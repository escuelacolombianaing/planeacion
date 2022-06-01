/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ControladorAdmin;

import BDatos.BDServiciosAdmin;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Vector;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Juan Vanzina
 */
public class AsociarRubroOFicial extends HttpServlet {

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
            out.println("<title>Servlet AsociarRubroOFicial</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AsociarRubroOFicial at " + request.getContextPath() + "</h1>");
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
        
        String idp, ccost, rub;
         int ret = 0;
        
        idp     = request.getParameter("idp");
        ccost   = request.getParameter("cop");
        //rub     = request.getParameter("rubrocc");
        
        BDServiciosAdmin bda = new BDServiciosAdmin();
        
        Vector consult = new Vector();
        Vector aux = new Vector();
        
        consult = bda.ConsultaDatosRubro(ccost);
        
        if(consult.size() > 0){
        for(int o = 0 ; o  < consult.size() ; o++){
            aux = (Vector)consult.elementAt(o); 
            ret = bda.AddRubroOF(aux.elementAt(1).toString(), aux.elementAt(0).toString(), idp, aux.elementAt(3).toString());
        }
        
        }
        
        response.sendRedirect("/planeacion/detalleproyadm?idp="+idp+"#collapseSeven");
        
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
