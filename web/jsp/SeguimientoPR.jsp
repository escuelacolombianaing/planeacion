<%-- 
    Document   : seguimiento
    Created on : 02/02/2017, 04:00:00 PM
    Author     : Juan Vanzina
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="BDatos.BDServiciosAdmin"%>
<%@page import="java.util.Vector"%>
<%@page import="BDatos.BDServicios"%>
<%@ include file="secure.jsp" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%response.setHeader("Cache-Control", "no-cache");        String ccemp = session.getAttribute("cod_emp").toString();
    //    String nomus = session.getAttribute("nom_emp").toString(); 
    //    String apus1 = session.getAttribute("ap1_emp").toString();
    //    String apus2 = session.getAttribute("ap2_emp").toString();
    //    String mailus = session.getAttribute("e_mail").toString();
        
        DecimalFormat formatea = new DecimalFormat("###,###.##");
        
        BDServicios bd = new BDServicios();
        BDServiciosAdmin bda = new BDServiciosAdmin();
        
        String idp     = request.getParameter("idp");
        String idseg   = request.getParameter("seg");
        String Valor = "", Cadena = "";
        
        int numero_archivo = 0; 
        
        String TErogStg = "0";
        Vector aux              = new Vector();
        Vector aux2             = new Vector();
        Vector datosb           = new Vector();
        Vector estadoejec       = new Vector();
        Vector metas            = new Vector();
        Vector indicadores      = new Vector();
        Vector indicadoract     = new Vector();
        Vector activseg         = new Vector();
        Vector activnoseg       = new Vector();
        Vector personal         = new Vector();
        Vector estadoPer        = new Vector();
        Vector horas            = new Vector();
        Vector horas1           = new Vector();
        Vector horasejec        = new Vector();
        Vector auxh             = new Vector();
        Vector empleados        = new Vector();
        Vector rubofpr          = new Vector();
        Vector archivos         = new Vector();
        Vector infseg           = new Vector();
        Vector infsegmet        = new Vector();
        Vector infsegind        = new Vector();
        Vector segactividad     = new Vector();
        Vector segpersonal      = new Vector();
        Vector actividad        = new Vector();        
        Vector segpryant        = new Vector();
        Vector cargos           = new Vector();
        Vector SegErogacion     = new Vector();
        
        BigInteger TErog = new BigInteger("0");   /* asi estaba antes (14 agosto 2019) int TErog = 0;*/
        
        String archivsigcarga = bd.signumeroarch(idp);
        
        int Validar = bd.ValidarIDPrAc(idp, idseg, "2");
        
        if(Validar > 0){
        datosb          = bd.ConsultaDatosProyecto(idp);
        estadoejec      = bd.parametros("2");
        metas           = bd.ConsultaObjetivosProyecto(idp,"3");
        indicadores     = bd.ConsultaIndProyecto(idp);
        activseg        = bd.ConsultaActividadesSEG(idp, "1");
        
        empleados       = bd.usuario();
        //rubofpr         = bda.ConsultaRubOF(idp);
        infseg          = bd.ConsultaSeguimiento(idseg);
        cargos          = bd.cargoseci();
        SegErogacion    = bd.ConsultaSegErogacion(idseg);
        }
        
        String estadosg = bd.ConsultaEstadoSegActual(idseg);
        
        segpryant       = bd.ConsultaSegAnteriorProy(idp, idseg);
                
        String vigencia = bd.vigenciaproy(idp);
        String agactual = "";
        String nomPer = "";
        String ccPer = "";
%>
<html lang="es">
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
    <script type="text/javascript">
        function ValidarCboxActividad(idact,evento){
            if(document.getElementById(idact).value==0){
                alert("No selecciono una opcion en Estado Ejecución Actividad")
                  evento.preventDefault();
                return false;
            }else{
              return true;
            }
        }
         function ValidarCboxEstadoEje(idestado,evento){
            if(document.getElementById(idestado).value==0){
                alert("No selecciono una opcion Estado Ejecución")
                  evento.preventDefault();
                return false;
            }else{
              return true;
            }
        }
    </script>
</head>
<body onload="testshow()">

    <header>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <center><img src="img/img-header-2.jpg" class="img-responsive"></center>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 franjaColor">
                    <center><h4>.:: Plataforma de seguimiento a la planeación ::.</h4><div align="right"><input class="btn-danger" type="button" align="right" value="Cerrar Sesión" onclick="location.href = '/planeacion/LogOut';"></center>
                        </div>
                </div>
            </div>
            <center> <img src="img/img-seguimiento.jpg" alt="portada" class="img-responsive"></center>
        </div>
    </header>
<%if(!ccemp.equals("1")){%>
    <nav>
        <div class="container">
        <ul class="nav nav-pills nav-justified">
          <li role="presentation"><a href="/planeacion/home"><span class="glyphicon glyphicon-home"></span> Inicio</a></li>
          <li role="presentation"><a href="/planeacion/proyectosact"><span class="glyphicon glyphicon-duplicate"></span> Proyectos activos</a></li>
          <li role="presentation"><a href="/planeacion/seguimiento"><span class="glyphicon glyphicon-eye-open"></span> Seguimiento</a></li>
          <li role="presentation"><a href="/planeacion/historial"><span class="glyphicon glyphicon-list-alt"></span> Historial</a></li>
          <li role="presentation"><a href="/planeacion/reportes"><span class="glyphicon glyphicon-file"></span> Reportes</a></li>
        </ul>
        </div>
    </nav>
<%}else{%>
.
    <nav>
        <div class="container">
        <ul class="nav nav-pills nav-justified">
          <li role="presentation"><a href="/planeacion/homeadm"><span class="glyphicon glyphicon-home"></span> Inicio</a></li>
          <li role="presentation"><a href="/planeacion/proyectosactadm"><span class="glyphicon glyphicon-duplicate"></span>Consulta de Proyectos</a></li>
          <li role="presentation"><a href="/planeacion/seguimientoadm"><span class="glyphicon glyphicon-eye-open"></span> Seguimiento Proyectos</a></li>
          <li role="presentation"><a href="/planeacion/historialadm"><span class="glyphicon glyphicon-list-alt"></span> Parametros del Sistema</a></li>
          <li role="presentation"><a href="/planeacion/reportesadm"><span class="glyphicon glyphicon-file"></span> Reportes Administrador</a></li>
        </ul>
        </div>
    </nav>

<%}%>

<!--CONTENIDOS-->
   
            
     <!--CONTENIDOS-->
    <section>
        <div class="container">

            
            <div class="colorFormulario">
                <%if(datosb.elementAt(21).equals("M")){%><a>MEGAPROYECTO</a><%}%>
                 <center>
                    <strong>Id. Proyecto:           </strong>           <a><%=idp%></a>  
                    <strong>Nombre del Proyecto:    </strong>           <a><%=datosb.elementAt(0)%></a>  <br>
                    <strong>Estado Proyecto:        </strong>           <a><%=bd.parametrosEsp("1", datosb.elementAt(1).toString())%></a>
                    <strong>Avance:                 </strong>           <a><%=datosb.elementAt(14)%>%</a>
                    <strong>Plan:                   </strong>           <a><%=bd.nombreplan(datosb.elementAt(3).toString())%></a>
                    <strong>Vigencia:               </strong>           <a><%=vigencia%></a>
                    <strong>Director:               </strong>           <a><%=bd.usuarioconscc(datosb.elementAt(6).toString())%></a>
                    <strong>Fecha Seg:              </strong>           <a><%=infseg.elementAt(1)%></a>
                    <br>
                    <marquee SCROLLDELAY=40 WIDTH=30% ><font color="red">Seguimiento del Proyecto</font></marquee>
                    <br><br>
                    <button class="btn btn-group-sm" onclick="window.open('/planeacion/ResumenPlaneacion?idp=<%=idp%>')">Ver Resumen Proyecto</button>
                </center>
            </div>
            
<% if((ccemp.equals(datosb.elementAt(17).toString()) || ccemp.equals(datosb.elementAt(6).toString()) || ccemp.equals(datosb.elementAt(7).toString()) || ccemp.equals("1")) || bd.ValidarDirectorResponMegapro(ccemp).equals("1")){%>            

<!--DATOS BASICOS-->
<%if(segpryant.size()>0){%>
<center><h3><button class="btn btn-warning" target="popup" onclick="window.open('/planeacion/seguimientoPR?idp=<%=idp%>&seg=<%=segpryant.elementAt(0)%>','name','resizeable=true,scrollbars,width=800,height=1000')">Ver seguimiento anterior (<%=segpryant.elementAt(1)%>)</button></h3></center>
<%}%>
            
        <%if(estadosg.equals("1")){%>

            <div class="colorFormulario">
                <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                  
                    
                    <!--ACTIVIDADES-->
                <%if(datosb.elementAt(21).equals("P")){%>  <!-- TERMINA EN LINEA 714-->   
                <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingFour">
                      <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                          <span class="glyphicon glyphicon-paperclip"></span> SEGUIMIENTO ACTIVIDADES
                        </a>
                      </h4>
                    </div>
                    <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour"> <!-- TERMINA EN LINEA 711--> 
                      <div class="panel-body">
                        Describa las acciones realizadas, el estado, el porcentaje de avance, la dedicación de personal e indicadores de las actividades formuladas de acuerdo con el cronograma establecido para el proyecto. Planeado para vigencia actual: Actividad que su ejecución se encuentra dentro de las fechas de seguimiento. Planeado para vigencia posterior: Actividad que su ejecución inicia después de las fechas de seguimiento.
                        <br>
                        <br>
                       
                        <%if(activseg.size()>0){%>
                        
                        
                        <% for ( int ml = 0 ; ml < activseg.size() ; ml++ ){
                            
                                       aux2 = (Vector)activseg.elementAt(ml);
                                       
                                       String Actividad = aux2.elementAt(0).toString();
                                       
                                       if (Actividad.equals("627")) {
                                            
                                           }
                                       segactividad = bd.ConsultaSeguimientoActividad(idseg, Actividad);
                                       
                                       if(segactividad.size()>0){
                                       
                                       Vector segactant = new Vector();
                                       
                                       /* SE DESHABILITA 13 DE SEPTIEMBRE DE 2019
                                        * segactant = bd.ConsultaSegAnteriorAct(Actividad, idseg);*/
                                       
                                       //
                                       segactant = bd.ConsultaSegAnteriorAct(Actividad);
                                       
                                       String ActSeg = "0";
                                       
                                       if(segactividad.size() <= 0){
                                           ActSeg = "0";
                                       }else{
                                          ActSeg = segactividad.elementAt(0).toString();
                                       }
                                       personal = bd.ConsultaPersonal(aux2.elementAt(0).toString(), ActSeg);
                                      
                         %>
                                    
                                
                                
                                
                                 <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="heading<%=(ml+1)%>">
                                      <h4 class="panel-title">
                                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion2" href="#colsend<%=Actividad%>" aria-expanded="false" aria-controls="collapse<%=(ml+1)%>">
                                            <span class="glyphicon glyphicon-adjust"></span> <%=(ml+1)%>. <%=aux2.elementAt(1)%> 
                                            
                                            <%if(aux2.elementAt(10).toString().equals("1")){%>
                                            <font color="red">(Planeado para vigencia actual)</font><br> <br>Vigencia:  (<%=aux2.elementAt(3).toString()%> - <%=aux2.elementAt(4).toString()%>)
                                            <%}else{%>
                                            <font color="green">(Planeado para vigencia posterior/anterior)</font><br>  <br>Vigencia:  (<%=aux2.elementAt(3).toString()%> - <%=aux2.elementAt(4).toString()%>)
                                            <%}%>
                                        </a>
                                      </h4>
                                    </div>
                                    <div id="colsend<%=Actividad%>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading<%=(ml+1)%>">
                                      <div class="panel-body">
                               
                                <div class="panel-body">    
                                    
                                    <form action="ActualizarDatosActividadSeguimiento" method="POST" onsubmit="ValidarCboxActividad(<%=Actividad%>,event)">
                                        <input type="hidden" name="tipoalm" value="PR">
                                        <input type="hidden" name="idp" value="<%=idp%>">
                                        <input type="hidden" name="idseg" value="<%=idseg%>">
                                        <input type="hidden" name="idact" value="<%=Actividad%>">
                                                <div class="row">
                                                    <div class="col-xs-12 col-md-3 col-lg-4">
                                                        <div class="form-group espaciado">
                                                                                <label for="">Estado Ejecución Actividad</label>
                                                                                <select id="<%=Actividad%>" name="estejecact" class="form-control" id="estejec" required>
                                                                                    <%if (estadoejec.size() > 0){ 
                                                                                            for (int ii = 0; ii < estadoejec.size(); ii++) {
                                                                                                    Vector infusu = (Vector)estadoejec.elementAt(ii);
                                                                                                    if(segactividad.size()>0){       
                                                                                                    if(infusu.elementAt(0).toString().equals(segactividad.elementAt(3).toString())){
                                                                                                        Valor = infusu.elementAt(0).toString(); Cadena = infusu.elementAt(1).toString();
                                                                                                    }}
                                                                                    %>
                                                                                    <option value="<%=infusu.elementAt(0)%>"><%=infusu.elementAt(1)%></option>
                                                                                            <%} if(Valor.equals("")){Cadena="Seleccione un elemento de la lista";}
                                                                                            %>
                                                                                            <option value="<%=Valor%>" selected='selected'><%=Cadena%></option><%Valor="";Cadena="";%>
                                                                                            <%
                                                                                    }%>
                                                                                </select>
                                                         </div>
                                                   </div>
                                                    <div class="col-xs-12 col-md-3 col-lg-4">
                                                        <div class="form-group espaciado">
                                                                                <label for="">Porcentaje de Avance Actividad</label>
                                                                                <%if(segpryant.size()>0 && segactant.size()>0){%>
                                                                                <input type="number" value="<%=segactividad.elementAt(6)%>" name="porcavact" min="<%=segactant.elementAt(6)%>" max="100" class="form-control" required>
                                                                                <%}else if(segactant.size()>0){%>
                                                                                <input type="number" value="<%=segactividad.elementAt(6)%>" name="porcavact" min="0" max="100" class="form-control" required>
                                                                                <%}else{%>
                                                                                <input type="number" value="<%=segactividad.elementAt(6)%>" name="porcavact" min="0" max="100" class="form-control" required>                                                                                
                                                                                <%}%>
                                                        </div>
                                                    </div>
                                                    <%if(segactant.size()>0){%>
                                                    <div class="col-xs-12 col-md-3 col-lg-4">
                                                        <div class="form-group espaciado">
                                                                                <label for="">Porcentaje de Avance Anterior Seguimiento</label>
                                                                                <input type="number" value="<%=segactant.elementAt(6)%>" class="form-control" readonly>
                                                                        </div>
                                                    </div>
                                                    <%}%>
                                                
                                                     
                                                  <div class="row">
                                                        <div class="col-xs-12 col-md-3 col-lg-12">
                                                                <div class="form-group espaciado">
                                                                                        <label for="">Descripción del Avance de la Actividad</label>
                                                                                        <textarea class="form-control" rows="6" name="descavact" required><%=segactividad.elementAt(4)%></textarea>
                                                                                </div>
                                                        </div>
                                                </div>
                                                  <div class="row">
                                                        <div class="col-xs-12 col-md-3 col-lg-12">
                                                                <div class="form-group espaciado">
                                                                                        <label for="">Acciones a Tomar</label>
                                                                                        <textarea class="form-control" rows="6" name="accionavact" required><%=segactividad.elementAt(5)%></textarea>
                                                                                </div>
                                                        </div>
                                                </div>
                                                  
                                                  <center><input type="submit" value="Guardar Seguimiento Actividad" id="act" class="btn-lg"></center>
                                                  
                                                                                                    
                                             </div>  
                                    </form>
                                                  
                                                       <%if(personal.size()>0){%>
                                                        
                                                        <h4><strong>Dedicación de Personal</strong></h4>
                                                        *(Por favor ingrese <strong>unicamente las horas del seguimiento actual</strong>, el sistema se encarga de sumar el total) <br><br>
                                                        
                                                        <form action="ActualizaSeguimientoHoras" method="POST">
                                                                    <input type="hidden" name="tipoalm" value="PR">
                                                                    <input type="hidden" name="idp" value="<%=idp%>">
                                                                    <input type="hidden" name="idseg" value="<%=idseg%>">
                                                                    
                                                              <table class="table table-hover">
                                                                <tr>
                                                                  <th>Nombre</th>
                                                                  <th>Cargo</th>
                                                                  <th>Horas en Planeación</th>
                                                                  <th>Total Horas acumuladas</th>
                                                                  <th>Horas Seguimiento Actual</th>
                                                                </tr>
                                                                <% for ( int qwq = 0 ; qwq < personal.size() ; qwq++ ){
                                                                 
                                                                             aux = (Vector)personal.elementAt(qwq);
                                                                       
                                                                    segpersonal = bd.ConsultaSeguimientoPersonal(idseg, aux.elementAt(0).toString());
                                                                    
                                                                   // if(segpersonal.size()==0){break;}
                                                                %>
                                                                <input type="hidden" name="idact" value="<%=Actividad%>">
                                                                <input type="hidden" name="idpers" value="<%=aux.elementAt(0).toString()%>">
                                                                
                                                                <tr>
                                                                    <%if(aux.elementAt(1).toString().equals("Sin Definir")){%>
                                                                        <td><%=aux.elementAt(1).toString()%></td>
                                                                    <%}else{%>
                                                                        <td><%=bd.usuarioconscc2(aux.elementAt(1).toString())%></td>
                                                                    <%}%>
                                                                  
                                                                  <td><%=aux.elementAt(2).toString()%></td>
                                                                  <td>
                                                                      <%    horas       = bd.ConsultarHorasSeg(aux.elementAt(0).toString());
                                                                            agactual    = infseg.elementAt(11).toString();
                                                                            horasejec   = bd.ConsultaTotalHorasSeg(Actividad, aux.elementAt(0).toString(),idseg);
                                                                         for ( int s = 0 ; s < 1 ; s++ ){
                                                                             if (horas.size()>0) {
                                                                                    auxh = (Vector)horas.elementAt(s); 
                                                                                 }
                                                                      %>
                                                                      
                                                                      <table>
                                                                          <td><input type="number" class="form-control" value="<%=agactual%>" name="agno" readonly></td>
                                                                          <%if(aux.elementAt(4).toString().equals("1")){%>
                                                                          <td><input type="number" class="form-control" value="<%=auxh.elementAt(1)%>" name="" min="0" max="2920" readonly></td>
                                                                          <%}else{%>
                                                                          <td><input type="number" class="form-control" value="0" name="" min="0" max="2920" readonly></td>
                                                                          <%}%>
                                                                      </table>
                                                                      
                                                                      <%}%>

                                                                  </td> 
                                                                  <td>
                                                                      <%horas = bd.ConsultarHorasSeg(aux.elementAt(0).toString());
                                                                     
                                                                       /* if(horas.size()<1){
                                                                                horas.add( new String[] { agactual , "0" } );
                                                                              
                                                                            }*/
                                                                         for ( int s = 0 ; s < 1 ; s++ ){
                                                                             
                                                                             if(horas.size()<1) {
                                                                                 auxh.addElement(agactual);
                                                                                 auxh.addElement("0");
                                                                             }else{    
                                                                             auxh = (Vector)horas.elementAt(s); //este es el q est mal
                                                                             }
                                                                         
                                                                      %>
                                                                      
                                                                      <table>
                                                                          <%if(aux.elementAt(4).toString().equals("1")){%>
                                                                          <td><input type="number" class="form-control" name="" value="<%=horasejec.elementAt(0)%>" min="0" max="2920" readonly></td>
                                                                          <%}else{%>
                                                                          <td><input type="number" class="form-control" name="" value="0" min="0" max="2920" readonly></td>
                                                                          <%}%>
                                                                      </table>
                                                                      
                                                                      <%}%>
                                                                  </td>
                                                                  <td>
                                                                      <% horas = bd.ConsultarHorasSeg(aux.elementAt(0).toString());
                                                                         for ( int s = 0 ; s < 1 ; s++ ){
                                                                             if (horas.size()>0) {
                                                                                    auxh = (Vector)horas.elementAt(s); 
                                                                                 }
                                                                            
                                                                      %>
                                                                      
                                                                      <table>
                                                                          <%if(segpersonal.size()!=0){%>
                                                                          <td><input type="number" class="form-control" name="horas" value="<%=segpersonal.elementAt(4)%>" min="0" max="2920" required></td>
                                                                          <%}else{%>
                                                                          <td><input type="number" class="form-control" name="horas" value="0" min="0" max="2920" required></td>
                                                                          <%}%>
                                                                      </table>                                                                      
                                                                      <%}%>
                                                                  </td>
                                                                
                                                                </tr>
                                                                <%}%>
                                                              </table>
                                                              
                                                              <center><input type="submit" value="Guardar Horas Participantes" id="act" class="btn-lg"></center>
                                                              
                                                            </form>
                                                              
                                                              <br>
                                                              <div class="colorFormulario"> 
                                                                <center><h4><strong>Eliminar Personal en Seguimiento</strong></h4></center><br>
                                                                <form action="EliminarPersonal" method="POST" onsubmit="return confirm('Esta Seguro de eliminar el Personal?');">
                                                                    <center>
                                                                        <table>
                                                                            <tr>
                                                                                <td>
                                                                                     <div class="select">
                                                                                       <select name="idPer" required>
                                                                                          <option value=""><font face="Times New Roman, Times, serif" size="2">Seleccione personal</font></option>
                                                                                              <%   
                                                                                                      for (int ii = 0; ii < personal.size(); ii++) 
                                                                                                      {
                                                                                                        Vector infusu = (Vector)personal.elementAt(ii) ;  
                                                                                                        if(infusu.elementAt(1).toString().equals("Sin Definir")){
                                                                                                        nomPer=infusu.elementAt(1).toString();}
                                                                                                        else{nomPer=bd.usuarioconscc2(infusu.elementAt(1).toString()); }
                                                                                              %>

                                                                                           <option value="<%=infusu.elementAt(0)%>"><font face="Times New Roman, Times, serif" size="2"><%=nomPer%> - <%=infusu.elementAt(2)%></font></option>
                                                                                                    <%}%>
                                                                                        </select>                                                 
                                                                                     </div>    
                                                                                </td>
                                                                                <td>&nbsp; &nbsp; &nbsp;</td>
                                                                                <td>
                                                                                    <input type="hidden" name="idp" value="<%=idp%>">
                                                                                    <input type="hidden" name="idseg" value="<%=idseg%>">
                                                                                    <input type="hidden" name="idAct" value="<%=Actividad%>">
                                                                                    <!-- <input type="hidden" name="idAct" value="<%=Actividad%>"> -->
                                                                                    
                                                                                    <input class="btn btn-group-sm" type="submit" value="Eliminar personal"/>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </center>
                                                                 </form><br>
                                                               </div>           
                                                               <%}else{%>
                                                               
                                                               <br><br>
                                                                <center><h4>Su actividad no registra dedicación de personal en la plataforma.</h4></center><br>
                                                                <%}%>
                                                              <br><br>
                                                              <div class="row" id="addcarac" style="display:block">
                                                                          <h3>Personal adicional para seguimiento ACTUAL</h3>
                                                                          <input type="radio" class="radioBtn" name="Radio" id="Radio" value="Q" onchange="testshow()"><a>Solo Consultar</a>     
                                                                          <input type="radio" class="radioBtn" name="Radio" id="Radio" value="N" onchange="testshow()" checked="checked"><a>Agregar personal por Nombre</a>
                                                                          <input class="radioBtn" type="radio" name="Radio" id="Radio" value="C" onchange="testshow()"><a>Agregar personal por Cargo</a>
                                                                          <br><br>
                                                                                <%  actividad   = bd.ConsultaInfoActividad(Actividad);  %>
                                                                                <div class="Box" style="display:none">
                                                                                <%agactual    = infseg.elementAt(10).toString();%>  
                                                                                <form action="NuevaDedPersonalSeg" method="POST">
                                                                                    <input type="hidden" name="tipoalm" value="PR">
                                                                                    <input type="hidden" name="returntip" value="U">
                                                                                    <div class="col-xs-12 col-md-3 col-lg-10">
                                                                                            <div class="form-group espaciado">
                                                                                                    <label for="">Nombre:</label>
                                                                                                                    <select name="empl" id="director" class="form-control" required>
                                                                                                                        <%if (empleados.size() > 0){
                                                                                                                               %><option value="">Seleccione Persona</option><%
                                                                                                                                for (int ii = 0; ii < empleados.size(); ii++) {
                                                                                                                                        Vector infusu = (Vector)empleados.elementAt(ii) ;
                                                                                                                        %>
                                                                                                                        <option value="<%=infusu.elementAt(0)%>"><%=infusu.elementAt(1)%></option>
                                                                                                                                <%} if(Valor.equals("")){Cadena="Seleccione un elemento de la lista";}
                                                                                                                        }%>
                                                                                                                    </select>
                                                                                                    <label for="">Horas</label>                

                                                                                                    <input class="form-control" type="number" value="<%=agactual%>" name="agnos" readonly>
                                                                                                    <input class="form-control" type="number" min="0" name="horaspart" required>
                                                                                                    
                                                                                            </div>
                                                                                    </div>
                                                                                    <div class="col-xs-12 col-md-3 col-lg-4">
                                                                                            <div class="form-group espacio">
                                                                                                <input type="hidden" value="<%=idp%>" name="idp">
                                                                                                <input type="hidden" value="<%=ActSeg%>" name="idact">
                                                                                                <input type="hidden" value="<%=idseg%>" name="idseg">
                                                                                                <input type="hidden" name="idacret" value="<%=Actividad%>">
                                                                                                <input type="submit" value="Agregar Participante" class="btn-lg">                                
                                                                                            </div>
                                                                                    </div>
                                                                                    </form>
                                                                                                                          
                                                                          </div>          
                                           
                                                                                   <div class="Box2" style="display:none">
                                                                                            
                                                                                       
                                                                                       <form action="NuevaDedPersonalCargoSeg" method="POST">
                                                                                           <input type="hidden" name="tipoalm" value="PR">
                                                                                    <div class="col-xs-12 col-md-3 col-lg-10">
                                                                                            <div class="form-group espaciado">
                                                                                                    <label for="">Nombre:</label>
                                                                                                                    <select name="empl" id="director" class="form-control" required>
                                                                                                                        <%if (cargos.size() > 0){
                                                                                                                               %><option value="">Seleccione Cargo</option><%
                                                                                                                                for (int ii = 0; ii < cargos.size(); ii++) {
                                                                                                                                        Vector infusu = (Vector)cargos.elementAt(ii) ;
                                                                                                                        %>
                                                                                                                        <option value="<%=infusu.elementAt(0)%>"><%=infusu.elementAt(1)%></option>
                                                                                                                                <%} if(Valor.equals("")){Cadena="Seleccione cargo";}
                                                                                                                        }%>
                                                                                                                    </select>
                                                                                                    <label for="">Horas</label>     
                                                                                                    
                                                                                                    <input class="form-control" type="number" value="<%=agactual%>" name="agnos" readonly>
                                                                                                    <input class="form-control" type="number" min="0" name="horaspart" required>
                                                                                                    
                                                                                            </div>
                                                                                    </div>
                                                                                    <div class="col-xs-12 col-md-3 col-lg-4">
                                                                                            <div class="form-group espacio">
                                                                                                <input type="hidden" value="<%=idp%>" name="idp">
                                                                                                <input type="hidden" value="<%=ActSeg%>" name="idact">
                                                                                                <input type="hidden" value="<%=idseg%>" name="idseg">
                                                                                                <input type="hidden" name="idacret" value="<%=Actividad%>">
                                                                                                <input type="submit" value="Agregar Participante" class="btn-lg">                                
                                                                                            </div>
                                                                                    </div>
                                                                                    </form>
                                                                                       
                                                                                   </div>
                                                                                                                          
                                                                          </div>
                                                              
                                                             
                                              <br>
                                              <br>
                                    
                                              
                            <div class="row">
                            
                            <%indicadoract = bd.ConsultaIndActividad(Actividad);%>
                                     
                                      <div class="panel-body">
                                              <div class="row">
                                                      <div class="col-xs-12 col-md-3 col-lg-12">    
                                                      </div>
                                                        <%if(indicadoract.size()>0){%>
                                                        <h4><strong>Indicador(es) de la Actividad</strong></h4>
                                                         <form action="ActualizarSeguimientoIndicadores" method="POST">
                                                             
                                                              <input type="hidden" name="idp" value="<%=idp%>">
                                                                <input type="hidden" name="idseg" value="<%=idseg%>">
                                                              <table class="table table-hover">
                                                                <tr>
                                                                  <th>Nombre</th>
                                                                  <th>Periodicidad de Medición</th>
                                                                  <th>Descripción</th>
                                                                  <th>Resultado</th>
                                                                  <th>Descripción</th>
                                                                </tr>
                                                                <% for ( int m = 0 ; m < indicadoract.size() ; m++ ){
                                                                  aux = (Vector)indicadoract.elementAt(m);
                                                                  
                                                                  infsegind       = bd.ConsultaSeguimientoIndicador(idseg, aux.elementAt(0).toString());
                                                                %>
                                                                
                                                                <input type="hidden" name="idind" value="<%=aux.elementAt(0)%>">
                                                                <input type="hidden" name="tipo" value="idp"><input type="hidden" name="idact" value="<%=Actividad%>">
                                                                <tr>
                                                                  <td><%=aux.elementAt(1)%></td>
                                                                  <td><%=aux.elementAt(3)%></td>
                                                                  <td><%=aux.elementAt(7)%></td>
                                                                  <td><textarea class="form-control" name="resultado"  required><%=infsegind.elementAt(0)%></textarea></td>
                                                                  <td><textarea class="form-control" name="descresult" required><%=infsegind.elementAt(1)%></textarea></td>
                                                                </tr>
                                                                <%}%>
                                                              </table>
                                                              <center> <input type="submit" class="btn-lg" value="Guardar Avance de Indicadores Actividad"> </center>
                                                              <input type="hidden" name="tipoalm" value="PR">
                                                         </form>
                                                          <%}%>
                                              </div>
                                      </div>
                       </div>
                                              
                                              <div class="panel-body">
                        

                       <% archivos = bd.ConsultafilesSeg(idp, Actividad, idseg);%>
                                                  
                        <div class="colorFormulario">  
                                      <%if(archivos.size() > 0){%>
                                      <label>Archivos</label>
                                      <div class="row">
                                          <table class="table">
                                              <tr>
                                                  <th>Número</th>
                                                  <th>Nombre Archivo</th>
                                                  <th>Tipo</th>
                                                  <th>Observación</th>
                                                  <th>Descargar</th>
                                                  <th>Eliminar</th>
                                              </tr>
                                              <% for ( int m = 0 ; m < archivos.size() ; m++ ){
                                                                  aux = (Vector)archivos.elementAt(m);
                                                                  numero_archivo = m+2;
                                              %>
                                              <tr>
                                                  <td><%=(m+1)%></td>
                                                  <td><%=aux.elementAt(2)%></td>
                                                  <td><%=aux.elementAt(4)%></td>
                                                  <td><%=aux.elementAt(5)%></td>
                                                  <td><a href="/planeacion/descarga?down=<%=aux.elementAt(1)%>" download><img src="img/descargar.png" width="20" height="22" border="0"></td>
                                                  <td>
                                                        <form action="EliminarInfoTipo" method="POST" onsubmit="return confirm('Esta Seguro de eliminar el Registro?');">
                                                                                <input type="hidden" name="idp" value="<%=idp%>">
                                                                                <input type="hidden" name="idreg" value="<%=aux.elementAt(0)%>">
                                                                                <input type="hidden" name="tipo" value="ARC">
                                                                            <button name="action" value="blue"><img src="img/delete.png" width="20" height="22" border="0"></button>
                                                        </form>
                                                  </td>
                                              </tr>
                                              <%}%>
                                          </table>
                                      </div>
                                      <%}%>
                                      
                                      
                                                     <div id="Archivo_C" style="display:block">
                                                                        <form action="CargaArchivosSeg" enctype="multipart/form-data" method="post"> 
                                                                            <input type="hidden" name="tipoalm" value="PR">
                                                                            <table class="table">
                                                                                <strong>Asociar Archivo(s) al Seguimiento de la Actividad</strong>
                                                                                <input type="hidden" value="a" name="tipo"><input type="hidden" value="CargaAutoresArchivo" name="retorno">
                                                                                    <input type="hidden" value="<%=idp%>" name="idp">
                                                                                    <input type="hidden" value="<%=idseg%>" name="idseg">
                                                                                    <input type="hidden" value="<%=Actividad%>" name="idact">
                                                                                    <input type="hidden" value="" name="verifica">
                                                                                    <input type="hidden" value="<%=archivsigcarga%>" name="numerosig" >
                                                                                    <input type="hidden" value="s" name="inicial">
                                                                                    <input type="hidden" value="a" name="reto">
                                                                                <tr>
                                                                                    <td><input type="file" name="file" class="" required/></td>
                                                                                    <td><textarea rows="3" type="textarea" maxlength="1999" class="form-control" name="obsar" placeholder="Observación referente al Archivo" required></textarea></td>
                                                                                   <td><input class="btn-lg" type="submit" value="Subir Archivo"/> </td>
                                                                                </tr>
                                                                           </table>
                                                                       </form> 
                                                     </div>
                                  </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                        <%}%>
                        
                        <%}}%>
                        <br>
                        <%if(segpryant.size()>0){%>
                        <a align="rigth" target="popup" onclick="window.open('/planeacion/seguimientoPR?idp=<%=idp%>&seg=<%=segpryant.elementAt(0)%>#collapseFour','name','resizeable=true,scrollbars,width=800,height=1000')">Ver seguimiento anterior:  <%=segpryant.elementAt(1)%></a>
                        <%}%>
                      </div>
                    </div>
                  </div>
                      
            <%}else if(datosb.elementAt(21).equals("M")){
            
                Vector infosubproyect = new Vector();
                infosubproyect = bd.ConsultaSegMegaPro(idseg);
            %>     
            <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingFour">
                      <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                          <span class="glyphicon glyphicon-paperclip"></span> SEGUIMIENTO PROYECTOS
                        </a>
                      </h4>
                    </div>
                    <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
                      <div class="panel-body">
                        Describa las acciones realizadas, el estado, el porcentaje de avance, la dedicación de personal e indicadores de los proyectos asociados de acuerdo con el cronograma establecido para el megaproyecto. 
                        <br>
                        <br>
                       
                     <table class="table table-hover" id="regTable">
                      <thead>
                      <tr>
                        <th>Id. Proyecto</th>
                        <th>Nombre</th> 
                        <th>Fecha inicio</th>
                        <th>Fecha fin</th>
                        <th>Fecha Seguimiento</th>
                        <th>Estado Seguimiento</th>
                        <th>Estado Ejecución</th>
                        <th>Avance</th>
                        <th>Detalle</th>
                      </tr>
                      </thead>
                      
                      <%for(int spr = 0 ; spr < infosubproyect.size() ; spr ++ ){
                          
                          Vector auxmpro = (Vector)infosubproyect.elementAt(spr);
                         
                      %>
                      
                      <tbody>
                      <tr>
                        <td><%=auxmpro.elementAt(0)%></td>
                        <td><%=auxmpro.elementAt(1)%></td>
                        <td><%=auxmpro.elementAt(2)%></td>
                        <td><%=auxmpro.elementAt(3)%></td>
                        <td><%=auxmpro.elementAt(4)%></td>
                        <td><%=auxmpro.elementAt(5)%></td>
                        <td><%=auxmpro.elementAt(8)%></td>
                        <td><%=auxmpro.elementAt(6)%>%</td>
                        <td><a target="_blank" href="/planeacion/seguimientoPR?idp=<%=auxmpro.elementAt(0)%>&seg=<%=auxmpro.elementAt(7)%>">Ver Detalle</a></td>
                      </tr>
                      </tbody>
                      <%}%>
                    </table>
                       
                      </div>
                    </div>
                  </div>
            
            
                      
            <%}%>
                    
    <!--SEG GENERAL-->                
                    <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingOne">
                      <h4 class="panel-title">
                        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                          <span class="glyphicon glyphicon-paperclip"></span> <%if(datosb.elementAt(21).equals("P")){%>SEGUIMIENTO GENERAL DEL PROYECTO<%}else if(datosb.elementAt(21).equals("M")){%>SEGUIMIENTO GENERAL DEL MEGAPROYECTO<%}%>
                        </a>
                      </h4>
                    </div>
                    <div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                        
                        
                      <div class="panel-body">
                        Describa el avance general del proyecto, el porcentaje de avance hasta la fecha de corte, las acciones a tomar para continuar con el proyecto y las dificultades que ha identificado en la ejecución del proyecto.
                      </div>
                        <div class="colorFormulario">
                            <form action="ActualizaDatosBSeguimiento" method="POST" onsubmit="ValidarCboxEstadoEje('CboxEstadoEje',event)">
                                
                                <input type="hidden" name="idp" value="<%=idp%>">
                                <input type="hidden" name="idseg" value="<%=idseg%>">                                
                            <div class="row">
		                	<div class="col-xs-12 col-md-3 col-lg-6">
			                	<div class="form-group espaciado">
									<label for="">Estado Ejecución</label>
                                                                        <select id="CboxEstadoEje" name="estadoejec" class="form-control" id="estejec" >
                                                                            <%if (estadoejec.size() > 0){ 
                                                                                    for (int ii = 0; ii < estadoejec.size(); ii++) {
                                                                                            Vector infusu = (Vector)estadoejec.elementAt(ii) ;
                                                                                            if(infusu.elementAt(0).toString().equals(infseg.elementAt(3).toString())){Valor = infusu.elementAt(0).toString(); Cadena = infusu.elementAt(1).toString();}
                                                                            %>
                                                                            <option value="<%=infusu.elementAt(0)%>"><%=infusu.elementAt(1)%></option>
                                                                                    <%} if(Valor.equals("")){Cadena="Seleccione un elemento de la lista"; Valor="0";}
                                                                                    %>
                                                                                    <option value="<%=Valor%>" selected='selected'><%=Cadena%></option><%Valor="";Cadena="";%>
                                                                                    <%
                                                                            }%>
                                                                        </select>
								</div>
					</div>
                                        <div class="col-xs-12 col-md-3 col-lg-6">
			                	<div class="form-group espaciado">
									<label for="">Estado Ejecución (Seguimiento Anterior)</label>
                                                                        <select name="" class="form-control" readonly>
                                                                            <%if (estadoejec.size() > 0){ 
                                                                                    for (int ii = 0; ii < estadoejec.size(); ii++) {
                                                                                            Vector infusu = (Vector)estadoejec.elementAt(ii) ;
                                                                                            String tmp = "";
                                                                                                    if(segpryant.size()>0){tmp = segpryant.elementAt(3).toString();}
                                                                                            if(infusu.elementAt(0).toString().equals(tmp)){Valor = infusu.elementAt(0).toString(); Cadena = infusu.elementAt(1).toString();} //infseg.elementAt(3).toString()
                                                                            %>
                                                                            <option value="<%=infusu.elementAt(0)%>"><%=infusu.elementAt(1)%></option>
                                                                                    <%} if(Valor.equals("")){Cadena="Sin Información";}
                                                                                    %>
                                                                                    <option value="<%=Valor%>" selected='selected'><%=Cadena%></option><%Valor="";Cadena="";%>
                                                                                    <%
                                                                            }%>
                                                                        </select>
								</div>
					</div>
                                </div>
                            <div class="row">
		                	<div class="col-xs-12 col-md-3 col-lg-4">
			                	<div class="form-group espaciado">
									<label for="">Porcentaje de Avance</label>
                                                                        <%if(segpryant.size()>0){%>
                                                                        <input type="number" name="porcejec" class="form-control" min="<%=segpryant.elementAt(2)%>" max="100" value="<%=infseg.elementAt(2).toString()%>" required>
                                                                        <%}else{%>
                                                                        <input type="number" name="porcejec" class="form-control" min="0" max="100" value="<%=infseg.elementAt(2).toString()%>" required>
                                                                        <%}%>
								</div>
					</div>
                                        <div class="col-xs-12 col-md-3 col-lg-4">
			                	<div class="form-group espaciado">
									<label for="">Porcentaje de Avance Sistema(Acumulado)</label>
                                                                        <input type="number" class="form-control" value="" readonly>
								</div>
					</div>
                                        <%if(segpryant.size()>0){%>
                                        <div class="col-xs-12 col-md-3 col-lg-4">
			                	<div class="form-group espaciado">	
                                                                    <label for="">Porcentaje de Avance (Seguimiento Anterior)</label> 
                                                                        <input type="number" name="" class="form-control" value="<%=segpryant.elementAt(2)%>" readonly> 
								</div>
					</div>
                                        <%}%>
                                </div>
                            <div class="row">
		                	<div class="col-xs-12 col-md-3 col-lg-12">
			                	<div class="form-group espaciado">
									<label for="">Descripción del Avance</label>
                                                                        <textarea class="form-control" rows="6" name="descavan" required><%=infseg.elementAt(5)%></textarea>
								</div>
					</div>
                                </div>
                            <div class="row">
		                	<div class="col-xs-12 col-md-3 col-lg-12">
			                	<div class="form-group espaciado">
									<label for="">Acciones a tomar</label>
                                                                        <textarea class="form-control" rows="6" name="acciones" required><%=infseg.elementAt(6)%></textarea>
								</div>
					</div>
                                </div>
                            <div class="row">
		                	<div class="col-xs-12 col-md-3 col-lg-12">
			                	<div class="form-group espaciado">
									<label for="">Dificultades en el avance</label>
                                                                        <textarea class="form-control" rows="6" name="dificultades" required><%=infseg.elementAt(9)%></textarea>
								</div>
					</div>
                                </div>
                            <center><input type="submit" value="Guardar Seguimiento de Proyecto" class="btn-lg"></center>
                            <%if(segpryant.size()>0){%>
                            <a align="rigth" target="top" onclick="window.open('/planeacion/seguimientoPR?idp=<%=idp%>&seg=<%=segpryant.elementAt(0)%>#collapseOne','name','resizeable=true,scrollbars,width=800,height=1000')">Ver seguimiento anterior:  <%=segpryant.elementAt(1)%></a>
                            <%}%>
                            </form> 
                        </div>
                            
                            <div class="panel-body">
                        <% archivos = bd.ConsultafilesSeg(idp, "0", idseg);%>
                        <div class="colorFormulario">  
                                      <%if(archivos.size() > 0){%>
                                      <h4>Archivos asociados al seguimiento del proyecto</h4>
                                      <div class="row">
                                          <table class="table">
                                              <tr>
                                                  <th>Número</th>
                                                  <th>Nombre Archivo</th>
                                                  <th>Tipo</th>
                                                  <th>Observación</th>
                                                  <th>Descargar</th>
                                                  <th>Eliminar</th>
                                              </tr>
                                              <% for ( int m = 0 ; m < archivos.size() ; m++ ){
                                                                  aux = (Vector)archivos.elementAt(m);
                                                                  numero_archivo = m+2;
                                              %>
                                              <tr>
                                                  <td><%=(m+1)%></td>
                                                  <td><%=aux.elementAt(2)%></td>
                                                  <td><%=aux.elementAt(4)%></td>
                                                  <td><%=aux.elementAt(5)%></td>
                                                  <td><a href="/planeacion/descarga?idp=<%=idp%>&down=<%=aux.elementAt(1)%>" download><img src="img/descargar.png" width="20" height="22" border="0"></td>
                                                  <td>
                                                      <form action="EliminarInfoTipo" method="POST" onsubmit="return confirm('Esta Seguro de eliminar el Registro?');">
                                                                                <input type="hidden" name="idp" value="<%=idp%>">
                                                                                <input type="hidden" name="idreg" value="<%=aux.elementAt(0)%>">
                                                                                <input type="hidden" name="tipo" value="ARC">
                                                                            <button name="action" value="blue"><img src="img/delete.png" width="20" height="22" border="0"></button>
                                                        </form>
                                                  </td>
                                              </tr>
                                              <%}%>
                                          </table>
                                      </div>
                                      <%}%>
                                      
                                      
                                                     <div id="Archivo_C" style="display:block">
                                                                        <form action="CargaArchivosSeg" enctype="multipart/form-data" method="post"> 
                                                                            <table class="table">
                                                                                <strong>Asociar Archivo(s) al Seguimiento del Proyecto</strong>
                                                                                <input type="hidden" value="a" name="tipo"><input type="hidden" value="CargaAutoresArchivo" name="retorno">
                                                                                    <input type="hidden" value="<%=idp%>" name="idp">
                                                                                    <input type="hidden" value="<%=idseg%>" name="idseg">
                                                                                    <input type="hidden" value="0" name="idact">
                                                                                    <input type="hidden" value="" name="verifica">
                                                                                    <input type="hidden" value="<%=archivsigcarga%>" name="numerosig" >
                                                                                    <input type="hidden" value="s" name="inicial">
                                                                                    <input type="hidden" value="p" name="reto">
                                                                                <tr>
                                                                                    <td><input type="file" name="file" class="" required/></td>
                                                                                    <td><textarea rows="3" type="textarea" maxlength="1999" class="form-control" name="obsar" placeholder="Observación referente al Archivo" required></textarea></td>
                                                                                   <td><input class="btn-lg" type="submit" value="Subir Archivo"/> </td>
                                                                                </tr>
                                                                           </table>
                                                                       </form> 
                                                     </div>
                                  </div>
                                <%if(segpryant.size()>0){%>                                                    
                                    <a align="rigth" target="popup" onclick="window.open('/planeacion/seguimientoPR?idp=<%=idp%>&seg=<%=segpryant.elementAt(0)%>#collapseSeven','name','resizeable=true,scrollbars,width=800,height=1000')">Ver seguimiento anterior:  <%=segpryant.elementAt(1)%></a>                                                     
                               <%}%>
                        </div>
                            
                    </div>
                  </div>

<!--METAS-->
                  <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingThree">
                      <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                          <span class="glyphicon glyphicon-paperclip"></span> SEGUIMIENTO DE METAS E INDICADORES
                        </a>
                      </h4>
                    </div>
                    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                      <div class="panel-body">
                                Describa el cumplimiento de las metas e indicadores establecidos para el proyecto.
                        <br>
                        
                        <%if(metas.size()>0){%>
                        <div class="row">
                                <h4><strong>Meta(s) del Proyecto</strong></h4>
                                <form action="ActualizaSeguimientoMetas" method="POST">
                                <input type="hidden" name="idp" value="<%=idp%>">
                                <input type="hidden" name="idseg" value="<%=idseg%>">     
                                
                                <% for ( int m = 0 ; m < metas.size() ; m++ ){
                                      aux = (Vector)metas.elementAt(m); 
                                      
                                      infsegmet       = bd.ConsultaSeguimientoMetas(idseg, aux.elementAt(0).toString());
                                    %>
                                        <input type="hidden" name="idmeta" value="<%=aux.elementAt(0)%>"> 
                                        <table class="table table-hover">
                                          <tr>
                                              <th>Descripción Meta <%=(m+1)%> (Planeación)</th>
                                              <th>Descripción del Avance de la meta <%=(m+1)%></th>
                                          </tr>
                                          <tr>
                                            <td width="45%"><textarea rows="6" type="textarea" maxlength="4999" class="form-control" name="obj" id="" readonly><%=aux.elementAt(1)%></textarea></td>
                                            <td width="45%"><textarea rows="6" type="textarea" maxlength="4999" class="form-control" name="descavmeta" id="" required><%=infsegmet.elementAt(0)%></textarea></td>
                                          </tr>
                                        </table>
                                        
                                                <center> <input type="submit" class="btn-lg" value="Guardar Avance de Metas"> </center>
                                      <%}%>
                                      
                                      </form>  
                            </div>
                                      <%}%>
                        
                            <div class="row">
                                <%if(indicadores.size()>0){%>
                            <h4><strong>Indicador(es) del Proyecto:</strong></h4>
                            
                                      
                                      <div class="panel-body">
                                              <div class="row">
                                                      <div class="col-xs-12 col-md-3 col-lg-12">    
                                                      </div>
                                                        
                                                        <form action="ActualizarSeguimientoIndicadores" method="POST">
                                                            <input type="hidden" name="tipoalm" value="PR">
                                                            <input type="hidden" name="idp" value="<%=idp%>">
                                                            <input type="hidden" name="idseg" value="<%=idseg%>"> 
                                                              <table class="table table-hover">
                                                                <tr>
                                                                  <th>Nombre</th>
                                                                  <th>Periodicidad de Medición</th>
                                                                  <th>Descripción del Indicador</th>
                                                                  <th>Resultado</th>
                                                                  <th>Descripción del Resultado</th>
                                                                </tr>
                                                                <% for ( int m = 0 ; m < indicadores.size() ; m++ ){
                                                                  aux = (Vector)indicadores.elementAt(m);
                                                                  
                                                                   infsegind       = bd.ConsultaSeguimientoIndicador(idseg, aux.elementAt(0).toString());
                                                                  
                                                                %>
                                                                <input type="hidden" name="idind" value="<%=aux.elementAt(0)%>">
                                                                <input type="hidden" name="tipo" value="act">
                                                                <tr>
                                                                  <td><%=aux.elementAt(1)%></td>
                                                                  <td><%=aux.elementAt(3)%></td>
                                                                  <td><%=aux.elementAt(7)%></td>
                                                                  <td><textarea class="form-control" name="resultado"  required><%=infsegind.elementAt(0)%></textarea></td>
                                                                  <td><textarea class="form-control" name="descresult" required><%=infsegind.elementAt(1)%></textarea></td>
                                                                </tr>
                                                                <%}%>
                                                              </table>
                                                              <center> <input type="submit" class="btn-lg" value="Guardar Avance de Indicadores"> </center>
                                                        </form>
                                                          
                                              </div>
                                      </div>
                                                              <%}%>
                                    </div><br>
                                    <%if(segpryant.size()>0){%>
                                    <a align="rigth" target="popup" onclick="window.open('/planeacion/seguimientoPR?idp=<%=idp%>&seg=<%=segpryant.elementAt(0)%>#collapseThree','name','resizeable=true,scrollbars,width=800,height=1000')">Ver seguimiento anterior:  <%=segpryant.elementAt(1)%></a>
                                    <%}%>
                      </div>
                    </div>
                  </div>

                      
<!--EJECUCION PRESUPUESTAL-->

<%if(datosb.elementAt(21).equals("P")){%>    



    <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingSix">
                      <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseSix" aria-expanded="false" aria-controls="collapseSix">
                          <span class="glyphicon glyphicon-paperclip"></span> EJECUCIÓN PRESUPUESTAL
                        </a>
                      </h4>
                    </div>
                    <div id="collapseSix" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingSix">
                      <div class="panel-body">
                        En esta sección se presenta la información del presupuesto oficial asociado al proyecto y el estado en el que se encontraba para la fecha en que se realizo el presente seguimiento.
                        
                        
                        <br>
                                         
                               
                                <div class="panel-body">
                                    
                                    <h4><strong>Presupuesto de Erogación oficial.</strong></h4><br>
                                    
                                                <table class="table table-hover">
                                                    <tr>
                                                      <th>Centro Operativo</th>
                                                      <th>Rubro</th>
                                                      <th>Año</th>
                                                      <th>Valor Asignado</th>
                                                      <th>Saldo</th>
                                                      <th>Ejecutado</th>
                                                      <th>Adición Cambio Año</th>
                                                      <th>Planeado</th>
                                                    </tr>
                                                    <%for(int iq = 0 ; iq < SegErogacion.size(); iq++){
                                                            Vector auxespec = (Vector)SegErogacion.elementAt(iq);                                    
                                                     %>
                                                    <tr>
                                                      <td><%=auxespec.elementAt(1)%></td>
                                                      <td><%=auxespec.elementAt(2)%></td>
                                                      <td><%=auxespec.elementAt(3)%></td>
                                                      <td><%=formatea.format(new BigInteger(auxespec.elementAt(7).toString()))%></td> <!-- Asi estaba antes: ** <td>%=formatea.format(Integer.parseInt(auxespec.elementAt(7).toString()))%</td> -->
                                                      <td><%=formatea.format(new BigInteger(auxespec.elementAt(4).toString()))%></td> <!-- Asi estaba antes: ** <td>%=formatea.format(  Integer.parseInt(  auxespec.elementAt(4).toString()  )  )%</td> 14 agosto 2019-->
                                                                                                            
                                                      <%                                                            
                                                              BigInteger T_aux1 = new BigInteger(auxespec.elementAt(5).toString());
                                                              BigInteger T_aux2 = new BigInteger(auxespec.elementAt(4).toString());
                                                              BigInteger T_aux3 = new BigInteger(T_aux1.subtract(T_aux2).toString()); //Equivale a T_aux1 - T_aux2
                                                              //Incrementa acumulador TErog en Forma Sencilla
                                                              TErog = new BigInteger(TErog.add(T_aux3).toString()); 
                                                              // Forma Abreviada(Compleja): TErog = new BigInteger(TErog.add(new BigInteger((new BigInteger(auxespec.elementAt(5).toString())).subtract(new BigInteger(auxespec.elementAt(4).toString())).toString())).toString()); 
                                                      %>                                                      
                                                      <!-- Forma Anterior: td>%=formatea.format(Integer.parseInt(auxespec.elementAt(5).toString())-Integer.parseInt(auxespec.elementAt(4).toString()))%</td-->
                                                      <td><%=formatea.format(new BigInteger((new BigInteger(auxespec.elementAt(5).toString())).subtract(new BigInteger(auxespec.elementAt(4).toString())).toString()))%></td> 
                                                      <td><%=formatea.format(Integer.parseInt(auxespec.elementAt(6).toString()))%></td> 
                                                      <td><%=auxespec.elementAt(9)%></td> 
                                                    </tr>
                                                    <%
                                                         TErogStg = String.valueOf(TErog);
                                                    }%>
                                                  </table>                                             
                                           <br>       
                                           <br>       
                                  <h4><strong>Dedicación de Personal Ejecutada.</strong></h4><br>
                                  <center>Dedicación de Personal: $ <%=formatea.format(Integer.parseInt((bd.ConsultaValorDedicacionSeg(idseg)).toString()))%></center>                                  
                                  <br>
                                  <h4><strong>Resumen de Ejecución.</strong></h4><br>
                                    
                                  <table class="table table-hover">
                                    <tr>
                                        <th>Total Personal</th>
                                        <th>Total Erogación</th>
                                        <th>Total Proyecto</th>
                                    </tr>
                                    <tr>
                                        <td>$ <%=formatea.format(Integer.parseInt((bd.ConsultaValorDedicacionSeg(idseg)).toString()))%></td>
                                        <td>$ <%=formatea.format(TErog)%></td>
                                        <!-- forma anterior: td>$ %=formatea.format(Integer.parseInt((bd.ConsultaValorDedicacionSeg(idseg)).toString()) + TErog)%</td-->
                                        <td> $ <%=formatea.format(new BigInteger(TErog.add(new BigInteger(bd.ConsultaValorDedicacionSeg(idseg))).toString()))%> </td> 
                                    </tr>
                                  </table>
                                        <%  
                                        String tmp = bd.ConsultaUltSeg(idp);                                       
                                    
                                        if(tmp.equals(idseg)){
                                        BigInteger TotalTMP;  TotalTMP = BigInteger.valueOf(0);
                                    
                                        TotalTMP = TotalTMP.add(new BigInteger(bd.ConsultaValorDedicacionProy(idseg,idp).toString()));
                                        TotalTMP = TotalTMP.add(new BigInteger(TErogStg));
                                        bd.ActualizarValorEjecutadoEroPer(idp,String.valueOf(TErog),(bd.ConsultaValorDedicacionProy(idseg,idp).toString()));
                                        bd.ActualizarValorEjecutado(idp, TotalTMP.toString());}                                        
                                        %> 
                                </div>                        
                      </div>
                    </div>
                  </div>
                                      

                                                  
<%}else if(datosb.elementAt(21).equals("M")){

      SegErogacion = bd.ConsultaSegErogacionMegaPro(idseg);
    
%>

<div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingSix">
                      <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseSix" aria-expanded="false" aria-controls="collapseSix">
                          <span class="glyphicon glyphicon-paperclip"></span> EJECUCIÓN PRESUPUESTAL
                        </a>
                      </h4>
                    </div>
                    <div id="collapseSix" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingSix">
                      <div class="panel-body">
                        En esta sección se presenta la información del presupuesto oficial asociado al proyecto y el estado en el que se encontraba para la fecha en que se realizo el presente seguimiento.
                                                
                        <br>                                         
                               
                                <div class="panel-body">
                                    
                                    <h4><strong>Presupuesto de Erogación oficial.</strong></h4><br>
                                    
                                                <table class="table table-hover">
                                                    <tr>
                                                      <th>Centro Operativo</th>
                                                      <th>Rubro</th>
                                                      <th>Año</th>
                                                      <th>Valor Asignado</th>
                                                      <th>Saldo</th>
                                                      <th>Ejecutado</th>
                                                      <th>Adición Cambio Año</th>
                                                      <th>Planeado</th>
                                                    </tr>
                                                    <%for(int iq = 0 ; iq < SegErogacion.size(); iq++){
                                                            Vector auxespec = (Vector)SegErogacion.elementAt(iq);                                    
                                                     %>
                                                    <tr>
                                                      <td><%=auxespec.elementAt(1)%></td>
                                                      <td><%=auxespec.elementAt(2)%></td>
                                                      <td><%=auxespec.elementAt(3)%></td>
                                                      <td><%=formatea.format(new BigInteger(auxespec.elementAt(7).toString()))%></td>
                                                      <td><%=formatea.format(new BigInteger(auxespec.elementAt(4).toString()))%></td> <!-- Asi estaba antes: ** <td>%=formatea.format(Integer.parseInt(auxespec.elementAt(4).toString()))%</td> 14 agosto 2019-->
                                                      <%
                                                         //TErog = TErog + Integer.parseInt(auxespec.elementAt(5).toString())-Integer.parseInt(auxespec.elementAt(4).toString()); ** forma anterior hasta 14 agosto 2019
                                                         TErog = new BigInteger(TErog.add(new BigInteger((new BigInteger(auxespec.elementAt(5).toString())).subtract(new BigInteger(auxespec.elementAt(4).toString())).toString())).toString());
                                                      %>
                                                      <td><%=formatea.format(new BigInteger((new BigInteger(auxespec.elementAt(5).toString())).subtract(new BigInteger(auxespec.elementAt(4).toString())).toString()))%></td> <!-- Forma Anterior: td>%=formatea.format(Integer.parseInt(auxespec.elementAt(5).toString())-Integer.parseInt(auxespec.elementAt(4).toString()))%</td-->
                                                      <td><%=formatea.format(Integer.parseInt(auxespec.elementAt(6).toString()))%></td>
                                                      <td><%=auxespec.elementAt(9)%></td>
                                                    </tr>
                                                    <%
                                                         TErogStg = String.valueOf(TErog);
                                                    }%>
                                                 </table>
                                                 
                                            
                                           <br>       
                                           <br>       
                                  <h4><strong>Dedicación de Personal Ejecutada.</strong></h4><br>
                                  <center>Dedicación de Personal: $ <%=formatea.format(Integer.parseInt((bd.ConsultaValorDedicacionSegMegaPro(idseg)).toString()))%></center>                             
                                  <br>
                                  <h4><strong>Resumen de Ejecución.</strong></h4><br>
                                    
                                  <table class="table table-hover">
                                    <tr>
                                        <th>Total Personal</th>
                                        <th>Total Erogación</th>
                                        <th>Total Proyecto</th>
                                    </tr>
                                    <tr>
                                        <td>$ <%=formatea.format(Integer.parseInt((bd.ConsultaValorDedicacionSegMegaPro(idseg)).toString()))%></td>
                                        <td>$ <%=formatea.format(TErog)%></td>
                                        <td>$ <%=formatea.format(new BigInteger(TErog.add(new BigInteger(bd.ConsultaValorDedicacionSegMegaPro(idseg))).toString()))%> </td> <!-- forma anterior: td>$ %=formatea.format(Integer.parseInt((bd.ConsultaValorDedicacionSegMegaPro(idseg)).toString()) + TErog)%</td--> 
                                    </tr> 
                                   </table>
                                        <%  
                                        String tmp = bd.ConsultaUltSeg(idp);
                                        
                                    
                                        if(tmp.equals(idseg)){
                                        BigInteger TotalTMP;  TotalTMP = BigInteger.valueOf(0);
                                    
                                        TotalTMP = TotalTMP.add(new BigInteger(bd.ConsultaValorDedicacionProy(idseg,idp).toString()));
                                        TotalTMP = TotalTMP.add(new BigInteger(TErogStg));
                                        bd.ActualizarValorEjecutadoEroPer(idp,String.valueOf(TErog),(bd.ConsultaValorDedicacionProy(idseg,idp).toString()));
                                        bd.ActualizarValorEjecutado(idp, TotalTMP.toString());}
                                        
                                        %> 
                                      </div>
                        
                      </div>
                    </div>
                  </div>


<%}%>
                                                  
                                                  
                                                  
                        
                  <br>
                  <div class="row" align="center">
                            <div class="col-xs-12 col-md-4"></div>
                            <div class="col-xs-12 col-md-4">
                                <div class="submit">
                                    <form action="EnviarSeguimiento" method="POST" onsubmit="return confirm('Confirma la finalización del seguimiento?');">
                                        <input type="hidden" name="idp" value="<%=idp%>">
                                        <input type="hidden" name="idseg" value="<%=idseg%>">
                                        <input type="hidden" name="cc" value="<%=ccemp%>">
                                        <input class="btn btn-primary btn-lg" type="submit" value="Enviar Seguimiento"/>
                                    </form>
                                </div>
                            </div>
                            <div class="col-xs-12 col-md-4"></div>                              
                        </div>

            </div>  
            </form> 
        </div>
<%}else{%>


<div class="colorFormulario">
                <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                  <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingOne">
                      <h4 class="panel-title">
                        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                          <span class="glyphicon glyphicon-paperclip"></span> <%if(datosb.elementAt(21).equals("P")){%>SEGUIMIENTO GENERAL DEL PROYECTO <%}else if(datosb.elementAt(21).equals("M")){%>SEGUIMIENTO GENERAL DEL MEGAPROYECTO <%}%>
                        </a>
                      </h4>
                    </div>
                    <div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                        
                        
                      <div class="panel-body">
                        A continuación se presenta la información recolectada del seguimiento general del proyecto diligenciada en su momento por el director y/o responsable del Proyecto.
                      </div>
                        <div class="colorFormulario">
                            
                                <input type="hidden" name="idp" value="<%=idp%>">
                                <input type="hidden" name="idseg" value="<%=idseg%>">                                
                            <div class="row">
		                	<div class="col-xs-12 col-md-3 col-lg-6">
			                	<div class="form-group espaciado">
									<label for="">Estado Ejecución</label>
                                                                        <select name="estadoejec" class="form-control" id="estejec" readonly>
                                                                            <%if (estadoejec.size() > 0){ 
                                                                                    for (int ii = 0; ii < estadoejec.size(); ii++) {
                                                                                            Vector infusu = (Vector)estadoejec.elementAt(ii) ;
                                                                                            if(infusu.elementAt(0).toString().equals(infseg.elementAt(3).toString()))
                                                                                            {Valor = infusu.elementAt(0).toString(); Cadena = infusu.elementAt(1).toString();}
                                                                            %>
                                                                            <option value="<%=infusu.elementAt(0)%>"><%=infusu.elementAt(1)%></option>
                                                                                    <%} if(Valor.equals("")){Cadena="Seleccione un elemento de la lista";}
                                                                                    %>
                                                                                    <option value="<%=Valor%>" selected='selected'><%=Cadena%></option><%Valor="";Cadena="";%>
                                                                                    <%
                                                                            }%>
                                                                        </select>
								</div>
					</div>
                                        <div class="col-xs-12 col-md-3 col-lg-6">
			                	<div class="form-group espaciado">
									<label for="">Estado Ejecución (Seguimiento Anterior)</label>
                                                                        <select name="" class="form-control" readonly>
                                                                            <%if (estadoejec.size() > 0){ 
                                                                                    for (int ii = 0; ii < estadoejec.size(); ii++) {
                                                                                            Vector infusu = (Vector)estadoejec.elementAt(ii) ;
                                                                                            String tmp = "";
                                                                                                    if(segpryant.size()>0){tmp = segpryant.elementAt(3).toString();}
                                                                                            if(infusu.elementAt(0).toString().equals(tmp)){Valor = infusu.elementAt(0).toString(); Cadena = infusu.elementAt(1).toString();} //infseg.elementAt(3).toString()
                                                                            %>
                                                                            <option value="<%=infusu.elementAt(0)%>"><%=infusu.elementAt(1)%></option>
                                                                                    <%} if(Valor.equals("")){Cadena="Sin Información";}
                                                                                    %>
                                                                                    <option value="<%=Valor%>" selected='selected'><%=Cadena%></option><%Valor="";Cadena="";%>
                                                                                    <%
                                                                            }%>
                                                                        </select>
								</div>
					</div>
                                </div>
                            <div class="row">
		                	<div class="col-xs-12 col-md-3 col-lg-4">
			                	<div class="form-group espaciado">
                                                    <label for="">Porcentaje de Avance</label>
                                                    <input type="number" name="porcejec" class="form-control" value="<%=infseg.elementAt(2).toString()%>" readonly>
						</div>
					</div>
                                        <div class="col-xs-12 col-md-3 col-lg-4">
			                	<div class="form-group espaciado">
                                                    <label for="">Porcentaje de Avance Sistema(Acumulado)</label>
                                                    <input type="number" class="form-control" value="" readonly>
						</div>
					</div>
                                        <%if(segpryant.size()>0){%>
                                        <div class="col-xs-12 col-md-3 col-lg-4">
			                	<div class="form-group espaciado">	
                                                    <label for="">Porcentaje de Avance (Seguimiento Anterior)</label> 
                                                    <input type="number" name="" class="form-control" value="<%=segpryant.elementAt(2)%>" readonly> 
						</div>
					</div>
                                        <%}%>
                                </div>
                            <div class="row">
		                	<div class="col-xs-12 col-md-3 col-lg-12">
			                	<div class="form-group espaciado">
									<label for="">Descripción del Avance</label>
                                                                        <textarea class="form-control" rows="6" name="descavan" readonly><%=infseg.elementAt(5)%></textarea>
								</div>
					</div>
                                </div>
                            <div class="row">
		                	<div class="col-xs-12 col-md-3 col-lg-12">
			                	<div class="form-group espaciado">
									<label for="">Acciones a tomar</label>
                                                                        <textarea class="form-control" rows="6" name="acciones" readonly><%=infseg.elementAt(6)%></textarea>
								</div>
					</div>
                                </div>
                           <div class="row">
		                	<div class="col-xs-12 col-md-3 col-lg-12">
			                	<div class="form-group espaciado">
									<label for="">Dificultades en el avance</label>
                                                                        <textarea class="form-control" rows="6" name="dificultades" readonly><%=infseg.elementAt(9)%></textarea>
								</div>
					</div>
                                </div>
                        </div>
                                                                
                              <div class="panel-body">
                        <% archivos = bd.ConsultafilesSeg(idp, "0", idseg);%>
                        <div class="colorFormulario">  
                                      <%if(archivos.size() > 0){%>
                                      <h4>Archivos asociados al seguimiento del Proyecto</h4>
                                      <div class="row">
                                          <table class="table">
                                              <tr>
                                                  <th>Número</th>
                                                  <th>Nombre Archivo</th>
                                                  <th>Tipo</th>
                                                  <th>Observación</th>
                                                  <th>Descargar</th>
                                                 
                                              </tr>
                                              <% for ( int m = 0 ; m < archivos.size() ; m++ ){
                                                                  aux = (Vector)archivos.elementAt(m);
                                                                  numero_archivo = m+2;
                                              %>
                                              <tr>
                                                  <td><%=(m+1)%></td>
                                                  <td><%=aux.elementAt(2)%></td>
                                                  <td><%=aux.elementAt(4)%></td>
                                                  <td><%=aux.elementAt(5)%></td>
                                                  <td><a href="/planeacion/descarga?idp=<%=idp%>&down=<%=aux.elementAt(1)%>" download><img src="img/descargar.png" width="20" height="22" border="0"></td>
                                                  
                                              </tr>
                                              <%}%>
                                          </table>
                                      </div>
                                      <%}%>
                      
                                  </div>
                        </div>
                                                                
                    </div>
                  </div>

<!--METAS E INDICADORES-->


                  <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingThree">
                      <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                          <span class="glyphicon glyphicon-paperclip"></span> SEGUIMIENTO DE METAS E INDICADORES
                        </a>
                      </h4>
                    </div>
                    <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                      <div class="panel-body">
                        En esta sección se presenta la información diligenciada en seguimiento de las meta y/o indicadores asociados al proyecto, ingresadas en la fecha del presente seguimiento.
                        <br>
                        <div class="row">
                                <h4><strong>Meta(s) del Proyecto</strong></h4>
                                
                                <input type="hidden" name="idp" value="<%=idp%>">
                                <input type="hidden" name="idseg" value="<%=idseg%>">                              
                                
                                <% for ( int m = 0 ; m < metas.size() ; m++ ){
                                      aux = (Vector)metas.elementAt(m);                                       
                                      infsegmet = bd.ConsultaSeguimientoMetas(idseg, aux.elementAt(0).toString());
                                %>
                                        <input type="hidden" name="idmeta" value="<%=aux.elementAt(0)%>"> 
                                        <table class="table table-hover">
                                          <tr>
                                              <th>Descripción Meta <%=(m+1)%> (Planeación)</th>
                                              <th>Descripción del Avance de la meta <%=(m+1)%></th>
                                          </tr>
                                          <tr>
                                            <td width="45%"><textarea rows="6" type="textarea" maxlength="4999" class="form-control" name="obj" id="" readonly><%=aux.elementAt(1)%></textarea></td>
                                            <td width="45%"><textarea rows="6" type="textarea" maxlength="4999" class="form-control" name="descavmeta" id="" readonly><%=infsegmet.elementAt(0)%></textarea></td>
                                          </tr>
                                        </table>
    
                                 <%}%>
                            </div>
                        
                            <div class="row">
                            <%if(indicadores.size()>0){%>
                            <h4><strong>Indicador(es) del Proyecto:</strong></h4>

                                      <div class="panel-body">
                                              <div class="row">
                                                      <div class="col-xs-12 col-md-3 col-lg-12">    
                                                      </div>
                                                        
                                                        
                                                            <input type="hidden" name="idp" value="<%=idp%>">
                                                            <input type="hidden" name="idseg" value="<%=idseg%>"> 
                                                              <table class="table table-hover">
                                                                <tr>
                                                                  <th>Nombre</th>
                                                                  <th>Periodicidad de Medición</th>
                                                                  <th>Descripción del Indicador</th>
                                                                  <th>Resultado</th>
                                                                  <th>Descripción del Resultado</th>
                                                                </tr>
                                                                <% for ( int m = 0 ; m < indicadores.size() ; m++ ){
                                                                  aux = (Vector)indicadores.elementAt(m);
                                                                  
                                                                   infsegind       = bd.ConsultaSeguimientoIndicador(idseg, aux.elementAt(0).toString());
                                                                  
                                                                %>
                                                                <input type="hidden" name="idind" value="<%=aux.elementAt(0)%>">
                                                                <input type="hidden" name="tipo" value="act">
                                                                <tr>
                                                                  <td><%=aux.elementAt(1)%></td>
                                                                  <td><%=aux.elementAt(3)%></td>
                                                                  <td><%=aux.elementAt(7)%></td>
                                                                  <td><textarea class="form-control" name="resultado"  readonly><%=infsegind.elementAt(0)%></textarea></td>
                                                                  <td><textarea class="form-control" name="descresult" readonly><%=infsegind.elementAt(1)%></textarea></td>
                                                                </tr>
                                                                <%}%>
                                                              </table>
                                                              
                                 
                                                          
                                              </div>
                                      </div>
                                                              <%}%>
                                    </div>
                            
                      </div>
                    </div>
                  </div>

                       
<!--ACTIVIDADES-->
                
<%if(datosb.elementAt(21).equals("P")){%>           
<div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingFour">
                      <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                          <span class="glyphicon glyphicon-paperclip"></span> ACTIVIDADES
                        </a>
                      </h4>
                    </div>
                    <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
                      <div class="panel-body">
                        A continuación puede consultar el avance de cada uno de los proyectos y su estado para la fecha de seguimiento.
                        <br>
                       
                        <%if(activseg.size()>0){%>
                        
                        
                        <% for ( int ml = 0 ; ml < activseg.size() ; ml++ ){
                            
                                      aux2 = (Vector)activseg.elementAt(ml);
                                       
                                       String Actividad = aux2.elementAt(0).toString();
                                       
                                       segactividad = bd.ConsultaSeguimientoActividad(idseg, Actividad);
                                       
                                       if(segactividad.size()>0){
                                       
                                       Vector segactant = new Vector();
                                       
                                       segactant = bd.ConsultaSegAnteriorAct(Actividad); //segactant = bd.ConsultaSegAnteriorAct(Actividad, idseg);
                                       
                                       String ActSeg = "0";
                                       
                                       if(segactividad.size() <= 0){
                                           ActSeg = "0";
                                       }else{
                                          ActSeg = segactividad.elementAt(0).toString();
                                       }
                                       personal    = bd.ConsultaPersonal(aux2.elementAt(0).toString(), ActSeg);
                                       
                                       
                                       %>
                                
                                
                                 <div class="panel panel-default">
                                    <div class="panel-heading" role="tab" id="heading<%=(ml+1)%>">
                                      <h4 class="panel-title">
                                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion2" href="#colsend<%=Actividad%>" aria-expanded="false" aria-controls="collapse<%=(ml+1)%>">
                                            <span class="glyphicon glyphicon-adjust"></span> <%=(ml+1)%>. <%=aux2.elementAt(1)%> 
                                            
                                            <%if(aux2.elementAt(10).toString().equals("1")){%>
                                            <font color="red">(Actualmente en Ejecución)</font><br> <br>Vigencia:  (<%=aux2.elementAt(3).toString()%> - <%=aux2.elementAt(4).toString()%>)
                                            <%}else{%>
                                            <font color="green">(Vigencia Anterior / Posterior)</font><br>  <br>Vigencia:  (<%=aux2.elementAt(3).toString()%> - <%=aux2.elementAt(4).toString()%>)
                                            <%}%>
                                        </a>
                                      </h4>
                                    </div>
                                    <div id="colsend<%=Actividad%>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading<%=(ml+1)%>">
                                      <div class="panel-body">
                               
                                <div class="panel-body"> 
                                    
                                    
                                        <input type="hidden" name="idp" value="<%=idp%>"> 
                                        <input type="hidden" name="idseg" value="<%=idseg%>"> 
                                        <input type="hidden" name="idact" value="<%=Actividad%>"> 
                                                <div class="row">
                                                    <div class="col-xs-12 col-md-3 col-lg-4">
                                                        <div class="form-group espaciado">
                                                                                <label for="">Estado Ejecución Actividad</label>
                                                                                <select name="estejecact" class="form-control" id="estejec" readonly>
                                                                                    <%if (estadoejec.size() > 0){ 
                                                                                            for (int ii = 0; ii < estadoejec.size(); ii++) {
                                                                                                    Vector infusu = (Vector)estadoejec.elementAt(ii) ;
                                                                                                    if(infusu.elementAt(0).toString().equals(segactividad.elementAt(3).toString())){Valor = infusu.elementAt(0).toString(); Cadena = infusu.elementAt(1).toString();}
                                                                                    %>
                                                                                    <option value="<%=infusu.elementAt(0)%>"><%=infusu.elementAt(1)%></option>
                                                                                            <%} if(Valor.equals("")){Cadena="Seleccione un elemento de la lista";}
                                                                                            %>
                                                                                            <option value="<%=Valor%>" selected='selected'><%=Cadena%></option><%Valor="";Cadena="";%>
                                                                                            <%
                                                                                    }%>
                                                                                </select>
                                                                        </div>
                                                            </div>
                                                    <div class="col-xs-12 col-md-3 col-lg-4">
                                                        <div class="form-group espaciado">
                                                                                <label for="">Porcentaje de Avance Actividad</label>
                                                                                <%if(segpryant.size()>0 && segactant.size()>0){%>
                                                                                <input type="number" value="<%=segactividad.elementAt(6)%>" name="porcavact" min="<%=segactant.elementAt(6)%>" max="100" class="form-control" required>
                                                                                <%}else if(segactant.size()>0){%>
                                                                                <input type="number" value="<%=segactividad.elementAt(6)%>" name="porcavact" min="0" max="100" class="form-control" required>
                                                                                <%}else{%>
                                                                                <input type="number" value="<%=segactividad.elementAt(6)%>" name="porcavact" min="0" max="100" class="form-control" required>                                                                                
                                                                                <%}%>
                                                                        </div>
                                                    </div>
                                                    <%if(segactant.size()>0){%>
                                                    <div class="col-xs-12 col-md-3 col-lg-4">
                                                        <div class="form-group espaciado">
                                                                                <label for="">Porcentaje de Avance Anterior Seguimiento</label>
                                                                                <input type="number" value="<%=segactant.elementAt(6)%>" class="form-control" readonly>
                                                                        </div>
                                                    </div>
                                                    <%}%>
                                                
                                           
                                                  <div class="row">
                                                        <div class="col-xs-12 col-md-3 col-lg-12">
                                                                <div class="form-group espaciado">
                                                                                        <label for="">Descripción del Avance de la Actividad</label>
                                                                                        <textarea class="form-control" rows="6" name="descavact" readonly><%=segactividad.elementAt(4)%></textarea>
                                                                                </div>
                                                        </div>
                                                </div>
                                                  <div class="row">
                                                        <div class="col-xs-12 col-md-3 col-lg-12">
                                                                <div class="form-group espaciado">
                                                                                        <label for="">Acciones a Tomar</label>
                                                                                        <textarea class="form-control" rows="6" name="accionavact" readonly><%=segactividad.elementAt(5)%></textarea>
                                                                                </div>
                                                        </div>
                                                </div>
                                                  
                                                                                           
                                             </div>  
                                    
                                                  
                                                        <%if(personal.size()>0){%> 
                                                        
                                                        <h4><strong>Dedicación de Personal</strong></h4>
                                                        
                                                       
                                                                    <input type="hidden" name="idp" value="<%=idp%>">
                                                                    <input type="hidden" name="idseg" value="<%=idseg%>">
                                                                    
                                                              <table class="table table-hover">
                                                                <tr>
                                                                  <th>Nombre</th>
                                                                  <th>Cargo</th>
                                                                  <th>Horas en Planeación</th>
                                                                  <th>Total Horas acumuladas</th>
                                                                  <th>Horas Seguimiento Actual</th>
                                                                </tr>
                                                                <% for ( int qwq = 0 ; qwq < personal.size() ; qwq++ ){
                                                                  
                                                                    aux         = (Vector)personal.elementAt(qwq);
                                                                    segpersonal = bd.ConsultaSeguimientoPersonal(idseg, aux.elementAt(0).toString());
                                                                    
                                                                  // if(segpersonal.size()==0){break;}
                                                                %>
                                                                <input type="hidden" name="idact" value="<%=Actividad%>">
                                                                <input type="hidden" name="idpers" value="<%=aux.elementAt(0).toString()%>">
                                                                
                                                                <tr>
                                                                    <%if(aux.elementAt(1).toString().equals("Sin Definir")){%>
                                                                        <td><%=aux.elementAt(1).toString()%></td>
                                                                    <%}else{%>
                                                                        <td><%=bd.usuarioconscc2(aux.elementAt(1).toString())%></td>
                                                                    <%}%>
                                                                  
                                                                  <td><%=aux.elementAt(2).toString()%></td>
                                                                  <td>
                                                                      <%    
                                                                         
                                                                            horas      = bd.ConsultarHorasSeg(aux.elementAt(0).toString());
                                                                           agactual = infseg.elementAt(11).toString();
                                                                            horasejec   = bd.ConsultaTotalHorasSeg(Actividad, aux.elementAt(0).toString(),idseg);
                                                                           // if(horas.size() < 1){
                                                                               //horas.add( new String[] { agactual , "0" } );
                                                                          // }
                                                                         for ( int s = 0 ; s < 1 ; s++ ){
                                                                              if(horas.size()<1) {
                                                                                 auxh.addElement(agactual);
                                                                                 auxh.addElement("0");
                                                                             }else{    
                                                                             auxh = (Vector)horas.elementAt(s); //este es el q est mal
                                                                             }
                                                                         
                                                                             
                                                                         /*if (horas.size()>0) {
                                                                                    auxh = (Vector)horas.elementAt(s); 
                                                                                 }*/
                                                                      %>
                                                                      
                                                                      <table>
                                                                          <td><input type="number" class="form-control" value="<%=agactual%>" name="agno" readonly></td>
                                                                          <td><input type="number" class="form-control" value="<%=auxh.elementAt(1)%>" name="" min="0" max="2920" readonly></td>
                                                                         
                                                                      </table>
                                                                      
                                                                      <%}%>

                                                                  </td>
                                                                  <td>
                                                                      <% horas = bd.ConsultarHorasSeg(aux.elementAt(0).toString());
                                                                       /* if(horas.size()<1){
                                                                                horas.add( new String[] { agactual , "0" } );
                                                                            }*/
                                                                         for ( int s = 0 ; s < 1 ; s++ ){
                                                                        /* if (horas.size()>0) {
                                                                                    auxh = (Vector)horas.elementAt(s); 
                                                                                 }*/
                                                                         if(horas.size()<1) {
                                                                                 auxh.addElement(agactual);
                                                                                 auxh.addElement("0");
                                                                             }else{    
                                                                             auxh = (Vector)horas.elementAt(s); //este es el q est mal
                                                                             }
                                                                        
                                                                      %>
                                                                      
                                                                      <table>
                                                                          <td><input type="number" class="form-control" name="" value="<%=horasejec.elementAt(0)%>" min="0" max="2920" readonly></td>
                                                                         
                                                                      </table>
                                                                      
                                                                      <%}%>
                                                                  </td>
                                                                  <td>
                                                                      <% horas = bd.ConsultarHorasSeg(aux.elementAt(0).toString());
                                                                     /* if(horas.size()<1){
                                                                                horas.add( new String[] { agactual , "0" } );
                                                                            }*/
                                                                         for ( int s = 0 ; s < 1 ; s++ ){
                                                                         /*if (horas.size()>0) {
                                                                                    auxh = (Vector)horas.elementAt(s); 
                                                                                 }*/
                                                                         if(horas.size()<1) {
                                                                                 auxh.addElement(agactual);
                                                                                 auxh.addElement("0");
                                                                             }else{    
                                                                             auxh = (Vector)horas.elementAt(s); //este es el q est mal
                                                                             }
                                                                          horasejec   = bd.ConsultaTotalHorasSegAct(Actividad, aux.elementAt(0).toString(),idseg);
                                                                      %>
                                                                      
                                                                      <table>
                                                                          <td><input type="number" class="form-control" name="" value="<%=horasejec.elementAt(0)%>" min="0" max="2920" readonly></td>
                                                                        
                                                                      </table>                                                                      
                                                                      <%}%>
                                                                  </td>
                                                                </tr>
                                                                <%}%>
                                                              </table>
                                                            
                                                                                                                          
                                                              
                                                              <%}else{%>
                                                                <center><label>Su actividad no registra dedicación de personal en la plataforma.</label></center><br>
                                                                <%}%>
                                              <br>
                                              <br>
                                    
                                              
                            <div class="row">
                            
                            <%indicadoract = bd.ConsultaIndActividad(Actividad);%>
                                     
                                      <div class="panel-body">
                                              <div class="row">
                                                      <div class="col-xs-12 col-md-3 col-lg-12">    
                                                      </div>
                                                        <%if(indicadoract.size()>0){%>
                                                        <h4><strong>Indicador(es) de la Actividad</strong></h4>
                                                        
                                                              <input type="hidden" name="idp" value="<%=idp%>">
                                                                <input type="hidden" name="idseg" value="<%=idseg%>">
                                                              <table class="table table-hover">
                                                                <tr>
                                                                  <th>Nombre</th>
                                                                  <th>Periodicidad de Medición</th>
                                                                  <th>Descripción</th>
                                                                  <th>Resultado</th>
                                                                  <th>Descripción</th>
                                                                </tr> 
                                                                <% for ( int m = 0 ; m < indicadoract.size() ; m++ ){
                                                                  aux = (Vector)indicadoract.elementAt(m);
                                                                  
                                                                  infsegind = bd.ConsultaSeguimientoIndicador(idseg, aux.elementAt(0).toString());
                                                                %>
                                                                <input type="hidden" name="idind" value="<%=aux.elementAt(0)%>">
                                                                <input type="hidden" name="tipo" value="idp"><input type="hidden" name="idact" value="<%=Actividad%>">
                                                                <tr>
                                                                  <td><%=aux.elementAt(1)%></td>
                                                                  <td><%=aux.elementAt(3)%></td>
                                                                  <td><%=aux.elementAt(7)%></td>
                                                                  <td><textarea class="form-control" name="resultado"  readonly><%=infsegind.elementAt(0)%></textarea></td>
                                                                  <td><textarea class="form-control" name="descresult" readonly><%=infsegind.elementAt(1)%></textarea></td>
                                                                </tr>
                                                                <%}%>
                                                              </table>
                                                         
                                                          <%}%>
                                              </div>
                                      </div>
                       </div>
                                              
                                              <div class="panel-body">
                        

                       <% archivos = bd.ConsultafilesSeg(idp, Actividad, idseg);%>
                                                  
                        <div class="colorFormulario">  
                                      <%if(archivos.size() > 0){%>
                                      <label>Archivos</label>
                                      <div class="row">
                                          <table class="table">
                                              <tr>
                                                  <th>Número</th>
                                                  <th>Nombre Archivo</th>
                                                  <th>Tipo</th>
                                                  <th>Observación</th>
                                                  <th>Descargar</th>
                                                  
                                              </tr>
                                              <% for ( int m = 0 ; m < archivos.size() ; m++ ){
                                                                  aux = (Vector)archivos.elementAt(m);
                                                                  numero_archivo = m+2;
                                              %>
                                              <tr>
                                                  <td><%=(m+1)%></td>
                                                  <td><%=aux.elementAt(2)%></td>
                                                  <td><%=aux.elementAt(4)%></td>
                                                  <td><%=aux.elementAt(5)%></td>
                                                  <td><a href="/planeacion/descarga?down=<%=aux.elementAt(1)%>" download><img src="img/descargar.png" width="20" height="22" border="0"></td>
                                                  
                                              </tr>
                                              <%}%>
                                          </table>
                                      </div>
                                      <%}%>        
                                  </div>
                          </div>
                        </div>
                      </div>
                    </div> 
                  </div> 
                        <%}%>
                        
                        <%}}%>
                        <br>
                        <%if(segpryant.size()>0){%>
                        <a align="rigth" target="popup" onclick="window.open('/planeacion/seguimientoPR?idp=<%=idp%>&seg=<%=segpryant.elementAt(0)%>#collapseFour','name','resizeable=true,scrollbars,width=800,height=1000')">Ver seguimiento anterior:  <%=segpryant.elementAt(1)%></a>
                        <%}%>
                      </div>
                    </div>
                  </div>

<%}else if(datosb.elementAt(21).equals("M")){
    
    Vector infosubproyect = new Vector();
                infosubproyect = bd.ConsultaSegMegaPro(idseg);
    
%>     
            
            
            
            <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingFour">
                      <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                          <span class="glyphicon glyphicon-paperclip"></span> SEGUIMIENTO PROYECTOS
                        </a>
                      </h4>
                    </div>
                    <div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
                      <div class="panel-body">
                        A continuación se pueden consultar el seguimiento de los proyectos asociados al megaproyecto.
                        <br>
                        <br>
                       
                                 <table class="table table-hover" id="regTable">
                                  <thead>
                                  <tr>
                                    <th>Id. Proyecto</th>
                                    <th>Nombre</th> 
                                    <th>Fecha inicio</th>
                                    <th>Fecha fin</th>
                                    <th>Fecha Seguimiento</th>
                                    <th>Estado Seguimiento</th>
                                    <th>Estado Ejecución</th>
                                    <th>Avance</th>
                                    <th>Detalle</th>
                                  </tr>
                                  </thead>

                                  <%for(int spr = 0 ; spr < infosubproyect.size() ; spr ++ ){

                                      Vector auxmpro = (Vector)infosubproyect.elementAt(spr);

                                  %>

                                  <tbody>
                                  <tr>
                                    <td><%=auxmpro.elementAt(0)%></td>
                                    <td><%=auxmpro.elementAt(1)%></td>
                                    <td><%=auxmpro.elementAt(2)%></td>
                                    <td><%=auxmpro.elementAt(3)%></td>
                                    <td><%=auxmpro.elementAt(4)%></td>
                                    <td><%=auxmpro.elementAt(5)%></td>
                                    <td><%=auxmpro.elementAt(8)%></td>
                                    <td><%=auxmpro.elementAt(6)%>%</td>
                                    <td><a target="_blank" href="/planeacion/seguimientoPR?idp=<%=auxmpro.elementAt(0)%>&seg=<%=auxmpro.elementAt(7)%>">Ver Detalle</a></td>
                                  </tr>
                                  </tbody>
                                  <%}%>
                                </table>
                      </div>
                    </div>
                  </div>
                      
            <%}%>
                      
<!-- PRESUPUESTO-->
                        
<%if(datosb.elementAt(21).equals("P")){%>    


    <div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingSix">
                      <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseSix" aria-expanded="false" aria-controls="collapseSix">
                          <span class="glyphicon glyphicon-paperclip"></span> EJECUCIÓN PRESUPUESTAL
                        </a>
                      </h4>
                    </div>
                    <div id="collapseSix" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingSix">
                      <div class="panel-body">
                        En esta sección se presenta la información del presupuesto oficial asociado al proyecto y el estado en el que se encontraba para la fecha en que se realizo el presente seguimiento.
                        
                        
                        <br>                                        
                               
                                <div class="panel-body">
                                    
                                    <h4><strong>Presupuesto de Erogación oficial.</strong></h4><br>
                                    
                                                <table class="table table-hover">
                                                    <tr>
                                                      <th>Centro Operativo</th>
                                                      <th>Rubro</th>
                                                      <th>Año</th>
                                                      <th>Valor Asignado</th>
                                                      <th>Saldo</th>
                                                      <th>Ejecutado</th>
                                                      <th>Adición Cambio Año</th>
                                                      <th>Planeado</th>
                                                    </tr>
                                                    <%for(int iq = 0 ; iq < SegErogacion.size(); iq++){
                                                            Vector auxespec = (Vector)SegErogacion.elementAt(iq);                                    
                                                    %>
                                                    <tr>
                                                      <td><%=auxespec.elementAt(1)%></td>
                                                      <td><%=auxespec.elementAt(2)%></td>
                                                      <td><%=auxespec.elementAt(3)%></td>
                                                      <td><%=formatea.format(new BigInteger(auxespec.elementAt(7).toString()))%></td>
                                                      <td><%=formatea.format(new BigInteger(auxespec.elementAt(4).toString()))%></td> <!-- Asi estaba antes: ** <td>%=formatea.format(Integer.parseInt(auxespec.elementAt(4).toString()))%</td> 14 agosto 2019-->                                                       
                                                      <%                                                            
                                                         TErog = new BigInteger(TErog.add(new BigInteger((new BigInteger(auxespec.elementAt(5).toString())).subtract(new BigInteger(auxespec.elementAt(4).toString())).toString())).toString());  /* forma anterior 14 agosto 2019 : TErog = TErog + Integer.parseInt(auxespec.elementAt(5).toString())-Integer.parseInt(auxespec.elementAt(4).toString()); */
                                                      %>
                                                      <td><%=formatea.format(new BigInteger((new BigInteger(auxespec.elementAt(5).toString())).subtract(new BigInteger(auxespec.elementAt(4).toString())).toString()))%></td> <!-- Forma Anterior: td>%=formatea.format(Integer.parseInt(auxespec.elementAt(5).toString())-Integer.parseInt(auxespec.elementAt(4).toString()))%</td-->                                                      
                                                      <td><%=formatea.format(Integer.parseInt(auxespec.elementAt(6).toString()))%></td>
                                                      <td><%=auxespec.elementAt(9)%></td>
                                                    </tr>
                                                    <%
                                                         TErogStg = String.valueOf(TErog);
                                                    }%>
                                               </table>
                                            
                                           <br>       
                                           <br>       
                                  <h4><strong>Dedicación de Personal Ejecutada.</strong></h4><br>
                                  <center>Dedicación de Personal: $ <%=formatea.format(Integer.parseInt((bd.ConsultaValorDedicacionSeg(idseg)).toString()))%></center>                                  
                                  <br>
                                  <h4><strong>Resumen de Ejecución.</strong></h4><br>
                                    
                                  <table class="table table-hover">
                                    <tr>
                                        <th>Total Personal</th>
                                        <th>Total Erogación</th>
                                        <th>Total Proyecto</th>
                                    </tr>
                                    <tr>
                                        <td>$ <%=formatea.format(Integer.parseInt((bd.ConsultaValorDedicacionSeg(idseg)).toString()))%></td>
                                        <td>$ <%=formatea.format(TErog)%></td>
                                        <td>$ <%=formatea.format(new BigInteger(TErog.add(new BigInteger(bd.ConsultaValorDedicacionSeg(idseg))).toString()))%> </td> <!-- forma anterior: td>$ %=formatea.format(Integer.parseInt((bd.ConsultaValorDedicacionSeg(idseg)).toString()) + TErog)%</td--> 
                                    </tr> 
                                   </table> 
                                        <%  
                                        String tmp = bd.ConsultaUltSeg(idp);
                                        
                                    
                                        if(tmp.equals(idseg)){
                                        BigInteger TotalTMP;  TotalTMP = BigInteger.valueOf(0);
                                    
                                        TotalTMP = TotalTMP.add(new BigInteger(bd.ConsultaValorDedicacionProy(idseg,idp).toString()));
                                        TotalTMP = TotalTMP.add(new BigInteger(TErogStg));
                                        bd.ActualizarValorEjecutadoEroPer(idp,String.valueOf(TErog),(bd.ConsultaValorDedicacionProy(idseg,idp).toString()));
                                        bd.ActualizarValorEjecutado(idp, TotalTMP.toString());}
                                        
                                        %> 
                                      </div>
                        
                      </div>
                    </div>
                  </div>
                                      

                                                  
<%}else if(datosb.elementAt(21).equals("M")){

      SegErogacion = bd.ConsultaSegErogacionMegaPro(idseg);
    
%>

<div class="panel panel-default">
                    <div class="panel-heading" role="tab" id="headingSix">
                      <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseSix" aria-expanded="false" aria-controls="collapseSix">
                          <span class="glyphicon glyphicon-paperclip"></span> EJECUCIÓN PRESUPUESTAL
                        </a>
                      </h4>
                    </div>
                    <div id="collapseSix" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingSix">
                      <div class="panel-body">
                        En esta sección se presenta la información del presupuesto oficial asociado al proyecto y el estado en el que se encontraba para la fecha en que se realizo el presente seguimiento.
                        
                        
                        <br>
                                         
                               
                                <div class="panel-body">
                                    
                                    <h4><strong>Presupuesto de Erogación oficial.</strong></h4><br>
                                    
                                                <table class="table table-hover">
                                                    <tr>
                                                      <th>Centro Operativo</th>
                                                      <th>Rubro</th>
                                                      <th>Año</th>
                                                      <th>Valor Asignado</th>
                                                      <th>Saldo</th>
                                                      <th>Ejecutado</th>
                                                      <th>Adición Cambio Año</th>
                                                      <th>Planeado</th>
                                                    </tr>
                                                    <%for(int iq = 0 ; iq < SegErogacion.size(); iq++){
                                                            Vector auxespec = (Vector)SegErogacion.elementAt(iq);                                    
                                                     %>
                                                    <tr>
                                                      <td><%=auxespec.elementAt(1)%></td>
                                                      <td><%=auxespec.elementAt(2)%></td>
                                                      <td><%=auxespec.elementAt(3)%></td>
                                                      <td><%=formatea.format(new BigInteger(auxespec.elementAt(7).toString()))%></td>
                                                      <td><%=formatea.format(new BigInteger(auxespec.elementAt(4).toString()))%></td>
                                                      <%
                                                          TErog = new BigInteger(TErog.add(new BigInteger((new BigInteger(auxespec.elementAt(5).toString())).subtract(new BigInteger(auxespec.elementAt(4).toString())).toString())).toString()); /* anterior hasta 14 agosto 2019 : TErog = TErog + Integer.parseInt(auxespec.elementAt(5).toString())-Integer.parseInt(auxespec.elementAt(4).toString());*/
                                                      %>
                                                      <td><%=formatea.format(new BigInteger((new BigInteger(auxespec.elementAt(5).toString())).subtract(new BigInteger(auxespec.elementAt(4).toString())).toString()))%></td>  <!-- Forma Anterior: td>%=formatea.format(Integer.parseInt(auxespec.elementAt(5).toString())-Integer.parseInt(auxespec.elementAt(4).toString()))%</td-->
                                                      <td><%=formatea.format(Integer.parseInt(auxespec.elementAt(6).toString()))%></td> 
                                                      <td><%=auxespec.elementAt(9)%></td> 
                                                    </tr>
                                                    <%
                                                         TErogStg = String.valueOf(TErog);
                                                    }%>
                                                </table>
                                            
                                           <br>       
                                           <br>       
                                  <h4><strong>Dedicación de Personal Ejecutada.</strong></h4><br>
                                  <center>Dedicación de Personal: $ <%=formatea.format(Integer.parseInt((bd.ConsultaValorDedicacionSegMegaPro(idseg)).toString()))%></center>                                  
                                  <br> 
                                  <h4><strong>Resumen de Ejecución.</strong></h4><br>
                                    
                                  <table class="table table-hover">
                                    <tr>
                                        <th>Total Personal</th>
                                        <th>Total Erogación</th>
                                        <th>Total Proyecto</th>
                                    </tr>
                                    <tr>
                                        <td>$ <%=formatea.format(Integer.parseInt((bd.ConsultaValorDedicacionSegMegaPro(idseg)).toString()))%></td>
                                        <td>$ <%=formatea.format(TErog)%></td>
                                        <td>$ <%=formatea.format(new BigInteger(TErog.add(new BigInteger(bd.ConsultaValorDedicacionSegMegaPro(idseg))).toString()))%> </td> <!-- forma anterior: td>$ %=formatea.format(Integer.parseInt((bd.ConsultaValorDedicacionSegMegaPro(idseg)).toString()) + TErog)%</td-->                                          
                                    </tr> 
                                  </table> 
                                        <%  
                                        String tmp = bd.ConsultaUltSeg(idp);
                                        
                                    
                                        if(tmp.equals(idseg)){
                                        BigInteger TotalTMP;  TotalTMP = BigInteger.valueOf(0);
                                    
                                        TotalTMP = TotalTMP.add(new BigInteger(bd.ConsultaValorDedicacionProy(idseg,idp).toString()));
                                        TotalTMP = TotalTMP.add(new BigInteger(TErogStg));
                                        bd.ActualizarValorEjecutadoEroPer(idp,String.valueOf(TErog),(bd.ConsultaValorDedicacionProy(idseg,idp).toString()));
                                        bd.ActualizarValorEjecutado(idp, TotalTMP.toString());}
                                        
                                        %> 
                                      </div>
                        
                      </div>
                    </div>
                  </div>


<%}%>
                                      
            </div>  
            </form> 
        </div>


<%}%>
<%}%>
    </div>    

    </section>



<!--FOOTER-->
<footer class="footerContainer">
    <div class="container">        
        <div class="row">
            <article class="col-sm-7 col-md-5">
                <p>                    
                    <strong>ESCUELA COLOMBIANA DE INGENIERÍA JULIO GARAVITO</strong><br/>
                    AK.45 No.205-59 (Autopista Norte)<br/>
                    <i>Contact center</i>: +57(1) 668 3600<br/>
                    Línea Nacional Gratuita: 018000112668<br/>
                    Información detallada en: www.escuelaing.edu.co<br/><br/>
                    <small>Personería Jurídica 086 de enero 19 de 1973. Acreditación Institucional de Alta Calidad Res. 002710 del 18 de marzo de 2019. (Vigencia 6 años).<br>
                    Vigilada Mineducación.</small><br><br>
                    Bogotá, D.C. - Colombia<br/>
                
            </article>
            <article class="col-sm-5 col-md-7">
                <p>
                    <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d1987.9617427360993!2d-74.04338482936627!3d4.783148717834411!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8e3f85e374627fe5%3A0x540783a0b074c84d!2sEscuela+Colombiana+de+Ingenier%C3%ADa!5e0!3m2!1ses!2ses!4v1424190444206" width="100%" height="280" frameborder="0" style="border:0"></iframe>
                </p>
            </article>
        </div> 
    </div>       
</footer>

<script>
    
    
        $(document).ready(function() {
            var hashVal = window.location.hash.split("#")[1];


                if(hashVal.indexOf("colsend") != -1){
                    $("#collapseFour").collapse();
                    $("#"+hashVal).collapse();
                }else{
                    
                    $("#"+hashVal).collapse();
                }

            });
            
            
            
            function testshow(){
        
                $('input[type="radio"]').click(function(){
                    if($(this).attr("value")=="N"){
                        $(".Box").show('slow');
                        $(".Box2").hide('slow');
                    }
                    if($(this).attr("value")=="C"){
                        $(".Box2").show('slow');
                        $(".Box").hide('slow');
                    }
                    if($(this).attr("value")=="Q"){
                        $(".Box").hide('slow');
                        $(".Box2").hide('slow');
                    } 
                });
                }
            
                 function caracteristicasp(){
        
                        if( document.getElementById("caracteristicas").checked == true){

                            document.getElementById('addcarac').style.display = 'block';
                        }
                        else{

                            document.getElementById('addcarac').style.display = 'none';
                        }

                    }
    
</script>


    <!--SCRIPT BOOTSTRAP-->
    <script src="js/jquery.js"></script>
    <script src="https://code.jquery.com/jquery-latest.jS"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>
