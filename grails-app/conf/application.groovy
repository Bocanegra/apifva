//environments {
//    production {
//        dataSource {
//            dbCreate = "update"
//            driverClassName = "com.mysql.jdbc.Driver"
//            dialect = org.hibernate.dialect.MySQL5InnoDBDialect
//            url = "jdbc:mysql://aa163hwh1c9li6y.cvef7hsbwcdb.us-west-2.rds.amazonaws.com:3306/ebdb"
//            username = "feriantes"
//            password = "feriantes"
//       	    pooled = true
//		properties {
//		validationQuery = "SELECT 1"
//		testOnBorrow = true
//		testOnReturn = true
//		testWhileIdle = true
//		timeBetweenEvictionRunsMillis = 1800000
//		numTestsPerEvictionRun = 3
//		minEvictableIdleTimeMillis = 1800000
//	    }
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
