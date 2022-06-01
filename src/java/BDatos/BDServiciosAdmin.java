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
public class BDServiciosAdmin extends BaseDatos {

   private String mensaje;

    /** Creates a new instance of BD.. */
    public BDServiciosAdmin() {
    }


    // SELECTS BASE DE DATOS (ADMIN)
    
      // Consulta planes
     public Vector ConsultaPlanes() {
        Vector retorno = new Vector();
        String consulta = new String();
        
        consulta = new String(  "SELECT [idplan] " +
                                "      ,[nombrepl] " +
                                "      ,[estadopl] " +
                                "  FROM [Planeacion].[odi].[Planes]" );

        try {
            conectarBD();
            retorno = consultar(consulta, 3, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
       }
     
        // Consulta ejes
        public Vector ConsultaEJES() {
        Vector retorno = new Vector();
        String consulta = new String();
        
        consulta = new String(  "SELECT [idejeprograma] " +
                                "      ,[nombreep] " +
                                "      ,[objgeneralep] " +
                                "      ,[tipoep] " +
                                "      ,[estadoep] " +
                                "  FROM [Planeacion].[odi].[Eje_Programa]" );

        try {
            conectarBD();
            retorno = consultar(consulta, 5, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
       }

      // Consulta planes
        public Vector ConsultaRubros() {
        Vector retorno = new Vector();
        String consulta = new String();
        
        consulta = new String(  "SELECT [idrubropl] " +
                                "      ,[nombre] " +
                                "      ,[tipo] " +
                                "      ,[estado] " +
                                "  FROM [Planeacion].[odi].[RubrosPlaneacion]" );

        try {
            conectarBD();
            retorno = consultar(consulta, 4, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
       }
        
        // Consulta unidades ejecutoras
        public Vector ConsultaUnidades() {
        Vector retorno = new Vector();
        String consulta = new String();
        
        consulta = new String(  " SELECT [idunidadej] " +
                                "      ,[nombreunidad] " +
                                "      ,[estadounidadej] " +
                                "  FROM [Planeacion].[odi].[UnidadEjecutora]" );    

        try {
            conectarBD();
            retorno = consultar(consulta, 3, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
       }
        
        
        // Consulta parametros generales
        public Vector ConsultaParametros() {
        Vector retorno = new Vector();
        String consulta = new String();
        
        consulta = new String(  " SELECT [idparametro] " +
                                "      ,[tipo] " +
                                "      ,[valor] " +
                                "      ,[descripcion] " +
                                "      ,[secuencial] " +
                                "  FROM [Planeacion].[odi].[Parametros]" );    

        try {
            conectarBD();
            retorno = consultar(consulta, 5, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
       }
        
        
        public int CambiaEstadoPRadmin(String idp, String estado, String obsad){

        int retorno = 0 ;
        String consulta = new String();
        
        consulta = new String(" Update Planeacion.odi.Proyecto " +
                              " Set estadopr = "+estado +
                              "     ,observacionadmin = '"+ obsad +"' "+
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
        
    
    public int CambiaEstadoSeguim(String idp, String idseg, String estado){

        int retorno = 0 ;
        String consulta = new String();
        
        consulta = new String("Update Planeacion.odi.Seguimiento " +
                                "set estadoseg = " + estado +
                                "   ,fechaenvioseg  = GETDATE()" +
                                " Where idseguimiento = "+idseg+" AND idproyecto = "+idp);

        try {
            conectarBD();
            retorno = actualizar(consulta);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }
        
        
    // Consulta Centros de Costo
        public Vector ConsultaCCostOF() {
        Vector retorno = new Vector();
        String consulta = new String();
        
        consulta = new String("Select distinct cod_cl1, (Select nombre from  Novasoft.dbo.gen_clasif1 where RP.cod_cl1 = codigo) AS NCcosto from Novasoft.dbo.usr_rubros_planeacion RP Where ano_acu = YEAR(GETDATE()) AND cod_cl1 <> '0' Order by NCcosto asc");
        try {
            conectarBD();
            retorno = consultar(consulta, 2, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
       } 
        
        
        // Consulta Centros de Costo
        public Vector ConsultaRubrosCCostOF(String ccosto) {
        Vector retorno = new Vector();
        String consulta = new String();
        
        consulta = new String("Select nom_rub, cod_rub, cod_cl1, saldo, APR_FINAL from Novasoft.dbo.usr_rubros_planeacion Where cod_cl1 = '"+ccosto+"' AND ano_acu = YEAR(GETDATE()) ");
        try {
            conectarBD();
            retorno = consultar(consulta, 5, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
       }
        
        // Consulta Centros de Costo
        public Vector ConsultaDatosRubro(String ccosto) {
        Vector retorno = new Vector();
        String consulta = new String();
        
        consulta = new String("Select cod_rub, cod_cl1, saldo, APR_FINAL from Novasoft.dbo.usr_rubros_planeacion Where cod_cl1 = '"+ccosto+"' AND ano_acu = YEAR(GETDATE())");
        try {
            conectarBD();
            retorno = consultar(consulta, 4, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
       }
        
        
        // Consulta Rubros OFiciales Asociados
        public Vector ConsultaRubOF(String idp) {
        Vector retorno = new Vector();
        String consulta = new String();
        
            consulta = new String("Select EOF.iderogacionof,  (Select nombre from  Novasoft.dbo.gen_clasif1 Where codigo = CONVERT(varchar,EOF.ccosto)), (Select nom_rub from Novasoft.dbo.usr_rubros_planeacion Where cod_rub = EOF.rubro AND cod_cl1 = EOF.ccosto AND ano_acu = Year(EOF.fecharub)), EOF.tiporub, EOF.valor, EOF.fecharub, EOF.idproyecto, CONVERT(BIGINT,(Select APR_FINAL from Novasoft.dbo.usr_rubros_planeacion Where cod_rub = EOF.rubro AND cod_cl1 = EOF.ccosto AND ano_acu = Year(EOF.fecharub))), CONVERT(BIGINT,(Select saldo from Novasoft.dbo.usr_rubros_planeacion Where cod_rub = EOF.rubro AND cod_cl1 = EOF.ccosto AND ano_acu = Year(EOF.fecharub))) from [Planeacion].[odi].[ErogacionOF] EOF Where idproyecto = "+idp);
        try {
            conectarBD();
            retorno = consultar(consulta, 9, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
       }
        
        // INSERTS BD
        
        public int AddRubroOF(String ccost, String rub, String idp, String valor){

        int retorno = 0 ;
        String consulta = new String();
        
        consulta = new String(" INSERT INTO [Planeacion].[odi].[ErogacionOF] " +
                                "           ([ccosto] " +
                                "           ,[rubro] " +
                                "           ,[tiporub] " +
                                "           ,[idproyecto] " +
                                "           ,[valor] " +
                                "           ,[fecharub]) " +
                                "     VALUES " +
                                "           (" + ccost +
                                "           ," + rub +
                                "           ,1" +
                                "           ," + idp +
                                "           ," + valor +
                                "           ,GETDATE())");

        try {
            conectarBD();
            retorno = actualizar(consulta);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
     }
        
        
         // Crea nueva fecha de seguimiento
     public int RegistrarNuevaFechaSeg(String fecini, String fecfin, String feciniusu, String fecfinusu) {
        int retorno = 0;
        String consulta = new String();

        consulta = new String("INSERT INTO [Planeacion].[odi].[FechaSeguimiento]" +
                                "           ([feciniseg] " +
                                "           ,[fecfinseg] " +
                                "           ,[fechainiodi] " +
                                "           ,[fechafinodi] " +
                                "           ,[flag]) " +
                                "     VALUES " +
                                "           (convert(datetime,'" + fecini + "',103)"+
                                "           ,convert(datetime,'" + fecfin + "',103)"+
                                "           ,convert(datetime,'" + feciniusu + "',103)"+
                                "           ,convert(datetime,'" + fecfinusu + "',103)"+
                                "           ,1)");
        try {
            conectarBD();
            retorno = actualizar(consulta);
           
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
            
        desconectarBD();
        return retorno;
    }
        
           // Actualiza Estado del Proyecto
    public int CambiaEstadoFechas(){

        int retorno = 0 ;
        String consulta = new String();
        
        consulta = new String("Update Planeacion.odi.FechaSeguimiento Set flag = 0 Where flag = 1");

        try {
            conectarBD();
            retorno = actualizar(consulta);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
}

       
   // Actualiza Estado del Proyecto
    public int CambiaEstadoPR(String idp, String estado){

        int retorno = 0 ;
        String consulta = new String();
        
        consulta = new String(" Update Planeacion.odi.Proyecto " +
                              " Set estadopr = "+estado +
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
    
   // Consulta proyectos en ejecución del usuario
    public Vector ConsultarProyectosAdminEJEC() {
        Vector retorno = new Vector();
        String consulta = new String();
         consulta = new String("Select P.idproyecto, \n" +
"P.nombrepr,\n" +
"(Select nombrepl from Planeacion.odi.Planes where idplan = P.idplan), \n" +
"(Select Valor from Planeacion.odi.Parametros Where tipo = 1 AND secuencial = P.estadopr), \n" +
"P.fechacrea, \n" +
"Seg.estadoseg , \n" +
"(Select nombreunidad \n" +
"from Planeacion.odi.UnidadEjecutora Where idunidadej = P.unidadejecutora) ,\n" +
"P.megapro \n" +
"from Planeacion.odi.Proyecto P \n" +
"left JOIN Planeacion.odi.Seguimiento Seg on Seg.idproyecto=p.idproyecto and Seg.fechaseg BETWEEN (Select max(fechainiodi) \n" +
"from Planeacion.odi.FechaSeguimiento) \n" +
"AND (Select max(fechafinodi) from Planeacion.odi.FechaSeguimiento) \n" +
"where estadopr IN (5) \n" +
"AND EXISTS(Select fechainiact, fechafinact \n" +
"from Planeacion.odi.Actividad where idproyecto = P.idproyecto AND\n" +
"((Select feciniseg from Planeacion.odi.FechaSeguimiento Where flag = 1) \n" +
"BETWEEN fechainiact AND fechafinact ) OR \n" +
"(Select fecfinseg from Planeacion.odi.FechaSeguimiento Where flag = 1) BETWEEN fechainiact \n" +
"AND fechafinact )\n" +
"Order by estadoseg");
        try {
            conectarBD();
            retorno = consultar(consulta, 8, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }
        
    
       // Consulta ultimas fechas de seguimiento para activar o inactivar
    public Vector ConsultarUltFechasSeg() {
        Vector retorno = new Vector();
        String consulta = new String();
         consulta = new String("Select top 4 CONVERT(varchar(11),feciniseg,103), CONVERT(varchar(11),fecfinseg,103), CASE flag WHEN 0 THEN 'Inactivo' WHEN 1 THEN 'Activo' END, CONVERT(varchar(11),fechainiodi,103), CONVERT(varchar(11),fechafinodi,103)   FROM planeacion.odi.FechaSeguimiento Order by feciniseg desc");
        try {
            conectarBD();
            retorno = consultar(consulta, 5, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }
    
}
