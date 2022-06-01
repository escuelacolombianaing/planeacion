/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import BDatos.BDServicios;
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
public class NuevoRubroPr extends HttpServlet {

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
            out.println("<title>Servlet NuevoRubroPr</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NuevoRubroPr at " + request.getContextPath() + "</h1>");
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
        
        String idp, tiporub,rubro,valor,obsrub,act,idero,agno;
     
        
        BDServicios bd = new BDServicios();
        
        PrintWriter pw = response.getWriter();
        String result;
        int retorno = 0;
        int retorno_2 = 0;

        idp         = request.getParameter("idp");
        act         = request.getParameter("act");
        rubro       = request.getParameter("rubro");
        valor       = request.getParameter("valor");
        agno       = request.getParameter("agno");
        obsrub      = request.getParameter("obsrub");
        tiporub     = bd.ConsultaTipoRubro(rubro);
        
        retorno =  bd.CreacionErogacionPL(idp, tiporub, rubro, act, obsrub, valor, agno);

        
        /*
        result = "<resultado>";
        result = result + "<dato>" + String.valueOf(retorno) + "</dato>";
        if (retorno > 0) {
                result += "<valor>Operación Exitosa</valor>";
            } else {
                result += "<valor>Fallo en la Operación</valor>";
            }
            result += "</resultado>";
            
            //Enviar Respuesta
            response.setContentType("text/xml");
            pw.write(result);
            pw.flush();
            pw.close();
        */
        
        String returntip = request.getParameter("returntip");
            if(returntip.equals("U")){
                    response.sendRedirect("/planeacion/DetalleActividad?idp="+idp+"&act="+act+"#erogacion"); 
            }else{
                    response.sendRedirect("/planeacion/editact?idp="+idp+"&act="+act+"#erogacion"); 
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
