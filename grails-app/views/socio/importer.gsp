<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'socio.label', default: 'Socio')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>

    <body>
        <ul class="nav" role="navigation">
            <li><a class="home" href="${createLink(uri: '/')}">Inicio</a></li>
            <li><a class="list" href="${createLink(action: 'index')}">Listado de Socios</a></li>
        </ul>

        <div id="content" role="main">
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>

            <section class="row colset-2-its">
                Carga de datos de los Socios desde fichero Excel
                <g:uploadForm action="importing" class="create">
                    <g:field type="file" name="datosExcel"/>
                    <br/>
                    <g:submitButton name="enviar" value="Cargar"/>
                </g:uploadForm>
            </section>
        </div>

    </body>
</html>