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
                    <li class="controller buttons">
                        <g:link action="pago">Listado número cuenta (IBAN)</g:link>
                        <g:link action="pago" params="[download: true]" class="save">Descargar</g:link>
                    </li>
                    <li class="controller buttons">
                        <g:form id="form_id" action="personalizado">
                            <ul class="columnas_3">
                                <li>
                                    <g:field name="submit" type="submit" value="Personalizado"/>
                                </li>
                                <li>
                                    <g:field name="download" type="submit" class="save" value="Descargar"/>
                                </li>
                                <br/>
                                <g:each in="${properties}" var="prop">
                                    <li><g:textField name="${prop}" size="2"/><span>${prop}</span><br/></li>
                                </g:each>
                            </ul>
                        </g:form>
                    </li>
                </ul>
            </section>
        </div>

    </body>
</html>
