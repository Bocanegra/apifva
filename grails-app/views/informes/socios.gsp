<%@ page import="feriantes_grails.TipoInformes; feriantes_grails.Feriante; grails.util.Environment" %>
<!doctype html>
<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Asociación de Feriantes de Valladolid</title>
        <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>
        <g:javascript>
            function checkAll() {
                $("input[type='checkbox']").prop("checked", true);
            }
        </g:javascript>
    </head>

    <body>
        <content tag="nav">
            <g:render template="/menu"/>
        </content>

        <div id="content" class="content scaffold-list" role="main">
            <section class="row colset-2-its">
                <h1>Generación de Etiquetas para Socios</h1>

                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>

                <g:form controller="informes">
                    <div align="center">
                        <g:hiddenField name="tipo" value="ETIQUETAS"/>
                        <g:hiddenField name="socios" value="1"/>
                        <g:actionSubmit action="generar" value="Generar"/>
                    </div>
                    <br/>

                    <table>
                        <thead>
                            <tr>
                                <th width="2"><g:field name="todos" type="button" value="Todos" onclick="checkAll()"/></th>
                                <g:sortableColumn property="numeroSocio" title="Número Socio"/>
                                <g:sortableColumn property="nombre" title="Nombre"/>
                                <g:sortableColumn property="poblacion" title="Población"/>
                                <g:sortableColumn property="provincia" title="Provincia"/>
                                <g:sortableColumn property="movil1" title="Teléfono móvil"/>
                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${sociosList}" status="i" var="socio">
                                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                    <td><g:field type="checkbox" name="feriantes" value="${socio.id}"/></td>
                                    <td>${socio.numeroSocio}</td>
                                    <td>${socio.nombre}</td>
                                    <td>${socio.poblacion}</td>
                                    <td>${socio.provincia}</td>
                                    <td>${socio.movil1}</td>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </g:form>

            </section>
        </div>

    </body>
</html>
