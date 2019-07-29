<%@ page import="feriantes_grails.TipoInformes; feriantes_grails.Feriante; grails.util.Environment" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Asociación de Feriantes de Valladolid</title>
        <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>
    </head>

    <body>
        <content tag="nav">
            <g:render template="/menu"/>
        </content>

        <div id="content" class="content scaffold-list" role="main">
            <section class="row colset-2-its">
                <h1>Envío de documentación por email, año <b>${Calendar.instance.get(Calendar.YEAR)}</b></h1>
                <p>
                    Elige la plantilla, selecciona a todos los usuarios que quieras enviar el mail, y pulsa
                    en el botón "Enviar por email".
                </p>

                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>

                <ul class="buttons">
                    <li class="controller"><g:link action="informativo">1. Documento informativo</g:link></li>
                    <li class="controller"><g:link action="justificante">2. Documento justificante de pago</g:link></li>
                    <li class="controller"><g:link action="generico">3. Otros mensajes</g:link></li>
                </ul>

            </section>
        </div>

    </body>
</html>
