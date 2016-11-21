package feriantes_grails

import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class UserController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def index(Integer max) {
        params.max = Math.min(max ?: 50, 100)
        respond User.list(params), model:[userCount: User.count(), roleList: Role.list()]
    }

    @Transactional
    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def create() {
        def role = Role.findByAuthority(params.authority)
        def user = new User(username: params.username, password: params.password, enabled: params.enabled == "true").save(flush:true)
        UserRole.create(user, role)

        redirect(view:"index")
    }

    @Transactional
    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def update(User user) {
        if (user == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        user.username = params.username
        user.enabled = params.enabled == "true"
        user.password = params.password

        def userRole = UserRole.get(user.id, user.getAuthorities()[0]?.id)
        def role = Role.findByAuthority(params.authority)
        if (userRole.role != role) {
            UserRole.remove(user, userRole.role)
            UserRole.create(user, role)
        }

        if (user.hasErrors()) {
            transactionStatus.setRollbackOnly()
            respond user.errors, view:'edit'
            return
        }

        user.save(flush:true)
        redirect(view:"index")
    }

    @Transactional
    @Secured(['ROLE_ADMIN', 'ROLE_SECRETARIO', 'ROLE_PRESIDENTE'])
    def delete(User user) {
        if (user == null) {
            transactionStatus.setRollbackOnly()
            notFound()
            return
        }

        if (user.username == "admin") {
            flash.message = "No se puede borrar el usuario ADMIN"
        } else {
            def userRole = UserRole.get(user.id, user.getAuthorities()[0]?.id ?: 0l)
            if (userRole) {
                UserRole.remove(user, userRole.role)
            }
            user.delete(flush:true)
        }

        redirect(view:"index")
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
