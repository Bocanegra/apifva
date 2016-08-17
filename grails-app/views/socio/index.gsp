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

        <div class="feriantes_table">
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

                %{--<f:table collection="${socioList}" properties="['numeroSocio', 'nombre', 'direccion', 'codigoPostal',--}%
                %{--'poblacion', 'provincia', 'movil1', 'telefonoFijo']"/>--}%

                <table>
                    <thead>
                    <tr class="center header">
                        <g:sortableColumn property="numeroSocio" title="Número"/>
                        <g:sortableColumn property="nombre" title="Nombre"/>
                        <g:sortableColumn property="direccion" title="Dirección"/>
                        <g:sortableColumn property="codigoPostal" title="CP"/>
                        <g:sortableColumn property="poblacion" title="Población"/>
                        <g:sortableColumn property="provincia" title="Provincia"/>
                        <g:sortableColumn property="movil1" title="Móvil"/>
                        <g:sortableColumn property="telefonoFijo" title="Fijo"/>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${socioList}" var="socio" status="i">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            <td><g:link action="show" id="${socio.id}">${socio.numeroSocio}</g:link></td>
                            <td><g:link action="show" id="${socio.id}">${socio.nombre}</g:link></td>
                            <td>${socio.direccion}</td>
                            <td>${socio.codigoPostal}</td>
                            <td>${socio.poblacion}</td>
                            <td>${socio.provincia}</td>
                            <td>${socio.movil1}</td>
                            <td>${socio.telefonoFijo}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>

                <div class="pagination">
                    <g:paginate total="${socioCount ?: 0}" />
                </div>
            </div>
        </div>
    </body>
</html>