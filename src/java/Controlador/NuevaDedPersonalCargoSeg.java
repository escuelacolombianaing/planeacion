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
public class NuevaDedPersonalCargoSeg extends HttpServlet {

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
            out.println("<title>Servlet NuevaDedPersonalCargoSeg</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NuevaDedPersonalCargoSeg at " + request.getContextPath() + "</h1>");
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
      //  processRequest(request, response);
    
        BDServicios bd = new BDServicios();
        
        String empl,idact,idp,cargo,idpers,valor, idseg,idacret;
        int agno = 0;
        
        String tipoalm;
        
        tipoalm         = request.getParameter("tipoalm");
        
        String [] agnos, horaspart;
        
        cargo        = request.getParameter("empl");
        idact       = request.getParameter("idact");
        idp         = request.getParameter("idp");
        idseg       = request.getParameter("idseg");
        idacret     = request.getParameter("idacret");
        
        int ret;
        
        empl        = "Sin Definir";
        valor       = bd.ConsultaValorCar(cargo).elementAt(2).toString();
        cargo       = bd.ConsultaValorCar(cargo).elementAt(1).toString();
        
        agnos       = request.getParameterValues("agnos");
        horaspart   = request.getParameterValues("horaspart");
        
        ret = bd.CreacionPersonalActSeg(empl, cargo, idact, valor);
        
//        int q  = bd.Consultaagnofechas(idact);
//        agno   = Integer.parseInt(bd.consultagnoiniact(idact)); 
        
        agnos       = request.getParameterValues("agnos");
        idpers = bd.consultaidpersonSeg(idact);
        
        //if(ret != 0 && agno != 0){

            //    for(int l = 1 ; l <= q ; l++){
              
         for(int wi = 0; wi < agnos.length; wi ++){
              //  bd.CreacionHorasPersonalSeg(Integer.parseInt(agnos[wi]), horaspart[wi], idpers);
                  bd.CreacionHorasPersonalSeg(Integer.parseInt(agnos[wi]), horaspart[wi], idpers, idact, idseg);
                agno = agno+1;
         }
            //    }
        //}           
        if(tipoalm.equals("AC")){
                  response.sendRedirect("/planeacion/seguimientoAC?idp="+idp+"&seg="+idseg+"#colsend"+idacret);
          }else{
                response.sendRedirect("/planeacion/seguimientoPR?idp="+idp+"&seg="+idseg+"#colsend"+idacret);
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
