<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'feriante.label', default: 'Feriante')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#show-feriante" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="show-feriante" class="content scaffold-show" role="main">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>

            <ol class="property-list feriante">
                <li class="fieldcontain">
                    <span id="anyo-label" class="property-label">Año</span>
                    <div class="property-value" aria-labelledby="anyo-label">${feriante.anyo}</div>
                </li>
                <li class="fieldcontain">
                    <span id="parcela-label" class="property-label">Parcela</span>
                    <div class="property-value" aria-labelledby="parcela-label">${feriante.parcela}</div>
                </li>
                <li class="fieldcontain">
                    <span id="nombre-label" class="property-label">Nombre</span>
                    <div class="property-value" aria-labelledby="nombre-label">${feriante.nombre}</div>
                </li>
                <li class="fieldcontain">
                    <span id="propietario-label" class="property-label">Propietario</span>
                    <div class="property-value" aria-labelledby="propietario-label">${feriante.propietarioStr()}</div>
                </li>
                <li class="fieldcontain">
                    <span id="negocio-label" class="property-label">Negocio</span>
                    <div class="property-value" aria-labelledby="negocio-label">${feriante.negocio}</div>
                </li>
                <li class="fieldcontain">
                    <span id="direccion-label" class="property-label">Dirección</span>
                    <div class="property-value" aria-labelledby="anyo-label">${feriante.direccion}</div>
                </li>
                <li class="fieldcontain">
                    <span id="codigoPostal-label" class="property-label">Código Postal</span>
                    <div class="property-value" aria-labelledby="codigoPostal-label">${feriante.codigoPostal}</div>
                </li>
                <li class="fieldcontain">
                    <span id="poblacion-label" class="property-label">Población</span>
                    <div class="property-value" aria-labelledby="poblacion-label">${feriante.poblacion}</div>
                </li>
                <li class="fieldcontain">
                    <span id="provincia-label" class="property-label">Provincia</span>
                    <div class="property-value" aria-labelledby="anyo-label">${feriante.provincia}</div>
                </li>
                <li class="fieldcontain">
                    <span id="telefono-label" class="property-label">Teléfono</span>
                    <div class="property-value" aria-labelledby="telefono-label">${feriante.telefono}</div>
                </li>
                <li class="fieldcontain">
                    <span id="dSuperficie1-label" class="property-label">Superficie 1</span>
                    <div class="property-value" aria-labelledby="dSuperficie1-label">${feriante.formatSuperficie1()}</div>
                </li>
                <li class="fieldcontain">
                    <span id="dPrecio1-label" class="property-label">Precio sup. 1</span>
                    <div class="property-value" aria-labelledby="dPrecio1-label">${feriante.formatPrecio1()}</div>
                </li>
                <li class="fieldcontain">
                    <span id="dSuperficie2-label" class="property-label">Superficie 2</span>
                    <div class="property-value" aria-labelledby="dSuperficie2-label">${feriante.formatSuperficie2()}</div>
                </li>
                <li class="fieldcontain">
                    <span id="dPrecio2-label" class="property-label">Precio sup. 2</span>
                    <div class="property-value" aria-labelledby="dPrecio2-label">${feriante.formatPrecio2()}</div>
                </li>
                <li class="fieldcontain">
                    <span id="gastos-label" class="property-label">Gastos</span>
                    <div class="property-value" aria-labelledby="gastos-label">${feriante.gastos}</div>
                </li>
                <li class="fieldcontain">
                    <span id="luzAgua-label" class="property-label">Luz/agua</span>
                    <div class="property-value" aria-labelledby="luzAgua-label">${feriante.luzAgua}</div>
                </li>
                <li class="fieldcontain">
                    <span id="vivienda-label" class="property-label">Vivienda</span>
                    <div class="property-value" aria-labelledby="vivienda-label">${feriante.vivienda}</div>
                </li>
                <li class="fieldcontain">
                    <span id="maquinas-label" class="property-label">Máquinas</span>
                    <div class="property-value" aria-labelledby="maquinas-label">${feriante.maquinas}</div>
                </li>
                <li class="fieldcontain">
                    <span id="deuda-label" class="property-label">Deuda</span>
                    <div class="property-value" aria-labelledby="deuda-label">${feriante.deuda}</div>
                </li>
                <li class="fieldcontain">
                    <span id="sancion-label" class="property-label">Sanción</span>
                    <div class="property-value" aria-labelledby="sancion-label">${feriante.sancion}</div>
                </li>
                <li class="fieldcontain">
                    <span id="motivoSancion-label" class="property-label">Motivo sanción</span>
                    <div class="property-value" aria-labelledby="motivoSancion-label">${feriante.motivoSancion}</div>
                </li>
                <li class="fieldcontain">
                    <span id="fianza-label" class="property-label">Fianza</span>
                    <div class="property-value" aria-labelledby="fianza-label">${feriante.fianza}</div>
                </li>
                <li class="fieldcontain">
                    <span id="pagado-label" class="property-label">Pagado</span>
                    <div class="property-value" aria-labelledby="pagado-label">${feriante.pagado}</div>
                </li>
                <li class="fieldcontain">
                    <span id="todoPagado-label" class="property-label">Todo pagado</span>
                    <div class="property-value" aria-labelledby="todoPagado-label">${feriante.todoPagado ? "X" : ""}</div>
                </li>
                <li class="fieldcontain">
                    <span id="dni-label" class="property-label">DNI</span>
                    <div class="property-value" aria-labelledby="dni-label">${feriante.dni}</div>
                </li>
                <li class="fieldcontain">
                    <span id="email-label" class="property-label">Email</span>
                    <div class="property-value" aria-labelledby="email-label">${feriante.email}</div>
                </li>
                <li class="fieldcontain">
                    <span id="IBAN-label" class="property-label">IBAN</span>
                    <div class="property-value" aria-labelledby="IBAN-label">${feriante.IBAN}</div>
                </li>
            </ol>

            <g:form resource="${this.feriante}" method="DELETE">
                <fieldset class="buttons">
                    <g:link class="edit" action="edit" resource="${this.feriante}"><g:message code="default.button.edit.label" default="Edit"/></g:link>
                    <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                           onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                    <g:link class="edit" action="copiarPropietario" resource="${this.feriante}">Copiar datos del propietario original</g:link>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
