# Redmine Hours-Notification Plugin

## Descripción

Hours-Notification, es un plugin que permite añadir a los proyectos de [Redmine](http://www.redmine.org/) las horas estimadas y crear notificaciones a diferentes porcentajes del tiempo estimado, con la finalidad de llevar un mejor control del estado de los proyectos.

## Getting started

### 1. Instalación del plugin
- Parar Redmine
- Clonar el repositorio en raiz_redmine/plugins.El directorio del plugin debe ser hoursnotification

	```
	git clone git://github.com/AgiliaCenter/Hours-Notification
	``` 
	
- Ejecutar:

  ```
    rake redmine:plugins:migrate NAME=hoursnotification RAILS_ENV=production
  ```
  
- En el fichero config/application.rb añadir la siguiente entrada:
  ```
  config.action_mailer.default_url_options = { host: 'localhost:3000' }
  ``` 
  
- Iniciar Redmine

### 2. Eliminar el plugin

  - Parar Redmine
  - Ejecutar:
  
    ```
      rake redmine:plugins:migrate NAME=hoursnotification VERSION=0 RAILS_ENV=production
    ```
  - Eliminar la carpeta hoursnotification que se encuentra en raiz_redmine/plugins
  - En el fichero config/application.rb eliminar la siguiente entrada:
    ```
    config.action_mailer.default_url_options = { host: 'localhost:3000' }
    ```  

  - Iniciar Redmine
  
### 3. Permisos

Por defecto, sólo los miembros que sean admins en Redmine podrán configurar las notificaciones en los proyectos. Puedes asignar este permiso a los diferentes roles de Redmine en la sección Hoursnotification que se encuentra en  /roles/permissions.
  
## Compatibilidad
  El plugin ha sido probado en Redmine v2.6.6.stable

## Versiones  
### 1.0.0

- Permite añadir las horas estimadas a los proyectos. Este campo se puede configurar desde el menú de configuración del proyecto.
- Ver el porcentaje del tiempo estimado consumido en la página principal del proyecto.
- Configurar alertas vía email en diferentes porcentajes del proyecto.
- Configurar a qué roles asociados al proyecto van dirigidas las alertas.
- Configurar mediante permisos que roles de Redmine pueden configurar el plugin.
- En los emails de alerta, van adjuntados un documento .pdf y un documento .csv con información de todas las peticiones que conforman el proyecto para un vistazo rápido.

