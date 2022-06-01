/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador.Seguimiento;

import BDatos.BDServicios;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

/**
 *
 * @author Juan Vanzina
 */
public class CargaArchivosSeg extends HttpServlet {

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
            out.println("<title>Servlet CargaArchivosSeg</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CargaArchivosSeg at " + request.getContextPath() + "</h1>");
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
       // processRequest(request, response);
        
                   BDServicios bd = new BDServicios();
        

            String idart, idseg, idact, tipo, numerosig, verif, NaArch = "NotName", Name="", reto;
            int NumeroAr = 0;
                    
             String tipoalm= "";
        
        
             idart      = "";
             idseg      = "";
             tipo       = "";
             numerosig  = "";
             verif      = "";
             idact      = "";
             reto       = "";
        
             //String archivourl = "C:\\Users\\Desarrollo\\Desktop\\Proyectos\\ZPruebasCarga";
             String archivourl = "/home/shares/ODI";
             
             try {

                DiskFileItemFactory factory = new DiskFileItemFactory();
                factory.setSizeThreshold(10 * 1024 * 1024); 
                factory.setRepository(new File(archivourl));
                ServletFileUpload upload = new ServletFileUpload(factory);
             
                 List<FileItem> partes = upload.parseRequest(request);
             
                  BDServicios c = new BDServicios();

                 for(FileItem items: partes){
                    
                     if (items.isFormField()) {
                            
                            if (items.getFieldName().equals("tipoalm")) {
                                 tipoalm = items.getString();
                             }
                            if (items.getFieldName().equals("idp")) {
                                 idart = items.getString();
                             }
                            if (items.getFieldName().equals("idseg")) {
                                 idseg = items.getString();
                             }
                            if (items.getFieldName().equals("idact")) {
                                 idact = items.getString();
                             }
                            if (items.getFieldName().equals("numerosig")) {
                                 numerosig = items.getString();
                             }
                            if (items.getFieldName().equals("obsar")) {
                                 verif = items.getString();
                             }
                            if (items.getFieldName().equals("inicial")) {
                                 tipo = items.getString();
                             }
                            if (items.getFieldName().equals("reto")) {
                                 reto = items.getString();
                             }
                     }
                     else{  

                                 NaArch = items.getName();   
                                 String Ext = FilenameUtils.getExtension(NaArch);
                                 Name = tipo+idart+"-"+numerosig+"."+Ext;
                                 File file = new File(archivourl, Name);
                                 items.write(file);
                             
                     }
                 }
                     
                     int retorno = bd.RegistrarArchivo(Name, NaArch, idart, idact, "1", verif, idseg);
                     
                     if(reto.equals("p")){
                         response.sendRedirect("/planeacion/seguimientoPR?idp="+idart+"&seg="+idseg+"#collapseOne");
                     }
                     else{
                        if(tipoalm.equals("AC")) {
                        response.sendRedirect("/planeacion/seguimientoAC?idp="+idart+"&seg="+idseg+"#collapseFour");    
                        }
                        else{
                        response.sendRedirect("/planeacion/seguimientoPR?idp="+idart+"&seg="+idseg+"#collapseFour");
                        }
                     }
                  
                } catch (Exception e) {
                 
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
