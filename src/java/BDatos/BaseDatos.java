/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package BDatos;


import java.rmi.RemoteException;
import javax.ejb.*;
import java.util.Properties;
import java.sql.*;
import java.util.Vector;
import javax.sql.*;
import javax.naming.*;

/**
 *
 * @author palvarad
 */
public class BaseDatos {


    private Connection con;
    private boolean conectado;
     protected String sPath; /* Path de backup y correo*/
      protected String textoCorreo; /* Sesion del texto de correo*/
    protected String mensaje;
    //private static final String dbName = "java:comp/env/jdbc/registro";
     private static final String dbName = "jdbc/registro";// nuevo
 //   private static final String dbName = "java:comp/env/jdbc/registro";
    /** Creates a new instance of BaseDatos */
    public BaseDatos() {
        mensaje = "";
    }

    public int actualizar(java.lang.String consulta)  {
    	int resCons;
    	PreparedStatement sentenciaConsulta;
    	try {
            sentenciaConsulta = con.prepareStatement(consulta) ;
            resCons = sentenciaConsulta.executeUpdate();
            sentenciaConsulta.close();
    	} catch (Exception e) {
            mensaje = "Error Actualizar: " + e.getMessage();
            return 0 ;
    	}
    	return resCons ;
    }


    public String getMensajeBD() {
            return mensaje;
    }

    public Vector consultar(String consulta, int nroCampos, int preg) throws SQLException, Exception {
	int cont ;
        String valor, nd = new String("No disponible");
        Vector info = new Vector() ;
        Vector lista = new Vector() ;
        PreparedStatement prepStmt = con.prepareStatement(consulta);
        ResultSet rs = prepStmt.executeQuery();
        try {
            while (rs.next()) {
                Vector  obj = new Vector() ;
                for (cont = 1; cont <= nroCampos; cont++) {
                    valor = rs.getString(cont) ;
                    if (rs.wasNull())
                        obj.addElement(nd) ;
                    else
                        obj.addElement(valor) ;
                }
                lista.addElement(obj) ;
            }
        } catch (SQLException e) {
            mensaje = "La sentencia preparada no se ha podido cerrar correctamente " + e.getMessage();
        }
        prepStmt.close();
        if(lista.size() > 0 && preg == 0)
            info = (Vector)lista.elementAt(0);
        else if(preg == 1)
            return lista;
        return info;
    }

    /*private DataSource getJdbcDefinitivo() throws NamingException {
        Context c = new InitialContext();
        return (DataSource) c.lookup("java:comp/env/jdbc/definitivo");
    }*/

    public void conectarBD(){
        try {
            //InitialContext ic = new InitialContext();
            InitialContext ic = new InitialContext();
            DataSource ds = (DataSource) ic.lookup(dbName);
            con = ds.getConnection();
            conectado = true;
        } catch (Exception ex) {
            conectado = false;
            mensaje = "No se puede hacer la conexion con la base de datos. " +
                ex.getMessage();
        }
    }

   /* public boolean desconectarBD() {
        try {
            con.close();
            conectado = false;
            return true;
        } catch (Exception e) {
            this.mensaje = e.getMessage();
            return false;
        }
    }*/


  public void desconectarBD(){
        try {
            con.close();
        } catch (SQLException ex) {
            mensaje= new String("Desconectar: " + ex.getMessage());
        }
    }

    /*private DataSource getJdbcRegistro() throws NamingException {
        Context c = new InitialContext();
        return (DataSource) c.lookup("java:comp/env/jdbc/registro");
    }*/

  
public int conectarBDErpProcCrea(String proyecto) {
    
        boolean res;
        String resultado = null;

  try {
            InitialContext icc = new InitialContext();
            DataSource dss = (DataSource) icc.lookup(dbName);
            con = dss.getConnection();
            conectado = true;
            
            CallableStatement cstmt = con.prepareCall("{call Planeacion.odi.SeguimientoODI (?)}");
            cstmt.setString(1, proyecto);            
            //cstmt.setString("blq", bloque);
            res = cstmt.execute();
            cstmt.close();      
            con.commit();
            desconectarBD();
            
            return 1;

        } catch (Exception ex) {

            conectado = false;
            mensaje = "No se puede hacer la conexion con la base de datos. "
                    + ex.getMessage();
            return 0;
        }
    }
  

public int HorasPersonalCambioFecha(String idact) {
    
        boolean res;
        String resultado = null;

  try {
            InitialContext icc = new InitialContext();
            DataSource dss = (DataSource) icc.lookup(dbName);
            con = dss.getConnection();
            conectado = true;
            
            CallableStatement cstmt = con.prepareCall("{call Planeacion.odi.ActPersonalFecActividad (?)}");
            cstmt.setString(1, idact);            
            //cstmt.setString("blq", bloque);
            res = cstmt.execute();
            cstmt.close();      
            con.commit();
            desconectarBD();
            
            return 1;

        } catch (Exception ex) {

            conectado = false;
            mensaje = "No se puede hacer la conexion con la base de datos. "
                    + ex.getMessage();
            return 0;
        }
    }
  


    public int actualiza(java.lang.String consulta){
        int retorno = 0;
        try {
            conectarBD();
            retorno = actualizar(consulta);
        } catch (Exception ex) {
            retorno = 0;
            mensaje = "Error: " + ex.getMessage() + mensaje;

        }
        desconectarBD();
        return retorno;
    }

    public String getMensaje(){
        return this.mensaje;
    }


     public void setPath(String finpath) {
      //  this.sPath = "C:\\Sun\\" + finpath;
        this.sPath = "/usr/local/SUN/" + finpath;
    }

    public String getPath() {
        //TODO implement getTercio
        return this.sPath;
    }

    public void setTextoCorreo(String texto) {
        this.textoCorreo = texto;
    }

    public String getTextoCorreo() {
        //TODO implement getTextoCorreo
        return this.textoCorreo;
    }

}
