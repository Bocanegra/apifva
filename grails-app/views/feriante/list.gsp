<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'feriante.label', default: 'Feriante')}" />
        <title><g:message code="default.list.label" args="[entityName]"/></title>
    </head>
    <body>

        <content tag="nav">
            <g:render template="/menu"/>
        </content>

        <div class="feriantes_table">

            <ul class="property-list" role="navigation">
                <li class="buttons save">
                    <g:form action="list">
                        Mostrar Feriantes para el año:
                        <g:select id="anyo" name="anyo" from="${anyos}"/>
                        <g:field name="send" type="submit" value="Filtrar" class="buttons"/>
                    </g:form>
                </li>
                <sec:ifAnyGranted roles='ROLE_ADMIN'>
                    <li class="buttons delete">
                        <g:form action="deleteFeriantes">
                            Eliminar todos los feriantes para el año:
                            <g:select id="anyo" name="anyo" from="${anyos}"/>
                            <g:field name="send" type="submit" value="Borrar" class="buttons"/>
                        </g:form>
                    </li>
                </sec:ifAnyGranted>
            </ul>

            <ul class="nav">
                <li><a class="home" href="${createLink(uri: '/')}">Inicio</a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]"/></g:link></li>
            </ul>

            <div id="list-feriante" class="content scaffold-list" role="main">
                <h1>Listado de Feriantes</h1>
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <table>
                    <thead>
                    <tr class="center header">
                        <g:sortableColumn property="nombre" title="Nombre"/>
                        <g:sortableColumn property="anyo" title="Año"/>
                        <g:sortableColumn property="parcela" title="Parcela"/>
                        <g:sortableColumn property="negocio" title="Negocio"/>
                        <g:sortableColumn property="direccion" title="Dirección"/>
                        <g:sortableColumn property="poblacion" title="Población"/>
                        <g:sortableColumn property="provincia" title="Provincia"/>
                        <g:sortableColumn property="telefono" title="Teléfono"/>
                        <g:sortableColumn property="superficie1" title="Sup 1"/>
                        <g:sortableColumn property="superficie2" title="Sup 2"/>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${ferianteList}" var="feriante" status="i">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            <td><g:link action="show" id="${feriante.id}">${feriante.nombre}</g:link></td>
                            <td>${feriante.anyo}</td>
                            <td>${feriante.parcela}</td>
                            <td>${feriante.negocio}</td>
                            <td>${feriante.direccion}</td>
                            <td>${feriante.poblacion}</td>
                            <td>${feriante.provincia}</td>
                            <td>${feriante.telefono}</td>
                            <td>${feriante.superficie1}</td>
                            <td>${feriante.superficie2}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>

        </div>

    </body>
</html>
