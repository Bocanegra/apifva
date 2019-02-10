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
                <h1><b>Listados</b></h1>
                <p>
                    Pulsando sobre cada uno de los listados, se generarán y se descargarán o se abrirán en el navegador.
                </p>

                <ul>
                    <li class="controller buttons">
                        <g:form id="impresion" action="impresion">
                            <g:field name="submit" type="submit" value="Listado resumen impresión"/>
                            Año <g:select id="anyo" name="anyo" from="${anyos}" value="${Calendar.instance.get(Calendar.YEAR).toString()}"/>
                            <g:checkBox name="download" checked="true"/>Descargar
                        </g:form>
                    </li>
                    <li class="controller buttons">
                        <g:form id="ayuntamiento" action="ayuntamiento">
                            <g:field name="submit" type="submit" value="Listado para el Ayuntamiento"/>
                            Año <g:select id="anyo" name="anyo" from="${anyos}" value="${Calendar.instance.get(Calendar.YEAR).toString()}"/>
                            <g:checkBox name="download" checked="true"/>Descargar
                        </g:form>
                    </li>
                    <li class="controller buttons">
                        <g:form id="pago" action="pago">
                            <g:field name="submit" type="submit" value="Listado número cuenta (IBAN)"/>
                            Año <g:select id="anyo" name="anyo" from="${anyos}" value="${Calendar.instance.get(Calendar.YEAR).toString()}"/>
                            <g:checkBox name="download" checked="true"/>Descargar
                        </g:form>
                    </li>
                    <li class="controller buttons">
                        <g:form id="personalizado" action="personalizado">
                            <ul class="columnas_3">
                                <li>
                                    <g:field name="submit" type="submit" value="Personalizado"/>
                                    Año <g:select id="anyo" name="anyo" from="${anyos}" value="${Calendar.instance.get(Calendar.YEAR).toString()}"/>
                                    <g:checkBox name="download" checked="true"/>Descargar
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
