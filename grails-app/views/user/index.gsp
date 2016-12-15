<%@ page import="feriantes_grails.Role" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main"/>
        <g:set var="entityName" value="${message(code:'user.label', default:'User')}" />
        <title>Lista de Usuarios</title>
    </head>
    <body>

        <content tag="nav">
            <g:render template="/menu"/>
        </content>

        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}">Inicio</a></li>
            </ul>
        </div>

        <div id="list-user" class="content scaffold-list" role="main">
            <h1>Lista de Usuarios</h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>

            <table>
                <thead>
                <tr class="center header">
                    <g:sortableColumn property="username" title="Usuario"/>
                    <g:sortableColumn property="enabled" title="Habilitada"/>
                    <g:sortableColumn property="authorities" title="Rol"/>
                    <g:sortableColumn property="password" title="Clave"/>
                </tr>
                </thead>
                <tbody>
                    <g:each in="${userList}" var="user" status="i">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        <g:form resource="${user}" action="update" method="PUT">
                            <td><g:field type="text" name="username" value="${user.username}"/></td>
                            <td><g:select name="enabled" from="[true, false]" value="${user.enabled}"/></td>
                            <td><g:select name="authority" from="${Role.list()}" value="${user.authorities}" optionKey="authority"/></td>
                            <td><g:field type="password" name="password" value="${user.password}"/></td>
                            <td><g:field type="submit" name="actualizar" value="Actualizar"/>
                        </g:form>

                        <g:form resource="${user}" method="DELETE">
                                <input class="delete" type="submit"
                                       value="Eliminar"
                                       onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                            </td>
                        </g:form>

                        </tr>
                    </g:each>

                    <g:form action="create">
                        <tr>
                            <td><g:field type="text" name="username"/></td>
                            <td><g:select name="enabled" from="[true, false]"/></td>
                            <td><g:select name="authority" from="${Role.list()}" optionKey="authority"/></td>
                            <td><g:field type="text" name="password"/></td>
                            <td><g:field type="submit" name="crear" value="Crear usuario"/></td>
                        </tr>
                    </g:form>

                </tbody>
            </table>

            <div class="pagination">
                <g:paginate total="${userCount ?: 0}"/>
            </div>
        </div>
    </body>
</html>