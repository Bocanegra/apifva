<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'feriante.label', default: 'Feriante')}" />
        <title><g:message code="default.list.label" args="[entityName]"/></title>
        <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>
        <g:javascript>
            function checkAll() {
                $("input[type='checkbox']").prop("checked", true);
            }
            function checkNone() {
                $("input[type='checkbox']").prop("checked", false);
            }
        </g:javascript>
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

            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>

            <section class="row colset-2-its">
                <h1><b>Modificación de datos masivos ${year}</b></h1>
                <g:form action="multiedit">
                    <h3>Mostrar Feriantes del año <g:select id="anyo" name="anyo" from="${anyos}" value="${year}"/> <g:submitButton class="email_buttons" name="multieditLoad" value="Cargar"/></h3>
                </g:form>
                <br/>
                <p>
                    Cambia el valor de un campo para los Feriantes seleccionados, admite valores absolutos (pe. 10,3), y relativos en porcentaje (pe. +8%, -10%)
                </p>
                <ul>
                    <li class="controller buttons">
                        <g:form id="multiedited" action="multiedited">
                            <ul class="columnas_3">
                                <g:each in="${properties}" var="prop">
                                    <ul><g:textField name="${prop}" size="5"/><span>${prop}</span><br/></ul>
                                </g:each>
                            </ul>
                            <p align="center">
                                <br/>
                                <g:field class="email_buttons" name="submit" type="submit" value="Cambiar valores"/>
                            </p>

                            <br/>
                            <table>
                                <thead>
                                <tr>
                                    <th width="2">
                                        <g:field name="todos" type="button" value="Todos" onclick="checkAll()"/><br/>
                                        <g:field name="ninguno" type="button" value="Ninguno" onclick="checkNone()"/>
                                    </th>
                                    <g:sortableColumn property="anyo" title="Año"/>
                                    <g:sortableColumn property="parcela" title="Parcela"/>
                                    <g:sortableColumn property="nombre" title="Nombre"/>
                                    <g:sortableColumn property="negocio" title="Negocio"/>
                                    <g:sortableColumn property="dSuperficie1" title="Superficie 1"/>
                                    <g:sortableColumn property="dPrecio1" title="Precio superficie 1"/>
                                    <g:sortableColumn property="dSuperficie2" title="Superficie 2"/>
                                    <g:sortableColumn property="dPrecio2" title="Precio superficie 2"/>
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
                                        <td>${ferianteInstance.dSuperficie1}</td>
                                        <td>${ferianteInstance.dPrecio1}</td>
                                        <td>${ferianteInstance.dSuperficie2}</td>
                                        <td>${ferianteInstance.dPrecio2}</td>
                                    </tr>
                                </g:each>
                                </tbody>
                            </table>

                        </g:form>
                    </li>
                </ul>
            </section>
        </div>

    </body>
</html>
