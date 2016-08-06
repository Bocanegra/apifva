<%@ page import="feriantes_grails.Recurso; feriantes_grails.Tipo" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'acceso.label', default: 'Acceso')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>

        <content tag="nav">
            <g:render template="/menu"/>
        </content>

        <div id="content" class="content scaffold-list" role="main">

            <section class="row colset-2-its">
                <h1>Tabla de Accesos</h1>
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
            </section>

            <div class="nav" role="navigation">
                <g:form action="filtrar">
                    <ul>
                        <li class="edit">
                                <g:select name="tipo" from="${Tipo.values()}" value="${Tipo}"/>
                                <g:field type="submit" name="filtrar_tipo" value="Filtrar por Tipo"/>
                        </li>
                        <li>
                            <g:select name="recurso" from="${Recurso.values()}" value="${Recurso}"/>
                            <g:field type="submit" name="filtrar_recurso" value="Filtrar por Recurso"/>
                        </li>
                    </ul>
                    <br/>
                    <ul>
                        <li>
                            Desde
                            <g:datePicker name="desde" precision="day"/>
                            hasta
                            <g:datePicker name="hasta" precision="day"/>
                            <g:field type="submit" name="filtrar_fecha" value="Filtrar por Fecha/hora"/>
                        </li>
                    </ul>
                </g:form>
            </div>
            <br/>

            <table>
                <thead>
                <tr class="center header">
                    <g:sortableColumn property="tipo" title="Tipo"/>
                    <g:sortableColumn property="recurso" title="Recurso"/>
                    <g:sortableColumn property="perfil" title="Perfil"/>
                    <g:sortableColumn property="comentarios" title="Comentario"/>
                    <g:sortableColumn property="dateCreated" title="Fecha"/>
                </tr>
                </thead>
                <tbody>
                <g:each in="${accesoList}" var="acceso" status="i">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        <td>${acceso.tipo}</td>
                        <td>${acceso.recurso}</td>
                        <td>${acceso.perfil}</td>
                        <td>${acceso.comentarios}</td>
                        <td>${acceso.dateCreated}</td>
                    </tr>
                </g:each>
                </tbody>
            </table>

            <div class="pagination">
                <g:paginate total="${accesoCount ?: 0}" />
            </div>

        </div>
    </body>
</html>
