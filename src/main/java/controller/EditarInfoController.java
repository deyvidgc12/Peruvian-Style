package controller;

import dao.UsuarioDAO;
import model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/editar-info")
public class EditarInfoController extends HttpServlet {

    private final UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Verifica la sesión y reenvía al formulario
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        request.getRequestDispatcher("/cliente/editar_info.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        Usuario usuarioActualizado = (Usuario) session.getAttribute("usuario");
        
        // 1. Recoger datos
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String telefono = request.getParameter("telefono");
        String direccion = request.getParameter("direccion");
        String contrasenaNueva = request.getParameter("contrasena");

        // 2. Actualizar objeto en sesión
        usuarioActualizado.setNombre(nombre);
        usuarioActualizado.setApellido(apellido);
        usuarioActualizado.setTelefono(telefono);
        usuarioActualizado.setDireccion(direccion);
        
        // 3. Llamar al DAO
        if (usuarioDAO.actualizarUsuario(usuarioActualizado, contrasenaNueva)) {
            
            // 4. Si tiene éxito, actualizar la sesión y mostrar mensaje
            session.setAttribute("usuario", usuarioActualizado);
            session.setAttribute("mensaje", "Información actualizada correctamente.");
            response.sendRedirect(request.getContextPath() + "/mi-cuenta"); 
            
        } else {
            // 5. Si falla, mostrar error
            request.setAttribute("error", "Error al guardar los cambios en la base de datos.");
            request.getRequestDispatcher("/cliente/editar_info.jsp").forward(request, response);
        }
    }
}