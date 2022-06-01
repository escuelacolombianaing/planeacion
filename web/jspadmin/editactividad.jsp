<%-- 
    Document   : historial
    Created on : 02/02/2017, 04:00:00 PM
    Author     : Juan Vanzina
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.util.Vector"%>
<%@page import="BDatos.BDServicios"%>
<%@ include file="secure.jsp" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%response.setHeader("Cache-Control", "no-cache");

        String ccemp = session.getAttribute("cod_emp").toString();
        String nomus = session.getAttribute("nom_emp").toString(); 
        String apus1 = session.getAttribute("of").toString();
        String apus2 = session.getAttribute("inst").toString();
        String mailus = session.getAttribute("e_mail").toString();
        
        String idp = request.getParameter("idp");
        String act = request.getParameter("act");
        
        String mensaje="";
        
        mensaje = request.getParameter("m");
        
        BDServicios bd = new BDServicios();
        
        Vector aux          = new Vector();
        Vector personal     = new Vector();
        Vector empleados    = new Vector();
        Vector cargos       = new Vector();
        Vector indicadores  = new Vector();
        Vector horas        = new Vector();
        Vector auxh         = new Vector();
        Vector auxin        = new Vector();
        Vector rubro        = new Vector();
        Vector presupuesto  = new Vector();
        Vector datosb       = new Vector();
        Vector actividad    = new Vector();
        
        actividad   = bd.ConsultaInfoActividad(act);
        presupuesto = bd.ConsultaPresupuestoActi(act);
        personal    = bd.ConsultaPersonal(act,"0");
        empleados   = bd.usuario();
        indicadores = bd.ConsultaIndActividad(act);
        rubro       = bd.PreRubrosPL();
        datosb      = bd.ConsultaDatosProyecto(idp);
        cargos      = bd.cargoseci();
        String vigencia = bd.vigenciaproy(idp);
        
        BigInteger TotalRubros;
        
        TotalRubros = BigInteger.valueOf(0);
        
         String Valor="", Cadena="", agnorub = "", Valor1="", Cadena1="", Valor2="", Cadena2="";
        
        DecimalFormat formatea = new DecimalFormat("###,###.##");
         
        int q  = bd.Consultaagnofechas(act);
        int agno   = Integer.parseInt(bd.consultagnoiniact(act)); 
%>
<html lang="es">
<head>
    <meta charset="UTF-8">
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

</head>
<body onload="testshow(), testshow2(), testshow3(), ini()">

    <header>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <center><img src="img/img-header-2.jpg" class="img-responsive"></center>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 franjaColor">
                    <center><h4>.:: Plataforma de seguimiento a la planeación ::.</h4><div align="right"><input class="btn-danger" type="button" align="right" value="Cerrar Sesión" onclick="location.href = '/planeacion/LogOut';"></center></div>
                </div>
            </div>
            <center><img src="img/img-historial.jpg" alt="portada" class="img-responsive"></center>
        </div>
    </header>

<!--CONTENIDOS-->
    <section>
        <div class="container">
            
            
            <div class="colorFormulario">
                <center>
                    <strong>Id. Proyecto:           </strong>           <a><%=idp%></a>  
                    <strong>Nombre del Proyecto:    </strong>           <a><%=datosb.elementAt(0)%></a>  <br>
                    <strong>Estado Proyecto:        </strong>           <a><%=bd.parametrosEsp("1", datosb.elementAt(1).toString())%></a>
                    <strong>Avance:                 </strong>           <a><%=datosb.elementAt(14)%>%</a>
                    <strong>Plan:                   </strong>           <a><%=bd.nombreplan(datosb.elementAt(3).toString())%></a>
                    <strong>Vigencia:               </strong>           <a><%=vigencia%></a>
                    <strong>Director:               </strong>           <a><%=bd.usuarioconscc2(datosb.elementAt(6).toString())%></a>
                    <br><br>
                    <button class="btn btn-group-sm" onclick="window.open('/planeacion/ResumenPlaneacion?idp=<%=idp%>')">Ver Resumen Proyecto</button>
                </center>
            </div>
            
            <div class="row">
                <div class="col-md-12 filaCompleta">
                    <p>
                        
                        <div class="colorFormulario">
                            <center>
                                <h3><b><a>Datos Básicos Actividad</a></b></h3>
                                <form action="ActualizaActividad" method="POST">
                                    <input type="hidden" name="returntip" value="A">
                                    <table style="min-width: 900;   ">
                                    <tr><input type="hidden" name="act" value="<%=act%>"><input type="hidden" name="idp" value="<%=idp%>">
                                    <td >Nombre Actividad:</td><td colspan="3"><input class="form-control" value="<%=actividad.elementAt(1)%>" type="text" pattern="[A-Za-z0-9ñÑáéíóú+-_ ]{0,999}" name="nom" required></td></tr>           
                                        <tr><td>Fecha Inicio: </td><td><input class="form-control" value="<%=actividad.elementAt(3)%>" type="text" name="feciniac" id="datepicker"></td>       
                                            <td>Fecha Fin:    </td><td><input class="form-control" value="<%=actividad.elementAt(4)%>" type="text" name="fecfinac" id="datepicker2"></td></tr>        
                                        <tr>
                                        <td>Porcentaje (Peso) Actividad: </td><td><input class="form-control" value="<%=actividad.elementAt(6)%>" type="number" name="peso" min="1" max="100" required></td>       
                                        <td>Porcentaje Avance:   </td><td><input class="form-control" type="text" value="<%=actividad.elementAt(5)%>" name="poravance" readonly></td></tr>
                                        <tr><td>Responsable Actividad</td>
                                            <td colspan="3">
                                                <select name="responact" id="responsable" class="form-control" required>
                                                                            <%if (empleados.size() > 0){ 
                                                                            %><option value="">Seleccione el Responsable</option><%
                                                                                    for (int ii = 0; ii < empleados.size(); ii++) {
                                                                                            Vector infusu = (Vector)empleados.elementAt(ii) ;
                                                                                            if(infusu.elementAt(0).toString().equals(actividad.elementAt(10).toString())){Valor = infusu.elementAt(0).toString(); Cadena = infusu.elementAt(1).toString();}
                                                                            %>
                                                                            <option value="<%=infusu.elementAt(0)%>"><%=infusu.elementAt(1)%></option>
                                                                                    <%} if(Valor.equals("")){Cadena="Seleccione un elemento de la lista";}
                                                                                    %>
                                                                                    <option value="<%=Valor%>" selected='selected'><%=Cadena%></option><%Valor="";Cadena="";%>
                                                                                    <%
                                                                            }%>
                                               </select>                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Descripción:</td><td colspan="3"><textarea rows="6" cols="20" class="form-control" name="desc" required><%=actividad.elementAt(2)%></textarea></td>
                                        </tr>
                                </table>
                                <br>
                                <input class="btn-lg" type="submit" name="Guardar" value="Guardar Cambios">
                                </form> 
                            </center>
                        </div>
                    
                                  <div class="row" style="display: block;">
                                      
                                      <br>
                                   <center><input class="btn btn-info" type="button" value="< Regresar al Proyecto" name="volver atrás2" onclick="location.href='/planeacion/editpr?idp=<%=idp%>#collapseThree'" /></center><br>
                                      <br>
                                      
                                      <div class="colorFormulario">
                                          <a name="dedicacion"><h4><strong>Dedicación de personal:</strong></h4></a>
                                      
                                      <div class="panel-body">
                                              <div class="row">
                                                      <div class="col-xs-12 col-md-3 col-lg-12">    
                                                      </div>
                                                        <%if(personal.size()>0){%>
                                                              <table class="table table-hover">
                                                                <tr>
                                                                  <th>Nombre</th>
                                                                  <th>Cargo</th>
                                                                  <th>Horas y Cantidad por año</th>
                                                                   <th>Eliminar</th>
                                                                </tr>
                                                                <% for ( int m = 0 ; m < personal.size() ; m++ ){
                                                                  aux = (Vector)personal.elementAt(m);
                                                                %>
                                                                <tr>
                                                                    <%if(aux.elementAt(1).toString().equals("Sin Definir")){%>
                                                                        <td><%=aux.elementAt(1).toString()%></td>
                                                                    <%}else{%>
                                                                        <td><%=bd.usuarioconscc2(aux.elementAt(1).toString())%></td>
                                                                    <%}%>
                                                                  
                                                                  <td><%=aux.elementAt(2).toString()%></td>
                                                                  <td>
                                                                      <table>
                                                                             <tr>
                                                                                 <th style="padding-right: 170px">Año</th>
                                                                          <th style="padding-right: 50px">Horas</th>
                                                                          <th>Cantidad Pers.</th>
                                                                          </tr>
                                                                      </table>
                                                                      <% horas = bd.ConsultarHoras(aux.elementAt(0).toString());
                                                                         for ( int s = 0 ; s < horas.size() ; s++ ){
                                                                         auxh = (Vector)horas.elementAt(s);
                                                                      %>
                                                                      <form name="MyForm" action="ActualizaHoras" method="POST">
                                                                           <input type="hidden" name="returntip" value="A">
                                                                      <table>
                                                                            <td><input type="number" class="form-control" value="<%=auxh.elementAt(0)%>" name="agno" readonly></td>
                                                                            <td><input type="number" class="form-control" value="<%=auxh.elementAt(1)%>" name="horas" min="0" max="2920" onblur="">
                                                                              <%if(aux.elementAt(1).toString().equals("Sin Definir")){%>
                                                                                    <td><input type="number" class="form-control" value="<%=auxh.elementAt(2)%>" name="CantPer" min="0" max="2920" onblur="">
                                                                                 <%}else{%>
                                                                                    <td><input type="number" class="form-control" value="<%=auxh.elementAt(2)%>" name="CantPer" min="0" max="2920" onblur="" readonly>
                                                                                <%}%>
                                                                            <input type="hidden" value="<%=aux.elementAt(0)%>" name="idpersonal">
                                                                            <input type="hidden" value="<%=idp%>" name="idp">
                                                                            <input type="hidden" value="<%=act%>" name="idact">
                                                                            </td>
                                                                      </table>
                                                                    
                                                                      <%}%>
                                                                      <input type="submit" value="Guardar Info." id="act" class="btn btn-default">
                                                                     </form>
                                                                  </td>
                                                                     <td>
                                                                      <form action="EliminaInfoActTipo" method="POST" onsubmit="return confirm('Esta Seguro de eliminar el Registro?');">
                                                                                <input type="hidden" name="idp" value="<%=idp%>">
                                                                                <input type="hidden" name="act" value="<%=act%>">
                                                                                <input type="hidden" name="idreg" value="<%=aux.elementAt(0)%>">
                                                                                <input type="hidden" name="tipo" value="PERS">
                                                                                <input type="hidden" name="usuario" value="editact">
                                                                            <button name="action" value="blue"><img src="img/delete.png" width="20" height="22" border="0"></button>
                                                                        </form>
                                                                  </td>
                                                                         
                                                                </tr>
                                                                <%}%>
                                                              </table>
                                                              <%}else{%>
                                                                <center><label>Su actividad aun no registra dedicación de personal en la plataforma.</label></center><br>
                                                                <%}%>
                                              </div>
                                                              <table a>
                                                                      <tr>
                                                                          <td><label><input type="radio" class="radioBtn" name="Radio" id="Radio" value="Q" onchange="testshow()"><a>Solo Consultar</a></label>
                                                                              <label><input type="radio" class="radioBtn" name="Radio" id="Radio" value="N" onchange="testshow()" checked="checked"><a>Agregar personal por Nombre</a></label>
                                                                              <label><input class="radioBtn" type="radio" name="Radio" id="Radio" value="C" onchange="testshow()"><a>Agregar personal por Cargo</a></label></td>
                                                                      </tr>
                                                                      <tr height="20">
                                                                      </tr>
                                                                      <tr>
                                                                      <td>  
                                                                          <div class="Box" style="display:none">
                                                                                  
                                                                                <form action="NuevaDedPersonal" method="POST">
                                                                                    <input type="hidden" name="returntip" value="A">
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
                                                                                                    <%for(int qp = Integer.valueOf(actividad.elementAt(3).toString().substring(6, 10)) ; qp <= Integer.valueOf(actividad.elementAt(4).toString().substring(6, 10)) ; qp++){%>
                                                                                                    <input class="form-control" type="number" value="<%=qp%>" name="agnos" readonly>
                                                                                                    <input class="form-control" type="number" min="0" name="horaspart" required>
                                                                                                    <%}%>
                                                                                            </div>
                                                                                    </div>
                                                                                    <div class="col-xs-12 col-md-3 col-lg-4">
                                                                                            <div class="form-group espacio">
                                                                                                <input type="hidden" value="<%=idp%>" name="idp">
                                                                                                <input type="hidden" value="<%=act%>" name="idact">
                                                                                                <input type="submit" value="Agregar Participante" class="btn-lg">                                
                                                                                            </div>
                                                                                    </div>
                                                                                    </form>
                                                                                                                          
                                                                          </div>          
                                           
                                                                                   <div class="Box2" style="display:none">
                                                                                            
                                                                                       
                                                                                       <form action="NuevaDedPersonalCargo" method="POST">
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
                                                                                                    <%for(int qp = Integer.valueOf(actividad.elementAt(3).toString().substring(6, 10)) ; qp <= Integer.valueOf(actividad.elementAt(4).toString().substring(6, 10)) ; qp++){%>
                                                                                                    <input class="form-control" type="number" value="<%=qp%>" name="agnos" readonly>
                                                                                                    <input class="form-control" type="number" min="0" name="horaspart" required>
                                                                                                     <%}%>
                                                                                                      <label for="">Cantidad personas:</label>     
                                                                                                       <input class="form-control" type="number" min="0" name="CantPer" required>
                                                                                            </div>
                                                                                    </div>
                                                                                    <div class="col-xs-12 col-md-3 col-lg-4">
                                                                                            <div class="form-group espacio">
                                                                                                <input type="hidden" value="<%=idp%>" name="idp">
                                                                                                <input type="hidden" value="<%=act%>" name="idact">
                                                                                                <input type="hidden" value="Admin" name="idadm">
                                                                                                <input type="submit" value="Agregar Participante" class="btn-lg">                                
                                                                                            </div>
                                                                                    </div>
                                                                                    </form>
                                                                                       
                                                                                   </div>
                                                                          
                                                                          <td>
                                                                      </tr>
                                                                      <tr height="20">
                                                                      </tr>
                                                                </table>
                                      </div>
                                            
                                      </div>
                                      <div class="colorFormulario">
                    
                   
                                          <a name="erogacion"><h4><strong>Presupuesto Erogación</strong></h4></a>
                      
                            <div class="row">
                                                      <div class="col-xs-12 col-md-3 col-lg-12">
                                                          <input type="hidden" value="<%=idp%>" name="idp">    
                                                      </div>
                                                              <%if(presupuesto.size()>0){%>
                                                              <div class="colorFormulario">
                                                                      <% for ( int m = 0 ; m < presupuesto.size() ; m++ ){
                                                                    aux = (Vector)presupuesto.elementAt(m);
                                                                    TotalRubros = TotalRubros.add(new BigInteger(aux.elementAt(6).toString()));
                                                                  %>
                                                                   <form action="ActualizarInfoActTipo" method="POST" id="my_form<%=m%>"> 
                                                              <table class="table table-hover">
                                                                <tr>
                                                                  <th>Actividad</th>
                                                                  <th>Rubro</th>
                                                                  <th>Tipo Rubro</th>
                                                                  <th>Año</th>
                                                                  <th>Valor</th>
                                                                  <th>Observación</th>
                                                                  
                                                                </tr>
                                                                <tr>
                                                                  <td><%=aux.elementAt(5)%></td>  
                                                                  <td>
                                                                      <select name="rubrosel" id="rubro" class="form-control" required>
                                                                            <%if (rubro.size() > 0){ 
                                                                            %><option value="">Seleccione el Rubro</option><%
                                                                                    for (int ii = 0; ii < rubro.size(); ii++) {
                                                                                            Vector infusu = (Vector)rubro.elementAt(ii) ;
                                                                                            if(infusu.elementAt(0).toString().equals(aux.elementAt(2).toString())){Valor = infusu.elementAt(0).toString(); Cadena = infusu.elementAt(1).toString();}
                                                                            %>
                                                                            <option value="<%=infusu.elementAt(0)%>"><%=infusu.elementAt(1)%></option>
                                                                                    <%} if(Valor.equals("")){Cadena="Seleccione un elemento de la lista";}
                                                                                    %>
                                                                                    <option value="<%=Valor%>" selected='selected'><%=Cadena%></option><%Valor="";Cadena="";%>
                                                                                    <%
                                                                            }%>
                                                                        </select>
                                                                  </td>
                                                                  <input type="hidden" name="iderog" value="<%=aux.elementAt(0)%>"><input type="hidden" name="idp" value="<%=idp%>">
                                                                  <td><%=aux.elementAt(1)%></td>
                                                                     <td> 
                                                                        <select name="AnioRubro"  id="anio" class="form-control" required>
                                                                                <option value="">Seleccione el año</option>
                                                                                 <%
                                                                                      int qi  = bd.Consultaagnofechas(act);
                                                                                      int agno1   = Integer.parseInt(bd.consultagnoiniact(act)); 
                                                                                    for(int li = 1 ; li <= qi ; li++){
                                                                                      if (agno1== Integer.parseInt(aux.elementAt(7).toString())){
                                                                                          Valor1 = aux.elementAt(7).toString(); Cadena1 = aux.elementAt(7).toString();
                                                                                      }
                                                                                 %>
                                                                                    <option value="<%=String.valueOf(agno1)%>"><%=agno1%></option>
                                                                                       <%
                                                                                         agno1 = agno1 + 1;
                                                                                        } 
                                                                                       %>
                                                                                        <option  selected='selected'><%=Cadena1%></option><%Valor1="";Cadena1="";%>
                                                                       </select>
                                                                     </td>
                                                                  <td><input name="ValorRubro" type="number" class="form-control" value="<%=aux.elementAt(6)%>" /></td>
                                                                  <td><input name="ObsRubro" type="text" class="form-control" value="<%=aux.elementAt(4)%>" /></td>
                                                                 <br>
                                                                  <td>                                                              
                                                                       <input type="hidden" name="idreg" value="<%=aux.elementAt(0)%>">
                                                                       <input type="hidden" name="idp" value="<%=idp%>">
                                                                       <input type="hidden" name="act" value="<%=act%>">
                                                                       <input type="hidden" name="tipusr" value="editact">
                                                                   <a href="javascript:{}" onclick="document.getElementById('my_form<%=m%>').submit();"><img src="img/actualizar.png" width="20" height="22" border="0"></a> 
                                                                  </td>
                                                                  </tr>
                                                                </table>
                                                              </form>            
                                                              <form action="EliminaInfoActTipo" method="POST" onsubmit="return confirm('Esta Seguro de eliminar el Registro?');">
                                                                   <input type="hidden" name="idp" value="<%=idp%>">
                                                                   <input type="hidden" name="act" value="<%=act%>">
                                                                   <input type="hidden" name="idreg" value="<%=aux.elementAt(0)%>">
                                                                   <input type="hidden" name="tipo" value="EROG">
                                                                   <input type="hidden" name="usuario" value="editact">
                                                                  <button name="action" value="blue"><img src="img/delete.png" width="20" height="22" border="0"></button>
                                                              </form>   
                                                                  <%}%>
                                                                
                                                                  
                                                                        <label>Total presupuesto de erogación: </label>
                                                                        <input type="text" name="" value="$   <%=formatea.format(new BigInteger(TotalRubros.toString()))%>" class="form-control" readonly>
                                                                        <br>
                                                                  
                                                                <%}else{%>
                                                                <center><label>Su actividad aun no registra valores de erogación en la plataforma.</label></center><br>
                                                                <%}%>
                                                               </div>
                                                              
                                                              
                                                              <br>
                                                              
                                              <table>
                                                                      <tr>
                                                                          <td><label><input type="radio" class="radioBtn" name="Radio3" id="Radio3" value="RX" onchange="testshow3()"><a>Solo Consultar</a></label>
                                                                              <label><input type="radio" class="radioBtn" name="Radio3" id="Radio3" value="RI" onchange="testshow3()" checked="true"><a>Agregar Presupuesto</a></label></td>
                                                                      </tr>
                                                                      <tr>
                                                                          <td>
                                                                                 <div class="Box4" style="display:none">
                                                                                  <div class="col-md-12 filaCompleta">
                                                                                      <h4>Creación de <strong>nuevo valor de erogación</strong></h4>

                                                                                      <form action="NuevoRubroPr" method="POST" class="colorFormulario">
                                                                                          <input type="hidden" name="returntip" value="A">
                                                                                          <div class="row">
                                                                                               <div class="col-md-offset-1 col-md-3">
                                                                                                  <div class="form-group"> <input type="hidden" value="<%=idp%>" name="idp">
                                                                                                      <input type="hidden" value="<%=act%>" name="act">
                                                                                                      <label for="">Rubro</label>
                                                                                                      <select name="rubro"  class="form-control" required>
                                                                                                          <%if (rubro.size() > 0){ 
                                                                                                          %><option value="">Seleccione el Rubro</option><%
                                                                                                                  for (int ii = 0; ii < rubro.size(); ii++) {
                                                                                                                          Vector infusu = (Vector)rubro.elementAt(ii) ;
                                                                                                                          if(infusu.elementAt(0).toString().equals(datosb.elementAt(7).toString())){Valor = infusu.elementAt(0).toString(); Cadena = infusu.elementAt(1).toString();}
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
                                                                                          
                                                                                              <div class="col-md-offset-1 col-md-3">
                                                                                                  <div class="form-group">
                                                                                                      <label for="">Año</label>
                                                                                                      <select name="agno"  class="form-control" required>
                                                                                                          <option value="">Seleccione el año</option>
                                                                                                          <%
                                                                                                                  for(int l = 1 ; l <= q ; l++){
                                                                                                          %>
                                                                                                         <option value="<%=String.valueOf(agno)%>"><%=agno%></option>
                                                                                                                  <%
                                                                                                                       agno = agno + 1;
                                                                                                                  }%>
                                                                                                      </select>
                                                                                                  </div>
                                                                                              </div>
                                                                                              <div class="col-md-offset-1 col-md-3">
                                                                                                  <div class="form-group">
                                                                                                      <label for="">Valor</label>
                                                                                                      <input type="number" class="form-control" name ="valor" required>
                                                                                                  </div>
                                                                                              </div>
                                                                                          </div>            
                                                                                          <div class="row">
                                                                                              <div class="col-md-offset-1 col-md-10">
                                                                                                  <div class="form-group">
                                                                                                      <label for="">Observaciones</label>
                                                                                                      <textarea rows="6" type="textarea" maxlength="4999" class="form-control" name="obsrub" id="" required></textarea>
                                                                                                  </div>
                                                                                              </div>
                                                                                          </div>

                                                                                          <center><input type="submit" class="btn-lg" value="Crear Valor Erogación"></center>
                                                                                      </form> 

                                                                                  </div>
                                                                              </div>                                                                              
                                                                          </td>
                                                                      </tr>
                                              </table>
                                              
                                                                        
                                                                        
                                              </div>
                      
                    
                                      </div>
                                      <div class="colorFormulario">                                             
                                                                                                                    
                                      <div class="row">
                                          
                                          
                                          <a name=""><h4><strong>Indicadores de la Actividad:</strong></h4></a>
                                             
                                                      <div class="col-xs-12 col-md-3 col-lg-12">    
                                                      </div>
                                                        <%if(indicadores.size()>0){%>
                                                              <table class="table table-hover">
                                                                <tr>
                                                                  <th>Nombre</th>
                                                                  <th>Periodicidad de Medición</th>
                                                                  <th>Descricpión</th>
                                                                  <th>Cálculo</th>
                                                                   <th>Eliminar</th>
                                                                </tr>
                                                                <% for ( int m = 0 ; m < indicadores.size() ; m++ ){
                                                                  auxin = (Vector)indicadores.elementAt(m);
                                                                %>
                                                                <tr>
                                                                  <td><%=auxin.elementAt(1)%></td>
                                                                  <td><%=auxin.elementAt(3)%></td>
                                                                  <td><%=auxin.elementAt(7)%></td>
                                                                  <td><%=auxin.elementAt(2)%></td>
                                                                     <td>
                                                                      <form action="EliminaInfoActTipo" method="POST" onsubmit="return confirm('Esta Seguro de eliminar el Registro?');">
                                                                                <input type="hidden" name="idp" value="<%=idp%>">
                                                                                <input type="hidden" name="act" value="<%=act%>">
                                                                                <input type="hidden" name="idreg" value="<%=auxin.elementAt(0)%>">
                                                                                <input type="hidden" name="tipo" value="INDAC">
                                                                                 <input type="hidden" name="usuario" value="editact">
                                                                            <button name="action" value="blue"><img src="img/delete.png" width="20" height="22" border="0"></button>
                                                                        </form>
                                                                  </td>
                                                                </tr>
                                                                <%}%>
                                                              </table>
                                                          <%}else{%>
                                                                <center><label>Su actividad aun no registra indicadores en la plataforma.</label></center><br>
                                                         <%}%>
                                                                <a name="indicadores"></a>
                                                              <table align="">
                                                                      <tr>
                                                                          <td><label><input type="radio" class="radioBtn" name="Radio2" id="Radio2" value="X" onchange="testshow2()"><a>Solo Consultar</a></label>
                                                                              <label><input type="radio" class="radioBtn" name="Radio2" id="Radio2" value="I" onchange="testshow2()" checked="true"><a>Agregar Indicador</a></label></td>
                                                                      </tr>
                                                                      <tr height="20">
                                                                      </tr>
                                                                      <tr>
                                                                          <td>    <div class="Box3" style="display:none">
                                                                                  
                                                                                  <form action="NuevoIndicador" method="POST">
                                                                                      <input type="hidden" name="returntip" value="A">
                                                                                  <div class="col-xs-12 col-md-3 col-lg-10">
                                                                                            <div class="form-group espaciado">
                                                                                                    <label for="">Nombre Indicador:</label>
                                                                                                    <input type="text" name="nombreind" min="0"  maxlength="999" placeholder="Nombre Indicador" value="" class="form-control" required> 		
                                                                                                    <label for="">Periodicidad de Medición:</label>
                                                                                                    <input type="hidden" value="<%=act%>" name="idact">
                                                                                                    <input type="hidden" value="2" name="tipoind">
                                                                                                    <input type="hidden" value="<%=idp%>" name="idp">
                                                                                                    <input type="text" name="periodicidad" min="0" placeholder="Cada Año - Cada Mes - ETC" value="" class="form-control" required> 
                                                                                                    <label for="">Descripción Cálculo</label>
                                                                                                    <textarea name="descripcioncal" class="form-control" maxlength="1999" required></textarea>
                                                                                            </div>
                                                                                    </div>
                                                                                    <div class="col-xs-12 col-md-3 col-lg-4">
                                                                                            <div class="form-group espacio">
                                                                                                <input type="submit" value="Agregar Indicador" class="btn-lg">                                
                                                                                            </div>
                                                                                    </div>
                                                                                  </form>
                                                                                  
                                                                              </div>
                                                                          </td>
                                                                      </tr>
                                                                      <tr height="20">
                                                                      </tr>
                                                                </table>
                                      
                                      </div>                    
                                      </div>
                                                                                                    
                                  </div>
                                  </div> 
                    </p>
            </div>                                 <center><input class="btn btn-info" type="button" value="< Regresar al Proyecto" name="volver atrás2" onclick="location.href='/planeacion/editpr?idp=<%=idp%>#collapseThree'" /></center><br>
                                                               
            </div>
        </div>
    </section>

<script>
    
    function ini(){
        
        $(".Box").show('slow');
        $(".Box3").show('slow');
        $(".Box4").show('slow');
    }
   
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
    
     function testshow2(){
    $('input[type="radio"]').click(function(){
        if($(this).attr("value")=="X"){
            $(".Box3").hide('slow');
        }
        if($(this).attr("value")=="I"){
            $(".Box3").show('slow');
        }
    });
    }
    
     function testshow3(){
    $('input[type="radio"]').click(function(){
        if($(this).attr("value")=="RX"){
            $(".Box4").hide('slow');
        }
        if($(this).attr("value")=="RI"){
            $(".Box4").show('slow');
        }
    });
    }
</script>

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




    <!--SCRIPT BOOTSTRAP-->
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <script>
    $( function() {
      $( "#datepicker" ).datepicker({dateFormat:      "dd/mm/yy",
                                      dayNamesMin:     ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"],
                                      dayNamesShort:   ["Dom", "Lun", "Mar", "Mie", "Jue", "Vie", "Sab"],
                                      monthNames:      ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio","Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
                                      monthNamesShort: ["Ene", "Feb", "Mar", "Abr", "May", "Jun","Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]}).val();
      $( "#datepicker2" ).datepicker({dateFormat:      "dd/mm/yy",
                                      dayNamesMin:     ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"],
                                      dayNamesShort:   ["Dom", "Lun", "Mar", "Mie", "Jue", "Vie", "Sab"],
                                      monthNames:      ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio","Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
                                      monthNamesShort: ["Ene", "Feb", "Mar", "Abr", "May", "Jun","Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]}).val();
    } );
    </script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>
