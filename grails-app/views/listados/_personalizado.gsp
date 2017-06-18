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
                            <g:each in="${fieldList}" var="cabecera">
                                <th>${cabecera.capitalize()}</th>
                            </g:each>
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="${ferianteList}" var="feriante" status="i">
                            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                <g:each in="${fieldList}" var="campo">
                                    <td>${feriante[campo]}</td>
                                </g:each>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>
        </div>

    </body>

</html>
