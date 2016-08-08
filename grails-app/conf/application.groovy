//environments {
//    production {
//        dataSource {
//            dbCreate = "update"
//            driverClassName = "org.postgresql.Driver"
//            dialect = org.hibernate.dialect.PostgreSQLDialect
//            uri = new URI(System.env.DATABASE_URL?:"postgres://localhost:5432/test")
//            url = "jdbc:postgresql://" + uri.host + ":" + uri.port + uri.path + "?sslmode=require"
//            username = uri.userInfo.split(":")[0]
//            password = uri.userInfo.split(":")[1]
//        }
//    }
//}

// Added by the Spring Security Core plugin:
grails.plugin.springsecurity.userLookup.userDomainClassName = 'feriantes_grails.User'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'feriantes_grails.UserRole'
grails.plugin.springsecurity.authority.className = 'feriantes_grails.Role'
grails.plugin.springsecurity.logout.postOnly = false
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
	[pattern: '/',               access: ['permitAll']],
	[pattern: '/error',          access: ['permitAll']],
	[pattern: '/index',          access: ['permitAll']],
	[pattern: '/list.gsp',       access: ['permitAll']],
	[pattern: '/shutdown',       access: ['permitAll']],
	[pattern: '/assets/**',      access: ['permitAll']],
	[pattern: '/**/js/**',       access: ['permitAll']],
	[pattern: '/**/css/**',      access: ['permitAll']],
	[pattern: '/**/images/**',   access: ['permitAll']],
	[pattern: '/**/favicon.ico', access: ['permitAll']]
]

grails.plugin.springsecurity.filterChain.chainMap = [
	[pattern: '/assets/**',      filters: 'none'],
	[pattern: '/**/js/**',       filters: 'none'],
	[pattern: '/**/css/**',      filters: 'none'],
	[pattern: '/**/images/**',   filters: 'none'],
	[pattern: '/**/favicon.ico', filters: 'none'],
	[pattern: '/**',             filters: 'JOINED_FILTERS']
]
