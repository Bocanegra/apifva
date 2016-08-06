<%@ page import="grails.util.Environment" %>

<!-- Menu de Feriantes -->
<li class="dropdown">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Feriantes <span class="caret"></span></a>
    <ul class="dropdown-menu">
        <li><g:link controller="feriante" action="list">Listado de Feriantes</g:link></li>
        <sec:ifAnyGranted roles='ROLE_ADMIN,ROLE_PRESIDENTE'>
            <li><g:link controller="feriante" action="importer">Carga de Feriantes desde Excel</g:link></li>
        </sec:ifAnyGranted>
    </ul>
</li>

<!-- Menu de Socios -->
<li class="dropdown">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Socios <span class="caret"></span></a>
    <ul class="dropdown-menu">
        <li><g:link controller="socio">Listado de Socios</g:link></li>
        <sec:ifAnyGranted roles='ROLE_ADMIN,ROLE_PRESIDENTE'>
            <li><g:link controller="socio" action="importer">Carga de Socios desde Excel</g:link></li>
        </sec:ifAnyGranted>
    </ul>
</li>

<!-- Menu del Sistema -->
<li class="dropdown">
    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Sistema <span class="caret"></span></a>
    <ul class="dropdown-menu">
        <li><a href="#">Environment: ${Environment.current.name}</a></li>
        <li><a href="#">App profile: ${grailsApplication.config.grails?.profile}</a></li>
        <li><a href="#">App version:
            <g:meta name="info.app.version"/></a>
        </li>
        <li role="separator" class="divider"></li>
        <li><a href="#">Grails version:
            <g:meta name="info.app.grailsVersion"/></a>
        </li>
        <li><a href="#">Groovy version: ${GroovySystem.getVersion()}</a></li>
        <li><a href="#">JVM version: ${System.getProperty('java.version')}</a></li>
        <li role="separator" class="divider"></li>
        <li><a href="#">Reloading active: ${Environment.reloadingAgentEnabled}</a></li>
    </ul>
</li>

<!-- Salir -->
<li class="dropdown">
    <a href="${createLink(controller: 'logout')}">Salir</a>
</li>
