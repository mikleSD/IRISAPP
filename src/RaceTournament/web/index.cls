Class RaceTournament.Web.Index Extends %CSP.Page
{

ClassMethod OnPage() As %Status
{
    &HTML<
        <html>
            <head>
                <script src="/csp/irisapp/webix/webix.min.js" type="text/javascript" charset="utf-8"></script>
                <link rel="stylesheet" href="/csp/irisapp/webix/webix.min.css" type="text/css" charset="utf-8">
                <link rel="stylesheet" href="https://cdn.materialdesignicons.com/2.7.94/css/materialdesignicons.css?v=7.2.0" type="text/css" charset="utf-8">
            </head>
            <body>
                <script src="/csp/irisapp/js/main.js" type="text/javascript" charset="utf-8"></script>
            </body>
        </html>
    >
    quit $$$OK
}

}
