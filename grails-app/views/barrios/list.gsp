<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'barrios.label', default: 'Barrio')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#list-barrio" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="list-barrio" class="content scaffold-list" role="main">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            %{--<f:table collection="${barrioList}" />--}%
            <table class="table">
                <thead>
                <tr class="center header">
                    <g:sortableColumn property="anyo" title="Año"/>
                    <g:sortableColumn property="lugar" title="Lugar"/>
                    <g:sortableColumn property="socios" title="Socios"/>
                    <g:sortableColumn property="nosocios" title="No socios"/>
                    <g:sortableColumn property="plano" title="Plano"/>
                </tr>
                </thead>
                <tbody>
                <g:each in="${barrioList}" var="barrio" status="i">
                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                        <td><g:link action="show" id="${barrio.id}">${barrio.anyo}</g:link></td>
                        <td>${barrio.lugar}</td>
                        <td>${barrio.socios}</td>
                        <td>${barrio.nosocios}</td>
                        <td>${barrio.planoFilename}</td>
                    </tr>
                </g:each>
                </tbody>
            </table>

            <div class="pagination">
                <g:paginate total="${barrioCount ?: 0}" />
            </div>
        </div>
    </body>
</html>