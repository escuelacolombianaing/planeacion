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
public class BDEliminaDatos extends BaseDatos {

   private String mensaje;

    /** Creates a new instance of BD.. */
    public BDEliminaDatos() {
    }
       
        // Eliminar EJE de Proyecto
        public int EliminarEJE(String idp, String eje) {
        int retorno = 0;
        String consulta = new String();
     
        consulta = new String("Delete from Planeacion.odi.[Eje_Programa-Proyecto] Where idproyecto    = "+idp+" AND idejeprograma = "+ eje +
                              "  Delete from Planeacion.odi.ObjetivosEJEProyecto Where idproyecto     = "+idp+" AND idejeprograma = "+ eje +
                              "  Delete from Planeacion.odi.FinFactorCaractProyecto Where idproyecto  = "+idp+" AND eje = "+ eje);
        try {
            conectarBD();
            retorno = actualizar(consulta);
           
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
           
            
        desconectarBD();
        return retorno;
    }
        // Eliminar Objetivo General, Especifico o Meta
    public int EliminarOBJMETA(String idp, String idobj) {
        int retorno = 0;
        String consulta = new String();
     
        consulta = new String("Delete from planeacion.odi.Objetivo Where idproyecto = "+idp+" AND idobjetivo = "+idobj);
        try {
            conectarBD();
            retorno = actualizar(consulta);
           
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
           
            
        desconectarBD();
        return retorno;
    }
    
     // Eliminar Indicador Proyecto
       public int EliminarIndicadorPR(String idp, String idind) {
        int retorno = 0;
        String consulta = new String();
     
        consulta = new String("Delete from planeacion.odi.Indicador Where idindicador = "+idind+" AND idproyecto = "+idp);
        try {
            conectarBD();
            retorno = actualizar(consulta);
           
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
           
            
        desconectarBD();
        return retorno;
    }
       
       // Eliminar Indicador Actividad
       public int EliminarIndicadorAct(String act, String idind) {
        int retorno = 0;
        String consulta = new String();
     
        consulta = new String("Delete from planeacion.odi.Indicador Where idindicador = "+idind+" AND idactividad = "+act);
        try {
            conectarBD();
            retorno = actualizar(consulta);
           
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
           
            
        desconectarBD();
        return retorno;
    }
 
       // actualizar Personal y horas del personal a eliminar estado = 0 
       public int EliminarPersAct(String idpers, String act) {
        int retorno = 0;
        String consulta = new String();
     
        
          consulta = new String("Update Planeacion.odi.Personal set estado = 0 Where idpersonal = "+ idpers+ " AND idactividad = "+act+
                              " Update Planeacion.odi.Horas_Personal set horas = 0 Where idpersonal  = " + idpers);
          
                    
        /*consulta = new String("Update Planeacion.odi.Personal set estado = 0 Where idpersonal = "+ idpers+ " AND idactividad = "+act+
                              " Update Planeacion.odi.Horas_Personal set horas = 0 Where idpersonal  = " + idpers+
                              " Update Planeacion.odi.PersonalNuevoSeg set estado = 0 where idpersonalseg = "+idpers+"");*/
        try {
            conectarBD();
            retorno = actualizar(consulta);
           
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
           
            
        desconectarBD();
        return retorno;
    }
       
       /*  --------------------------------------------------------------------------------------------------------------------------  */
       
            public int EliminarPersAct2(String idpers, String act, int band) {
            int retorno = 0;
            String consulta = new String();

                if (band == 1){
                    
                    consulta = new String("Update Planeacion.odi.Personal set estado = 0 Where idpersonal = "+ idpers+ " AND idactividad = " + act);
                    
                }else if (band == 2){
                    
                    consulta = new String("Update Planeacion.odi.Personal set estado = 0 Where idpersonal = "+ idpers+ " AND idactividad = "+act+
                                  " Update Planeacion.odi.Horas_Personal set horas = 0 Where idpersonal  = " + idpers);
                }           

                                    /*consulta = new String("Update Planeacion.odi.Personal set estado = 0 Where idpersonal = "+ idpers+ " AND idactividad = "+act+
                                  " Update Planeacion.odi.Horas_Personal set horas = 0 Where idpersonal  = " + idpers+
                                  " Update Planeacion.odi.PersonalNuevoSeg set estado = 0 where idpersonalseg = "+idpers+"");*/
            try {
                conectarBD();
                retorno = actualizar(consulta);

            } catch (Exception ex) {
                mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
            }


            desconectarBD();
            return retorno;
        }
       
       
       /*  --------------------------------------------------------------------------------------------------------------------------  */
                      
     
        // actualizar Personal tabla PersonalNuevoSeg estado = 0 
       public int EliminarPersNuevoseg(String idpers, String act) {
        int retorno = 0;
        String consulta = new String();
     
             
        consulta = new String("Update Planeacion.odi.PersonalNuevoSeg set estado = 0 where idpersonalseg = "+idpers+"");
        try {
            conectarBD();
            retorno = actualizar(consulta);
           
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
           
            
        desconectarBD();
        return retorno;
    }
       
      // Eliminar Personal y horas del personal a eliminar
       public int EliminarPersonal(String idpers, String act) {
        int retorno = 0;
        String consulta = new String();
     
        consulta = new String("Delete from Planeacion.odi.Horas_Personal Where idpersonal = "+ idpers +
                                   "Delete from Planeacion.odi.Personal Where idpersonal  = " + idpers+ " AND idactividad = "+act);
        try {
            conectarBD();
            retorno = actualizar(consulta);
           
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
           
            
        desconectarBD();
        return retorno;
    }
       
      // Eliminar Rubro en PLaneación
       public int EliminarRubroPL(String idpers, String act, String idp) {
        int retorno = 0;
        String consulta = new String();
     
        consulta = new String("Delete from planeacion.odi.ErogacionPL where idproyecto = "+idp+" AND idactividad = "+act+" AND iderogacionpl = "+idpers);
        try {
            conectarBD();
            retorno = actualizar(consulta);
           
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
           
            
        desconectarBD();
        return retorno;
    }

     // Eliminar ACtividad
       public int EliminarActividad(String act) {
        int retorno = 0;
        String consulta = new String();
     
        consulta = new String(" Delete from Planeacion.odi.Horas_Personal Where idpersonal IN ("+horascons(act)+") " +
                              " Delete from Planeacion.odi.Personal where idactividad    = " + act +
                              " Delete from Planeacion.odi.ErogacionPL Where idactividad = " + act +
                              " Delete from Planeacion.odi.Indicador Where idactividad   = " + act +
                              " Delete from Planeacion.odi.Actividad where idactividad   = " + act );
        try {
            conectarBD();
            retorno = actualizar(consulta);
           
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
           
            
        desconectarBD();
        return retorno;
    }
  
        // Eliminar Archivo de la base de datos
       public int EliminarArchivo(String idarch) {
        int retorno = 0;
        String consulta = new String();
     
        consulta = new String("Delete from planeacion.odi.Archivos Where idarchivo = "+idarch);
        try {
            conectarBD();
            retorno = actualizar(consulta);
           
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
           
            
        desconectarBD();
        return retorno;
    }
       
     // Eliminar EJE de caracteristica
       public int EliminarEJECaract(String idp, String eje) {
        int retorno = 0;
        String consulta = new String();
     
        consulta = new String(" Delete from Planeacion.odi.[Eje_Programa-Proyecto] Where idproyecto = "+idp+" AND idejeprograma = "+ eje);
        try {
            conectarBD();
            retorno = actualizar(consulta);
           
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
           
            
        desconectarBD();
        return retorno;
    }
       
    // Eliminar Caracteristica del proyecto
       public int EliminarCaracteristica(String idp, String fin, String factor,String nombrecar) {
        int retorno = 0;
        String consulta = new String();
     
        consulta = new String("Delete from Planeacion.odi.FinFactorCaractProyecto where idproyecto = "+idp+" AND idfin = "+fin+" AND idfactor = "+factor+" AND nombrecaract = '"+nombrecar+"'");
        try {
            conectarBD();
            retorno = actualizar(consulta);
           
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
           
            
        desconectarBD();
        return retorno;
    }
       
   //  Consulta Horas Personal
   public String horascons(String act) {
             
        Vector retorno = new Vector();
        String consulta = new String();
         consulta = new String("SELECT STUFF((SELECT ',' + CONVERT(Varchar(20),idpersonal) FROM Planeacion.odi.Personal Where idactividad = "+act+" FOR XML PATH(''), TYPE).value('.', 'VARCHAR(MAX)'), 1, 1, '')");
        try {
            conectarBD();
            retorno = consultar(consulta, 1, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        String Ret = retorno.elementAt(0).toString();
            
        if(Ret.equals("No disponible")){
            Ret = "0";
        }
        
        return Ret;
    }
   
      //  Consulta Cantidad Factores asociado al eje
   public String ffcarac(String idp, String eje) {
             
        Vector retorno = new Vector();
        String consulta = new String();
         consulta = new String("Select COUNT(*) from Planeacion.odi.FinFactorCaractProyecto where idproyecto = "+idp+" AND eje = "+eje);
        try {
            conectarBD();
            retorno = consultar(consulta, 1, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        String Ret = retorno.elementAt(0).toString();
                
        return Ret;
    }
   
     // Cancelar Proyecto
       public int CambiarEstadoPROY(String idp) {
        int retorno = 0;
        String consulta = new String();
     
        consulta = new String(" Update Planeacion.odi.Proyecto " +
                                " Set estadopr = 7 " +
                                " Where idproyecto = "+idp);
        try {
            conectarBD();
            retorno = actualizar(consulta);
           
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
           
            
        desconectarBD();
        return retorno;
    }
       
       // Eliminar Rubro OF
     public int EliminarRubrOF(String idp, String idrubof) {
        int retorno = 0;
        String consulta = new String();
     
        consulta = new String("Delete from [Planeacion].[odi].[ErogacionOF] where idproyecto = "+idp+" AND iderogacionof = "+idrubof);
        try {
            conectarBD();
            retorno = actualizar(consulta);
           
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
           
            
        desconectarBD();
        return retorno;
    }
       
}
