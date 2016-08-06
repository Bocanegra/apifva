<%@ page import="grails.util.Environment" %>
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

        <div class="svg" role="presentation">
            <div class="grails-logo-container">
                <asset:image src="grails-cupsonly-logo-white.svg" class="grails-logo"/>
            </div>
        </div>

        <div id="content" role="main">
            <section class="row colset-2-its">
                <h1>Listados <b>${Calendar.instance.get(Calendar.YEAR)}</b></h1>
                <p>
                    Pulsando sobre cada uno de los listados, se generarán y se descargarán o se abrirán en el navegador.
                </p>

                <ul>
                    <li class="controller buttons">
                        <g:link action="impresion">Listado resumen impresión</g:link>
                        <g:link action="impresion" params="[download: true]" class="save">Descargar</g:link>
                    </li>
                    <li class="controller buttons">
                        <g:link action="ayuntamiento">Listado para el Ayuntamiento</g:link>
                        <g:link action="ayuntamiento" params="[download: true]" class="save">Descargar</g:link>
                    </li>
                </ul>
            </section>
        </div>

    </body>
</html>
