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
Vector eje        = new Vector();
Vector unidadejec    = new Vector();
Vector valores    = new Vector();


eje         = bd.ConsultaEJE();
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
                <button class="btn btn-group-vertical" onclick="location.href='/planeacion/ResumenGeneral_2?formato=excel'">Descargar Reporte</button>  -     <button class="btn btn-group-vertical" onclick="window.close();"> Cerrar</button>    
            </center>
        <%}%>
        
        <br><br>
        <h3>Poyectos en estado de Ejecución</h3>
        <table border="2">
        <tr>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> EJE [Unidad Ejecutora] </center></font></th>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Presupuesto Personal Planeado </center></font></th>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Presupuesto Personal Ejecutado </center></font></th>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Porcentaje Personal Ejecutado </center></font></th>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Presupuesto Erogación Planeado </center></font></th>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Presupuesto Erogación Ejecutado </center></font></th>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Porcentaje Erogación Ejecutado </center></font></th>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Total Planeado </center></font></th>
            <th bgcolor="#8B0D04"><font color="#FFFFFF"><center> Total Ejecutado </center></font></th>
        </tr>
        
        <%for(int p = 0 ; p < eje.size() ; p++){
             aux = (Vector) eje.elementAt(p);
        %>
        <tr>
            <td bgcolor="#BDBDBD"><%=aux.elementAt(1)%></td>
            <td bgcolor="#BDBDBD">-</td>
            <td bgcolor="#BDBDBD">-</td>
            <td bgcolor="#BDBDBD">-</td>
            <td bgcolor="#BDBDBD">-</td>
            <td bgcolor="#BDBDBD">-</td>
            <td bgcolor="#BDBDBD">-</td>
            <td bgcolor="#BDBDBD">-</td>
            <td bgcolor="#BDBDBD">-</td>
        </tr>
        <%for(int k = 0 ; k < unidadejec.size() ; k++){
             aux2 = (Vector) unidadejec.elementAt(k);
             valores = bd.ConsultaValoresEJEReporteGen(aux.elementAt(0).toString(), aux2.elementAt(0).toString(),"5");
             if(valores.size()>0){
        %>
        <tr>
            <td><%=aux2.elementAt(1)%></td>
            <td><%=formatea.format(new BigInteger(valores.elementAt(0).toString().replace("No disponible", "0")))%></td>
            <td><%=formatea.format(new BigInteger(valores.elementAt(1).toString().replace("No disponible", "0")))%></td>
            <td><%=valores.elementAt(2).toString().toString().replace("No disponible", "0").replace("0.0000", "0").replace(".", ",")%>%</td>
            <td><%=formatea.format(new BigInteger(valores.elementAt(3).toString().replace("No disponible", "0")))%></td>
            <td><%=formatea.format(new BigInteger(valores.elementAt(4).toString().replace("No disponible", "0")))%></td>
            <td><%=valores.elementAt(5).toString().toString().replace("No disponible", "0").replace("0.0000", "0").replace(".", ",")%>%</td>
            <td><%=formatea.format(new BigInteger(valores.elementAt(6).toString().replace("No disponible", "0")))%></td>
            <td><%=formatea.format(new BigInteger(valores.elementAt(7).toString().replace("No disponible", "0")))%></td>
        </tr>
        <%}}}%>
        </table>
    </center>
    </body>
</html>
