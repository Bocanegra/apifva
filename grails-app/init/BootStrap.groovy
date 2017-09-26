import feriantes_grails.*


class BootStrap {

    static numeroUsers = 6
    def grailsApplication

    def init = { servletContext ->

        if (User.count == 0) {
            log.fatal("Creando usuarios y roles...")

            def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
            def secretarioRole = new Role(authority: 'ROLE_SECRETARIO').save(flush: true)
            def presidenteRole = new Role(authority: 'ROLE_PRESIDENTE').save(flush: true)
            def gestoriaRole = new Role(authority: 'ROLE_GESTORIA').save(flush: true)
            def socioRole = new Role(authority: 'ROLE_SOCIO').save(flush: true)

            def adminUser = new User(username: 'admin', password: '1234').save(flush: true)
            def secretarioUser = new User(username: 'secretario', password: '1234').save(flush: true)
            def presidenteUser = new User(username: 'presidente', password: '1234').save(flush: true)
            def viceUser = new User(username: 'vicepresidente', password: '1234').save(flush: true)
            def gestoriaUser = new User(username: 'gestoria', password: '1234').save(flush: true)
            def socioUser = new User(username: 'socio', password: '1234').save(flush: true)

            UserRole.create(adminUser, adminRole)
            UserRole.create(secretarioUser, secretarioRole)
            UserRole.create(presidenteUser, presidenteRole)
            UserRole.create(viceUser, presidenteRole)
            UserRole.create(gestoriaUser, gestoriaRole)
            UserRole.create(socioUser, socioRole)
            UserRole.withSession {
                it.flush()
                it.clear()
            }
        }

        // CAMBIOS Y ADAPTACIONES ENTRE VERSIONES
        def version = grailsApplication.metadata.getApplicationVersion()
        log.fatal("App version: ${version}")
        if (version == "1.2.2") {
            // v1.2.2: Cambios de precio y metros a Double, para poder meter decimales
            // - Se crean nuevas variables, y al arrancar se copia lo que hubiera en las antiguas
            log.fatal("Migration [1] in progress...")
            Feriante.list().each { feriante ->
                feriante.dSuperficie1 = feriante.superficie1
                feriante.dPrecio1 = feriante.precio1
                feriante.dSuperficie2 = feriante.superficie2
                feriante.dPrecio2 = feriante.precio2
                feriante.save()
            }
            log.fatal("Migration [1] finished")
        }

        if (version == "1.3.0") {
            // v1.3.1: Añadir nuevo rol "Vocal"
            log.fatal("Migration [2] in progress...")
            new Role(authority: 'ROLE_VOCAL').save(flush: true)
            log.fatal("Migration [2] finished")
        }

    }

    def destroy = {

    }
}
