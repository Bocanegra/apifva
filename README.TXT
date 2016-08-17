---------
FERIANTES
---------

FUNCIONALIDADES:

Modelos:
[x] Feriante
[x] Documentación (año y feriante)
[x] Socios

Formulario:
[x] Formulario de documentaciones

Listados:
[x] Vista impresión (subconjunto de Feriantes)
[x] Vista ayuntamiento (subconjunto de Feriantes)
[x] Pendiente cabecera en Vista impresión
[x] Botón de descarga

Informes:
[x] Justificante de pago
[x] Documento de pago
[x] Etiquetas

[x] Perfil nuevo "Gestoría", sólo permite la validación
[x] Añadir email a los modelos
[x] Años para las ferias, que se dupliquen cada año los usuarios y modificables por años
[x] Notas en el menú principal, con permiso para todos
[x] Listado de Feriantes por años
[x] Años para los barrios, también copiable lo del año anterior
[x] Poder subir imagen con plano de barrios, imprimible en formulario
[x] Creación de tabla Logs, mostrarlos y filtrarlos
[ ] Ajustar tablas al 100% del ancho
[x] Fechas en validaciones
[x] Añadir IBAN al modelo de Feriantes
[x] Listado nuevo con parcela-nombre-iban

Despliegue:
[ ] Heroku: https://objectpartners.com/2015/04/23/deploying-grails-3-applications-and-other-fat-jars-to-heroku/
[ ] AWS Beanstalk: https://medium.com/@benorama/how-to-deploy-grails-3-app-to-aws-elastic-beanstalk-with-gradle-and-travis-318d084c0f7d#.sxjqazw65
[ ] http://www.databaseapplications.com.au/elastic_beanstalk.jsp#.V62cbGWlUWo
[x] AMAZON EC2: https://aws.amazon.com/es/getting-started/tutorials/launch-a-virtual-machine

Bugs/mejoras:
[ ] El segundo y siguientes informes no mantienen el formato (INFORMATIVO)
[x] Probar el borrado en cascada de Documentaciones al borrar Feriantes
[ ] Guardar planos de barrios en base de datos
[ ] Creación/modificación usuarios para perfil Admin

------------------------------------------------------------------------------------------------------------------------
NOTAS:

- Crear plantilla con Word y rellenar en PHP:
http://sandritascs.blogspot.com.es/2015/03/crear-documentos-word-doc-docx-con.html

- Instalar symfony
$ sudo curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony
$ sudo chmod a+x /usr/local/bin/symfony

Activation code para Idea:
- Añadir como servidor de licencias:
http://idea.qinxi1992.cn/

http://www.damirscorner.com/blog/posts/20160313-AccessingApplicationFilesFromCodeInGrails.html

- Para actualizar los paquetes de Grails si cambias algo en el build.gradle, ir a la pestaña gradle, y arriba a la
izquierda hay un botón de Refresh.

DESPLIEGUE EN HEROKU:

- Crear o disponer de una cuenta gratuita en Heroku:
	> luigiangelo22@hotmail.com - grande05

- Descarga del cliente: 
	> https://toolbelt.heroku.com
	> heroku login
	(descarga CLI)
	
- Despliegue de servicio Gradle 
	> https://devcenter.heroku.com/articles/deploying-gradle-apps-on-heroku

- Ejecutar en local:
	$ ./gradlew stage
	$ heroku local web

- Grails 3:
    1) build.gradle, añadir en dependencies:
    // Para ejecutar en Heroku
    runtime 'org.postgresql:postgresql:9.4-1201-jdbc4'
    provided "org.springframework.boot:spring-boot-starter-tomcat"
    compile 'org.eclipse.jetty:jetty-runner:9.2.11.v20150529'
    compile 'com.github.jsimone:webapp-runner:8.0.30.2'

    y

    ""
    task stage() {
        dependsOn clean, war
    }
    tasks.stage.doLast() {
        delete fileTree(dir: "build/distributions")
        delete fileTree(dir: "build/assetCompile")
        delete fileTree(dir: "build/distributions")
        delete fileTree(dir: "build/libs", exclude: "*.war")
    }
    war.mustRunAfter clean

    task copyToLib(type: Copy) {
        into "$buildDir/server"
        from(configurations.compile) {
            include "webapp-runner*"
        }
    }

    stage.dependsOn(copyToLib)
    ""

    2) Procfile:
    web: cd build ; java $JAVA_OPTS -Dgrails.env=prod -jar ../build/server/webapp-runner-*.jar --expand-war --port $PORT libs/*.war

    3) application.groovy (grails-app/conf):

    environments {
      production {
        dataSource {
          dbCreate = "update"
          driverClassName = "org.postgresql.Driver"
          dialect = org.hibernate.dialect.PostgreSQLDialect
          uri = new URI(System.env.DATABASE_URL?:"postgres://localhost:5432/test")
          url = "jdbc:postgresql://" + uri.host + ":" + uri.port + uri.path + "?sslmode=require"
          username = uri.userInfo.split(":")[0]
          password = uri.userInfo.split(":")[1]
        }
      }
    }

    4) Crear máquina heroku:

    $ heroku create
    $ heroku addons:create heroku-postgresql
    $ git push heroku master

DESPLIEGUE EN AMAZON AWS:

- Hay un bug en tomcat 8.0.35, hay que crear un fichero (vacío) en:
    WEB-INF/classes/META-INF/MANIFEST.MF
  En Grails 3, se crea dentro de src/webapp/WEB-INF.....

- También hay que deshabilitar el tomcat embebido que viene de serie con Grails, cambiar en build.gradle:
     compile "org.springframework.boot:spring-boot-starter-tomcat" por
     provided "org.springframework.boot:spring-boot-starter-tomcat"

- Crear la BD (RDS) en Amazon, y coger datos, y en el fichero application.groovy (conf):
    environments {
        production {
            dataSource {
                dbCreate = "update"
                driverClassName = "com.mysql.jdbc.Driver"
                dialect = org.hibernate.dialect.MySQL5InnoDBDialect
                url = "jdbc:mysql://aa163hwh1c9li6y.cvef7hsbwcdb.us-west-2.rds.amazonaws.com:3306/ebdb"
                username = "feriantes"
                password = "feriantes"
                pooled = true
                properties {
                    validationQuery = "SELECT 1"
                    testOnBorrow = true
                    testOnReturn = true
                    testWhileIdle = true
                    timeBetweenEvictionRunsMillis = 1800000
                    numTestsPerEvictionRun = 3
                    minEvictableIdleTimeMillis = 1800000
                }
            }
        }
    }

