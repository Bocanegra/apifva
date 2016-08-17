<%@ page import="feriantes_grails.Feriante; grails.util.Environment" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Asociación de Feriantes de Valladolid</title>

        <asset:link rel="icon" href="favicon.ico" type="image/x-ico" />
    </head>

    <body>
        <content tag="nav">
            <g:render template="/menu"/>
        </content>

        <div id="content" role="main">
            <section class="row colset-2-its">
                <h1>Asociación Provincial de Industriales Feriantes de Valladolid</h1>
                <p></p>
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>

                <div id="wrap">
                    <div id="left_col">
                        <g:if test="${hasFeriantes}">
                            <h2>Ferias de Valladolid</h2>
                            <ul class="buttons">
                                <li class="controller"><g:link controller="listados" action="index">Listados</g:link></li>
                                <li class="controller"><g:link controller="validacion" action="index">Validación de documentaciones</g:link></li>
                                <li class="controller"><g:link controller="informes" action="index">Generación de Informes</g:link></li>
                            </ul>
                            <h2>Ferias de los Barrios</h2>
                            <ul class="buttons">
                                <li class="controller"><g:link controller="barrios" action="index">Informes</g:link></li>
                            </ul>
                            <h2>Accesos</h2>
                            <ul class="buttons">
                                <li class="controller"><g:link controller="acceso" action="index">Consulta de Accesos</g:link></li>
                            </ul>

                        </g:if>
                        <g:else>
                            <h2>No hay feriantes para el año ${Calendar.instance.get(Calendar.YEAR)}</h2>

                            <sec:ifAnyGranted roles='ROLE_ADMIN,ROLE_SECRETARIO,ROLE_PRESIDENTE'>
                                <g:form action="newFeriantes">
                                    <ul class="buttons">
                                        <li>
                                            Crear feriantes para el año <b>${Calendar.instance.get(Calendar.YEAR)}</b> a partir del año:
                                            <g:select id="anyo" name="anyo" from="${anyos}"/>
                                            <g:field name="send" type="submit" value="Crear Feriantes" class="buttons"/>
                                        </li>
                                    </ul>
                                </g:form>
                            </sec:ifAnyGranted>
                        </g:else>

                    </div>

                    <div id="right_col">
                        <g:render template="notas"/>
                    </div>
                </div>

            </section>
        </div>

    </body>
</html>
