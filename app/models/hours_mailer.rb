class HoursMailer < ActionMailer::Base
	default from: Setting.mail_from

	def send_email (mails = [] , project , alert , total_hours)
		@project = project
		@alert = alert
		@total_hours = total_hours
		@project_url = url_for :controller => "projects" , :action => "show" ,  :id => @project.id , :only_path => false

		csvfile = create_csv(@project)
		pdffile = create_pdf(@project)

		attachments[@project.name + '-task-report.csv'] = csvfile
		attachments[@project.name + '-task-report.pdf'] = pdffile
		mail :bcc => mails.join(",")  ,
			 :subject => "[#{t(:project)}:#{project.name}] - Alert: #{alert.percentage}%"
	end

	 #Solo tiene el esqueleto
	 def create_pdf(project)
	 	issues = Issue.where(:project_id => project.id).all

	 	pdf = RBPDF.new('P', 'mm', 'A4', true, 'UTF-8', false)
	 	pdf.add_page()

	 	html = "<h1> #{t(:project)}: #{project.name}</h1><table style=\"width:100%\">
	 			<tr>
	 			<th>#{t(:name)}</th>
	 			<th>#{t(:estimated_hours)}</th>
	 			<th>#{t(:total_hours)}</th>
	 			<th>% #{t(:hours)}</th>
	 			</tr>"

	 	issues.each do | issue |
	 		estimated_hours = issue.estimated_hours.nil? ? 0 : issue.estimated_hours
	 		total_hours = issue.total_spent_hours
	 		link = url_for :controller => "issues" , :action => "show" ,  :id => issue.id , :only_path => false
	 		ratio = 0

	 		if  estimated_hours > 0
	 			ratio = (total_hours / estimated_hours) * 100
	 		end

	 		html << "<tr>
	 				<td><a href=\"#{link}\">#{issue.subject}</a></td>
	 				<td>#{estimated_hours}</td>
	 				<td>#{total_hours}</td>"

	 		if ratio > 100
	 			html << "<td style=\"color:red\">#{ratio}</td>"
	 		else
	 			html << "<td>#{ratio}</td>"
	 		end

	 		html << "</tr>"
	 	end

	 	html << "</table>"
	 	pdf.write_html_cell(w=0, h=0, x='', y='', html, border=0, ln=1, fill=0, reseth=true, align='', autopadding=true)
	 	return pdf.output()
	 end

	 def create_csv(project)

	 	issues = Issue.where(:project_id => project.id).all

	 	file = FCSV.generate(:col_sep => t(:general_csv_separator)) do |csv|
	 		csv << ["#{t(:name)}" , "#{t(:link)}" , "#{t(:estimated_hours)}" , "#{t(:total_hours)}" , "% #{t(:hours)}"]

	 		issues.each do |issue|
	 			link = url_for :controller => "issues" , :action => "show" ,  :id => issue.id , :only_path => false
	 			subject = issue.subject
	 			estimated_hours = issue.estimated_hours.nil? ? 0 : issue.estimated_hours
	 			total_hours = issue.total_spent_hours
	 			ratio = 0

	 			if estimated_hours > 0
	 				ratio = (total_hours / estimated_hours) * 100 if not estimated_hours.nil?
	 			end

	 			csv << [subject , link , estimated_hours , total_hours , ratio ]
	 		end
	 	end

	 	file
	 end
	end