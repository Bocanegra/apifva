import feriantes_grails.*


class BootStrap {

    static numeroUsers = 6

    def init = { servletContext ->

        if (User.count == 0) {
            log.fatal("Creando usuarios y roles...")

            def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
            def secretarioRole = new Role(authority: 'ROLE_SECRETARIO').save(flush: true)
            def presidenteRole = new Role(authority: 'ROLE_PRESIDENTE').save(flush: true)
            def gestoriaRole = new Role(authority: 'ROLE_GESTORIA').save(flush: true)
            def socioRole = new Role(authority: 'ROLE_SOCIO').save(flush: true)

            def adminUser = new User(username: 'Admin', password: '1234').save(flush: true)
            def secretarioUser = new User(username: 'Secretario', password: '1234').save(flush: true)
            def presidenteUser = new User(username: 'Presidente', password: '1234').save(flush: true)
            def viceUser = new User(username: 'Vice', password: '1234').save(flush: true)
            def gestoriaUser = new User(username: 'Gestoria', password: '1234').save(flush: true)
            def socioUser = new User(username: 'Socio', password: '1234').save(flush: true)

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

            assert User.count == numeroUsers
            assert Role.count == numeroUsers
            assert UserRole.count == numeroUsers
        }

    }

    def destroy = {

    }
}
