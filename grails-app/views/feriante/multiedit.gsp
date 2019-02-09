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

        <div id="content" role="main">

            <ul class="nav">
                <li><g:link class="home" action="list">Listado de Feriantes</g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]"/></g:link></li>
            </ul>

            <section class="row colset-2-its">
                <h1><b>Modificación de datos masivos</b></h1>
                <p>
                    Cambia el valor de un campo para todos los Feriantes del año indicado
                </p>

                <ul>
                    <li class="controller buttons">
                        <g:form id="multiedited" action="multiedited">
                            <ul class="columnas_3">
                                <li>
                                    <g:field name="submit" type="submit" value="Cambiar valor"/>
                                    para todos los Feriantes del año <g:select id="anyo" name="anyo" from="${anyos}"/>
                                </li>
                                <br/>
                                <g:each in="${properties}" var="prop">
                                    <li><g:textField name="${prop}" size="5"/><span>${prop}</span><br/></li>
                                </g:each>
                            </ul>
                        </g:form>
                    </li>
                </ul>
            </section>
        </div>

    </body>
</html>
