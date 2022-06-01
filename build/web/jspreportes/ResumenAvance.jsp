<%-- 
    Document   : 
    Created on : 11/07/2017, 09:08:19 PM
    Author     : Juan David Vanzina
--%>


<%@page import="java.math.BigInteger"%>
<%@page import="BDatos.BDServiciosReportes"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import="java.util.*,java.awt.*,java.io.*, java.text.*, java.net.*;" %>
<%@ page import="javax.naming.*,javax.rmi.PortableRemoteObject;" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns:o='urn:schemas-microsoft-com:office:office' xmlns:w='urn:schemas-microsoft-com:office:word' xmlns='http://www.w3.org/TR/REC-html40' xml:lang="es" xml:pageEncoding="iso-8859-1" lang="es" >
    <head>
        
<%
    
    BDServiciosReportes bdr = new BDServiciosReportes();
            
    response.setHeader("Cache-Control","no-cache");
  
    DecimalFormat formatea = new DecimalFormat("###,###.##");
   
    
    String ccemp        = session.getAttribute("cod_emp").toString();
    String tipor        = request.getParameter("tipor");
    String plan         = request.getParameter("plan");
    String eje          = request.getParameter("eje");
    String estadopr     = request.getParameter("estado");
    String uniej        = request.getParameter("uniej");
    String estseg       = request.getParameter("estseg");
    String formato      = request.getParameter("formato");
    String nomproy      = request.getParameter("nomproy"); 
    String fcinirep      = request.getParameter("fcinirep"); 
    String fcfinacrep      = request.getParameter("fcfinacrep"); 
    
    if(formato.equals("word")){
            response.setContentType("application/msword");
            response.setHeader("Content-Disposition", "attachment; filename=\"ResumenAvance" + ".doc\"");
    }
    if(formato.equals("excel")){
        response.setContentType("application/excel");
        response.setHeader("Content-Disposition", "attachment; filename=\"ResumenAvance" + ".xls\"");
    }
    
    Vector aux              = new Vector();
    Vector auxpseg          = new Vector();
    Vector auxacseg         = new Vector();
    Vector proyectos        = new Vector();
    Vector objetivosg       = new Vector();
    Vector objetivose       = new Vector();
    Vector metas            = new Vector();
    Vector indicadores      = new Vector();
    Vector actividades      = new Vector();
    Vector seguimproy       = new Vector();
    Vector seguimact        = new Vector();
    Vector activseg         = new Vector();
    
    proyectos = bdr.ConsultaProyectosUser(ccemp, plan, estadopr, eje, uniej, estseg, nomproy, fcinirep, fcfinacrep);
   
    Calendar dateNow = Calendar.getInstance();
    
    
%>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <xml: namespace ns = 'urn: schemas-microsoft-com: vml' prefix = 'v' />
        <title>Informe avance plataforma de seguimiento.</title>
        <style>
            html, body {
                font-family: Verdana, Arial, Helvetica, sans-serif;
                font-size: 11px;
                /*color: #000046;*/
                color: #000000;
            }
            
            table {
                width: 100%;
                border: 1px solid #C0C0C0;
                border-collapse: collapse;
            }
            
            table td, th {
                border: 1px solid #C0C0C0;
            }
            
            table td.title {
                font-weight: bold;
                width: 20%;
                line-height: 150%;
            }
            
            .subTitle {
                margin-top: 32px;
                margin-bottom: 16px;
                font-size: 13px;
            }
        </style>
        
        <style> 
            @page Section1 {
                mso-header: h1;
                mso-footer: f1;
            }
            
            div.Section1 {
                page: Section1;
            }
            
            p.MsoHeader, li.MsoHeader, div.MsoHeader {
                mso-pagination: widow-orphan;
                tab-stops: center 3.0in right 6.0in;
            }
            
            p.MsoFooter, li.MsoFooter, div.MsoFooter {
                margin:0in;
                margin-bottom:.0001pt;
                mso-pagination:widow-orphan;
                tab-stops:center 3.0in right 6.0in;
            }
            
            table#norepeat {
                margin:0in 0in 0in 900in;
                width: 0px;
                height: 0px;
                overflow: hidden;
            }
        </style>
        
        <xml>
        <w:WordDocument>
        <w:View>Print</w:View>
        <w:DoNotOptimizeForBrowser/>
        </w:WordDocument>
        </xml>
    
    </head>
    
    <body>
        <font face="sans-serif" size="2">
        <div class="Section1"><br>
            <p style="text-align: center;">
                <center><b>Resumen Proyectos - Plataforma de Seguimiento.</b></center>
            </p>
                <!--<img src="https://upload.wikimedia.org/wikipedia/commons/2/2f/Escuela_Colombiana_de_Ingenier%C3%ADa_2.jpg">-->
                <!--<img id='img-0' src='http://".$_SERVER['PLATON']."/img/img_encab.png' />-->
            <br>
               
               <%for (int i = 0 ; i < proyectos.size() ; i++){
                   
                   Vector auxppal = (Vector)proyectos.elementAt(i);
                   
                   objetivosg  = bdr.ConsultaObjetivosProyecto(auxppal.elementAt(0).toString(),"1");
                   objetivose  = bdr.ConsultaObjetivosProyecto(auxppal.elementAt(0).toString(),"2");
                   metas       = bdr.ConsultaObjetivosProyecto(auxppal.elementAt(0).toString(),"3");
                   indicadores = bdr.ConsultaIndProyecto(auxppal.elementAt(0).toString());
                   actividades = bdr.ConsultaActividades(auxppal.elementAt(0).toString());
               %> 
            
            <em><p style="text-align: center;"><b>Información General</b></p></em>
               
            <p style="text-align: justify;">
                <b>Proyecto: </b> <u><%=auxppal.elementAt(1)%></u> 
            </p>
            <p style="text-align: justify;">
                <b>Vigencia: </b> <%=auxppal.elementAt(7)%> - <%=auxppal.elementAt(8)%>
            </p>
            <p style="text-align: justify;">
                <b>Estado: </b> <%=auxppal.elementAt(9)%>
            </p
            <p style="text-align: justify;">
                <b>Unidad Ejecutora: </b> <%=auxppal.elementAt(20)%>
            </p>
            
            <%if(objetivosg.size() > 0){%>
            <b>Objetivo General:</b><br>
            <p style="text-align: justify;">
                <% for ( int m = 0 ; m < objetivosg.size() ; m++ ){
                                      aux = (Vector)objetivosg.elementAt(m); 
                                    %>
                                    - <%=aux.elementAt(1)%>
                <%}%>
            </p>
             <%}%>
            
            <%if(objetivose.size() > 0){%>
            <b>Objetivo(s) Específico(s):</b><br>
            <p style="text-align: justify;">
                <% for ( int m = 0 ; m < objetivose.size() ; m++ ){
                                      aux = (Vector)objetivose.elementAt(m); 
                                    %>
                                    - <%=aux.elementAt(1)%>
                <%}%>
            </p>
            <%}%>
            
            <b>Justificaci&oacute;n:</b><br>
            <p style="text-align: justify;">
               <%=auxppal.elementAt(5)%>
            </p>
            <p><b>Actividades:</b>
            </p>
            <%for(int m = 0 ; m < actividades.size() ; m++){ 
                            aux = (Vector)actividades.elementAt(m);
                            %>
                            <p style="text-align:  justify"> <%=(m+1)%>. <%=aux.elementAt(1)%> <b>Vigencia:</b> <%=aux.elementAt(3)%> - <%=aux.elementAt(4)%>.</p>
            
            <%}%>
            <br>
            <p><b>Metas:</b>
            </p>
            <%for(int m = 0 ; m < metas.size() ; m++){ 
                            aux = (Vector)metas.elementAt(m);
                            %>
                            <p style="text-align:  justify"> <%=(m+1)%>. <%=aux.elementAt(1)%>.</p>
            
            <%}%>
            <br>
            <br>
            <p><b>Indicadores Proyecto:</b>
            </p>
            <%for(int m = 0 ; m < indicadores.size() ; m++){ 
                            aux = (Vector)indicadores.elementAt(m);
                            %>
                            <p style="text-align:  justify"> <%=(m+1)%>. <b>Nombre:</b> <%=aux.elementAt(1)%> <b>Periodicidad:</b> <%=aux.elementAt(3)%> <b>Descripción</b> <%=aux.elementAt(7)%>.</p>
            
            <%}%>
            <br>
            <%if(tipor.equals("2")){
                
                seguimproy = bdr.ConsultaSeguimientosPR(auxppal.elementAt(0).toString());
            %>
            <%if(seguimproy.size()>0){%>
            
            <em><p style="text-align: center;">
            <b>Descripción del Avance por año.</b>   <br><br>
            </p></em>
            
            <b><u>Avance General del Proyecto</u></b><br><br>
            <%for(int w = 0 ; w < seguimproy.size() ; w++){
                            auxpseg = (Vector)seguimproy.elementAt(w);
                            activseg = bdr.ConsultaActividadesSeg(auxpseg.elementAt(1).toString());
            %>
            
            <p><u><b>Año:</b> <%=auxpseg.elementAt(0)%></u> <br></p>
            <p><b>Fecha del último Avance del año:</b> <%=auxpseg.elementAt(2)%> <br></p>
            <p><b>Estado:</b> <%=auxpseg.elementAt(4)%> <br></p>
            <p><b>Porcentaje de Avance:</b> <%=auxpseg.elementAt(3)%> <br></p>
            <p><b>Descripción del Avance:</b></p> <p style="text-align: justify;"><%=auxpseg.elementAt(6)%> </p>
            <p><b>Acciones a tomar:</b></p> <p style="text-align: justify;"> <%=auxpseg.elementAt(7)%> </p>
            <p><b>Dificultades del avance:</b></p> <p style="text-align: justify;"> <%=auxpseg.elementAt(9)%> </p>
            
            <%if(activseg.size() > 0){%>            
            <b><u>Avance de Actividades del Proyecto.</u></b><br><br>
            
            <%for(int p = 0; p < activseg.size(); p++){
                        auxacseg = (Vector)activseg.elementAt(p);
            %>
            
            <p><b>Nombre actividad:</b> <%=auxacseg.elementAt(7)%> <br></p>
            <p><b>Estado actividad:</b> <%=auxacseg.elementAt(3)%> <br></p>
            <p><b>Porcentaje de avance actividad:</b> <%=auxacseg.elementAt(6)%> <br></p>
            <p><b>Descripción del avance actividad:</b> <%=auxacseg.elementAt(4)%> <br></p>
            <p><b>Acciones a tomar actividad:</b> <%=auxacseg.elementAt(5)%> <br></p>
            
            <%}//if tieneact%>
            <%}//for actividades%>
            <%}//for recorreseg%>
            <%}//if tieneseg%>
            <%}//if tipo%>
            <br><br>
            <%}%>
            
            <center><b>Resumen Presupuestal</b></center>
            <br>
            
            <%if(proyectos.size()>0){%>
            <table>
                
                <tr>
                    <th bgcolor="#8B0D04"><font color="#FFFFFF">Nombre del Proyecto</font></th>
                    <th bgcolor="#8B0D04"><font color="#FFFFFF">Estado</font></th>
                    <th bgcolor="#8B0D04"><font color="#FFFFFF">Valor personal planeado</font></th>
                    <%if(tipor.equals("2")){%>
                    <th bgcolor="#8B0D04"><font color="#FFFFFF">Valor personal ejecutado</font></th> 
                    <%}%>
                    <th bgcolor="#8B0D04"><font color="#FFFFFF">Valor erogación planeado</font></th>
                    <%if(tipor.equals("2")){%>
                    <th bgcolor="#8B0D04"><font color="#FFFFFF">Valor erogación ejecutado</font></th> 
                    <%}%>
                    <th bgcolor="#8B0D04"><font color="#FFFFFF">Valor Total planeado</font></th> 
                    <%if(tipor.equals("2")){%>
                     <th bgcolor="#8B0D04"><font color="#FFFFFF">Valor Total ejecutado</font></th> 
                    <%}%>
                    
                </tr>
                <%for (int i = 0 ; i < proyectos.size() ; i++){
                
                    Vector auxppal = (Vector)proyectos.elementAt(i);
                %>

                
                <tr>
                    <td><%=auxppal.elementAt(1).toString()%></td>
                    <td><%=auxppal.elementAt(9).toString()%></td>
                    <td><%if(!auxppal.elementAt(25).toString().equals("No disponible")){%><%=formatea.format(new BigInteger(auxppal.elementAt(25).toString()))%><%}else{%>0<%}%></td>
                    <%if(tipor.equals("2")){%>
                    <td><%if(!auxppal.elementAt(23).toString().equals("No disponible")){%><%=formatea.format(new BigInteger(auxppal.elementAt(23).toString()))%><%}else{%>0<%}%></td>
                    <%}%>
                    <td><%if(!auxppal.elementAt(26).toString().equals("No disponible")){%><%=formatea.format(new BigInteger(auxppal.elementAt(26).toString()))%><%}else{%>0<%}%></td>
                    <%if(tipor.equals("2")){%>
                    <td><%if(!auxppal.elementAt(24).toString().equals("No disponible")){%><%=formatea.format(new BigInteger(auxppal.elementAt(24).toString()))%><%}else{%>0<%}%></td>
                    <%}%>
                    <td><%if(!auxppal.elementAt(10).toString().equals("No disponible")){%><%=formatea.format(new BigInteger(auxppal.elementAt(10).toString()))%><%}else{%>0<%}%></td>
                    <%if(tipor.equals("2")){%>
                     <td><%if(!auxppal.elementAt(11).toString().equals("No disponible")){%><%=formatea.format(new BigInteger(auxppal.elementAt(11).toString()))%><%}else{%>0<%}%></td> 
                    <%}%>
                    
                </tr>
                
                <%}%>
            </table>
            <%}%>
            <br><br>
            <!--[if supportFields]-->
            
            <!--[endif]-->
        </div>
      </font>
            <table id='norepeat' border='0' cellspacing='0' cellpadding='0'>
                <tr>
                    <td>
                        <div style="mso-element: header" align="right" id="h1">
                            <!--<img src="img/img_encab.png" align="left">-->
                                    <font size="0.2">
                                    Escuela Colombiana de Ingeniería Julio Garavito<br>
                                    Plataforma de seguimiento a la planeación
                                    <br><br>
                                    </font>
                        </div>
                    </td>
                    <td>
                        <div style="mso-element: footer" id="f1" align="right">
                            <p class="MsoFooter">
                                <font size="0.2">
                                    Número de proyectos del presente informe: <%=proyectos.size()%><br>
                                    Fecha del informe: <%=dateNow.get(Calendar.DAY_OF_MONTH)%> de <%=dateNow.getDisplayName(Calendar.MONTH, Calendar.LONG, new Locale("es","CO"))%> de <%=dateNow.get(Calendar.YEAR)%><br>
                                    <br>
                                 </font>
                                <span style=mso-tab-count:2'></span>
                                Página <span style='mso-field-code: PAGE '></span> de <span style='mso-field-code: NUMPAGES '></span>
                            </p>
                        </div>
                    </td>
                </tr>
            </table>
    </body>
</html>