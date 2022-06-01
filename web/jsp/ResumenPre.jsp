<%-- 
    Document   : Resumen
    Created on : 3/05/2017, 10:02:20 AM
    Author     : Juan Vanzina
--%>

<%@page import="javax.activation.MimetypesFileTypeMap"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Vector"%>
<%@page import="BDatos.BDServicios"%>
<%@page import="java.math.BigInteger"%>
<%@page contentType="text/html; charset=iso-8859-1" pageEncoding="iso-8859-1"%>
<!DOCTYPE html>
<%response.setHeader("Cache-Control", "no-cache");

        String down = (String) request.getParameter("down");

        //String ccemp = session.getAttribute("cod_emp").toString();
        
        String mensaje = "";
        
        String idp = request.getParameter("idp");
        
        BigInteger TotalRubros;
        
        TotalRubros = BigInteger.valueOf(0);
        
        mensaje = request.getParameter("m");
        
        
        BDServicios bd = new BDServicios();
        
        Vector aux          = new Vector();
        Vector planes       = new Vector();
        Vector empleados    = new Vector();
        Vector snies        = new Vector();
        Vector estadopr     = new Vector();
        Vector estadoejec   = new Vector();
        Vector prioridad    = new Vector();
        Vector datosb       = new Vector();
        Vector objetivosg   = new Vector();
        Vector objetivose   = new Vector();
        Vector metas        = new Vector();
        Vector actividades  = new Vector();
        Vector presupuesto  = new Vector();
        Vector rubro        = new Vector();
        Vector indicadores  = new Vector();
        Vector auxin        = new Vector();        
        Vector archivos     = new Vector();
        Vector auxh         = new Vector();
        Vector valores      = new Vector();
        Vector ejes         = new Vector();
        Vector ejesasoc     = new Vector();
        Vector infoeje      = new Vector();
        Vector auxeje       = new Vector();
        Vector auxobje      = new Vector();
        Vector fines        = new Vector();
        Vector unidades     = new Vector();
        Vector caracfac     = new Vector();
        
        DecimalFormat formatea = new DecimalFormat("###,###,###.##");        

        
        ejesasoc    = bd.ConsultaEJEasociado(idp);
        actividades = bd.ConsultaActividades(idp);
        rubro       = bd.PreRubrosPL();
        indicadores = bd.ConsultaIndProyecto(idp);
        caracfac    = bd.ConsultaCarFac(idp);
        
        datosb = bd.ConsultaDatosProyecto(idp);
        
        String Valor="", Cadena="", ValorDed="", ValorEro="";
        String vigencia = bd.vigenciaproy(idp);
        int numero_archivo = 0;
        int porcentajact = 0;
        
        int agnoinicial = 0;
        int agnofinal   = 0;
        
        if(vigencia.length()>=9){
        String[] vigenciapart = vigencia.split(" - ");
            agnoinicial = Integer.parseInt(vigenciapart[0]);
            agnofinal = Integer.parseInt(vigenciapart[1]);
        }
        
        if(down!=null){ // Solicitud de Descarga de archivos
       
           String filename = down;   
           //String filepath = "C:\\Users\\Desarrollo\\Desktop\\Proyectos\\ZPruebasCarga\\";   
           String filepath = "/home/shares/ODI/";   
           MimetypesFileTypeMap mimetypesFileTypeMap = new MimetypesFileTypeMap();
           response.setContentType(mimetypesFileTypeMap.getContentType(filename));   
           response.setContentType("application/x-download"); 
           response.setHeader("Content-Disposition","attachment; filename=\"" + filename + "\"");   

           java.io.FileInputStream fileInputStream=new java.io.FileInputStream(filepath + filename);  

            int i;   
            while ((i=fileInputStream.read()) != -1) {  
              out.write(i);   
            }   
            fileInputStream.close();   
       }       
        
        BigInteger TotalPR;
        
        TotalPR = BigInteger.valueOf(0); 
        
         String formato = request.getParameter("formato");      
                if ((formato != null) && (formato.equals("excel"))) {
                      response.setContentType("application/excel");
                      response.setHeader("Content-Disposition", "attachment; filename=\"Detalle Presupuesto PR " + idp + ".xls\"");
                 }
        
%>
<html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:w='urn:schemas-microsoft-com:office:excel' xmlns='http://www.w3.org/TR/REC-html40' lang="es">
    <head>
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
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.js" type="text/javascript"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="app.js"></script>
    
    
<script src="js/jquery-1.11.1.js" type="text/javascript"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
        <br>
        <%if(formato == null || (!formato.equals("excel"))){%>
            <center>
                <button class="btn btn-group-vertical" onclick="location.href='/planeacion/resumenpre?idp=<%=idp%>&formato=excel'">Descargar Detalle Presupuesto</button>     -     <button class="btn btn-group-vertical" onclick="window.open('/planeacion/ResumenPlaneacion?idp=<%=idp%>');"> Ver Resumen del Proyecto</button>      -     <button class="btn btn-group-vertical" onclick="window.close();"> Cerrar</button>
            </center>
    
        <br>
        <center><h2><strong>Detalle del presupuesto planeado. </strong></h2></center>
        <br>
        <center><h3><strong>ID Proyecto:</strong> <%=idp%></h3></center>
        <center><h3><strong>Nombre del Proyecto:</strong> <%=datosb.elementAt(0)%></h3></center>        
        <br>
        <br>
                    <table class="table table-hover" id="sum_table">
                      <tr>
                        <th bgcolor="#8B0D04"><font color="#FFFFFF">Actividades / Año</font></th>
                        <%for(int qw = agnoinicial; qw <= agnofinal; qw++){%>
                        <th colspan="2" bgcolor="#8B0D04"><font color="#FFFFFF"><%=qw%></font></th>
                        <%}%>
                        <th colspan="2" bgcolor="#8B0D04"><font color="#FFFFFF">SubTotal</font></th>
                        <th bgcolor="#8B0D04"><font color="#FFFFFF">Total Actividad</font></th>
                      </tr>
                      <tr class="titlerow">
                          <td bgcolor="#8B0D04"></td>
                          <%for(int qw = agnoinicial; qw <= agnofinal; qw++){%>
                          <th >Dedicación Personal</td>
                          <th >Presupuesto Erogación</td>
                          <%}%>
                          <th >Dedicación Personal</td>
                          <th >Presupuesto Erogación</td>
                          <td></td>
                      </tr>
                      <% for ( int m = 0 ; m < actividades.size() ; m++ ){
                                      aux = (Vector)actividades.elementAt(m);
                                      
                                      BigInteger TotalEct, TotalDed, TotalAc;

                                        TotalEct = BigInteger.valueOf(0);
                                        TotalDed = BigInteger.valueOf(0);                                      
                                        TotalAc  = BigInteger.valueOf(0);
                                    %>
                      <tr >
                        <td bgcolor="#8B0D04"><font color="#FFFFFF"><%=aux.elementAt(1)%></font>    </td>
                        <%for(int q = agnoinicial; q <= agnofinal; q++){
                            
                            ValorDed = bd.consultavalordedper(aux.elementAt(0).toString(), Integer.toString(q));
                            ValorEro = bd.consultavalorerog(aux.elementAt(0).toString(), Integer.toString(q));
                            
                            TotalDed = TotalDed.add(new BigInteger(ValorDed));
                            TotalEct = TotalEct.add(new BigInteger(ValorEro)); 
                        %>
                        <td>$ <%=formatea.format(Integer.parseInt(ValorDed.toString()))%></td><td>$ <%=formatea.format(Integer.parseInt(ValorEro.toString()))%></td>
                        <td class="rowDataSd" style="display:none;"><%=Integer.parseInt(ValorDed.toString())%></td><td class="rowDataSd" style="display:none;"><%=Integer.parseInt(ValorEro.toString())%></td>
                        <%}
                        TotalAc = TotalDed.add(TotalEct);
                        %>
                        <td>$ <%=formatea.format(Integer.parseInt(TotalDed.toString()))%></td>
                        <td class="rowDataSd" style="display:none;"> <%=Integer.parseInt(TotalDed.toString())%></td>
                        <td>$ <%=formatea.format(Integer.parseInt(TotalEct.toString()))%></td>
                        <td class="rowDataSd" style="display:none;"> <%=Integer.parseInt(TotalEct.toString())%></td>
                        <td>$ <%=formatea.format(Integer.parseInt(TotalAc.toString()))%></td>
                        <td class="rowDataSd" style="display:none;"> <%=Integer.parseInt(TotalAc.toString())%></td>
                      </tr>
                      <% TotalPR = TotalPR.add(TotalAc);
                      }
                      %>
                      
                      
                            <tr class="totalColumn">
                                <td bgcolor="#8B0D04"><b><u><font color="#FFFFFF"><center>Valores totales por año y del proyecto</center></u></font></b></td>
                                  <%for(int q = agnoinicial; q <= agnofinal; q++){%>
                                  <td class="totalCol" bgcolor="#E6E6E6"></td>
                                  <td class="totalCol" bgcolor="#F2F2F2"></td>
                                  <%}%> 
                                  <td class="totalCol" bgcolor="#BDBDBD"></td>
                                  <td class="totalCol" bgcolor="#BDBDBD"></td>
                                  <td class="totalCol" bgcolor="#FFFF00"></td>
                            </tr>
                    </table>
    
    
            <%}else{%>
        
        <br>
        <center><h3>Detalle del presupuesto planeado. </h3></center>
        <br>
        <br>
        <table class="table table-hover" id="sum_table">
                      <tr>
                        <th bgcolor="#8B0D04"><font color="#FFFFFF">Actividades / Año</font></th>
                        <%for(int qw = agnoinicial; qw <= agnofinal; qw++){%>
                        <th colspan="2" bgcolor="#8B0D04"><font color="#FFFFFF"><%=qw%></font></th>
                        <%}%>
                        <th colspan="2" bgcolor="#8B0D04"><font color="#FFFFFF">SubTotal</font></th>
                        <th bgcolor="#8B0D04"><font color="#FFFFFF">Total Actividad</font></th>
                      </tr>
                      <tr class="titlerow">
                          <td bgcolor="#8B0D04"></td>
                          <%for(int qw = agnoinicial; qw <= agnofinal; qw++){%>
                          <th >Dedicación Personal</td>
                          <th >Presupuesto Erogación</td>
                          <%}%>
                          <th >Dedicación Personal</td>
                          <th >Presupuesto Erogación</td>
                          <td></td>
                      </tr>
                      <% for ( int m = 0 ; m < actividades.size() ; m++ ){
                                      aux = (Vector)actividades.elementAt(m);
                                      
                                      BigInteger TotalEct, TotalDed, TotalAc;

                                        TotalEct = BigInteger.valueOf(0);
                                        TotalDed = BigInteger.valueOf(0);                                      
                                        TotalAc  = BigInteger.valueOf(0);
                                    %>
                      <tr >
                        <td bgcolor="#8B0D04"><font color="#FFFFFF"><%=aux.elementAt(1)%></font>    </td>
                        <%for(int q = agnoinicial; q <= agnofinal; q++){
                            
                            ValorDed = bd.consultavalordedper(aux.elementAt(0).toString(), Integer.toString(q));
                            ValorEro = bd.consultavalorerog(aux.elementAt(0).toString(), Integer.toString(q));
                            
                            TotalDed = TotalDed.add(new BigInteger(ValorDed));
                            TotalEct = TotalEct.add(new BigInteger(ValorEro)); 
                        %>
                        <td>$ <%=formatea.format(Integer.parseInt(ValorDed.toString()))%></td><td>$ <%=formatea.format(Integer.parseInt(ValorEro.toString()))%></td>
                        <%}
                        TotalAc = TotalDed.add(TotalEct);
                        %>
                        <td>$ <%=formatea.format(Integer.parseInt(TotalDed.toString()))%></td>
                        
                        <td>$ <%=formatea.format(Integer.parseInt(TotalEct.toString()))%></td>
                        
                        <td>$ <%=formatea.format(Integer.parseInt(TotalAc.toString()))%></td>
                        
                      </tr>
                      <% TotalPR = TotalPR.add(TotalAc);
                      }
                      %>
                    </table>
                                 
              <%}%>   
        
                      <script>
                           
                           $("#rowDataSd").remove();
                           
                                 var totals=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
                                  $(document).ready(function(){

                                      var $dataRows=$("#sum_table tr:not('.totalColumn, .titlerow')");

                                      $dataRows.each(function() {
                                          $(this).find('.rowDataSd').each(function(i){        
                                              totals[i]+=parseInt( $(this).html());
                                          });
                                      });
                                      $("#sum_table td.totalCol").each(function(i){  
                                          $(this).html("$ "+currency(totals[i]));
                                      });

                                  });

                                    
                                    
                                    function currency(value, decimals, separators) {
                                       
                                        separators = separators || ['.', ".", ','];
                                        var number = (parseFloat(value) || 0).toFixed(decimals);
                                        if (number.length <= (4 + decimals))
                                            return number.replace('.', separators[separators.length - 1]);
                                        var parts = number.split(/[-.]/);
                                        value = parts[parts.length > 1 ? parts.length - 2 : 0];
                                        var result = value.substr(value.length - 3, 3) + (parts.length > 1 ?
                                            separators[separators.length - 1] + parts[parts.length - 1] : '');
                                        var start = value.length - 6;
                                        var idx = 0;
                                        while (start > -3) {
                                            result = (start > 0 ? value.substr(start, 3) : value.substr(0, 3 + start))
                                                + separators[idx] + result;
                                            idx = (++idx) % 2;
                                            start -= 3;
                                        }
                                        return (parts.length == 3 ? '-' : '') + result;
                                    }
                                    

                      </script>
                      
    </body>
</html>
