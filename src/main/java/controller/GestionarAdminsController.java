package controller;

import dao.UsuarioDAO;
import model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/gestionar-admins")
public class GestionarAdminsController extends HttpServlet {
    private final UsuarioDAO usuarioDAO = new UsuarioDAO();
    private final String SUPER_ADMIN_EMAIL = "admin@peruvianstyle.com";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuario") == null || !"admin".equals(((Usuario)session.getAttribute("usuario")).getRol())) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        if (session.getAttribute("mensaje") != null) {
            request.setAttribute("mensaje", session.getAttribute("mensaje"));
            session.removeAttribute("mensaje");
        }
        if (session.getAttribute("error") != null) {
            request.setAttribute("error", session.getAttribute("error"));
            session.removeAttribute("error");
        }
        
        List<Usuario> listaAdmins = usuarioDAO.obtenerTodosPorRol("admin");
        request.setAttribute("listaAdmins", listaAdmins);
        
        request.getRequestDispatcher("/administrador/gestionar_admins.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        Usuario adminLogueado = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (adminLogueado == null || !"admin".equals(adminLogueado.getRol())) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        String action = request.getParameter("action");
        boolean esSuperAdmin = SUPER_ADMIN_EMAIL.equals(adminLogueado.getCorreo());

        if (esSuperAdmin) {
            switch (action) {
                case "toggle_status":
                case "delete":
                    int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
                    Usuario adminAfectado = usuarioDAO.obtenerPorId(idUsuario);
                    if (adminAfectado != null && !SUPER_ADMIN_EMAIL.equals(adminAfectado.getCorreo())) {
                        if ("toggle_status".equals(action)) {
                            if ("activo".equals(adminAfectado.getEstado())) {
                                usuarioDAO.desactivarUsuario(idUsuario);
                            } else {
                                usuarioDAO.activarUsuario(idUsuario);
                            }
                        } else if ("delete".equals(action)) {
                            usuarioDAO.eliminarUsuarioFisico(idUsuario);
                        }
                    }
                    break;
                
                case "create":
                    Usuario nuevoAdmin = new Usuario();
                    nuevoAdmin.setNombre(request.getParameter("nombre"));
                    nuevoAdmin.setApellido(request.getParameter("apellido"));
                    nuevoAdmin.setCorreo(request.getParameter("correo"));
                    nuevoAdmin.setContrasena(request.getParameter("contrasena"));
                    nuevoAdmin.setTelefono(request.getParameter("telefono"));
                    nuevoAdmin.setDireccion(request.getParameter("direccion"));
                    if (usuarioDAO.crearAdmin(nuevoAdmin)) {
                        session.setAttribute("mensaje", "Administrador añadido correctamente.");
                    } else {
                        session.setAttribute("error", "Error al crear el administrador.");
                    }
                    break;

                case "update":
                    int idAdminUpdate = Integer.parseInt(request.getParameter("idUsuarioUpdate"));
                    Usuario adminUpdate = usuarioDAO.obtenerPorId(idAdminUpdate);
                    
                    // *** INICIO: LÓGICA DE ACTUALIZACIÓN DE DATOS Y CONTRASEÑA ***
                    String nuevaContrasena = request.getParameter("contrasena"); // <-- ¡Recoger el nuevo campo!

                    if (adminUpdate != null && !SUPER_ADMIN_EMAIL.equals(adminUpdate.getCorreo())) {
                        adminUpdate.setNombre(request.getParameter("nombre"));
                        adminUpdate.setApellido(request.getParameter("apellido"));
                        adminUpdate.setTelefono(request.getParameter("telefono"));
                        adminUpdate.setDireccion(request.getParameter("direccion"));
                        
                        // Llamar al DAO con la nueva contraseña (si se ingresó)
                        if (usuarioDAO.actualizarUsuario(adminUpdate, nuevaContrasena)) {
                           session.setAttribute("mensaje", "Datos del administrador actualizados.");
                        } else {
                           session.setAttribute("error", "Error al actualizar los datos.");
                        }
                    }
                    // *** FIN: LÓGICA DE ACTUALIZACIÓN ***
                    break;
            }
        } else {
            session.setAttribute("error", "No tienes permisos para realizar esta acción.");
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/gestionar-admins");
    }
}