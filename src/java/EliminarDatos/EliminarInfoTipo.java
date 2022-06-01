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
import javax.servlet.http.HttpSession;

/**
 *
 * @author Juan Vanzina
 */
public class EliminarInfoTipo extends HttpServlet {
    String usr;
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
            out.println("<title>Servlet EliminarInfoTipo</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EliminarInfoTipo at " + request.getContextPath() + "</h1>");
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
        //processRequest(request, response);
        
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
        
        String tipo, idp, idreg, CodEmp;
        
        tipo  = request.getParameter("tipo");
        idp   = request.getParameter("idp");
        idreg = request.getParameter("idreg");
        
        HttpSession  sesion;
        sesion = request.getSession(true);
        CodEmp = sesion.getAttribute("cod_emp").toString();
        
        BDEliminaDatos e = new BDEliminaDatos();
        
        
        if(tipo.equals("EJE")){
                e.EliminarEJE(idp, idreg);
                if(CodEmp.equals("1")){
                    response.sendRedirect("/planeacion/editpr?idp="+idp+"#collapseFour");
                }else{
                    response.sendRedirect("/planeacion/detalleproy?idp="+idp+"#collapseFour");
                }
        }
        if(tipo.equals("OBJ")){
                e.EliminarOBJMETA(idp, idreg);
                if(CodEmp.equals("1")){
                    response.sendRedirect("/planeacion/editpr?idp="+idp+"#collapseTwo");
                }else{
                    response.sendRedirect("/planeacion/detalleproy?idp="+idp+"#collapseTwo");
                }
        }
        if(tipo.equals("INDP")){
                e.EliminarIndicadorPR(idp, idreg);
                if(CodEmp.equals("1")){
                    response.sendRedirect("/planeacion/editpr?idp="+idp+"#collapseTwo");
                }else{
                    response.sendRedirect("/planeacion/detalleproy?idp="+idp+"#collapseTwo");
                }
        }
        if(tipo.equals("ACT")){
                e.EliminarActividad(idreg);
                if(CodEmp.equals("1")){
                    response.sendRedirect("/planeacion/editpr?idp="+idp+"#collapseThree");
                }else{
                    response.sendRedirect("/planeacion/detalleproy?idp="+idp+"#collapseThree");
                }
        }
        if(tipo.equals("ARC")){
                e.EliminarArchivo(idreg);
                if(CodEmp.equals("1")){
                response.sendRedirect("/planeacion/editpr?idp="+idp+"#collapseFive");
                }else{
                response.sendRedirect("/planeacion/detalleproy?idp="+idp+"#collapseFive");
                }
        }
        if(tipo.equals("PROY")){
                e.CambiarEstadoPROY(idp);
                if(CodEmp.equals("1")){
                    response.sendRedirect("/planeacion/proyectosact");
                }else{
                    response.sendRedirect("/planeacion/proyectosact");
                }
        }
        if(tipo.equals("RBOF")){
                e.EliminarRubrOF(idp, idreg);
                if(CodEmp.equals("1")){
                    response.sendRedirect("/planeacion/detalleproyadm?idp="+idp);
                }else{
                    response.sendRedirect("/planeacion/detalleproyadm?idp="+idp);
                }
        }
          if(tipo.equals("TRA")){
                e.EliminarArchivo(idreg);
                if(CodEmp.equals("1")){
                    response.sendRedirect("/planeacion/detalleproyadm?idp="+idp+"#collapseTen");
                }else{
                   // response.sendRedirect("/planeacion/detalleproyadm?idp="+idp);
                }
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
