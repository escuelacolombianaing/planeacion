<%-- 
    Document   : ResumenGeneral
    Created on : 18/09/2017, 04:27:58 PM
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
Vector proyectos     = new Vector();

proyectos = bd.ConsultaProyectosGeneral();

 String formato = request.getParameter("formato");      
  if ((formato != null) && (formato.equals("excel"))) {
        response.setContentType("application/excel");
        response.setHeader("Content-Disposition", "attachment; filename=\"ResumenProyectos.xls\"");
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
                <button class="btn btn-group-vertical" onclick="location.href='/planeacion/ResumenProyectos?formato=excel'">Descargar Reporte</button>  -     <button class="btn btn-group-vertical" onclick="window.close();"> Cerrar</button>    
            </center>
        <%}%>
        
        <br><br>
        <table border="2">
        <tr>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Id. Proyecto </center></font></th>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Nombre Proyecto </center></font></th>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Fecha Inicio </center></font></th>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Fecha Fin </center></font></th>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Plan </center></font></th>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Prioridad </center></font></th>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Unidad Ejecutora </center></font></th>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Director </center></font></th>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Responsable </center></font></th>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Estado Proyecto </center></font></th>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Estado Ejecución </center></font></th>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Valor Personal Planeado </center></font></th>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Valor Personal Ejecutado </center></font></th>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Porcentaje Ejecutado Personal </center></font></th>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Valor Erogación Planeada </center></font></th>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Valor Erogación Ejecutada </center></font></th>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Porcentaje Ejecutado Erogación</center></font></th>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Valor Total Planeado </center></font></th>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Valor Total Ejecutado </center></font></th>  
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Porcentaje Total Ejecutado  </center></font></th>  
        </tr>
        
        <%for(int p = 0 ; p < proyectos.size() ; p++){
             aux = (Vector) proyectos.elementAt(p);
        %>
        <tr>
            <td bgcolor=""><%=aux.elementAt(0)%></td>
            <td bgcolor=""><%=aux.elementAt(1)%></td>
            <td bgcolor=""><%=aux.elementAt(2)%></td>
            <td bgcolor=""><%=aux.elementAt(3)%></td>
            <td bgcolor=""><%=aux.elementAt(4)%></td>
            <td bgcolor=""><%=aux.elementAt(5)%></td>
            <td bgcolor=""><%=aux.elementAt(6)%></td>
            <td bgcolor=""><%=aux.elementAt(7)%></td>
            <td bgcolor=""><%=aux.elementAt(8)%></td>
            <td bgcolor=""><%=aux.elementAt(9)%></td>
            <td bgcolor=""><%=aux.elementAt(10)%></td>
            <td bgcolor=""><%=formatea.format(new BigInteger(aux.elementAt(11).toString().replace("No disponible", "0")))%></td>
            <td bgcolor=""><%=formatea.format(new BigInteger(aux.elementAt(12).toString().replace("No disponible", "0")))%></td>
            <td bgcolor=""><%=formatea.format(new BigInteger(aux.elementAt(17).toString().replace("No disponible", "0")))%>%</td>
            <td bgcolor=""><%=formatea.format(new BigInteger(aux.elementAt(13).toString().replace("No disponible", "0")))%></td>
            <td bgcolor=""><%=formatea.format(new BigInteger(aux.elementAt(14).toString().replace("No disponible", "0")))%></td>
            <td bgcolor=""><%=formatea.format(new BigInteger(aux.elementAt(18).toString().replace("No disponible", "0")))%>%</td>
            <td bgcolor=""><%=formatea.format(new BigInteger(aux.elementAt(15).toString().replace("No disponible", "0")))%></td>
            <td bgcolor=""><%=formatea.format(new BigInteger(aux.elementAt(16).toString().replace("No disponible", "0")))%></td>
            <td bgcolor=""><%=formatea.format(new BigInteger(aux.elementAt(19).toString().replace("No disponible", "0")))%>%</td>
            
        </tr>
        <%}%>
        </table>
    </center>
    </body>
</html>
