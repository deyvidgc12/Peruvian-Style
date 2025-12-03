<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${empty sessionScope.usuario or (sessionScope.usuario.rol != 'admin' and sessionScope.usuario.rol != 'empleado')}">
    <c:redirect url="/index.jsp"/>
</c:if>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestionar Clientes - Admin</title>
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
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin/gestionar-clientes"><i class="bi bi-people me-2"></i> Gestionar Clientes</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/gestionar-admins"><i class="bi bi-person-gear me-2"></i> Gestionar Admins</a></li>                <hr><li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-left me-2"></i> Cerrar Sesión</a></li>
            </ul>
        </nav>

        <div class="admin-main-content">
            <header class="top-header"></header>
            <main class="container-fluid p-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>Gestionar Clientes</h2>
                </div>
                
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <div class="card">
                    <div class="card-body">
                        <table class="table table-dark table-hover align-middle">
                            <thead>
                                <tr>
                                    <th>ID</th><th>Nombre Completo</th><th>Correo</th><th>Teléfono</th><th>Estado</th><th class="text-end">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="cliente" items="${listaClientes}">
                                    <tr>
                                        <td>${cliente.id_usuario}</td>
                                        <td>${cliente.nombre} ${cliente.apellido}</td>
                                        <td>${cliente.correo}</td>
                                        <td>${cliente.telefono}</td>
                                        <td><span class="badge ${cliente.estado == 'activo' ? 'bg-success' : 'bg-secondary'}">${cliente.estado}</span></td>
                                        <td class="text-end">
                                            <form action="${pageContext.request.contextPath}/admin/gestionar-clientes" method="post" class="d-inline">
                                                <input type="hidden" name="idUsuario" value="${cliente.id_usuario}">
                                                <input type="hidden" name="action" value="toggle_status">
                                                <c:choose>
                                                    <c:when test="${cliente.estado == 'activo'}"><button type="submit" class="btn btn-sm btn-outline-warning" title="Desactivar"><i class="bi bi-person-x"></i></button></c:when>
                                                    <c:otherwise><button type="submit" class="btn btn-sm btn-outline-success" title="Activar"><i class="bi bi-person-check"></i></button></c:otherwise>
                                                </c:choose>
                                            </form>

                                            <button class="btn btn-sm btn-outline-danger" title="Eliminar Permanentemente"
                                                    data-bs-toggle="modal" data-bs-target="#eliminarClienteModal"
                                                    data-id="${cliente.id_usuario}"
                                                    ${cliente.estado == 'activo' ? 'disabled' : ''}>
                                                <i class="bi bi-trash"></i>
                                            </button>
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

    <div class="modal fade" id="eliminarClienteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="background-color: #1f1f1f; border: 1px solid #333;">
                <form action="${pageContext.request.contextPath}/admin/gestionar-clientes" method="post">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="idUsuario" id="delete-id-usuario">
                    <div class="modal-header border-bottom-0">
                        <h5 class="modal-title text-danger" id="deleteModalLabel"><i class="bi bi-exclamation-triangle-fill me-2"></i> Confirmar Eliminación</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>
                    <div class="modal-body">
                        <p>¿Estás seguro de que quieres eliminar este cliente permanentemente? Esta acción es irreversible.</p>
                    </div>
                    <div class="modal-footer border-top-0">
                        <button type="submit" class="btn btn-danger">Sí, Eliminar</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const eliminarClienteModal = document.getElementById('eliminarClienteModal');
            if (eliminarClienteModal) {
                eliminarClienteModal.addEventListener('show.bs.modal', function (event) {
                    const button = event.relatedTarget;
                    const id = button.getAttribute('data-id');
                    const idInput = document.getElementById('delete-id-usuario');
                    idInput.value = id;
                });
            }
        });
    </script>
</body>
</html>