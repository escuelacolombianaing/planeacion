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
public class BDServicios extends BaseDatos {

    private String mensaje;

    /**
     * Creates a new instance of BD..
     */
    public BDServicios() {
    }

//-------------------------------------------------------------
// ** Funciones Generales
    //-------------------------------------------------------------
    private String limpiarStr(String cadena) {
        cadena = cadena.replace("'", "");
        cadena = cadena.replace(" ", "");
        return cadena;
    }

    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

//-------------------------------------------------------------
// CONSULTAS BASE DATOS 
//-------------------------------------------------------------
    // Consulta verificación Login
    public Vector Login(String nomusr, String passwd) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select rtrim(cod_emp), rtrim(nom_emp), rtrim(ap1_emp), rtrim(ap2_emp), rtrim(e_mail) from odi.empnomina  Where e_mail = '" + limpiarStr(nomusr) + "' and  (est_lab='Activo' or est_lab='Vacaciones')");

        try {
            conectarBD();
            retorno = consultar(consulta, 5, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }
    //  Consulta de empleados Escuela - Revisar, posiblemente consultar vista de bd RRHH.

    public Vector usuario() {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select rtrim(cod_emp), nombres, usr_val_hora from registro.odi.empnomina  Where est_lab IN ('Activo','Vacaciones') order by nombres asc");
        try {
            conectarBD();
            retorno = consultar(consulta, 3, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    //  Cargos
    public Vector cargoseci() {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select a.cod_car, a.nom_car,b.usr_val_hora from Novasoft.dbo.rhh_cargos a left join Novasoft.dbo.usr_rhh_cargos b on a.cod_car=b.cod_car where a.cod_car in ( select distinct cod_car from novasoft.dbo.rhh_emplea where est_lab in ('01','02'))  Order by nom_car asc ");
        try {
            conectarBD();
            retorno = consultar(consulta, 3, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    //  Consulta de Empleado por Cedula Sin filtro por estado
    public String usuarioconscc2(String cc) {

        if (cc.length() <= 1) {
            return "Sin Definir";
        }

        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select cod_emp, nombres from odi.empnomina where rtrim(cod_emp)= rtrim('" + cc + "') ");
        try {
            conectarBD();
            retorno = consultar(consulta, 2, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        String Ret = retorno.elementAt(1).toString();

        return Ret;
    }

    //  Consulta de Empleado por Cedula Sin filtro por estado
    public String ConSiPerteneceAMegaPro(String idp) {

        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String(" IF EXISTS (Select idMegaPro from Planeacion.odi.MegaProyectos Where idproyecto = " + idp + ") BEGIN "
                + "         (Select idMegaPro from Planeacion.odi.MegaProyectos Where idproyecto = " + idp + ")  END "
                + " ELSE  BEGIN"
                + "         (SELECT 'NA') END ");
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

    //  Consulta de Empleado por Cedula
    public String usuarioconscc(String cc) {

        if (cc.length() <= 1) {
            return "Sin Definir";
        }

        Vector retorno = new Vector();
        String consulta = new String();

        /* Se deshabilito el 18 de Octubre de 2019, dado que no controlaba retorno de valores NULOS
         consulta = new String("Select cod_emp, nombres from odi.empnomina where cod_emp='"+cc+"' AND est_lab IN ('Activo','Vacaciones')"); */

        consulta = new String(
                "IF EXISTS(select cod_emp from registro.odi.empnomina where cod_emp = '" + cc + "' AND est_lab IN ('Activo','Vacaciones') ) "
                + "  BEGIN SELECT cod_emp, nombres FROM registro.odi.empnomina WHERE cod_emp = '" + cc + "' AND est_lab IN ('Activo','Vacaciones')  END "
                + "  ELSE (select '' [cod_emp], 'Usuario Inactivo' [nombres])");

        try {
            conectarBD();
            retorno = consultar(consulta, 2, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        String Ret = retorno.elementAt(1).toString();

        return Ret;
    }

    //  Consulta Vigencia de Proyecto
    public String vigenciaproy(String idp) {

        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select CONCAT(DATEPART(year,fechainipr),' - ', DATEPART(year,fechafinpr)) from Planeacion.odi.Proyecto where idproyecto = " + idp);
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

    //  Consulta Vigencia de Actividades
    public String vigenciaact(String idact) {

        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select CONCAT(DATEPART(year, fechainiact),' - ', DATEPART(year,fechafinact)) from Planeacion.odi.Actividad Where idactividad =  " + idact);
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

    public String signumeroarch(String idp) {

        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select IDENT_CURRENT( 'planeacion.odi.Archivos' )  ");
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

    //  Consulta de parametros
    public Vector parametros(String tipo) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select secuencial, valor from Planeacion.odi.Parametros where tipo = " + tipo + " Order by secuencial");
        try {
            conectarBD();
            retorno = consultar(consulta, 2, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }
    //  Consulta de parametro especifico

    public String parametrosEsp(String tipo, String secuencial) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select valor from Planeacion.odi.Parametros where tipo = " + tipo + " AND secuencial = " + secuencial + "");
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

    //  Consulta de año inicio del acttividad
    public String consultagnoiniact(String act) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select DATEPART(year, fechainiact) from Planeacion.odi.Actividad where idactividad = " + act);
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
    // COnsulta de persona que se acaba de agregar a la actividad

    public String consultaidperson(String act) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select max(idpersonal) from Planeacion.odi.Personal where idactividad = " + act);
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

    // COnsulta de persona que se acaba de agregar a la actividad
    public String consultaidpersonSeg(String act) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select max(idpersonalseg) from [Planeacion].[odi].[PersonalNuevoSeg] where idactividadseg = " + act);
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

    // Consultar valiores agno y valor del rubro segun el idactividad y agno
    public String consultavalorRubro(String act, String agno, String idRub) {
        Vector retorno = new Vector();
        String consulta = new String();
        String Ret;
        consulta = new String("select valor\n"
                + " from Planeacion.odi.ErogacionPL EP\n"
                + " where EP.idactividad =" + act + " and EP.agno =" + agno + " and rubropl = " + idRub);
        try {
            conectarBD();
            retorno = consultar(consulta, 1, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();

        if (retorno.size() == 0) {
            Ret = "0";
        } else {
            Ret = retorno.elementAt(0).toString();
        }
        return Ret;
    }

    // Consultar NOmbre del rubor de un proyecto
    public String nombreRubro(String act, String idproy, String idRub) {
        Vector retorno = new Vector();
        String consulta = new String();
        String Ret;
        /* consulta = new String(" SELECT STUFF((SELECT ' , ' + CONVERT(Varchar(200),EP.observacionpl) "
         + " from Planeacion.odi.ErogacionPL EP where idproyecto = "+idproy+" and rubropl = "+idRub+" and idactividad = "+act+" FOR XML PATH(''), TYPE).value('.', 'VARCHAR(MAX)'), 1, 1, '')");*/
        consulta = new String(" select observacionpl from Planeacion.odi.ErogacionPL EP where idproyecto = " + idproy + " and rubropl = " + idRub + " and idactividad = " + act);
        try {
            conectarBD();
            retorno = consultar(consulta, 1, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();

        if (retorno.size() == 0) {
            Ret = "0";
        } else {
            Ret = retorno.elementAt(0).toString();
        }
        return Ret;
    }

    public String sumaRubro(String idproy, String agno) {
        Vector retorno = new Vector();
        String consulta = new String();
        String Ret;
        consulta = new String("select ISNULL(SUM(valor),0)\n"
                + " from Planeacion.odi.ErogacionPL EP\n"
                + " where EP.idproyecto = " + idproy + " and EP.agno = " + agno);
        try {
            conectarBD();
            retorno = consultar(consulta, 1, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();

        if (retorno.size() == 0) {
            Ret = "0";
        } else {
            Ret = retorno.elementAt(0).toString();
        }
        return Ret;
    }

    /*public Vector consultavalorRubro(String act, String agno) {
     Vector retorno = new Vector();
     String consulta = new String();
     consulta = new String ("select valor\n" + 
     " from Planeacion.odi.ErogacionPL EP\n" +
     " where EP.idactividad ="+act+" and EP.agno ="+agno);
     try {
     conectarBD();
     retorno = consultar(consulta, 1, 0);
     } catch (Exception ex) {
     mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
     }
     desconectarBD();
     return retorno;
     }*/
    // Consultar valores dedicacion personal por actividad y año
    public String consultavalordedper(String act, String agno) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select ISNULL(sum((H.horas*P.valorprs)*isnull(replace(H.CantPer,'          ',1),1)),0) from Planeacion.odi.Personal P, Planeacion.odi.Horas_Personal H "
                + "Where idactividad = " + act + " AND P.idpersonal = H.idpersonal AND H.agno = " + agno);
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
    // Consultar valores erogacion

    public String consultavalorerog(String act, String agno) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select ISNULL(SUM(valor),0) from Planeacion.odi.ErogacionPL where idactividad = " + act + " AND agno = " + agno);
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

    // COnsulta de persona que se acaba de agregar a la actividad
    public String consultaiderogacion(String act) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select * from Planeacion.odi.ErogacionPL where idactividad = " + act);
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

    //  Consulta de nombre del plan
    public String nombreplan(String id) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select nombrepl from Planeacion.odi.Planes where idplan = " + id);
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
    // Consulta Centros de Costo conocidos como SNIES Activos en Novasoft

    public Vector SNIES_CCosto() {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select cod_cco, nom_cco from Novasoft.dbo.gen_ccosto where est_cco = 1 Order by nom_cco");
        try {
            conectarBD();
            retorno = consultar(consulta, 2, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }
    // Consulta Centros de Costo conocidos como SNIES Activos en Novasoft

    public Vector PreRubrosPL() {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select idrubropl, nombre from Planeacion.odi.RubrosPlaneacion Order by nombre asc");
        try {
            conectarBD();
            retorno = consultar(consulta, 2, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta actividad, rubro y observacion de un proyecto determinado
    public Vector ConsultaRubros(String id) {
        Vector retorno = new Vector();
        String consulta = new String();
        /*   consulta = new String("  select A.idactividad, A.nombreact Actividad, RP.nombre rubro,observacionpl, RP.idrubropl \n" +
         " from Planeacion.odi.ErogacionPL EP, Planeacion.odi.RubrosPlaneacion RP, Planeacion.odi.Actividad A\n" +
         " where RP.idrubropl = EP.rubropl and A.idactividad = EP.idactividad and EP.idproyecto = "+id+" group by A.idactividad,A.nombreact,RP.nombre,observacionpl, RP.idrubropl");*/

        consulta = new String("  select A.idactividad, A.nombreact Actividad, RP.nombre rubro,RP.idrubropl \n"
                + " from Planeacion.odi.ErogacionPL EP, Planeacion.odi.RubrosPlaneacion RP, Planeacion.odi.Actividad A\n"
                + " where RP.idrubropl = EP.rubropl and A.idactividad = EP.idactividad and EP.idproyecto = " + id + " group by A.idactividad,A.nombreact,RP.nombre,RP.idrubropl");
        try {
            conectarBD();
            retorno = consultar(consulta, 4, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }
    // Consulta de planes activos en base de datos planeación (Local) 

    public Vector Planes() {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select idplan, nombrepl from Planeacion.odi.Planes Where estadopl = 1 Order by nombrepl");
        try {
            conectarBD();
            retorno = consultar(consulta, 2, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }
    //Consulta EJES

    public Vector EJES() {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select idejeprograma, nombreep from Planeacion.odi.Eje_Programa Where estadoep = 1");
        try {
            conectarBD();
            retorno = consultar(consulta, 2, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta de fines
    public Vector fines(String relacion) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select idfactor, nombrefacfin, secuencial, relacionfin from Planeacion.odi.Factores_Fines where relacionfin = " + relacion + " AND relacionfactor = 0 AND tipofac = 0");
        try {
            conectarBD();
            retorno = consultar(consulta, 4, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta de Factro fin por nombre
    public Vector fines2(String Nombre) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select idfactor, nombrefacfin, secuencial, relacionfin from Planeacion.odi.Factores_Fines where nombrefacfin = '" + Nombre + "' AND relacionfactor = 0 AND tipofac = 0 AND relacionfin = 0");
        try {
            conectarBD();
            retorno = consultar(consulta, 4, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta de caracteristicas - (fin - factor)
    public Vector caracteristicas(String relacionfin, String relacionfactor) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select idfactor, nombrefacfin, secuencial, relacionfin, relacionfactor from Planeacion.odi.Factores_Fines Where relacionfin = (" + relacionfactor + "+1) AND relacionfactor = " + relacionfin);
        try {
            conectarBD();
            retorno = consultar(consulta, 5, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }
    // Consulta de eje (fac - fin - caracteristica)

    public Vector consultaejefactorCaracter(String relacionfin, String relacionfactor, String nombrecaract) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select distinct eje, facintegral from planeacion.odi.Factores_Fines Where relacionfin = (" + relacionfactor + "+1) AND relacionfactor = " + relacionfin + " AND  nombrefacfin = '" + nombrecaract + "'");
        try {
            conectarBD();
            retorno = consultar(consulta, 2, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }
    // Consulta de fines - factor

    public String finesEspec(String secuencial, String fin) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select idfactor, nombrefacfin, secuencial, relacionfin from Planeacion.odi.Factores_Fines where secuencial = " + secuencial + " AND relacionfin= " + fin);
        try {
            conectarBD();
            retorno = consultar(consulta, 4, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno.elementAt(1).toString();
    }

    // Consulta estado ultimo seguimiento proyecto plan
    public String ConEstadosSeguimientoProyectosPlan(String plan, String tipo, String estado) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("        Select COUNT(*)\n"
                + "        from Planeacion.odi.Seguimiento Where \n"
                + "        idseguimiento IN (Select ISNULL((Select max(idseguimiento) from Planeacion.odi.Seguimiento Where idproyecto = P.idproyecto),0) from Planeacion.odi.Proyecto P Where idplan = " + plan + " AND estadopr IN (" + estado + ")) "
                + "        AND estadoproyseg IN(" + tipo + ")");
        try {
            conectarBD();
            retorno = consultar(consulta, 1, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno.elementAt(0).toString();
    }

    // Consulta estado ultimo seguimiento proyecto EJE
    public String ConEstadosSeguimientoProyectosEJE(String eje, String tipo, String estado) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("        Select COUNT(*) "
                + "        from Planeacion.odi.Seguimiento Where "
                + "        idseguimiento IN (Select ISNULL((Select max(idseguimiento) from Planeacion.odi.Seguimiento Where idproyecto = P.idproyecto),0) from Planeacion.odi.Proyecto P Where estadopr IN (" + estado + ") AND idproyecto IN (Select idproyecto from Planeacion.odi.[Eje_Programa-Proyecto] Where ejeppal = 1 AND idejeprograma = " + eje + ")) "
                + "        AND estadoproyseg IN(" + tipo + ")");
        try {
            conectarBD();
            retorno = consultar(consulta, 1, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno.elementAt(0).toString();
    }

    // Consulta de caracteristicas y factores del proyecto
    public Vector ConsultaCarFac(String idp) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("    Select idproyecto, (Select nombrefacfin from Planeacion.odi.Factores_Fines where secuencial = CP.idfin AND relacionfin = 0 AND relacionfactor = 0 AND tipofac = 0 ), "
                + "                       (Select nombrefacfin from Planeacion.odi.Factores_Fines where secuencial = CP.idfactor AND relacionfin = CP.idfin AND relacionfactor = 0 AND tipofac = 0 ), "
                + "                       nombrecaract, "
                + "                       (Select nombrefacfin from Planeacion.odi.Factores_Fines where secuencial = CP.idfactintegral AND relacionfin = 0 AND relacionfactor = 0 AND tipofac = 1), "
                + "                       eje,   idfin, idfactor"
                + "                       from planeacion.odi.FinFactorCaractProyecto CP "
                + "       Where idproyecto = " + idp);
        try {
            conectarBD();
            retorno = consultar(consulta, 8, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta de archivos del proyecto
    public Vector Consultafiles(String idp) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select A.idarchivo, A.nombrearc, A.nombreorig, A.estado, (Select Valor from Planeacion.odi.Parametros Where tipo = 5 AND secuencial = A.tipocargue), A.observacion from Planeacion.odi.Archivos A Where seguimiento = 0 AND idproyecto = " + idp + "and nombrearc not like 'adm%'");
        try {
            conectarBD();
            retorno = consultar(consulta, 6, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta de archivos de observaciones administrador
    public Vector Consultafilesobs(String idp) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select A.idarchivo, A.nombrearc, A.nombreorig, A.estado, (Select Valor from Planeacion.odi.Parametros Where tipo = 5 AND secuencial = A.tipocargue), A.observacion from Planeacion.odi.Archivos A Where seguimiento = 0 AND idproyecto = " + idp + "and nombrearc like 'adm%'");
        try {
            conectarBD();
            retorno = consultar(consulta, 6, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }
    // Consulta de archivos del proyecto

    public Vector ConsultafilesSeg(String idp, String idact, String idseg) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select A.idarchivo, A.nombrearc, A.nombreorig, A.estado, (Select Valor from Planeacion.odi.Parametros Where tipo = 5 AND secuencial = A.tipocargue), A.observacion from Planeacion.odi.Archivos A Where nombrearc like 's%' AND idactividad = " + idact + " AND idproyecto = " + idp + " AND seguimiento = " + idseg);
        try {
            conectarBD();
            retorno = consultar(consulta, 6, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta unidades ejecutoras
    public Vector Consultaunidades() {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select idunidadej, nombreunidad from Planeacion.odi.UnidadEjecutora where estadounidadej = 1 Order by nombreunidad");
        try {
            conectarBD();
            retorno = consultar(consulta, 2, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta todos los nombres de los proyectos
    public Vector ConsultanomProy() {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("select P.idproyecto,P.nombrepr from Planeacion.odi.Proyecto P Order by P.idproyecto asc");
        try {
            conectarBD();
            retorno = consultar(consulta, 2, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta unidades ejecutoras
    public Vector ConsultaProyectosMegaPro() {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select idproyecto, nombrepr from Planeacion.odi.Proyecto Where idproyecto NOT IN (Select idproyecto from Planeacion.odi.MegaProyectos) AND estadopr IN (1,2,3,4,5) Order by nombrepr");
        try {
            conectarBD();
            retorno = consultar(consulta, 2, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta unidades ejecutoras
    public Vector ConsultaProyectosAsociadosMegaPro(String idp) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select idproyecto, nombrepr, CONVERT(varchar(11),fechainipr,103), CONVERT(varchar(11),fechafinpr,103), isnull((Select top 1 prcntavanceproyseg from Planeacion.odi.Seguimiento Where idproyecto = P.idproyecto Order by idseguimiento desc),0) from Planeacion.odi.Proyecto P Where idproyecto IN (Select idproyecto from [Planeacion].[odi].[MegaProyectos] Where idMegapro = " + idp + ")");
        try {
            conectarBD();
            retorno = consultar(consulta, 5, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta unidades ejecutoras
    public Vector ConsultaValoresPlanReporteGen(String idplan, String idunidad, String estado) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String(" IF (Select COUNT(*) from Planeacion.odi.Proyecto Where estadopr IN (" + estado + ") AND idplan = " + idplan + " AND unidadejecutora = " + idunidad + ") > 0 "
                + " BEGIN "
                + "    ( Select  ISNULL(SUM(valorplper),0) as PerPlaneado, "
                + "        ISNULL(SUM(valorejper),0) as PerEjecutado, "
                + "        Convert(Decimal(15,4),((CAST(ISNULL(SUM(valorejper),0) as decimal) *100/CAST(ISNULL(SUM(valorplper),0)as decimal)) )) as PPer,  "
                + "        ISNULL(SUM(valorplero),0) as EroPlaneado, "
                + "        ISNULL(SUM(valorejero),0) as EroEjecutado, "
                + "        Convert(Decimal(15,4),((CAST(ISNULL(SUM(valorejero),0) as decimal) *100/CAST(ISNULL(SUM(valorplero),0) as decimal)) )) as PEro,  "
                + "        ISNULL(SUM(valorproyectadopr),0) as TotalPlan, "
                + "        ISNULL(SUM(valorejecutadopr),0) as TotalEjec, "
                + "        COUNT(*) as Cantidad "
                + "        from Planeacion.odi.Proyecto Where estadopr IN (" + estado + ") AND idplan = " + idplan + " AND unidadejecutora = " + idunidad + " ) "
                + " END");
        try {
            conectarBD();
            retorno = consultar(consulta, 8, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta por eje
    public Vector ConsultaValoresEJEReporteGen(String ideje, String idunidad, String estado) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String(" IF ((Select COUNT(*) from Planeacion.odi.Proyecto  where estadopr IN (" + estado + ") AND idproyecto IN (Select idproyecto from Planeacion.odi.[Eje_Programa-Proyecto] Where idejeprograma = " + ideje + "  AND ejeppal = 1) AND unidadejecutora = " + idunidad + ")) > 0  "
                + " BEGIN "
                + "    ( Select  ISNULL(SUM(valorplper),0) as PerPlaneado, "
                + "        ISNULL(SUM(valorejper),0) as PerEjecutado, "
                + "        Convert(Decimal(15,4),((CAST(ISNULL(SUM(valorejper),0)as decimal) *100/CAST(ISNULL(SUM(valorplper),0)as decimal)) )) as PPer,  "
                + "        ISNULL(SUM(valorplero),0) as EroPlaneado, "
                + "        ISNULL(SUM(valorejero),0) as EroEjecutado, "
                + "        Convert(Decimal(15,4),((CAST(ISNULL(SUM(valorejero),0) as decimal) *100/CAST(ISNULL(SUM(valorplero),0) as decimal)) )) as PEro,  "
                + "        ISNULL(SUM(valorproyectadopr),0) as TotalPlan, "
                + "        ISNULL(SUM(valorejecutadopr),0) as TotalEjec, "
                + "        COUNT(*) as Cantidad "
                + "        from Planeacion.odi.Proyecto Where estadopr IN (" + estado + ") AND idproyecto IN ((Select idproyecto from Planeacion.odi.Proyecto  where idproyecto IN (Select idproyecto from Planeacion.odi.[Eje_Programa-Proyecto] Where idejeprograma = " + ideje + "  AND ejeppal = 1) AND unidadejecutora = " + idunidad + ")))  "
                + " END");
        try {
            conectarBD();
            retorno = consultar(consulta, 8, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta por eje
    public Vector ConsultaProyectosGeneral() {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select  P.idproyecto, "
                + "        P.nombrepr, "
                + "        ISNULL(CONVERT(varchar(11),fechainipr,103),'') As FechaInicio, "
                + "        ISNULL(CONVERT(varchar(11),fechafinpr,103),'') As FechaFin, "
                + "        (Select nombrepl from planeacion.odi.Planes Where idplan = P.idplan) As Planes, "
                + "        ISNULL((Select valor from Planeacion.odi.Parametros Where tipo = 3 AND secuencial = P.Prioridadpr),'') As Prioridad, "
                + "        ISNULL((Select nombreunidad from planeacion.odi.UnidadEjecutora Where idunidadej = P.unidadejecutora),'') As UnidadEjecutora, "
                + "        ISNULL((Select nombres from registro.odi.empnomina Where cod_emp = P.ccdirectorpr),'') As Director, "
                + "        ISNULL((Select nombres from registro.odi.empnomina Where cod_emp = P.ccresponsablepr),'') As Responsable, "
                + "        (Select valor from Planeacion.odi.Parametros Where tipo = 1 AND secuencial = P.estadopr) As Estado, "
                + "        '----' As EstadoEJEC, "
                + "        ISNULL(P.valorplper,0) As PersonalPlaneado, "
                + "        ISNULL(P.valorejper,0) As PersonalEjecutado, "
                + "        ISNULL(P.valorplero,0) As ErogacionPlaneada, "
                + "        ISNULL(P.valorejero,0) As ErogacionEjecutada, "
                + "        ISNULL(P.valorproyectadopr,0) As ValorTotalPL, "
                + "        ISNULL(P.valorejecutadopr,0) As ValorTotalEJE, "
                + "        CASE WHEN valorplper > 1 THEN ISNULL(((ISNULL(P.valorejper,0)*100)/ISNULL(P.valorplper,0)),0) ELSE '-' END As PorcPersonalEjec,"
                + "        CASE WHEN valorplero > 1 THEN ISNULL(((ISNULL(P.valorejero,0)*100)/ISNULL(P.valorplero,0)),0) ELSE '-' END As PorcPersonalPlan, "
                + "        CASE WHEN valorproyectadopr > 1 THEN ISNULL(((ISNULL(P.valorejecutadopr,0)*100)/ISNULL(P.valorproyectadopr,0)),0) ELSE '-' END As PorcPersonalPlan "
                + "from Planeacion.odi.Proyecto P");
        try {
            conectarBD();
            retorno = consultar(consulta, 20, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta horas por persona cada año
    public Vector ConsultarHoras(String idpersonal) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select agno, horas, rtrim(CantPer) from Planeacion.odi.Horas_Personal Where idpersonal = " + idpersonal + " Order by agno asc");
        try {
            conectarBD();
            retorno = consultar(consulta, 3, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta horas por persona cada año
    public Vector ConsultarHorasSeg(String idpersonal) {
        Vector retorno = new Vector();
        String consulta = new String();
        // consulta = new String("Select ISNULL(agno, YEAR(GETDATE())), ISNULL(horas,0) from Planeacion.odi.Horas_Personal Where idpersonal = "+idpersonal+" UNION (Select YEAR(GETDATE()), '0')");
        consulta = new String("Select ISNULL(agno, YEAR(GETDATE())), ISNULL(horas,0) from Planeacion.odi.Horas_Personal Where idpersonal = " + idpersonal);
        try {
            conectarBD();
            retorno = consultar(consulta, 2, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta horas por persona cada año
    public String ConsultarAgnoHorasSeg(String idseg) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select year(dateadd(month,2,fechaseg)) from Planeacion.odi.Seguimiento Where idseguimiento="+idseg);
        try {
            conectarBD();
            retorno = consultar(consulta, 1, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno.elementAt(0).toString();
    }

    // Consulta del id del ultimo proyecto creado por el usuario
    public Vector LastProyectUser(String codemp) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select max(idproyecto) from Planeacion.odi.Proyecto where ccusucreapr = '" + codemp + "'");

        try {
            conectarBD();
            retorno = consultar(consulta, 1, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }
    // Consulta el id de la ultima actividad

    public String LastActivtPr(String idp) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select max(idactividad) from planeacion.odi.actividad where idproyecto = " + idp);

        try {
            conectarBD();
            retorno = consultar(consulta, 1, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno.elementAt(0).toString();
    }
    // Consulta proyectos creados por usuario

    public Vector ConsultarProyectosUsuario(String CCUser) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select P.idproyecto, P.nombrepr, (Select nombrepl from Planeacion.odi.Planes where idplan = P.idplan), (Select Valor from Planeacion.odi.Parametros Where tipo = 1 AND secuencial = P.estadopr), P.fechacrea, megapro from Planeacion.odi.Proyecto P where (ccusucreapr = '" + CCUser + "' OR ccdirectorpr = '" + CCUser + "' OR ccresponsablepr = '" + CCUser + "') AND estadopr IN (1,2,3,4,5) Order by estadopr desc, nombrepr asc");
        try {
            conectarBD();
            retorno = consultar(consulta, 6, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta proyectos en ejecución del usuario
    public Vector ConsultarProyectosUsuarioEJEC(String CCUser) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select P.idproyecto, P.nombrepr, (Select nombrepl from Planeacion.odi.Planes where idplan = P.idplan), (Select Valor from Planeacion.odi.Parametros Where tipo = 1 AND secuencial = P.estadopr), P.fechacrea, P.megapro from Planeacion.odi.Proyecto P where (ccusucreapr = '" + CCUser + "' OR ccdirectorpr = '" + CCUser + "' OR ccresponsablepr = '" + CCUser + "') AND estadopr IN (5) AND EXISTS(Select fechainiact, fechafinact from Planeacion.odi.Actividad where idproyecto = P.idproyecto AND ((Select feciniseg from Planeacion.odi.FechaSeguimiento Where flag = 1) BETWEEN fechainiact AND fechafinact ) OR (Select fecfinseg from Planeacion.odi.FechaSeguimiento Where flag = 1) BETWEEN fechainiact AND fechafinact ) ");
        try {
            conectarBD();
            retorno = consultar(consulta, 6, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta proyectos en ejecución del usuario
    public Vector ConsultarProyectosUsuarioEJECINVOL(String CCUser) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select P.idproyecto, P.nombrepr, (Select nombrepl from Planeacion.odi.Planes where idplan = P.idplan), (Select Valor from Planeacion.odi.Parametros Where tipo = 1 AND secuencial = P.estadopr), P.fechacrea from Planeacion.odi.Proyecto P where idproyecto IN (Select distinct idproyecto from Planeacion.odi.Actividad where rtrim(responsableact) = rtrim('" + CCUser + "')) AND estadopr IN (5) AND EXISTS(Select fechainiact, fechafinact from Planeacion.odi.Actividad where idproyecto = P.idproyecto AND GETDATE() BETWEEN fechainiact AND fechafinact ) ");
        try {
            conectarBD();
            retorno = consultar(consulta, 5, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consultar estado de seguimiento
    public Vector ConsultarEstadoSeg(String idp) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select idseguimiento, estadoseg from Planeacion.odi.Seguimiento where fechaseg BETWEEN (Select max(fechainiodi) from Planeacion.odi.FechaSeguimiento) AND (Select max(fechafinodi) from Planeacion.odi.FechaSeguimiento) AND idproyecto = " + idp);
        try {
            conectarBD();
            retorno = consultar(consulta, 2, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consultar estado de seguimiento
    public Vector ConsultarUltFechaSeg() {
        Vector retorno = new Vector();
        String consulta = new String();
        /*consulta = new String("SELECT top 1 feciniseg, fecfinseg, CASE WHEN flag = '1' AND GETDATE() Between fechainiodi AND fechafinodi THEN '1' ELSE '0' END FROM planeacion.odi.FechaSeguimiento Order by feciniseg desc");*/
        consulta = new String("SELECT TOP 1 feciniseg, fecfinseg, CASE WHEN GETDATE() Between fechainiodi AND fechafinodi THEN '1' ELSE '0' END FROM planeacion.odi.FechaSeguimiento ORDER BY fecfinseg DESC");
        //Se ajusta consulta el 30 de Agosto de 2019
        //CASE WHEN flag = '1' AND CONVERT(VARCHAR(10), GETDATE(), 103) Between fechainiodi AND fechafinodi THEN '1' ELSE '0' END 
        try {
            conectarBD();
            retorno = consultar(consulta, 3, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta proyectos creados por usuario
    public Vector ConsultaALLProyectosUser(String CCUser) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select P.idproyecto, P.nombrepr, (Select nombrepl from Planeacion.odi.Planes where idplan = P.idplan), (Select Valor from Planeacion.odi.Parametros Where tipo = 1 AND secuencial = P.estadopr), P.fechacrea, P.megapro from Planeacion.odi.Proyecto P where (ccusucreapr = '" + CCUser + "' OR ccdirectorpr = '" + CCUser + "' OR ccresponsablepr = '" + CCUser + "') and estadopr > 0 Order by estadopr asc, nombrepr asc");
        try {
            conectarBD();
            retorno = consultar(consulta, 6, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }
    // Consulta proyectos por estado

    public Vector ConsultarProyectosEstado() {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select P.idproyecto, P.nombrepr, (Select nombrepl from Planeacion.odi.Planes where idplan = P.idplan), (Select Valor from Planeacion.odi.Parametros Where tipo = 1 AND secuencial = P.estadopr), P.fechacrea, (Select nombreunidad from Planeacion.odi.UnidadEjecutora Where idunidadej = P.unidadejecutora), megapro from Planeacion.odi.Proyecto P where estadopr IN (1,2,3,4,5) Order by estadopr desc, nombrepr asc");
        try {
            conectarBD();
            retorno = consultar(consulta, 7, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta todos los proyectos
    public Vector ConsultarTotalProyectos() {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select P.idproyecto, P.nombrepr, (Select nombrepl from Planeacion.odi.Planes where idplan = P.idplan), (Select Valor from Planeacion.odi.Parametros Where tipo = 1 AND secuencial = P.estadopr), P.fechacrea, (Select nombreunidad from Planeacion.odi.UnidadEjecutora Where idunidadej = P.unidadejecutora), P.megapro from Planeacion.odi.Proyecto P Order by estadopr desc, nombrepr asc");
        try {
            conectarBD();
            retorno = consultar(consulta, 7, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consultar tipo rubro en planeación
    public String ConsultaTipoRubro(String rubro) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String(" Select tipo from Planeacion.odi.RubrosPlaneacion where idrubropl = " + rubro);

        try {
            conectarBD();
            retorno = consultar(consulta, 1, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();

        String valor = retorno.elementAt(0).toString();

        return valor;
    }
    // Consutlar datos basicos del proyecto 

    public Vector ConsultaDatosProyecto(String idp) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String(" Select nombrepr, estadopr, estadoejecucion, idplan, SNIESpr, Prioridadpr, rtrim(ccdirectorpr), rtrim(ccresponsablepr), "
                + "       CONVERT(varchar(11),fechainipr,103), CONVERT(varchar(11),fechafinpr,103), CONVERT(varchar(11),fechacrea,103), valorproyectadopr, valorejecutadopr, porcejecucionsispr, porcejecuciondirpr , "
                + "       metapr, justificacionpr, rtrim(ccusucreapr), unidadejecutora, observacionadmin, (Select valor from Planeacion.odi.Parametros where tipo = 3 AND secuencial = Prioridadpr), megapro from Planeacion.odi.Proyecto where idproyecto = " + idp);

        try {
            conectarBD();
            retorno = consultar(consulta, 22, 0);
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

        consulta = new String("Select idobjetivo, descripcionob, tipoob from planeacion.odi.Objetivo Where idproyecto = " + idp + " AND tipoob = " + tipo);

        try {
            conectarBD();
            retorno = consultar(consulta, 3, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta personal de la actividad
    public Vector ConsultaPersonal(String idact, String idactseg) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select idpersonal, nombreparticpprs, cargoparticprs, ISNULL(valorprs,0), '1' from Planeacion.odi.Personal where estado = 1 and idactividad = " + idact + " UNION Select idpersonalseg, nombreparticpseg, cargoparticseg, ISNULL(valorprsseg,0), '2' from Planeacion.odi.PersonalNuevoSeg Where estado = 1 and idactividadseg = " + idactseg);
        try {
            conectarBD();
            retorno = consultar(consulta, 5, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta estado del personal de la actividad
    public Vector ConsultaPersonalEst(String idper) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select estado from Planeacion.odi.Personal where idpersonal = " + idper);
        try {
            conectarBD();
            retorno = consultar(consulta, 5, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta indicadores de la actividad
    public Vector ConsultaIndActividad(String idact) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select idindicador, nombreind, calculoind, periodicidadind, tipoind, idproyecto, idactividad, descripcioncal from Planeacion.odi.Indicador where idactividad = " + idact);
        try {
            conectarBD();
            retorno = consultar(consulta, 8, 1);
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

    // Consulta seguimientos del MegaProyecto
    public Vector ConsultaSegMegaPro(String idseg) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select S.idproyecto, "
                + "       (Select nombrepr from Planeacion.odi.Proyecto Where idproyecto = S.idproyecto), "
                + "       (Select CONVERT(varchar(11),fechainipr,103) from Planeacion.odi.Proyecto Where idproyecto = S.idproyecto), "
                + "       (Select CONVERT(varchar(11),fechafinpr,103) from Planeacion.odi.Proyecto Where idproyecto = S.idproyecto), CONVERT(varchar(11),S.fechaseg,103),"
                + "       CASE S.estadoseg WHEN 1 THEN 'Incompleto' WHEN 2 THEN 'Completado' ELSE 'Error' END, "
                + "       S.prcntavanceproyseg, S.idseguimiento, isnull((Select valor from Planeacion.odi.Parametros Where tipo =  2 AND secuencial = S.estadoproyseg),'No disponible') "
                + "from Planeacion.odi.Seguimiento S "
                + "Where idseguimiento IN (Select idsegsubproyecto from Planeacion.odi.RegSegMegaPro Where idseguimiento = " + idseg + ")");
        try {
            conectarBD();
            retorno = consultar(consulta, 9, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta cargo y valor hora
    public Vector ConsultaCargoValor(String cc) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select (Select nom_car from novasoft.dbo.rhh_cargos Where cod_car = EM.cod_car ), ISNULL(EM.usr_val_hora,0) from registro.odi.empnomina EM where cod_emp = '" + cc + "'");
        try {
            conectarBD();
            retorno = consultar(consulta, 2, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta cargo y valor hora
    public Vector ConsultaValorCar(String codcar) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select a.cod_car, a.nom_car, ISNULL(b.usr_val_hora,0) from Novasoft.dbo.rhh_cargos a inner join Novasoft.dbo.usr_rhh_cargos b on a.cod_car=b.cod_Car Where a.cod_car = " + codcar);
        try {
            conectarBD();
            retorno = consultar(consulta, 3, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta personal de la actividad
    public int Consultaagnofechas(String idact) {
        Vector retorno = new Vector();
        String consulta = new String();
        int ret = 0;

        consulta = new String("Select (DATEDIFF(year,fechainiact, fechafinact)+1) from Planeacion.odi.Actividad where idactividad = " + idact);
        try {
            conectarBD();
            retorno = consultar(consulta, 1, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();

        ret = Integer.parseInt(retorno.elementAt(0).toString());

        return ret;
    }

    // Consulta EJE PROGRAMA
    public Vector ConsultaEJE() {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select idejeprograma, nombreep from planeacion.odi.Eje_Programa");
        try {
            conectarBD();
            retorno = consultar(consulta, 2, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta EJE(s) Asociados al Proyecto
    public Vector ConsultaEJEasociado(String idp) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select idejeprograma, ejeppal, (Select nombreep from Planeacion.odi.Eje_Programa Where idejeprograma = EP.idejeprograma) from Planeacion.odi.[Eje_Programa-Proyecto] EP Where idproyecto = " + idp + " Order by ejeppal desc, idejeprograma ");
        try {
            conectarBD();
            retorno = consultar(consulta, 3, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta verificacion de eje asociado
    public Vector ConsultaVerificaEJE(String idp, String eje) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select idproyecto from planeacion.odi.[Eje_Programa-Proyecto] Where idproyecto = " + idp + " AND idejeprograma = " + eje);
        try {
            conectarBD();
            retorno = consultar(consulta, 1, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta Objetivos Especificos EJE
    public Vector ConsultaObjEspecEJE(String ideje) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select numeroobj, descripcion, idejeprograma from Planeacion.odi.ObjetivosEJE where idejeprograma = " + ideje);
        try {
            conectarBD();
            retorno = consultar(consulta, 3, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta personal de la actividad
    public Vector ConsultaDatosEJE(String ideje) {
        Vector retorno = new Vector();
        String consulta = new String();
        int ret = 0;

        consulta = new String("Select idejeprograma, nombreep, objgeneralep, tipoep, estadoep from Planeacion.odi.Eje_Programa Where idejeprograma = " + ideje);
        try {
            conectarBD();
            retorno = consultar(consulta, 5, 0);
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

        consulta = new String("   SELECT idactividad"
                + "      ,nombreact"
                + "      ,descripcionact"
                + "      ,CONVERT(varchar(11),fechainiact,103)"
                + "      ,CONVERT(varchar(11),fechafinact,103)"
                + "      ,porcejecucionact"
                + "      ,porcproyectoact"
                + "      ,tipoact"
                + "      ,consecutivoact"
                + "      ,idproyecto"
                + "  FROM Planeacion.odi.Actividad"
                + "  Where idproyecto = " + idp + " Order by consecutivoact");
        try {
            conectarBD();
            retorno = consultar(consulta, 10, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta actividades del Proyecto
    public Vector ConsultaActividadesMegaPro(String idp) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("   SELECT idactividad"
                + "      ,nombreact"
                + "      ,descripcionact"
                + "      ,CONVERT(varchar(11),fechainiact,103)"
                + "      ,CONVERT(varchar(11),fechafinact,103)"
                + "      ,porcejecucionact"
                + "      ,porcproyectoact"
                + "      ,tipoact"
                + "      ,consecutivoact"
                + "      ,idproyecto"
                + "     ,(Select nombrepr from Planeacion.odi.Proyecto Where idproyecto = A.idproyecto)"
                + "  FROM Planeacion.odi.Actividad A"
                + "  Where idproyecto IN (Select idproyecto from Planeacion.odi.MegaProyectos Where idMegaPro = " + idp + ") Order by consecutivoact");
        try {
            conectarBD();
            retorno = consultar(consulta, 11, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta actividades del Proyecto
    public Vector ConsultaPersonasAgno(String act, String agno) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select COUNT(*) from planeacion.odi.Horas_Personal P Where idpersonal IN (Select idpersonal from Planeacion.odi.Personal Where idactividad = " + act + ") AND agno = " + agno);
        try {
            conectarBD();
            retorno = consultar(consulta, 4, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta actividades del Proyecto
    public Vector ConsultaProyAsociadosMegapro(String idp) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select idproyecto from Planeacion.odi.MegaProyectos Where idMegaPro = (Select idproyecto from Planeacion.odi.Proyecto Where idproyecto = " + idp + " AND megapro = 'M')");
        try {
            conectarBD();
            retorno = consultar(consulta, 1, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta personal para reporte 1
    public Vector ConsultaPersonalRep1(String act) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select agno, ISNULL((Select nombres from odi.empnomina where cod_emp = (Select nombreparticpprs from Planeacion.odi.Personal Where idpersonal = P.idpersonal)), 'Sin Definir'), (Select cargoparticprs from Planeacion.odi.Personal Where idpersonal = P.idpersonal), horas, '0'  from planeacion.odi.Horas_Personal P Where idpersonal IN (Select idpersonal from Planeacion.odi.Personal Where idactividad = " + act + ") Order by agno ");
        try {
            conectarBD();
            retorno = consultar(consulta, 5, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta Presupuesto Reporte 1
    public Vector ConsultaPresupuestoRep1(String act) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select EP.iderogacionpl, (Select valor from Planeacion.odi.Parametros where tipo = 4 and secuencial = CONVERT(int, EP.tiporubpl)), (Select nombre from Planeacion.odi.RubrosPlaneacion Where idrubropl = EP.rubropl), '', EP.observacionpl, (Select nombreact from Planeacion.odi.Actividad where idactividad = EP.idactividad), valor, agno, (Select ISNULL(SUM(valor),0) from Planeacion.odi.ErogacionPL EP where idactividad = " + act + ") from Planeacion.odi.ErogacionPL EP where idactividad = " + act + " Order by agno, tiporubpl asc");
        try {
            conectarBD();
            retorno = consultar(consulta, 9, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta Valor total personal por actividad
    public String ConsultaValorPersonalRep1(String act) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select ISNULL(SUM(horas*valorprs),0) from Planeacion.odi.Horas_Personal HP, Planeacion.odi.Personal P Where HP.idpersonal = P.idpersonal AND P.idpersonal IN (Select idpersonal from Planeacion.odi.Personal WHERE idactividad = " + act + ")");
        try {
            conectarBD();
            retorno = consultar(consulta, 1, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno.elementAt(0).toString();
    }

    // Consulta  indicadores actividad reporte 
    public Vector ConsultaIndicactRep1(String idact) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select idindicador, nombreind, calculoind, periodicidadind, tipoind, idproyecto, idactividad, descripcioncal from Planeacion.odi.Indicador where idactividad = " + idact);
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
    public Vector ConsultaInfoActividad(String act) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String(" SELECT [idactividad] "
                + "      ,[nombreact] "
                + "      ,[descripcionact] "
                + "      ,CONVERT(varchar(11),[fechainiact],103) "
                + "      ,CONVERT(varchar(11),[fechafinact],103) "
                + "      ,[porcejecucionact] "
                + "      ,[porcproyectoact] "
                + "      ,[tipoact] "
                + "      ,[consecutivoact] "
                + "      ,[idproyecto] "
                + "      ,rtrim([responsableact]) "
                + "  FROM [Planeacion].[odi].[Actividad] "
                + "WHERE  [idactividad] = " + act);
        try {
            conectarBD();
            retorno = consultar(consulta, 11, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta Presupuesto del Proyecto
    public Vector ConsultaPresupuesto(String idp) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select EP.iderogacionpl, (Select valor from Planeacion.odi.Parametros where tipo = 4 and secuencial = CONVERT(int, EP.tiporubpl)), EP.rubropl, '', EP.observacionpl, (Select nombreact from Planeacion.odi.Actividad where idactividad = EP.idactividad), valor, agno from Planeacion.odi.ErogacionPL EP where idproyecto = " + idp + " Order by agno, tiporubpl asc");
        try {
            conectarBD();
            retorno = consultar(consulta, 8, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta Presupuesto Actividad
    public Vector ConsultaPresupuestoActi(String act) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select EP.iderogacionpl, (Select valor from Planeacion.odi.Parametros where tipo = 4 and secuencial = CONVERT(int, EP.tiporubpl)), EP.rubropl, '', EP.observacionpl, (Select nombreact from Planeacion.odi.Actividad where idactividad = EP.idactividad), valor, agno from Planeacion.odi.ErogacionPL EP where idactividad = " + act + " Order by agno, rubropl asc");
        try {
            conectarBD();
            retorno = consultar(consulta, 8, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Validar si hay registro Objetivo EJE - Proyecto
    public Vector ValidarObEJEProyecto(String idp, String numob, String ideje) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select idejeprograma from [Planeacion].[odi].[ObjetivosEJEProyecto] where idproyecto =  " + idp + " AND numeroobj = " + numob + " AND idejeprograma = " + ideje);

        try {
            conectarBD();
            retorno = consultar(consulta, 1, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();

        return retorno;
    }

    // Validar si hay registro Objetivo EJE - Proyecto
    public String ValidarDirectorResponMegapro(String cc) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("SELECT CASE (Select '1' from Planeacion.odi.Proyecto Where idproyecto IN (Select idMegaPro from Planeacion.odi.MegaProyectos Where idproyecto = 49) AND (ccdirectorpr = '" + cc + "' OR ccresponsablepr = '" + cc + "' OR ccusucreapr = '" + cc + "')) WHEN '1' THEN '1' ELSE '0'  END");

        try {
            conectarBD();
            retorno = consultar(consulta, 1, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();

        return retorno.elementAt(0).toString();
    }

    // Validar si hay registro Objetivo EJE - Proyecto
    public String ConsultaSiPerteneceAMegapro(String idp) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("IF EXISTS (Select top 1 idMegaPro from Planeacion.odi.MegaProyectos Where idproyecto = " + idp + ")"
                + " BEGIN "
                + "      Select top 1 idMegaPro from Planeacion.odi.MegaProyectos Where idproyecto = " + idp
                + " END "
                + " ELSE "
                + " BEGIN "
                + "      Select '0' "
                + " END ");

        try {
            conectarBD();
            retorno = consultar(consulta, 1, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();

        return retorno.elementAt(0).toString();
    }

    // Consulta  ultimo seguimiento
    public String consultaultseg(String idp) {
        Vector retorno = new Vector();
        String consulta = new String();
        consulta = new String("Select max(idseguimiento) from Planeacion.odi.Seguimiento Where idproyecto = " + idp);
        try {
            conectarBD();
            retorno = consultar(consulta, 1, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno.elementAt(0).toString();
    }

    // Consulta datos de seguimiento
    public Vector ConsultaSeguimiento(String idseg) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select idseguimiento, fechaseg, prcntavanceproyseg, estadoproyseg, estadosistemaseg, descripavanceseg, accionesseg, idproyecto, estadoseg, dificultadesavance, YEAR(fechaseg),year(dateadd(month,-2,fechaseg)) from Planeacion.odi.Seguimiento Where idseguimiento = " + idseg);

        try {
            conectarBD();
            retorno = consultar(consulta, 12, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();

        return retorno;
    }

    /*  -----------------------------------------------------------------------------------------  */
    /* Consulta el IdActividadSeguimiento << idactividadseg >>      */
    public Vector ConsultaIdActivSeg(String idact, String idseg) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("select idactividadseg, idactividad, idseguimiento from Planeacion.odi.SegActividad where idactividad = " + idact + " and idseguimiento = " + idseg);

        try {
            conectarBD();
            retorno = consultar(consulta, 3, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();

        return retorno;
    }

    /*  -----------------------------------------------------------------------------------------  */
    // Consulta datos de seguimiento metas
    public Vector ConsultaSeguimientoMetas(String idseg, String idmeta) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select descripavancemetobj from [Planeacion].[odi].[SegMetas] Where idmetaobj = " + idmeta + " and idseguimeinto = " + idseg);

        try {
            conectarBD();
            retorno = consultar(consulta, 1, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();

        return retorno;
    }

    // Consulta datos de seguimiento indicadores
    public Vector ConsultaSeguimientoIndicador(String idseg, String idind) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select resultado, descripresult from [Planeacion].[odi].[SegIndicador] Where idindicador = " + idind + " AND idseguimiento = " + idseg);

        try {
            conectarBD();
            retorno = consultar(consulta, 2, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();

        return retorno;
    }

    // Consulta datos de seguimiento actividad
    public Vector ConsultaSeguimientoActividad(String idseg, String idact) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("SELECT idactividadseg, idactividad, idseguimiento, estadoejecactividad, descripavance, accionesact, porcavanact from [Planeacion].[odi].[SegActividad] WHERE idactividad = " + idact + " AND idseguimiento = " + idseg);

        try {
            conectarBD();
            retorno = consultar(consulta, 7, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();

        return retorno;
    }

    // Consulta datos de seguimiento de personal
    public Vector ConsultaSeguimientoPersonal(String idseg, String idper) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select idsegpersonal, idseguimiento, idpersonal, idactividad, horaseg, agno, tipo from [Planeacion].[odi].[SegPersonal] Where idpersonal = " + idper + " AND idseguimiento =" + idseg);

        try {
            conectarBD();
            retorno = consultar(consulta, 7, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();

        return retorno;
    }

    // Consulta datos de seguimiento de personal
    public String ConsultaValorDedicacionSeg(String idseg) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select ISNULL(SUM(P.valorprs*SP.horaseg),0)  from Planeacion.odi.SegPersonal SP, Planeacion.odi.Personal P  Where P.idpersonal = SP.idpersonal AND SP.idseguimiento = " + idseg);

        try {
            conectarBD();
            retorno = consultar(consulta, 1, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();

        return retorno.elementAt(0).toString();
    }

    // Consulta datos de seguimiento de personal MEGAPROYECTO
    public String ConsultaValorDedicacionSegMegaPro(String idseg) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select ISNULL(SUM(P.valorprs*SP.horaseg),0)  from Planeacion.odi.SegPersonal SP, Planeacion.odi.Personal P  Where P.idpersonal = SP.idpersonal AND SP.idseguimiento IN (Select idsegsubproyecto from Planeacion.odi.RegSegMegaPro Where idseguimiento = " + idseg + ")");

        try {
            conectarBD();
            retorno = consultar(consulta, 1, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();

        return retorno.elementAt(0).toString();
    }

    // Consulta valor personal total
    public String ConsultaValorDedicacionProy(String idseg, String idp) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select ISNULL(SUM(P.valorprs*SP.horaseg),0)  from Planeacion.odi.SegPersonal SP, Planeacion.odi.Personal P  Where P.idpersonal = SP.idpersonal AND SP.idseguimiento IN (Select idseguimiento from Planeacion.odi.Seguimiento Where idproyecto = " + idp + ")");

        try {
            conectarBD();
            retorno = consultar(consulta, 1, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();

        return retorno.elementAt(0).toString();
    }

    // Consulta seguimiento anterior  proyecto
    public Vector ConsultaSegAnteriorProy(String idp, String segactual) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select top 1 idseguimiento, CONVERT(varchar(11),fechaseg,103), prcntavanceproyseg, estadoproyseg, estadosistemaseg, descripavanceseg, accionesseg, idproyecto, estadoseg, dificultadesavance from planeacion.odi.Seguimiento Where idseguimiento < " + segactual + " AND idproyecto = " + idp + " Order by idseguimiento desc");

        try {
            conectarBD();
            retorno = consultar(consulta, 10, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();

        return retorno;
    }

    // Consulta ultimo seguimiento
    public String ConsultaUltSeg(String idp) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select top 1 idseguimiento, CONVERT(varchar(11),fechaseg,103), prcntavanceproyseg, estadoproyseg, estadosistemaseg, descripavanceseg, accionesseg, idproyecto, estadoseg, dificultadesavance from planeacion.odi.Seguimiento Where idproyecto = " + idp + " Order by idseguimiento desc");

        try {
            conectarBD();
            retorno = consultar(consulta, 10, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();

        return retorno.elementAt(0).toString();
    }

    // Consulta seguimiento anterior  actividad
    public Vector ConsultaSegAnteriorAct(String idac/*, String segactual*/) {
        Vector retorno = new Vector();
        String consulta = new String();
        /*Se modifica query el día 13 de Septiembre de 2019*/
        consulta = new String("SELECT TOP 1 idactividadseg, idactividad, idseguimiento, estadoejecactividad, descripavance, accionesact, porcavanact FROM ("
                + "SELECT TOP 2 idactividadseg, idactividad, idseguimiento, estadoejecactividad, descripavance, accionesact, porcavanact "
                + "FROM planeacion.odi.SegActividad "
                + "WHERE idactividad = " + idac + " ORDER BY idseguimiento DESC) Q ORDER BY idseguimiento ASC");
        //consulta = new String("SELECT idactividadseg, idactividad, idseguimiento, estadoejecactividad, descripavance, accionesact, porcavanact FROM planeacion.odi.SegActividad WHERE idactividad = "+idac+" AND idseguimiento < "+segactual);

        try {
            conectarBD();
            retorno = consultar(consulta, 7, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();

        return retorno;
    }

    // Consulta seguimiento personal horas acumuladas
    public Vector ConsultaTotalHorasSeg(String idac, String idper, String idseg) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("SELECT ISNULL(SUM(horaseg),"
                + " ( select  ISNULL(SUM(horaseg),0) from Planeacion.odi.SegPersonal c\n" +
"  inner join Planeacion.odi.PersonalNuevoSeg a on a.idactividadseg=c.idactividad and c.idpersonal=a.idpersonalseg\n" +
"  inner join Planeacion.odi.SegActividad b on a.idactividadseg=b.idactividadseg\n" +
"  where b.idactividad="+idac+" and a.nombreparticpseg \n" +
"  in (select nombreparticpseg from Planeacion.odi.PersonalNuevoSeg  where idpersonalseg in ("+idper+")) and c.idseguimiento <="+idseg+")) "
                + "FROM Planeacion.odi.SegPersonal WHERE idactividad = " + idac + " and idpersonal  = " + idper+ "and idseguimiento <="+idseg);

        try {
            conectarBD();
            retorno = consultar(consulta, 1, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();

        return retorno;
    }
    
    public Vector ConsultaTotalHorasSegAct(String idac, String idper, String idseg) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("SELECT ISNULL(SUM(horaseg),"
                + " ( select  ISNULL(SUM(horaseg),0) from Planeacion.odi.SegPersonal c\n" +
"  inner join Planeacion.odi.PersonalNuevoSeg a on a.idactividadseg=c.idactividad and c.idpersonal=a.idpersonalseg\n" +
"  inner join Planeacion.odi.SegActividad b on a.idactividadseg=b.idactividadseg\n" +
"  where b.idactividad="+idac+" and c.idpersonal="+idper+" and c.idseguimiento ="+idseg +")) "
                + "FROM Planeacion.odi.SegPersonal WHERE idactividad = " + idac + " and idpersonal  = " + idper+" and idseguimiento ="+idseg );

        try {
            conectarBD();
            retorno = consultar(consulta, 1, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();

        return retorno;
    }

    // Consulta estado seguimiento en ventana actual
    public String ConsultaEstadoSegActual(String idseg) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("SELECT estadoseg FROM Planeacion.odi.Seguimiento WHERE idseguimiento = " + idseg);

        try {
            conectarBD();
            retorno = consultar(consulta, 1, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();

        return retorno.elementAt(0).toString();
    }

    // Consulta seguimientos
    public Vector ConsultaSeguimientosPRY(String idp) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select idseguimiento, fechaseg, CASE estadoseg WHEN '2' THEN 'Terminado' ELSE 'Incompleto' END, prcntavanceproyseg from Planeacion.odi.Seguimiento where idproyecto = " + idp + " Order by fechaseg asc");

        try {
            conectarBD();
            retorno = consultar(consulta, 4, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();

        return retorno;
    }

    // Consulta de seguimiento a erogacion
    public Vector ConsultaSegErogacion(String idseg) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select iderogacionseg, (Select nombre from  Novasoft.dbo.gen_clasif1 Where codigo = CONVERT(varchar(20),SE.ccosto)), (Select nom_rub from Novasoft.dbo.usr_rubros_planeacion Where cod_rub = SE.rubro AND cod_cl1 = SE.ccosto AND ano_acu = SE.agno), agno, saldo, apropiacion, adicioncambioagno, aprfinal, idseguimiento, CASE WHEN EXISTS(Select iderogacionof from planeacion.odi.erogacionof where ccosto = SE.ccosto AND rubro = SE.rubro) THEN 'SI' ELSE 'NO' END AS Planeado from planeacion.odi.SegErogacion SE Where idseguimiento = " + idseg);

        try {
            conectarBD();
            retorno = consultar(consulta, 10, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();

        return retorno;
    }

    // Consulta seguimiento erogación MEGAPROYECTO
    public Vector ConsultaSegErogacionMegaPro(String idseg) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select iderogacionseg, (Select nombre from  Novasoft.dbo.gen_clasif1 Where codigo = CONVERT(varchar(20),SE.ccosto)), (Select nom_rub from Novasoft.dbo.usr_rubros_planeacion Where cod_rub = SE.rubro AND cod_cl1 = SE.ccosto AND ano_acu = SE.agno), agno, saldo, apropiacion, adicioncambioagno, aprfinal, idseguimiento, CASE WHEN EXISTS(Select iderogacionof from planeacion.odi.erogacionof where ccosto = SE.ccosto AND rubro = SE.rubro) THEN 'SI' ELSE 'NO' END AS Planeado from planeacion.odi.SegErogacion SE Where idseguimiento IN (Select idsegsubproyecto from Planeacion.odi.RegSegMegaPro Where idseguimiento = " + idseg + ")");

        try {
            conectarBD();
            retorno = consultar(consulta, 10, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();

        return retorno;
    }

//-------------------------------------------------------------
// INSERT BASE DE DATOS    
//-------------------------------------------------------------
    public int CreacionProyecto(String NombrePr, String Plan, String SNIES, String CCUser) {
        int retorno = 0;
        String consulta = new String();

        consulta = new String("   INSERT INTO [Planeacion].[odi].[Proyecto]"
                + "           ([nombrepr]"
                + "           ,[tipopr]"
                + "           ,[ccdirectorpr]"
                + "           ,[ccresponsablepr]"
                + "           ,[metapr]"
                + "           ,[justificacionpr]"
                + "           ,[Prioridadpr]"
                + "           ,[fechainipr]"
                + "           ,[fechafinpr]"
                + "           ,[estadopr]"
                + "           ,[valorproyectadopr]"
                + "           ,[valorejecutadopr]"
                + "           ,[porcejecucionsispr]"
                + "           ,[porcejecuciondirpr]"
                + "           ,[SNIESpr]"
                + "           ,[observacionpr]"
                + "           ,[ccusucreapr]"
                + "           ,[idplan]"
                + "           ,[fechacrea]"
                + "           ,[estadoejecucion]"
                + "           ,[megapro])"
                + "     VALUES"
                + "           ('" + NombrePr + "'"
                + "           ,''"
                + "           ,''"
                + "           ,''"
                + "           ,''"
                + "           ,''"
                + "           ,0"
                + "           ,NULL"
                + "           ,NULL"
                + "           ,1"
                + "           ,NULL"
                + "           ,NULL"
                + "           ,0"
                + "           ,0"
                + "           ," + SNIES
                + "           ,NULL"
                + "           ,'" + CCUser + "'"
                + "           ," + Plan + ""
                + "           ,GETDATE()"
                + "           ,1"
                + "           ,'P')");

        try {
            conectarBD();
            retorno = actualizar(consulta);

        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }


        desconectarBD();
        return retorno;
    }

    // Asocia Proyectos a un Megaproyecto en una tabla independiente
    public int AsociarProyectoMegapro(String idp, String idsubpro) {
        int retorno = 0;
        String consulta = new String();

        consulta = new String(" INSERT INTO [Planeacion].[odi].[MegaProyectos]\n"
                + "           ([idMegaPro] "
                + "           ,[idproyecto] "
                + "           ,[fecharegistro]) "
                + "     VALUES "
                + "           (" + idp
                + "           ," + idsubpro
                + "           ,GETDATE())");
        try {
            conectarBD();
            retorno = actualizar(consulta);

        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }


        desconectarBD();
        return retorno;
    }

    // Realiza el registro de los seguimientos de los subproyectos para luego mostrarlos en el seguimiento del MegaProyecto
    public int RegistroSegSubproyectosMegapro(String idSegMegaPro, String idSegPro) {
        int retorno = 0;
        String consulta = new String();

        consulta = new String("INSERT INTO [Planeacion].[odi].[RegSegMegaPro] "
                + "           ([idseguimiento] "
                + "           ,[idsegsubproyecto]) "
                + "     VALUES "
                + "           (" + idSegMegaPro
                + "           ," + idSegPro + ")");
        try {
            conectarBD();
            retorno = actualizar(consulta);

        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }


        desconectarBD();
        return retorno;
    }

    // Crea objetivo general o especifico para el proyecto
    public int CreacionObjetivoPr(String idp, String tipopr) {
        int retorno = 0;
        String consulta = new String();

        consulta = new String(" INSERT INTO [Planeacion].[odi].[Objetivo]"
                + "           ([descripcionob]"
                + "           ,[tipoob]"
                + "           ,[idproyecto])"
                + "     VALUES"
                + "           (''"
                + "           ," + tipopr
                + "           ," + idp + ")");
        try {
            conectarBD();
            retorno = actualizar(consulta);

        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }


        desconectarBD();
        return retorno;
    }

    // Crea asociacion Proyecto EJE(s)
    public int AsociarProyectoEJE(String idp, String eje) {
        int retorno = 0;
        String consulta = new String();

        BDServicios b = new BDServicios();
        if (b.ValidarEjeProyecto(idp, eje).size() == 0) {

            consulta = new String("INSERT INTO [Planeacion].[odi].[Eje_Programa-Proyecto] "
                    + "           ([idproyecto] "
                    + "           ,[idejeprograma]"
                    + "           ,[ejeppal]) "
                    + "     VALUES "
                    + "           (" + idp + " "
                    + "           ," + eje + ", 0)");
        }
        try {
            conectarBD();
            retorno = actualizar(consulta);

        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }


        desconectarBD();
        return retorno;
    }

    // Valida que el eje no este asociado al proyecto
    public Vector ValidarEjeProyecto(String idp, String eje) {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String("Select idproyecto from [Planeacion].[odi].[Eje_Programa-Proyecto] Where idproyecto = " + idp + " AND idejeprograma = " + eje);
        try {
            conectarBD();
            retorno = consultar(consulta, 1, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Asociar objetivos especificos de EJE a Proyecto.
    public int AsociarObjEjeProy(String ideje, String numeroobj, String idp) {
        int retorno = 0;
        String consulta = new String();

        consulta = new String("INSERT INTO [Planeacion].[odi].[ObjetivosEJEProyecto] "
                + "           ([idejeprograma] "
                + "           ,[numeroobj] "
                + "           ,[idproyecto]) "
                + "     VALUES "
                + "           (" + ideje
                + "           ," + numeroobj
                + "           ," + idp + ")");
        try {
            conectarBD();
            retorno = actualizar(consulta);

        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }


        desconectarBD();
        return retorno;
    }

    // Crea objetivo general o especifico para el proyecto
    public int CreacionHorasPersonal(int agno, String horas, String idpersonal, String CantPer) {
        int retorno = 0;
        String consulta = new String();

        consulta = new String(" INSERT INTO [Planeacion].[odi].[Horas_Personal] "
                + "           ([agno] "
                + "           ,[horas] "
                + "           ,[idpersonal] "
                + "           ,[CantPer])"
                + "     VALUES "
                + "           (" + String.valueOf(agno) + ""
                + "           ," + horas + " "
                + "           ," + idpersonal + " "
                + "           ," + CantPer + ")");
        try {
            conectarBD();
            retorno = actualizar(consulta);

        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }


        desconectarBD();
        return retorno;
    }

    // Crea horas de PERSONAL ADICIONAL EN SEGUIMIENTO
    public int CreacionHorasPersonalSeg(int agno, String horas, String idpersonal, String idac, String idseg) {
        int retorno = 0;
        String consulta = new String();

        consulta = new String("INSERT INTO [Planeacion].[odi].[SegPersonal]"
                + "           ([idseguimiento]"
                + "           ,[idpersonal]"
                + "           ,[idactividad]"
                + "           ,[horaseg]"
                + "           ,[agno]"
                + "           ,[tipo])"
                + "     VALUES"
                + "           (" + idseg
                + "           ," + idpersonal
                + "           ," + idac
                + "           ," + horas + " "
                + "           ,year(getdate())"
                + "           ,2)");


        try {
            conectarBD();
            retorno = actualizar(consulta);

        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }


        desconectarBD();
        return retorno;
    }

    // Crea rubros año
    public int CreacionErogacionAgno(int agno, String valor, String iderogacion) {
        int retorno = 0;
        String consulta = new String();

        consulta = new String(" INSERT INTO [Planeacion].[odi].[ErogacionAgno] "
                + "           ([agno] "
                + "           ,[valor] "
                + "           ,[iderogacion]) "
                + "     VALUES "
                + "           (" + agno + " "
                + "           ," + valor + " "
                + "           ," + iderogacion + ")");
        try {
            conectarBD();
            retorno = actualizar(consulta);

        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }


        desconectarBD();
        return retorno;
    }

    // Crea personal a actividad
    public int CreacionPersonalAct(String ccpersona, String cargo, String idact, String valor) {
        int retorno = 0;
        String consulta = new String();

        consulta = new String(" INSERT INTO [Planeacion].[odi].[Personal] "
                + "           ([nombreparticpprs] "
                + "           ,[cargoparticprs] "
                + "           ,[valorprs] "
                + "           ,[idactividad]"
                + "           ,[estado]) "
                + "     VALUES "
                + "           ('" + ccpersona + "' "
                + "           ,'" + cargo + "' "
                + "           ," + valor
                + "           ," + idact
                + "           ,1) ");
        try {
            conectarBD();
            retorno = actualizar(consulta);

        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }


        desconectarBD();
        return retorno;
    }

    // Crea personal a actividad ADICIONAL EN SEGUIMIENTO
    public int CreacionPersonalActSeg(String ccpersona, String cargo, String idact, String valor) {
        int retorno = 0;
        String consulta = new String();

        consulta = new String(" INSERT INTO [Planeacion].[odi].[PersonalNuevoSeg] "
                + "           ([nombreparticpseg] "
                + "           ,[cargoparticseg] "
                + "           ,[valorprsseg] "
                + "           ,[idactividadseg]"
                + "           ,[estado])"
                + "     VALUES "
                + "           ('" + ccpersona + "' "
                + "           ,'" + cargo + "' "
                + "           ," + valor
                + "           ," + idact
                + "           ,1) ");
        try {
            conectarBD();
            retorno = actualizar(consulta);

        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }


        desconectarBD();
        return retorno;
    }

    // Crea actividad para el proyecto
    public int CreacionActividadPr(String idp, String tipoac, String nomac, String fciniac, String fcfinac, String descac, String porcntpr, String responact) {
        int retorno = 0;
        String consulta = new String();

        consulta = new String(" INSERT INTO [Planeacion].[odi].[Actividad]\n"
                + "       ([nombreact]"
                + "       ,[descripcionact]"
                + "       ,[fechainiact]"
                + "       ,[fechafinact]"
                + "       ,[porcejecucionact]"
                + "       ,[porcproyectoact]"
                + "       ,[tipoact]"
                + "       ,[consecutivoact]"
                + "       ,[responsableact]"
                + "       ,[idproyecto])"
                + " VALUES"
                + "       ('" + nomac + "'"
                + "       ,'" + descac + "'"
                + "       ,convert(datetime,'" + fciniac + "',103) "
                + "       ,convert(datetime,'" + fcfinac + "',103) "
                + "       ,0"
                + "       ," + porcntpr + " "
                + "       ," + tipoac + " "
                + "       ,NULL"
                + "       ,'" + responact + "' "
                + "       ," + idp + ")");
        try {
            conectarBD();
            retorno = actualizar(consulta);

        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }


        desconectarBD();
        return retorno;
    }

    // Crea Erogación Planeación
    public int CreacionErogacionPL(String idp, String tiporub, String rubro, String act, String observ, String valor, String agno) {
        int retorno = 0;
        String consulta = new String();

        consulta = new String("INSERT INTO [Planeacion].[odi].[ErogacionPL] "
                + "           ([tiporubpl] "
                + "           ,[rubropl] "
                + "           ,[observacionpl] "
                + "           ,[idproyecto] "
                + "           ,[idactividad] "
                + "           ,[valor] "
                + "           ,[agno]) "
                + "     VALUES "
                + "           ('" + tiporub + "' "
                + "           ," + rubro + " "
                + "           ,'" + observ + "'"
                + "           ," + idp
                + "           ," + act
                + "           ," + valor
                + "           ," + agno + ")");
        try {
            conectarBD();
            retorno = actualizar(consulta);

        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }


        desconectarBD();
        return retorno;
    }

    // Crea indicador
    public int CreacionIndicador(String nombre, String periodicidad, String tipo, String idproy, String idact, String descripcioncal) {
        int retorno = 0;
        String consulta = new String();

        consulta = new String("INSERT INTO [Planeacion].[odi].[Indicador] "
                + "           ([nombreind] "
                + "           ,[descripcioncal] "
                + "           ,[calculoind] "
                + "           ,[periodicidadind] "
                + "           ,[tipoind] "
                + "           ,[idproyecto] "
                + "           ,[idactividad]) "
                + "     VALUES "
                + "           ('" + nombre + "' "
                + "           ,'" + descripcioncal + "' "
                + "           ,NULL "
                + "           ,'" + periodicidad + "' "
                + "           ," + tipo + " "
                + "           ," + idproy + ""
                + "           ," + idact + ")");
        try {
            conectarBD();
            retorno = actualizar(consulta);

        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }


        desconectarBD();
        return retorno;
    }

    // Crea registro de Archivo
    public int RegistrarArchivo(String nomarch, String nomorig, String idp, String idact, String tipousu, String Obs, String Seg) {
        int retorno = 0;
        String consulta = new String();

        consulta = new String("INSERT INTO [Planeacion].[odi].[Archivos] "
                + "           ([nombrearc] "
                + "           ,[nombreorig] "
                + "           ,[estado] "
                + "           ,[idproyecto] "
                + "           ,[idactividad] "
                + "           ,[tipocargue] "
                + "           ,[seguimiento] "
                + "           ,[observacion]) "
                + "     VALUES "
                + "           ('" + nomarch + "'"
                + "           ,'" + nomorig + "'"
                + "           ,1"
                + "           ," + idp
                + "           ," + idact
                + "           ," + tipousu
                + "           ," + Seg
                + "           ,'" + Obs + "')");
        try {
            conectarBD();
            retorno = actualizar(consulta);

        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }

        desconectarBD();
        return retorno;
    }

    // Asociar Fin-factor-caracteristica a proyecto de mejoramiento.
    public int AsociarFactorIntegral(String idp, String idfin, String idfac, String nomcaract, String idfacint, String eje) {
        int retorno = 0;
        String consulta = new String();

        consulta = new String("INSERT INTO [Planeacion].[odi].[FinFactorCaractProyecto] "
                + "           ([idproyecto] "
                + "           ,[idfin] "
                + "           ,[idfactor] "
                + "           ,[nombrecaract] "
                + "           ,[eje] "
                + "           ,[idfactintegral]) "
                + "     VALUES "
                + "           (" + idp
                + "           ," + idfin
                + "           ,(" + idfac + "+1)"
                + "           ,'" + nomcaract + "' "
                + "           ," + eje
                + "           ," + idfacint + ") ");
        try {
            conectarBD();
            retorno = actualizar(consulta);

        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }


        desconectarBD();
        return retorno;
    }

//-------------------------------------------------------------
// UPDATE BASE DE DATOS    
//-------------------------------------------------------------
    public int ActualizarInfA(String idpr, String nomproy, String estpr, String estejec, String plan, String snies, String prioridad, String director, String responsable, String fecini, String fecfin, String valejecutado, String porcejesis, String porcejedir, String metapr, String justifpr, String UEjecutora) {

        int retorno = 0;
        String consulta = new String();

        // fecini,fecfin,

        consulta = new String("UPDATE [Planeacion].[odi].[Proyecto]"
                + "   SET [nombrepr] = '" + nomproy + "'"
                + "      ,[ccdirectorpr] = '" + director + "'"
                + "      ,[ccresponsablepr] = '" + responsable + "'"
                + "      ,[metapr] = '" + metapr + "'"
                + "      ,[justificacionpr] =  '" + justifpr + "'"
                + "      ,[Prioridadpr] = " + prioridad + ""
                + "      ,[fechainipr] = convert(date, '" + fecini + "',103)"
                + "      ,[fechafinpr] =convert(date, '" + fecfin + "',103)"
                + "      ,[SNIESpr] = " + snies + ""
                + "      ,[observacionpr] = ''"
                + "      ,[idplan] = " + plan + " "
                + "      ,[estadoejecucion] = " + estejec + " "
                + "      ,[unidadejecutora] = " + UEjecutora + " "
                + " WHERE idproyecto = " + idpr);

        try {
            conectarBD();
            retorno = actualizar(consulta);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

// Cambia Eje principal
    public int CambiarEJEPpal(String idp, String eje) {

        int retorno = 0;
        String consulta = new String();
        String consulta2 = new String();

        consulta = new String("  Update [Planeacion].[odi].[Eje_Programa-Proyecto] "
                + "  set ejeppal = 0 "
                + "  Where idproyecto = " + idp);
        consulta2 = new String("  Update [Planeacion].[odi].[Eje_Programa-Proyecto] "
                + "  set ejeppal = 1"
                + "  Where idproyecto = " + idp + " AND idejeprograma = " + eje);

        try {
            conectarBD();
            retorno = actualizar(consulta);
            retorno = actualizar(consulta2);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

// Actualiza el objetivo en la planeacion
    public int ActualizarValorPlaneado(String idp, String valor) {

        int retorno = 0;
        String consulta = new String();

        consulta = new String("Update Planeacion.odi.Proyecto "
                + "set valorproyectadopr = '" + valor + "' "
                + "Where idproyecto = " + idp);

        try {
            conectarBD();
            retorno = actualizar(consulta);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

// Cambiar Proyecto a tipo MEGAPROYECTO
    public int Cambiar_A_MEGAPROYECTO(String idp) {

        int retorno = 0;
        String consulta = new String();

        consulta = new String("Update Planeacion.odi.Proyecto set megapro = 'M' Where idproyecto = " + idp);

        try {
            conectarBD();
            retorno = actualizar(consulta);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    public int ActualizarValorPlaneadoErPer(String idp, String valorplero, String valorplper) {

        int retorno = 0;
        String consulta = new String();

        consulta = new String("Update Planeacion.odi.Proyecto "
                + "set valorplero = '" + valorplero + "', "
                + "    valorplper = '" + valorplper + "' "
                + "Where idproyecto = " + idp);

        try {
            conectarBD();
            retorno = actualizar(consulta);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

// Actualiza el objetivo en la planeacion
    public int ActualizarConsecutivoAct(String idact, String consec) {

        int retorno = 0;
        String consulta = new String();

        consulta = new String("Update Planeacion.odi.Actividad "
                + "set consecutivoact = " + consec
                + "where idactividad = " + idact);

        try {
            conectarBD();
            retorno = actualizar(consulta);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

// Actualiza el objetivo en la planeacion
    public int ActualizarEstadoSeg(String idseg, String tipo) {

        int retorno = 0;
        String consulta = new String();


        if (tipo.equals("0")) {
            consulta = new String("Update Planeacion.odi.Seguimiento set estadoseg = 2");
        }
        if (tipo.equals("1")) {
            consulta = new String("Update Planeacion.odi.Seguimiento set estadoseg = 2 Where idseguimiento = " + idseg);
        }
        if (tipo.equals("2")) {
            consulta = new String("Update Planeacion.odi.Seguimiento set estadoseg = 1 Where idseguimiento = " + idseg);
        }



        try {
            conectarBD();
            retorno = actualizar(consulta);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

// Actualiza el objetivo en la planeacion
    public int ActualizarValorEjecutado(String idp, String valor) {

        int retorno = 0;
        String consulta = new String();

        consulta = new String(" Update Planeacion.odi.Proyecto "
                + "set  valorejecutadopr  = '" + valor + "' "
                + "Where idproyecto = " + idp);

        try {
            conectarBD();
            retorno = actualizar(consulta);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

// Actualiza el valor de ejecución de erogación y personal del proyecto
    public int ActualizarValorEjecutadoEroPer(String idp, String valorero, String valorper) {

        int retorno = 0;
        String consulta = new String();

        consulta = new String(" Update Planeacion.odi.Proyecto "
                + "set  valorejero  = '" + valorero + "', "
                + "     valorejper  = '" + valorper + "' "
                + "Where idproyecto = " + idp);

        try {
            conectarBD();
            retorno = actualizar(consulta);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

// Actualiza el objetivo en la planeacion
    public int ActualizarObjetivo(String idob, String descrp) {

        int retorno = 0;
        String consulta = new String();

        consulta = new String("     Update Planeacion.odi.Objetivo "
                + "           Set  descripcionob = '" + descrp + "' "
                + "   Where idobjetivo = " + idob);

        try {
            conectarBD();
            retorno = actualizar(consulta);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

// Actualiza datos Actividad
    public int ActualizarActividad(String act, String nom, String peso, String desc, String responact, String feciniac, String fecfinac) {

        int retorno = 0;
        String consulta = new String();

        consulta = new String(" Update planeacion.odi.Actividad "
                + " set     [nombreact]       = '" + nom + "'"
                + "        ,[porcproyectoact] = " + peso
                + "        ,[descripcionact]  = '" + desc + "'"
                + "        ,[responsableact]  = '" + responact + "'"
                + "        ,[fechainiact]  = convert(datetime,'" + feciniac + "',103)"
                + "        ,[fechafinact]  = convert(datetime,'" + fecfinac + "',103)"
                + " Where idactividad = " + act);

        try {
            conectarBD();
            retorno = actualizar(consulta);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

// Actualiza datos Actividad
    public int ActualizarRubro(String rubrosel, String TipRub, String AnioRub, String ValorRub, String ObsRub, String idreg) {

        int retorno = 0;
        String consulta = new String();

        consulta = new String(" Update Planeacion.odi.ErogacionPL "
                + " set     [rubropl]       = '" + rubrosel + "'"
                + "        ,[tiporubpl] = '" + TipRub + "'"
                + "        ,[agno]  = '" + AnioRub + "'"
                + "        ,[valor]  = '" + ValorRub + "'"
                + "        ,[observacionpl]  = '" + ObsRub + "'"
                + " Where iderogacionpl = " + idreg);

        try {
            conectarBD();
            retorno = actualizar(consulta);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

// Actualizar valores de erogacion - rubros o valor
    public int ActualizarErogacion(String iderog, String valor, String rubro, String tipo) {

        int retorno = 0;
        String consulta = new String();

        consulta = new String("  Update Planeacion.odi.ErogacionPL "
                + "set    valor      =" + valor
                + "       ,rubropl   =" + rubro
                + "       ,tiporubpl ='" + tipo + "' "
                + "where iderogacionpl = " + iderog);

        try {
            conectarBD();
            retorno = actualizar(consulta);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

// Actualiza Horas por año del personal
    public int ActualizarHorasPers(String idpersonal, String agno, String horas, String CantPer) {

        int retorno = 0;
        String consulta = new String();

        consulta = new String(" Update Planeacion.odi.Horas_Personal "
                + " set    horas = " + horas
                + "        ,CantPer='" + CantPer + "'"
                + " Where  agno = " + agno + " AND idpersonal = " + idpersonal);

        try {
            conectarBD();
            retorno = actualizar(consulta);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

// Actualiza Horas por año del personal
    public int ActualizarValoresErog(String iderog, String agno, String valor) {

        int retorno = 0;
        String consulta = new String();

        consulta = new String(" Update Planeacion.odi.ErogacionAgno "
                + " set    valor = " + valor
                + " Where  agno = " + agno + " AND iderogacion = " + iderog);

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
    public int CambiaEstadoPR(String idp, String estado) {

        int retorno = 0;
        String consulta = new String();

        consulta = new String(" Update Planeacion.odi.Proyecto "
                + " Set estadopr = " + estado
                + " Where idproyecto = " + idp);

        try {
            conectarBD();
            retorno = actualizar(consulta);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

//-------------------------------------------------------------
// DELETE BASE DE DATOS    
//-------------------------------------------------------------
// Borrar  Objetivos Espec Antes de Escribir nuevamente
    public int EliminarAsociacionOBJEJEProy(String idp, String ideje) {

        int retorno = 0;
        String consulta = new String();

        consulta = new String("Delete from [Planeacion].[odi].[ObjetivosEJEProyecto] Where idproyecto = " + idp + " AND idejeprograma = " + ideje);

        try {
            conectarBD();
            retorno = actualizar(consulta);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Verificar idactividad con idproyecto
    public int ValidarIDPrAc(String idp, String idact, String tipo) {
        String consulta;
        Vector retorno = new Vector();

        if (tipo.equals("1")) {
            consulta = new String("Select idactividad from planeacion.odi.Actividad where idproyecto = " + idp + " AND idactividad = " + idact);
        } else {
            consulta = new String("Select idseguimiento from Planeacion.odi.Seguimiento where idproyecto = " + idp + " AND idseguimiento = " + idact);
        }

        try {
            conectarBD();
            retorno = consultar(consulta, 1, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno.size();
    }

    // Consulta actividades para seguimiento
    public Vector ConsultaActividadesSEG(String idp, String tipcon) {
        Vector retorno = new Vector();
        String consulta = new String();



        consulta = new String("  SELECT idactividad      \n"
                + "  ,nombreact      \n"
                + "   ,descripcionact       \n"
                + "   ,CONVERT(varchar(11),fechainiact,103)\n"
                + "    ,CONVERT(varchar(11),fechafinact,103)  \n"
                + "	,porcejecucionact       ,porcproyectoact       \n"
                + "	,tipoact       ,consecutivoact       ,idproyecto       \n"
                + "	,CASE              WHEN (Select max(feciniseg) \n"
                + "	from Planeacion.odi.FechaSeguimiento) BETWEEN \n"
                + "	AC.fechainiact AND \n"
                + "	AC.fechafinact OR \n"
                + "	(Select max(fecfinseg) from Planeacion.odi.FechaSeguimiento)\n"
                + "	 BETWEEN AC.fechainiact AND AC.fechafinact               \n"
                + "	 THEN 1                 ELSE 0         END as EnSeguimiento        \n"
                + "	 FROM Planeacion.odi.Actividad AC       Where idproyecto = " + idp + " Order by fechainiact asc");
        try {
            conectarBD();
            retorno = consultar(consulta, 11, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Consulta actividades para seguimiento
    public String ConsultaRagoFechasPermitirSegAdmin() {
        Vector retorno = new Vector();
        String consulta = new String();

        consulta = new String(" IF  GETDATE() Between (Select fechainiodi from planeacion.odi.FechaSeguimiento where flag = 1) AND (Select fechafinodi from planeacion.odi.FechaSeguimiento where flag = 1) "
                + "BEGIN "
                + "    Select '1' END ELSE BEGIN   Select '0' "
                + "END");
        try {
            conectarBD();
            retorno = consultar(consulta, 1, 0);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno.elementAt(0).toString();
    }

    public Vector ConsultaActividadesSEGInv(String idp, String cc) {
        Vector retorno = new Vector();
        String consulta = new String();



        consulta = new String(" SELECT idactividad "
                + "      ,nombreact "
                + "      ,descripcionact "
                + "      ,CONVERT(varchar(11),fechainiact,103) "
                + "      ,CONVERT(varchar(11),fechafinact,103) "
                + "      ,porcejecucionact "
                + "      ,porcproyectoact "
                + "      ,tipoact "
                + "      ,consecutivoact "
                + "      ,idproyecto "
                + "      ,CASE  "
                + //"            WHEN (fechainiact >= (Select max(feciniseg) from Planeacion.odi.FechaSeguimiento) AND fechainiact <= (Select max(fecfinseg) from Planeacion.odi.FechaSeguimiento) AND (Select max(porcavanact) from planeacion.odi.SegActividad where idactividad = AC.idactividad) <= 100) OR (fechainiact <= (Select max(feciniseg) from Planeacion.odi.FechaSeguimiento) AND (Select max(porcavanact) from planeacion.odi.SegActividad where idactividad = AC.idactividad) <= 100)" +
                "            WHEN (Select max(feciniseg) from Planeacion.odi.FechaSeguimiento) BETWEEN CONVERT(varchar(11),AC.fechainiact,103) AND CONVERT(varchar(11),AC.fechafinact,103) OR (Select max(fecfinseg) from Planeacion.odi.FechaSeguimiento) BETWEEN CONVERT(varchar(11),AC.fechainiact,103) AND CONVERT(varchar(11),AC.fechafinact,103)"
                + "               THEN 1  "
                + "               ELSE 0  "
                + "       END as EnSeguimiento "
                + "       FROM Planeacion.odi.Actividad AC"
                + "       Where idproyecto = " + idp + " AND rtrim(responsableact) = rtrim('" + cc + "') Order by fechainiact asc");
        try {
            conectarBD();
            retorno = consultar(consulta, 11, 1);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Actualiza tabla seguimiento*
    public int ActualizarSeguimiento(String idseg, String porcavan, String estpr, String estsis, String descav, String accionesseg, String dificultades) {

        int retorno = 0;
        String consulta = new String();

        consulta = new String("UPDATE [Planeacion].[odi].[Seguimiento] "
                + "   SET "
                + "       [prcntavanceproyseg] = " + porcavan
                + "      ,[estadoproyseg]      = " + estpr
                + "      ,[estadosistemaseg]   = " + estsis
                + "      ,[descripavanceseg]   = '" + descav + "'"
                + "      ,[accionesseg]        = '" + accionesseg + "'"
                + "      ,[estadoseg] = 1 "
                + "      ,[dificultadesavance] = '" + dificultades + "' "
                + " WHERE idseguimiento = " + idseg);

        try {
            conectarBD();
            retorno = actualizar(consulta);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Actualiza seguimiento de metas (Objetivos)
    public int ActualizarSeguimientoMetas(String idseg, String idmeta, String descavmeta) {

        int retorno = 0;
        String consulta = new String();

        consulta = new String("UPDATE [Planeacion].[odi].[SegMetas] "
                + "   SET  "
                + "      [descripavancemetobj]  = '" + descavmeta + "'"
                + " WHERE idseguimeinto = " + idseg + " AND idmetaobj = " + idmeta);

        try {
            conectarBD();
            retorno = actualizar(consulta);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Actualiza seguimiento de indicadores
    public int ActualizarSeguimientoIndicador(String idseg, String idind, String resultado, String descrpesult) {

        int retorno = 0;
        String consulta = new String();

        consulta = new String("UPDATE [Planeacion].[odi].[SegIndicador] "
                + "   SET [resultado] = '" + resultado + "'"
                + "      ,[descripresult] = '" + descrpesult + "'"
                + " WHERE idindicador = " + idind + " AND idseguimiento = " + idseg);

        try {
            conectarBD();
            retorno = actualizar(consulta);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Actualiza seguimiento de actividad
    public int ActualizarSegActividad(String idseg, String idact, String estado, String descav, String acciones, String porcentav) {

        int retorno = 0;
        String consulta = new String();

        consulta = new String("UPDATE [Planeacion].[odi].[SegActividad] "
                + "   SET [estadoejecactividad]   = " + estado
                + "      ,[descripavance]         = '" + descav + "' "
                + "      ,[accionesact]           = '" + acciones + "' "
                + "      ,[porcavanact]           = " + porcentav
                + " WHERE idactividad = " + idact + " AND idseguimiento = " + idseg);

        try {
            conectarBD();
            retorno = actualizar(consulta);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    // Actualiza seguimiento de actividad
    public int ActualizarSegPersonal(String idseg, String idpers, String horas) {

        int retorno = 0;
        String consulta = new String();

        consulta = new String("UPDATE [Planeacion].[odi].[SegPersonal] "
                + "   SET [horaseg] = " + horas
                + "      ,[agno] = Year(GetDATE()) "
                + " WHERE idpersonal = " + idpers + " AND idseguimiento = " + idseg);

        try {
            conectarBD();
            retorno = actualizar(consulta);
        } catch (Exception ex) {
            mensaje = new String("Unable to fetch status due to SQLException: " + ex.getMessage());
        }
        desconectarBD();
        return retorno;
    }

    public int ActualizarSegPersonal2(String idseg, String idpers, String idact) {

        int retorno = 0;
        String consulta = new String();

        consulta = new String("UPDATE [Planeacion].[odi].[SegPersonal] SET horaseg = NULL, agno = NULL, tipo = NULL "
                + " WHERE idpersonal = " + idpers + " AND idseguimiento = " + idseg + " AND idactividad = " + idact);

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
