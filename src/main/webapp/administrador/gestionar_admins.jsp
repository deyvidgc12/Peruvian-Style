<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${empty sessionScope.usuario or sessionScope.usuario.rol != 'admin'}">
    <c:redirect url="/index.jsp"/>
</c:if>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestionar Administradores - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin_dashboard_style.css">
</head>
<body>
    <div class="admin-layout">
        <nav class="admin-sidebar">
            <a href="${pageContext.request.contextPath}/admin/dashboard"><img src="${pageContext.request.contextPath}/img/logo_sin_fondo.png" alt="Logo" class="sidebar-logo"></a>
            <ul class="nav flex-column">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard"><i class="bi bi-speedometer2 me-2"></i> Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/gestionar-productos"><i class="bi bi-box-seam me-2"></i> Gestionar Productos</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/gestionar-ventas"><i class="bi bi-cart4 me-2"></i> Gestionar Ventas</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/gestionar-clientes"><i class="bi bi-people me-2"></i> Gestionar Clientes</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/gestionar-admins"><i class="bi bi-person-gear me-2"></i> Gestionar Admins</a></li>
                <hr><li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-left me-2"></i> Cerrar Sesión</a></li>
            </ul>
        </nav>

        <div class="admin-main-content">
            <header class="top-header"></header>
            <main class="container-fluid p-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>Gestionar Administradores</h2>
                    <c:if test="${sessionScope.usuario.correo == 'admin@peruvianstyle.com'}">
                        <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#agregarAdminModal"><i class="bi bi-plus-circle me-2"></i>Añadir Nuevo Admin</button>
                    </c:if>
                </div>
                
                <c:if test="${not empty mensaje}"><div class="alert alert-success">${mensaje}</div></c:if>
                <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

                <div class="card">
                    <div class="card-body">
                        <table class="table table-dark table-hover align-middle">
                            <thead>
                                <tr>
                                    <th>ID</th><th>Nombre Completo</th><th>Correo</th><th>Teléfono</th><th>Estado</th><th class="text-end">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="admin" items="${listaAdmins}">
                                    <tr>
                                        <td>${admin.id_usuario}</td>
                                        <td>${admin.nombre} ${admin.apellido}</td>
                                        <td>${admin.correo}</td>
                                        <td>${admin.telefono}</td>
                                        <td><span class="badge ${admin.estado == 'activo' ? 'bg-success' : 'bg-secondary'}">${admin.estado}</span></td>
                                        <td class="text-end">
                                            <c:if test="${sessionScope.usuario.correo == 'admin@peruvianstyle.com' and admin.correo != 'admin@peruvianstyle.com'}">
                                                <button class="btn btn-sm btn-outline-info" title="Editar" data-bs-toggle="modal" data-bs-target="#editarAdminModal" data-id="${admin.id_usuario}" data-nombre="${admin.nombre}" data-apellido="${admin.apellido}" data-telefono="${admin.telefono}" data-direccion="${admin.direccion}"><i class="bi bi-pencil"></i></button>
                                                
                                                <form action="${pageContext.request.contextPath}/admin/gestionar-admins" method="post" class="d-inline">
                                                    <input type="hidden" name="idUsuario" value="${admin.id_usuario}"><input type="hidden" name="action" value="toggle_status">
                                                    <c:choose>
                                                        <c:when test="${admin.estado == 'activo'}"><button type="submit" class="btn btn-sm btn-outline-warning" title="Desactivar"><i class="bi bi-person-x"></i></button></c:when>
                                                        <c:otherwise><button type="submit" class="btn btn-sm btn-outline-success" title="Activar"><i class="bi bi-person-check"></i></button></c:otherwise>
                                                    </c:choose>
                                                </form>

                                                <button class="btn btn-sm btn-outline-danger" title="Eliminar Permanentemente" data-bs-toggle="modal" data-bs-target="#eliminarAdminModal" data-id="${admin.id_usuario}"><i class="bi bi-trash"></i></button>
                                            </c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <div class="modal fade" id="agregarAdminModal" tabindex="-1" aria-labelledby="addModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content" style="background-color: #1f1f1f; border: 1px solid #333;">
                <form action="${pageContext.request.contextPath}/admin/gestionar-admins" method="post">
                    <input type="hidden" name="action" value="create">
                    <div class="modal-header border-bottom-0"><h5 class="modal-title text-warning" id="addModalLabel">Añadir Nuevo Administrador</h5><button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button></div>
                    <div class="modal-body">
                        <div class="row"><div class="col-md-6 mb-3"><label for="nombre" class="form-label">Nombre</label><input type="text" class="form-control bg-dark text-white" name="nombre" required></div><div class="col-md-6 mb-3"><label for="apellido" class="form-label">Apellido</label><input type="text" class="form-control bg-dark text-white" name="apellido" required></div></div>
                        <div class="row"><div class="col-md-6 mb-3"><label for="correo" class="form-label">Correo</label><input type="email" class="form-control bg-dark text-white" name="correo" required></div><div class="col-md-6 mb-3"><label for="contrasena" class="form-label">Contraseña</label><input type="password" class="form-control bg-dark text-white" name="contrasena" required></div></div>
                        <div class="mb-3"><label for="telefono" class="form-label">Teléfono</label><input type="text" class="form-control bg-dark text-white" name="telefono"></div>
                        <div class="mb-3"><label for="direccion" class="form-label">Dirección</label><textarea class="form-control bg-dark text-white" name="direccion" rows="2"></textarea></div>
                    </div>
                    <div class="modal-footer border-top-0"><button type="submit" class="btn btn-warning">Guardar Administrador</button><button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button></div>
                </form>
            </div>
        </div>
    </div>
    
    <div class="modal fade" id="editarAdminModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content" style="background-color: #1f1f1f; border: 1px solid #333;">
                <form action="${pageContext.request.contextPath}/admin/gestionar-admins" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="idUsuarioUpdate" id="edit-id-admin">
                    <div class="modal-header border-bottom-0"><h5 class="modal-title text-warning" id="editModalLabel">Editar Administrador</h5><button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button></div>
                    <div class="modal-body">
                        <div class="row"><div class="col-md-6 mb-3"><label for="edit-nombre" class="form-label">Nombre</label><input type="text" class="form-control bg-dark text-white" id="edit-nombre" name="nombre" required></div><div class="col-md-6 mb-3"><label for="edit-apellido" class="form-label">Apellido</label><input type="text" class="form-control bg-dark text-white" id="edit-apellido" name="apellido" required></div></div>
                        <div class="mb-3"><label for="edit-telefono" class="form-label">Teléfono</label><input type="text" class="form-control bg-dark text-white" id="edit-telefono" name="telefono"></div>
                        <div class="mb-3"><label for="edit-direccion" class="form-label">Dirección</label><textarea class="form-control bg-dark text-white" id="edit-direccion" name="direccion" rows="2"></textarea></div>
                        <div class="mb-3"><label for="edit-contrasena" class="form-label">Nueva Contraseña (Opcional)</label><input type="password" class="form-control bg-dark text-white" id="edit-contrasena" name="contrasena" placeholder="Dejar en blanco para no cambiar"></div>
                    </div>
                    <div class="modal-footer border-top-0"><button type="submit" class="btn btn-info">Guardar Cambios</button><button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button></div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal fade" id="eliminarAdminModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="background-color: #1f1f1f; border: 1px solid #333;">
                <form action="${pageContext.request.contextPath}/admin/gestionar-admins" method="post">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="idUsuario" id="delete-id-admin">
                    <div class="modal-header border-bottom-0"><h5 class="modal-title text-danger" id="deleteModalLabel">Confirmar Eliminación</h5><button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button></div>
                    <div class="modal-body"><p>¿Estás seguro de que quieres eliminar este administrador permanentemente?</p></div>
                    <div class="modal-footer border-top-0"><button type="submit" class="btn btn-danger">Sí, Eliminar</button><button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button></div>
                </form>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Script para el modal de EDICIÓN
            const editarAdminModal = document.getElementById('editarAdminModal');
            if (editarAdminModal) {
                editarAdminModal.addEventListener('show.bs.modal', function (event) {
                    const button = event.relatedTarget;
                    document.getElementById('edit-id-admin').value = button.getAttribute('data-id');
                    document.getElementById('edit-nombre').value = button.getAttribute('data-nombre');
                    document.getElementById('edit-apellido').value = button.getAttribute('data-apellido');
                    document.getElementById('edit-telefono').value = button.getAttribute('data-telefono');
                    document.getElementById('edit-direccion').value = button.getAttribute('data-direccion');
                    document.getElementById('edit-contrasena').value = ''; // Limpiar campo de contraseña
                });
            }

            // Script para el modal de ELIMINACIÓN
            const eliminarAdminModal = document.getElementById('eliminarAdminModal');
            if (eliminarAdminModal) {
                eliminarAdminModal.addEventListener('show.bs.modal', function (event) {
                    const button = event.relatedTarget;
                    const id = button.getAttribute('data-id');
                    const idInput = document.getElementById('delete-id-admin');
                    idInput.value = id;
                });
            }
        });
    </script>
</body>
</html>