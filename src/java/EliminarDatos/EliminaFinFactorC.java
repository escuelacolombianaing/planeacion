/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package EliminarDatos;

import BDatos.BDEliminaDatos;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Juan Vanzina
 */
public class EliminaFinFactorC extends HttpServlet {

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
            out.println("<title>Servlet EliminaFinFactorC</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EliminaFinFactorC at " + request.getContextPath() + "</h1>");
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
        
        
        String fin, factor, caract, eje, idp;
        int resp1 = 0, resp2 = 0;
        
        idp     = request.getParameter("idp");
        fin     = request.getParameter("fin");
        factor  = request.getParameter("factor");
        caract  = request.getParameter("caract");
        eje     = request.getParameter("eje");
        
        BDEliminaDatos e = new BDEliminaDatos();
        
        int numejes = Integer.parseInt(e.ffcarac(idp, eje));
        
        if(numejes <= 1){
        
            resp1 =  e.EliminarEJECaract(idp, eje);
            
        }
        
            resp2 = e.EliminarCaracteristica(idp, fin, factor, caract);
        
        String returntip = request.getParameter("returntip");
            
        if(returntip.equals("U")){
            response.sendRedirect("/planeacion/detalleproy?idp="+idp+"#collapseFour");
        }else{
          response.sendRedirect("/planeacion/editpr?idp="+idp+"#collapseFour");
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
