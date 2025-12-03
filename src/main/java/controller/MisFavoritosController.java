package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/mis-favoritos")
public class MisFavoritosController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Validar Sesión
        if (request.getSession(false) == null || request.getSession(false).getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        // Por ahora no pasamos datos, así que la maqueta se mostrará.
        
        // 2. Reenviar al JSP correcto
        request.getRequestDispatcher("/cliente/mis_favoritos.jsp").forward(request, response);
    }
}