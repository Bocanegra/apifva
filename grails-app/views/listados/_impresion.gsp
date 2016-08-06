<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html>
    <head>
        <meta name="layout" content="main"/>
        <title>Asociación de Feriantes de Valladolid</title>

        <asset:link rel="icon" href="favicon.ico" type="image/x-ico"/>
        <asset:stylesheet src="main.css"/>

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
            <h1 class="center">Listado de Feriantes</h1>
            <div>
                <table class="table" width="100%">
                    <thead>
                        <tr class="center header">
                            <g:each in="[' ', 'Nombre', 'Negocio', 'Sup 1', 'Precio 1', 'Sup 2',
                            'Precio 2', 'Sitio', 'Gastos', 'Luz-agua', 'Vivienda', 'Máquinas', 'Deuda', 'Sanción',
                            'Pago 1', 'Pago 2', 'Total', 'Fianza']" var="cabecera">
                                <th>${cabecera}</th>
                            </g:each>
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${ferianteList}" var="feriante" status="i">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <td>${feriante.parcela}</td>
                                <td>${feriante.nombre}</td>
                                <td>${feriante.negocio}</td>
                                <td>${feriante.superficie1}</td>
                                <td>${feriante.precio1}</td>
                                <td>${feriante.superficie2}</td>
                                <td>${feriante.precio2}</td>
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
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>
        </div>

    </body>

</html>
