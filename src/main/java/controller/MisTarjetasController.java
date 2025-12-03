package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/mis-tarjetas")
public class MisTarjetasController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Validar Sesión
        if (request.getSession(false) == null || request.getSession(false).getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        // 2. Por ahora no hay lógica de BD, solo reenviamos al JSP
        request.getRequestDispatcher("/cliente/mis_tarjetas.jsp").forward(request, response);
    }
}