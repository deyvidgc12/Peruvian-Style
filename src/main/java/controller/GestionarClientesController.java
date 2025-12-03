package controller;

import dao.UsuarioDAO;
import model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/gestionar-clientes")
public class GestionarClientesController extends HttpServlet {
    private final UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // (Validación de sesión de admin)
        // ...

        List<Usuario> listaClientes = usuarioDAO.obtenerTodosPorRol("cliente");
        request.setAttribute("listaClientes", listaClientes);
        
        // Mover mensajes de error de la sesión al request para mostrarlos
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("error") != null) {
            request.setAttribute("error", session.getAttribute("error"));
            session.removeAttribute("error");
        }

        request.getRequestDispatcher("/administrador/gestionar_clientes.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));

        switch (action) {
            case "toggle_status":
                Usuario cliente = usuarioDAO.obtenerPorId(idUsuario);
                if (cliente != null) {
                    if ("activo".equals(cliente.getEstado())) {
                        usuarioDAO.desactivarUsuario(idUsuario);
                    } else {
                        usuarioDAO.activarUsuario(idUsuario);
                    }
                }
                break;
            case "delete":
                Usuario clienteParaBorrar = usuarioDAO.obtenerPorId(idUsuario);
                if (clienteParaBorrar != null && "inactivo".equals(clienteParaBorrar.getEstado())) {
                    usuarioDAO.eliminarUsuarioFisico(idUsuario);
                } else {
                    request.getSession().setAttribute("error", "Solo se pueden eliminar clientes que estén inactivos.");
                }
                break;
        }
        
        // *** INICIO: CORRECCIÓN CRÍTICA ***
        // Usar sendRedirect fuerza una nueva petición GET, recargando la tabla.
        response.sendRedirect(request.getContextPath() + "/admin/gestionar-clientes");
        // *** FIN: CORRECCIÓN ***
    }
}