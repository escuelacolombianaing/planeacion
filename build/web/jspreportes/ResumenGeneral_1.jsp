<%-- 
    Document   : ResumenGeneral
    Created on : 13/09/2017, 04:27:58 PM
    Author     : Juan Vanzina
--%>

<%@page import="java.math.BigInteger"%>
<%@page import="java.util.Vector"%>
<%@page import="BDatos.BDServicios"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%response.setHeader("Cache-Control", "no-cache");


DecimalFormat formatea = new DecimalFormat("###,###.##");

BDServicios bd = new BDServicios();

Vector aux           = new Vector();
Vector aux2          = new Vector();
Vector planes        = new Vector();
Vector unidadejec    = new Vector();
Vector valores    = new Vector();


planes      = bd.Planes();
unidadejec  = bd.Consultaunidades();

 String formato = request.getParameter("formato");      
  if ((formato != null) && (formato.equals("excel"))) {
        response.setContentType("application/excel");
        response.setHeader("Content-Disposition", "attachment; filename=\"Resumen_PlanUnidad.xls\"");
   }

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
            <title>SEGUIMIENTO A LA PLANEACIÓN - ESCUELA COLOMBIANA DE INGENIERÍA JULIO GARAVITO</title>
            <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
            <meta http-equiv="Content-Language" content="ES" />
            <meta name="language" content="spanish" />
            <meta name="author" content="Escuela Colombiana de Ingenieria Julio Garavito - Julio Garavito" />
            <meta name="copyright" content="Copyright (c) 2017" />
            <meta name="description" content="Escuela Colombiana de Ingenieria Julio Garavito - Julio Garavito" />
            <meta name="abstract" content="Escuela Colombiana de Ingenieria Julio Garavito - Julio Garavito" />
            <meta http-equiv="X-UA-Compatible" content="IE=edge">     
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
            <link rel="shortcut icon" type="image/x-icon" href="img/favicon.ico">
            <link href="https://fonts.googleapis.com/css?family=Arsenal" rel="stylesheet">
            <link rel="stylesheet" href="css/seguimiento.css"> 
            <script type="text/js.usuario" src="js.usuario/update_inf.js"></script>
            <script language="javascript" type="text/javascript" src="js.usuario/update_inf.js" ></script>
            <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
            <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.js" type="text/javascript"></script>
            <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
            <script type="text/javascript" src="app.js"></script>
            <script src="js/jquery-1.11.1.js" type="text/javascript"></script>
        <title>Resumen General</title>
    </head>
    <body>
    <center>
        <br><br>
        
        <%if(formato == null || (!formato.equals("excel"))){%>
            <center>
                <button class="btn btn-group-vertical" onclick="location.href='/planeacion/ResumenGeneral_1?formato=excel'">Descargar Reporte</button>  -     <button class="btn btn-group-vertical" onclick="window.close();"> Cerrar</button>    
            </center>
        <%}%>
        
        <br><br>
        <h3>Poyectos en estado de Ejecución</h3>
        <table border="2">
        <tr>
            <th bgcolor="#8B0D04" width="10%"><font color="#FFFFFF"><center> Plan </center></font></th>
            <th bgcolor="#8B0D04" width="10%"><font color="#FFFFFF"><center> Sin Avance </center></font></th>
            <th bgcolor="#8B0D04" width="10%"><font color="#FFFFFF"><center> A tiempo </center></font></th>
            <th bgcolor="#8B0D04" width="10%"><font color="#FFFFFF"><center> Atrasado </center></font></th>
            <th bgcolor="#8B0D04" width="10%"><font color="#FFFFFF"><center> Ejecutado </center></font></th>
            <th bgcolor="#8B0D04" width="10%"><font color="#FFFFFF"><center> Cancelado </center></font></th>
            <th bgcolor="#8B0D04" width="10%"><font color="#FFFFFF"><center> Suspendido </center></font></th>
            <th bgcolor="#8B0D04" width="10%"><font color="#FFFFFF"><center> Total por Plan </center></font></th>
            
        </tr>
        <%for(int p = 0 ; p < planes.size() ; p++){
             aux = (Vector) planes.elementAt(p);
        %>
        <tr>
            <td bgcolor="#BDBDBD"><%=aux.elementAt(1)%></td>
            <td><center><%=bd.ConEstadosSeguimientoProyectosPlan(aux.elementAt(0).toString(),"1","5")%></center></td>
            <td><center><%=bd.ConEstadosSeguimientoProyectosPlan(aux.elementAt(0).toString(),"2","5")%></center></td>
            <td><center><%=bd.ConEstadosSeguimientoProyectosPlan(aux.elementAt(0).toString(),"3","5")%></center></td>
            <td><center><%=bd.ConEstadosSeguimientoProyectosPlan(aux.elementAt(0).toString(),"4","5")%></center></td>
            <td><center><%=bd.ConEstadosSeguimientoProyectosPlan(aux.elementAt(0).toString(),"5","5")%></center></td>
            <td><center><%=bd.ConEstadosSeguimientoProyectosPlan(aux.elementAt(0).toString(),"6","5")%></center></td>
            <td><center><%=bd.ConEstadosSeguimientoProyectosPlan(aux.elementAt(0).toString(),"1,2,3,4,5,6","5")%></center></td>
        </tr>
        <%}%>
        </table>
    </center>
    </body>
</html>
