<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Asociación de Feriantes de Valladolid</title>

        <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>

        <style type="text/css">
        @page {
            size: 297mm 210mm;
            @bottom-center {
                content: counter(page);
            }
        }
        @font-face {
            font-family: "Helvetica Neue";
        }
        body {
            font-family: "Helvetica Neue", Arial, sans-serif;
            font-size: 13px;
        }
        /*td {border-bottom:1px solid black}*/
        .even {background-color: #CCCCCC}
        .center {text-align: center; }
        div.break {
            page-break-after:always;
        }

        </style>
    </head>

    <body>

        <div id="list-feriante" class="content scaffold-list" role="main">
            <h1 class="center">Listado de Feriantes ${year}</h1>
            <div>
                <table class="table" width="100%">
                    <thead>
                        <tr class="center header">
                            <g:each in="[' ', 'Nombre', 'Negocio', 'Sup 1', 'Precio 1', 'Sup 2',
                            'Precio 2', 'Sitio', 'Gastos', 'Luz-agua', 'Vivienda', 'Máquinas', 'Deuda', 'Sanción',
                            'Pago 1', 'Pago 2', 'Total', 'Fianza', 'Pagado']" var="cabecera">
                                <th>${cabecera}</th>
                            </g:each>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Integer totalSup1 = 0
                            Integer totalSup2 = 0
                            Integer totalSitio = 0
                            Integer totalGastos = 0
                            Integer totalLuz = 0
                            Integer totalVivienda = 0
                            Integer totalMaquinas = 0
                            Integer totalDeuda = 0
                            Integer totalSanciones = 0
                            Integer totalPago1 = 0
                            Integer totalPago2 = 0
                            Integer totalTotal = 0
                            Integer totalFianza = 0
                            Integer totalPdte = 0
                        %>
                        <g:each in="${ferianteList}" var="feriante" status="i">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <td>${feriante.parcela}</td>
                                <td>${feriante.nombre}</td>
                                <td>${feriante.negocio}</td>
                                <td>${feriante.dSuperficie1}</td>
                                <td>${feriante.dPrecio1}</td>
                                <td>${feriante.dSuperficie2}</td>
                                <td>${feriante.dPrecio2}</td>
                                <td>${feriante.sitio}</td>
                                <td>${feriante.gastos}</td>
                                <td>${feriante.luzAgua}</td>
                                <td>${feriante.vivienda}</td>
                                <td>${feriante.maquinas}</td>
                                <td>${feriante.deuda}</td>
                                <td>${feriante.sancion}</td>
                                <td>${feriante.pago1}</td>
                                <td>${feriante.pago2}</td>
                                <td>${feriante.total}</td>
                                <td>${feriante.fianza}</td>
                                <td>${feriante.todoPagado ? "--- X ---" : ""}</td>
                            </tr>
                            <%
                                totalSup1       += feriante.dSuperficie1 ?: 0
                                totalSup2       += feriante.dSuperficie2 ?: 0
                                totalSitio      += feriante.sitio ?: 0
                                totalGastos     += feriante.gastos ?: 0
                                totalLuz        += feriante.luzAgua ?: 0
                                totalVivienda   += feriante.vivienda ?: 0
                                totalMaquinas   += feriante.maquinas ?: 0
                                totalDeuda      += feriante.deuda ?: 0
                                totalSanciones  += feriante.sancion ?: 0
                                totalPago1      += feriante.pago1 ?: 0
                                totalPago2      += feriante.pago2 ?: 0
                                totalTotal      += feriante.total ?: 0
                                totalFianza     += feriante.fianza ?: 0
                                totalPdte       += feriante.pendiente ?: 0
                            %>
                        </g:each>

                        <!-- Totales -->
                        <tr class="even">
                            <td></td>
                            <td>TOTALES</td>
                            <td></td>
                            <td>${totalSup1}</td>
                            <td></td>
                            <td>${totalSup2}</td>
                            <td></td>
                            <td>${totalSitio}</td>
                            <td>${totalGastos}</td>
                            <td>${totalLuz}</td>
                            <td>${totalVivienda}</td>
                            <td>${totalMaquinas}</td>
                            <td>${totalDeuda}</td>
                            <td>${totalSanciones}</td>
                            <td>${totalPago1}</td>
                            <td>${totalPago2}</td>
                            <td>${totalTotal}</td>
                            <td>${totalFianza}</td>
                            <td>${totalPdte}</td>
                        </tr>
                        <tr class="even">
                            <g:each in="[' ', 'Nombre', 'Negocio', 'Sup 1', 'Precio 1', 'Sup 2',
                                         'Precio 2', 'Sitio', 'Gastos', 'Luz-agua', 'Vivienda', 'Máquinas', 'Deuda', 'Sanción',
                                         'Pago 1', 'Pago 2', 'Total', 'Fianza', 'Pdte.']" var="cabecera">
                                <td>${cabecera}</td>
                            </g:each>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

    </body>

</html>
