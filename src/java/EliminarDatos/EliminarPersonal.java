/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package EliminarDatos;

/**
 *
 * @author nicolas.almanzar
 */
import BDatos.BDEliminaDatos;
import BDatos.BDServicios;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Vector;

/**
 *
 * @author Juan Vanzina
 */
public class EliminarPersonal extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EliminaInfoActTipo</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EliminaInfoActTipo at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        } finally {            
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
                
        String idPer, idAct,idp,idseg,idpers;
        Vector My_idactividadseg = new Vector();
        Vector Id_actsg = new Vector();
                
        int retorno = 0;
        int retorno2 = 0;
        int retorno3 = 0;
        int retorno4 = 0;
        
        idPer   = request.getParameter("idPer");
        idAct   = request.getParameter("idAct");    //767
        idp     = request.getParameter("idp");
        idseg   = request.getParameter("idseg");    //715
        idpers  = request.getParameter("idpers");
                   
        BDEliminaDatos e = new BDEliminaDatos();
        BDServicios bd = new BDServicios();    
        
            //Se carga el vector con el Id de la Actividad de Seguimiento de acuerdo a los parámetros enviados
            My_idactividadseg = bd.ConsultaIdActivSeg(idAct,idseg);     //3526
            //Variable que almacenara el Id de la actividad de seguimiento
            String var_id_activseg = new String("");
            
            if(My_idactividadseg.size()>0)
            {                   
                for ( int xx = 0 ; xx < My_idactividadseg.size() ; xx++ )
                {
                    //Id_actsg = (Vector)My_idactividadseg.elementAt(xx);  
                    //Id_actsg = (Vector)My_idactividadseg.elementAt(xx); 
                    /* Asigna el ID Actividad Seguimiento*/
                    //var_id_activseg = Id_actsg.elementAt(0).toString();
                    var_id_activseg = My_idactividadseg.elementAt(0).toString();
                }
             }
            
            //se hace eliminación de personas
            //retorno = e.EliminarPersAct(idPer, idAct);
            
            retorno = e.EliminarPersAct2(idPer, idAct, 1);  //1128 - 767 - 1
            
                        
             if (retorno == 1){
                retorno4 = e.EliminarPersAct2(idPer, idAct, 2);  //1128 - 767 - 2
                response.sendRedirect("/planeacion/seguimientoPR?idp="+idp+"&seg="+idseg+"#colsend"+idAct);
            }else{
                retorno2 = e.EliminarPersNuevoseg(idPer, idAct);
                retorno3 = bd.ActualizarSegPersonal2(idseg, idPer, var_id_activseg); //ActualizarSegPersonal2
            }
             
            if (retorno2 == 1 && retorno3 == 1){
                response.sendRedirect("/planeacion/seguimientoPR?idp="+idp+"&seg="+idseg+"#colsend"+idAct);
            }else{
                //error
            }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}

