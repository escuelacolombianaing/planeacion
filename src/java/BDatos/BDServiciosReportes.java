/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package BDatos;

import java.io.*;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import BDatos.BaseDatos;

/**
 *
 * @author palvarad
 */
public class BDServiciosReportes extends BaseDatos {

   private String mensaje;

    /** Creates a new instance of BD.. */
    public BDServiciosReportes() {
    }


     public Vector ConsultaProyectosUser(String ccuser, String plan, String estado, String eje, String uniej, String estseg, String nomproy, String fcinirep, String fcfinacrep) {
        Vector retorno = new Vector();
        String consulta = new String();
        String ejeppal = "";
        
        ejeppal = "AND ejeppal = 1";
        
        String adicional = "";
        String adicional1 = "";
        String adicional2 = "";
        if(!uniej.equals("0")){
        
            adicional = " unidadejecutora = "+ uniej +" AND ";
        }
        if(!nomproy.equals("0")){
        
            adicional1 = " idproyecto = "+ nomproy +" AND ";
        }
        if(!fcinirep.equals("") && !fcfinacrep.equals("")){
        
            adicional2 = "  fechafinpr BETWEEN '"+fcinirep+"' AND '"+ fcfinacrep +"' AND ";
        }
         
        if(ccuser.equals("1")){
        consulta = new String(  " Select idproyecto, " +
                                "        nombrepr,   " +
                                "        tipopr, " +
                                "        ccdirectorpr, " +
                                "        ccresponsablepr, " +
                                "        justificacionpr, " +
                                "        Prioridadpr, " +
                                "        CONVERT(varchar(11),fechainipr,103), " +
                                "        CONVERT(varchar(11),fechafinpr,103), " +
                                "        ( Select valor from Planeacion.odi.Parametros where tipo = 1 AND Secuencial = estadopr ), " +
                                "        valorproyectadopr, " +
                                "        valorejecutadopr, " +
                                "        porcejecucionsispr, " +
                                "        porcejecuciondirpr, " +
                                "        SNIESpr, " +
                                "        observacionpr, " +
                                "        ccusucreapr, " +
                                "        idplan, " +
                                "        fechacrea, " +
                                "        estadoejecucion, " +
                                "        (Select nombreunidad from planeacion.odi.UnidadEjecutora where idunidadej =  unidadejecutora), " +
                                "        observacionadmin, " +
                                "        nivelalerta, valorejero, valorejper, valorplero, valorplper " +
                                " from Planeacion.odi.Proyecto P" +
                                " where "+adicional+adicional1+adicional2+" idplan IN ("+plan+") AND estadopr IN ("+estado+") "+
                                "  AND ( Select CASE WHEN " +
                                "                NOT EXISTS (Select distinct idejeprograma from Planeacion.odi.[Eje_Programa-Proyecto] Where idejeprograma IN (1,2,3,4,5,6,7,8) AND idproyecto = P.idproyecto "+ejeppal+") " +
                                "                Then '0' Else (Select distinct idejeprograma from Planeacion.odi.[Eje_Programa-Proyecto] Where idejeprograma IN (1,2,3,4,5,6,7,8) AND idproyecto = P.idproyecto "+ejeppal+") END ) IN ("+eje+") " +
                                                                " AND ( Select CASE WHEN NOT EXISTS (" +
                                "                                  Select top 1 estadoproyseg from Planeacion.odi.Seguimiento Where idproyecto = P.idproyecto Order by fechaseg desc" +
                                "                                 ) Then '0' Else (Select top 1 estadoproyseg from Planeacion.odi.Seguimiento Where idproyecto = P.idproyecto Order by fechaseg desc) END ) IN ("+estseg+")");
        
        }else{
        consulta = new String(  " Select idproyecto, " +
                                "        nombrepr,   " +
                                "        tipopr, " +
                                "        ccdirectorpr, " +
                                "        ccresponsablepr, " +
                                "        justificacionpr, " +
                                "        Prioridadpr, " +
                                "        CONVERT(varchar(11),fechainipr,103), " +
                                "        CONVERT(varchar(11),fechafinpr,103), " +
                                "        ( Select valor from Planeacion.odi.Parametros where tipo = 1 AND Secuencial = estadopr ), " +
                                "        valorproyectadopr, " +
                                "        valorejecutadopr, " +
                                "        porcejecucionsispr, " +
                                "        porcejecuciondirpr, " +
                                "        SNIESpr, " +
                                "        observacionpr, " +
                                "        ccusucreapr, " +
                                "        idplan, " +
                                "        fechacrea, " +
                                "        estadoejecucion, " +
                                "        (Select nombreunidad from planeacion.odi.UnidadEjecutora where idunidadej =  unidadejecutora), " +
                                "        observacionadmin, " +
                                "        nivelalerta, valorejero, valorejper, valorplero, valorplper " +
                                " from Planeacion.odi.Proyecto P" +
                                " where "+adicional+adicional2+"(ccdirectorpr = "+ccuser+" OR ccresponsablepr = "+ccuser+" OR ccusucreapr = "+ccuser+") AND idplan IN ("+plan+") AND estadopr IN ("+estado+") "+
                                "  AND ( Select CASE WHEN " +
                                "                NOT EXISTS (Select distinct idejeprograma from Planeacion.odi.[Eje_Programa-Proyecto] Where idejeprograma IN (1,2,3,4,5,6,7,8) AND idproyecto = P.idproyecto "+ejeppal+") " +
                                "                Then '0' Else (Select distinct idejeprograma from Planeacion.odi.[Eje_Programa-Proyecto] Where idejeprograma IN (1,2,3,4,5,6,7,8) AND idproyecto = P.idproyecto "+ejeppal+") END ) IN ("+eje+") " +
                                                                " AND ( Select CASE WHEN NOT EXISTS (" +
                                "                                  Select top 1 estadoproyseg from Planeacion.odi.Seguimiento Where idproyecto = P.idproyecto Order by fechaseg desc" +
                                "                                 ) Then '0' Else (Select top 1 estadoproyseg from Planeacion.odi.Seguimiento Where idproyecto = P.idproyecto Order by fechaseg desc) END ) IN ("+estseg+")");
        }
         
        try {
            conectarBD();
            retorno = consultar(consulta, 27, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
       }
     
       // Consulta objetivos del Proyecto
      public Vector ConsultaObjetivosProyecto(String idp, String tipo) {
        Vector retorno = new Vector();
        String consulta = new String();
        
        consulta = new String("Select idobjetivo, descripcionob, tipoob from planeacion.odi.Objetivo Where idproyecto = " + idp + " AND tipoob = "+tipo);

        try {
            conectarBD();
            retorno = consultar(consulta, 3, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
       }
      
      // Consulta indicadores del Proyecto
        public Vector ConsultaIndProyecto(String idp) {
        Vector retorno = new Vector();
        String consulta = new String();
        
        consulta = new String("Select idindicador, nombreind, calculoind, periodicidadind, tipoind, idproyecto, idactividad, descripcioncal from Planeacion.odi.Indicador where idproyecto= " + idp);
        try {
            conectarBD();
            retorno = consultar(consulta, 8, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
       }
      
      
      // Consulta ultimos seguimientos por año
      public Vector ConsultaSeguimientosPR(String idp) {
        Vector retorno = new Vector();
        String consulta = new String();
        
        //consulta = new String("Select YEAR(fechaseg), idseguimiento, fechaseg, prcntavanceproyseg, (Select valor from planeacion.odi.parametros Where tipo = 2 AND secuencial = estadoproyseg), estadosistemaseg, descripavanceseg, accionesseg, estadoseg, dificultadesavance, fechaenvioseg from planeacion.odi.seguimiento Where fechaseg = (Select MAX(fechaseg) from Planeacion.odi.Seguimiento Where YEAR(fechaseg) IN (Select distinct YEAR(fechaseg) from Planeacion.odi.seguimiento Where idproyecto = "+idp+") AND idproyecto = "+idp+") AND idproyecto = "+idp+" Order by fechaseg");
        consulta = new String("Select distinct  YEAR(fechaseg), idseguimiento, fechaseg, prcntavanceproyseg, " +
                                "(Select valor from planeacion.odi.parametros Where tipo = 2 AND secuencial = estadoproyseg), " +
                                " estadosistemaseg, descripavanceseg, accionesseg, estadoseg, dificultadesavance, fechaenvioseg " +
                                " from planeacion.odi.seguimiento " +
                                " Where idproyecto = "+idp+" Order by fechaseg");

        try {
            conectarBD();
            retorno = consultar(consulta, 10, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
       }
      
      
      // Consulta actividades del seguimiento ppa
      public Vector ConsultaActividadesSeg(String idseg) {
        Vector retorno = new Vector();
        String consulta = new String();
        
        consulta = new String("Select SA.idactividadseg, SA.idactividad, SA.idseguimiento, ( Select valor from Planeacion.odi.Parametros where tipo = 2 AND Secuencial = SA.estadoejecactividad ), SA.descripavance, SA.accionesact, SA.porcavanact, (Select nombreact from planeacion.odi.Actividad where idactividad = SA.idactividad) from Planeacion.odi.SegActividad SA Where idseguimiento = "+idseg+" Order by idactividad");

        try {
            conectarBD();
            retorno = consultar(consulta, 8, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
       }
      
      
      // Consulta actividades del Proyecto
        public Vector ConsultaActividades(String idp) {
        Vector retorno = new Vector();
        String consulta = new String();
        
        consulta = new String("   SELECT idactividad" +
                                "      ,nombreact" +
                                "      ,descripcionact" +
                                "      ,CONVERT(varchar(11),fechainiact,103)" +
                                "      ,CONVERT(varchar(11),fechafinact,103)" +
                                "      ,porcejecucionact" +
                                "      ,porcproyectoact" +
                                "      ,tipoact" +
                                "      ,consecutivoact" +
                                "      ,idproyecto" +
                                "  FROM Planeacion.odi.Actividad" +
                                "  Where idproyecto = " + idp + " Order by idactividad");
        try {
            conectarBD();
            retorno = consultar(consulta, 10, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
       }
      
    
}
