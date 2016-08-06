<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'socio.label', default: 'Socio')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>

        <content tag="nav">
            <g:render template="/menu"/>
        </content>

        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}">Inicio</a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="list-socio" class="content scaffold-list" role="main">
            <h1>Lista de Socios</h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>

            <f:table collection="${socioList}" properties="['numeroSocio', 'nombre', 'direccion', 'codigoPostal',
            'poblacion', 'provincia', 'movil1', 'telefonoFijo']"/>

            <div class="pagination">
                <g:paginate total="${socioCount ?: 0}" />
            </div>
        </div>
    </body>
</html>