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
                <h1>Generación de informes año <b>${Calendar.instance.get(Calendar.YEAR)}</b></h1>
                <p>
                    Elige el tipo de informe y selecciona a todos los usuarios para los que haya que generarlo, y pulsa
                    en el botón "Generar".
                </p>

                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>

                <g:form controller="informes">
                    <div align="center">
                        <g:select id="tipo_informe" name="tipo" from="${TipoInformes.values()}" value="${TipoInformes}"
                                  optionKey="key"/>
                        <g:actionSubmit action="generar" value="Generar"/>
                    </div>
                    <br/>

                    <table>
                        <thead>
                            <tr>
                                <th width="2"><g:field name="todos" type="button" value="Todos" onclick="checkAll()"/></th>
                                <g:sortableColumn property="anyo" title="Año"/>
                                <g:sortableColumn property="parcela" title="Parcela"/>
                                <g:sortableColumn property="nombre" title="Nombre"/>
                                <g:sortableColumn property="negocio" title="Negocio"/>
                                <g:sortableColumn property="superficie1" title="Superficie 1"/>
                                <g:sortableColumn property="superficie2" title="Superficie 2"/>
                            </tr>
                        </thead>
                        <tbody>
                            <g:each in="${ferianteList}" status="i" var="ferianteInstance">
                                <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                                    <td><g:field type="checkbox" name="feriantes" value="${ferianteInstance.id}"/></td>
                                    <td>${ferianteInstance.anyo}</td>
                                    <td>${ferianteInstance.parcela}</td>
                                    <td>${ferianteInstance.nombre}</td>
                                    <td>${ferianteInstance.negocio}</td>
                                    <td>${ferianteInstance.superficie1}</td>
                                    <td>${ferianteInstance.superficie2}</td>
                                </tr>
                            </g:each>
                        </tbody>
                    </table>
                </g:form>

            </section>
        </div>

    </body>
</html>
