<%-- 
    Document   : ResumenPlaneacion
    Created on : 27/06/2017, 08:37:36 AM
    Author     : Juan Vanzina
--%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.math.BigInteger"%>
<%@page import="javax.activation.MimetypesFileTypeMap"%>
<%@page import="java.util.Vector"%>
<%@page import="BDatos.BDServicios"%>
<%@page import="java.util.*, java.io.File, java.text.SimpleDateFormat"%>
<%@page contentType="text/html; charset=iso-8859-1" pageEncoding="iso-8859-1"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%response.setHeader("Cache-Control", "no-cache");


//String ccemp = session.getAttribute("cod_emp").toString();

DecimalFormat formatea = new DecimalFormat("###,###.##");

String idp = request.getParameter("idp");

BDServicios bd = new BDServicios();

Vector aux              = new Vector();
Vector aux2             = new Vector();
Vector aux3             = new Vector();
Vector datosb           = new Vector();
Vector actividades      = new Vector();
Vector objetivosg       = new Vector();
Vector objetivose       = new Vector();
Vector metas            = new Vector();
Vector indicadores      = new Vector();
Vector indicadoresact   = new Vector();
Vector persactividad    = new Vector();
Vector presupuesto      = new Vector();
Vector ejesp            = new Vector();
Vector finfactor        = new Vector();


datosb          = bd.ConsultaDatosProyecto(idp);
actividades     = bd.ConsultaActividades(idp);
objetivosg      = bd.ConsultaObjetivosProyecto(idp,"1");
objetivose      = bd.ConsultaObjetivosProyecto(idp,"2");
metas           = bd.ConsultaObjetivosProyecto(idp,"3");

indicadores     = bd.ConsultaIndProyecto(idp);

 String formato = request.getParameter("formato");      
  if ((formato != null) && (formato.equals("excel"))) {
        response.setContentType("application/excel");
        response.setHeader("Content-Disposition", "attachment; filename=\"Resumen Proyecto " + idp + ".xls\"");
   }

int maxreg = 0;
String valor = "NA";
%>
<html  xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:w='urn:schemas-microsoft-com:office:excel' xmlns='http://www.w3.org/TR/REC-html40' lang="es">
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
    <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.js" type="text/javascript"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="app.js"></script>
    <script src="js/jquery-1.11.1.js" type="text/javascript"></script>
    </head>
    <body>
        
        <br>
         <%if(formato == null || (!formato.equals("excel"))){%>
            <center>
                <button class="btn btn-group-vertical" onclick="location.href='/planeacion/ResumenPlaneacion?idp=<%=idp%>&formato=excel'">Descargar Resumen del Proyecto</button>     -     <button class="btn btn-group-vertical" onclick="window.open('/planeacion/resumenpre?idp=<%=idp%>');"> Ver Detalle Presupuesto</button>      -     <button class="btn btn-group-vertical" onclick="window.close();"> Cerrar</button>
            </center>
            <%}%>        
        <br>
        <center><h2><strong>Resumen del Proyecto </strong></h2></center>
        <br>
        <!-- ****************** -->
        <center><h3><strong>ID Proyecto:</strong> <%=idp%></h3></center>
        <center><h3><strong>Nombre del Proyecto:</strong> <%=datosb.elementAt(0)%></h3></center>        
        <br>
        <br>
        <!-- ****************** -->
        
        <table border="2">
            <tr>
                <th colspan="14" bgcolor="#8B0D04"><font color="#FFFFFF"><center>Resumen de la planeación del Proyecto</center></font></th>
            </tr>
            <tr>
                <td colspan="1" bgcolor="#8B0D04"><font color="#FFFFFF">Identificador del Proyecto: </font></td>
                <td colspan="13" align="left"><%=idp%></td>
            </tr>
            <tr>
                <td colspan="1" bgcolor="#8B0D04"><font color="#FFFFFF">Nombre del Proyecto: </font></td>
                <td colspan="13" align="justify"><%=datosb.elementAt(0)%></td>
            </tr>
            <tr>
                <td colspan="1" bgcolor="#8B0D04"><font color="#FFFFFF">Tipo: </font></td>
                <td colspan="13" align="justify"><%=bd.nombreplan(datosb.elementAt(3).toString())%></td>
            </tr>
            <tr>
                <td colspan="1" bgcolor="#8B0D04"><font color="#FFFFFF">Director: </font></td>
                <td colspan="13" align="justify"><%=bd.usuarioconscc(datosb.elementAt(6).toString())%></td>
            </tr>
            <tr>
                <td colspan="1" bgcolor="#8B0D04"><font color="#FFFFFF">Responsable: </font></td>
                <td colspan="13" align="justify"><%=bd.usuarioconscc(datosb.elementAt(7).toString())%></td>
            </tr>
            <tr>
                <td colspan="1" bgcolor="#8B0D04"><font color="#FFFFFF">Alineación Estrategica: </font></td>
                <td colspan="13" align="justify">
                    
                    
                <u><b>EJES Asociados</b></u><br>
                        
                        <%
                        ejesp = bd.ConsultaEJEasociado(idp);
                        for(int o = 0; o < ejesp.size(); o++)                         
                        {                            
                            aux3 = (Vector)ejesp.elementAt(o);
                        %>
                            <%=aux3.elementAt(2)%><br>          
                                    
                      <%}%>
                    
                    
                    <%if(datosb.elementAt(3).toString().equals("2")){ // Mejoramiento%>
                      
                                                        <br><u><b>Factores y Caracteristicas del Proyecto</b></u><br>
                        
                    <%                    
                        finfactor = bd.ConsultaCarFac(idp);
                    
                        for(int o = 0; o < finfactor.size(); o++){
                            
                            aux3 = (Vector)finfactor.elementAt(o);
                    %>     
                            
                        <b>Fin de autoevaluación:</b> <%=aux3.elementAt(1)%> <b>Factor:</b> <%=aux3.elementAt(2)%>   <b>Caracteristica:</b> <%=aux3.elementAt(3)%>	<b>Factor Integral:</b> <%=aux3.elementAt(4)%>  <b>EJE:</b> <%=aux3.elementAt(5)%><br> 
                    
                        <%}} // Desrrollo - Acción%>                        
                        
                </td>
            </tr>
            <tr>
                <td colspan="1" bgcolor="#8B0D04"><font color="#FFFFFF">Objetivos: </font></td>
                <td colspan="13" align="justify">
                    <b>Objetivo(s) General(es)</b><br>
                    <%for(int q = 0; q < objetivosg.size(); q++){
                        aux2 = (Vector)objetivosg.elementAt(q);
                    %>
                    - <%=aux2.elementAt(1)%>
                    <br>
                    <%}%>
                    <b>Objetivo(s) Especifico(s)</b><br>
                    <%for(int q = 0; q < objetivose.size(); q++)
                     {
                        aux2 = (Vector)objetivose.elementAt(q);
                    %>
                    - <%=aux2.elementAt(1)%>
                    <br>
                    <%}%>
                </td>
            </tr>
            <tr>
                <td colspan="1" bgcolor="#8B0D04"><font color="#FFFFFF">Metas: </font></td>
                <td colspan="13" align="justify">
                    <%for(int q = 0; q < metas.size(); q++){
                        aux2 = (Vector)metas.elementAt(q);
                    %>
                    - <%=aux2.elementAt(1)%>
                    <br>
                    <%}%>                    
                </td>
            </tr>
            <tr>
                <td colspan="1" bgcolor="#8B0D04"><font color="#FFFFFF">Indicadores: </font></td>
                <td colspan="13" align="justify">
                    <%for(int q = 0; q < indicadores.size(); q++)
                    {
                        aux2 = (Vector)indicadores.elementAt(q);
                    %>
                    - <b>Indicador:</b> <%=aux2.elementAt(1)%>, <b>Periodicidad:</b> <%=aux2.elementAt(3)%>, <b>Descripción</b> <%=aux2.elementAt(7)%>
                    <br>
                  <%}%>                      
                </td>
            </tr>
            <tr>
                <td colspan="1" bgcolor="#8B0D04"><font color="#FFFFFF">Justificación: </font></td>
                <td colspan="13" align="justify"><%=datosb.elementAt(16)%></td>
            </tr>
            <tr>
                <td colspan="1" bgcolor="#8B0D04"><font color="#FFFFFF">Prioridad: </font></td>
                <td colspan="13" align="justify"><%=datosb.elementAt(20)%></td>
            </tr>
            <tr>
                <td colspan="1" bgcolor="#8B0D04"><font color="#FFFFFF">Vigencia: </font></td>
                <td colspan="13" align="justify"><%=bd.vigenciaproy(idp)%></td>
            </tr>
            <tr>
                <th colspan="14" height="15"></th>
            </tr>
            <tr>
                <th colspan="14" bgcolor="#8B0D04"><font color="#FFFFFF"><center>Actividades</center></font></th>
            </tr>
            <tr>
                <tr>
                    <td rowspan="2" bgcolor="#8B0D04"><font color="#FFFFFF">Nombre - Descripción de las actividades </font></td>
                    <td rowspan="2" bgcolor="#8B0D04"><font color="#FFFFFF">Fecha de inicio de la actividad</font></td>
                    <td rowspan="2" bgcolor="#8B0D04"><font color="#FFFFFF">Fecha de finalización  de la actividad</font></td>
                    <td bgcolor="#8B0D04" colspan="7"><font color="#FFFFFF"><center>Costo Estimado</center></font></td>
                    <td rowspan="2" colspan="3" bgcolor="#8B0D04"><font color="#FFFFFF"><center>Indicadores de cumplimiento por cada actividad</center></font></td>
                </tr>
                <tr>
                    <td bgcolor="#8B0D04" colspan="4"><font color="#FFFFFF"><center>Dedicación de personal</center></font></td>
                    <td bgcolor="#8B0D04" colspan="3"><font color="#FFFFFF"><center>Erogación</center></font></td>
                </tr>                
            </tr>
            
                        <%if(actividades.size()>0){%>
                        <% for ( int m = 0 ; m < actividades.size() ; m++ ){
                                 aux = (Vector)actividades.elementAt(m);
                                 persactividad   = bd.ConsultaPersonalRep1(aux.elementAt(0).toString());
                                 presupuesto     = bd.ConsultaPresupuestoRep1(aux.elementAt(0).toString());
                                 indicadoresact  = bd.ConsultaIndicactRep1(aux.elementAt(0).toString());

                                 String [] agnos = bd.vigenciaact(aux.elementAt(0).toString()).split(" - ");
                                 String agnoini = agnos[0];
                                 String agnofin = agnos[1];
                                 
                                 if(maxreg < persactividad.size()) {maxreg = persactividad.size();}
                                 if(maxreg < presupuesto.size())   {maxreg = presupuesto.size();}
                                 if(maxreg < indicadoresact.size()){maxreg = indicadoresact.size();}
                        
                                 
                           %>
            <tr>
                <td width="20%"><b><%=aux.elementAt(1)%></b> - <%=aux.elementAt(1)%></td>
                <td width="5%"><center><%=aux.elementAt(3)%></center></td>
                <td width="5%"><center><%=aux.elementAt(4)%></center></td>           
                <td colspan="4" width="25%" valign="baseline">
                    <%if(persactividad.size()>0){%>
                    <table border="2" width="100%">
                        <tr>
                            <td bgcolor="#8B0D04" width="5%"><font color="#FFFFFF">Año</font></td>
                            <td bgcolor="#8B0D04" width="40%"><font color="#FFFFFF">Cargo Participante</font></td>
                            <td bgcolor="#8B0D04" width="40%"><font color="#FFFFFF">Nombre Participante</font></td>
                            <td bgcolor="#8B0D04" width="15%"><font color="#FFFFFF">Horas</font></td>
                            
                        </tr>
                        
                            <%for(int q = 0; q < persactividad.size(); q++){
                                aux3 = (Vector)persactividad.elementAt(q); valor = aux3.elementAt(4).toString();
                            %>
                            <tr>
                            <td width="5%"><%=aux3.elementAt(0)%></td>                            
                            <td width="40%"><%=aux3.elementAt(2)%></td>
                            <td width="40%"><%=aux3.elementAt(1)%></td>
                            <td width="15%"><%=aux3.elementAt(3)%></td>

                            </tr>
                            <%}%>
                        <tr>
                            <td colspan="4"><center><b>Valor total personal: <%=formatea.format(new BigInteger(bd.ConsultaValorPersonalRep1(aux.elementAt(0).toString()).toString()))%></b></center></td>
                        </tr>
                    </table>
                           
                    <%} valor = "NA";%>
                </td>                
                <td colspan="3" width="25%" valign="baseline">
                    <%if(presupuesto.size()>0){%>
                    <table border="2" width="100%">
                        <tr>
                            <td bgcolor="#8B0D04" width="5%"><font color="#FFFFFF">Año</font></td>
                            <td bgcolor="#8B0D04" width="20%"><font color="#FFFFFF">Rubro</font></td>
                            <td bgcolor="#8B0D04" width="20%"><font color="#FFFFFF">Tipo</font></td>
                            <td bgcolor="#8B0D04" width="40%"><font color="#FFFFFF">Observaciones</font></td>
                            <td bgcolor="#8B0D04" width="15%"><font color="#FFFFFF">Valor</font></td>
                        </tr>
                        
                            <%for(int q = 0; q < presupuesto.size(); q++){
                                aux3 = (Vector)presupuesto.elementAt(q); valor = aux3.elementAt(8).toString();
                            %>
                            <tr>
                            <td width="5%"><%=aux3.elementAt(7)%></td>
                            <td width="20%"><%=aux3.elementAt(2)%></td>
                            <td width="20%"><%=aux3.elementAt(1)%></td>
                            <td width="40%"><%=aux3.elementAt(5)%></td>
                            <td width="15%"><%=formatea.format(new BigInteger(aux3.elementAt(6).toString()))%></td>
                            </tr>
                            <%}%>
                        <tr>
                            <td colspan="5"><center><b>Valor total erogación: <%=formatea.format(new BigInteger(valor.toString()))%></b></center></td>
                        </tr>
                    </table>
                            
                       <%} valor = "NA";%>
                </td>              
                <td colspan="3" width="20%" valign="baseline">
                    <table border="2" width="100%">
                        <tr>
                            <td bgcolor="#8B0D04" width="33%"><font color="#FFFFFF">Nombre</font></td>
                            <td bgcolor="#8B0D04" width="33%"><font color="#FFFFFF">Descripción</font></td>
                            <td bgcolor="#8B0D04" width="33%"><font color="#FFFFFF">Medición</font></td>
                        </tr>
                       
                            <%for(int q = 0; q < indicadoresact.size(); q++){
                                aux3 = (Vector)indicadoresact.elementAt(q);
                            %>
                            <tr>
                            <td width="33%"><%=aux3.elementAt(1)%></td>
                            <td width="33%"><%=aux3.elementAt(7)%></td>
                            <td width="33%"><%=aux3.elementAt(3)%></td> 
                            </tr>
                            <%}%>
                            
                    </table>
                           
                </td>
            </tr>
        <%}}%>
          
    </table>
    </body>
</html>


