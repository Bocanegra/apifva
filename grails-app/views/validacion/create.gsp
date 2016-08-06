<%@ page import="grails.util.Environment" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main"/>

        <asset:link rel="icon" href="favicon.ico" type="image/x-ico" />
    </head>

    <body>
        <content tag="nav">
            <g:render template="/menu"/>
        </content>

        <div class="svg" role="presentation">
            <div class="grails-logo-container">
                <asset:image src="grails-cupsonly-logo-white.svg" class="grails-logo"/>
            </div>
        </div>

        <div id="content" role="main">
            <section class="row colset-2-its">
                <h1>Validación de documentaciones</h1>

                <div class="message" role="status">Actualmente no hay documentaciones creadas para el año en curso</div>
                <ul class="nav">
                    <li class="create">

                        <sec:ifAnyGranted roles='ROLE_ADMIN,ROLE_SECRETARIO,ROLE_PRESIDENTE'>
                            <g:form action="create">
                                Puede crear las documentaciones para el año <b>${Calendar.instance.get(Calendar.YEAR)}</b> pulsando en el botón:
                                <g:field name="send" type="submit" value="Crear documentaciones" class="create"/>
                            </g:form>
                        </sec:ifAnyGranted>

                        <sec:ifAnyGranted roles='ROLE_GESTORIA'>
                            Contacte con la Asociación para generar las documentaciones del año <b>${Calendar.instance.get(Calendar.YEAR)}</b>
                        </sec:ifAnyGranted>
                    </li>

                </ul>

            </section>
        </div>

    </body>
</html>
