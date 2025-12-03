<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:if test="${empty sessionScope.usuario}"><c:redirect url="/index.jsp"/></c:if>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mis Pedidos - Peruvian&Style</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/c_style.css"> 
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pedidos_style.css">
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            
            <nav class="col-md-3 col-lg-2 d-md-block sidebar">
                <div class="position-sticky pt-3">
                    
                    <a href="${pageContext.request.contextPath}/inicio.jsp">
                        <img src="${pageContext.request.contextPath}/img/logo_sin_fondo.png" alt="Logo" class="sidebar-logo mb-3">
                    </a>
                    
                    <h5 class="px-3 text-warning">Hola, ${sessionScope.usuario.nombre}!</h5>
                    <hr class="text-secondary">
                    
                    <ul class="nav flex-column">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/mi-cuenta"><i class="bi bi-person-circle me-2"></i> Mis Datos</a></li>
                        <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/mis-pedidos"><i class="bi bi-bag-check me-2"></i> Mis Pedidos</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/mis-favoritos"><i class="bi bi-heart me-2"></i> Favoritos</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/mis-tarjetas"><i class="bi bi-credit-card me-2"></i> Mis Tarjetas</a></li>
                    </ul>
                    
                    <hr class="text-secondary">
                    
                    <ul class="nav flex-column">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/inicio.jsp" style="color: #6c757d !important;"><i class="bi bi-arrow-left-circle me-2"></i> Regresar a Inicio</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i> Cerrar Sesión</a></li>
                        <li class="nav-item"><a class="nav-link text-danger" href="#" data-bs-toggle="modal" data-bs-target="#confirmarEliminarModal" data-delete-url="${pageContext.request.contextPath}/eliminar-cuenta"><i class="bi bi-trash me-2"></i> Eliminar Cuenta</a></li>
                    </ul>
                </div>
            </nav>
            <main class="col-md-9 ms-sm-auto col-lg-10 content-area">
                <h2 class="mb-4">Historial de Pedidos</h2>

                <div class="card p-5 text-center empty-history-card">
                    <i class="bi bi-bag-x display-1 mb-3 text-warning"></i>
                    <h3 class="card-title">Aún no has realizado ningún pedido.</h3>
                    <p class="text-secondary">Tu historial de compras aparecerá aquí.</p>
                    <a href="${pageContext.request.contextPath}/catalogo.jsp" class="btn btn-warning mt-3 w-50 mx-auto">Ver Catálogo</a>
                </div>
            </main>
        </div>
    </div>
    
    <div class="modal fade" id="confirmarEliminarModal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content" style="background-color: #1f1f1f; border: 1px solid #333;">
                <div class="modal-header border-bottom-0"><h5 class="modal-title text-warning" id="modalLabel"><i class="bi bi-person-x me-2"></i> Confirmación de Cierre de Cuenta</h5><button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button></div>
                <div class="modal-body"><p class="text-white">Esta acción es <strong>definitiva</strong> y <strong>no se puede deshacer</strong>.</p><p class="text-danger">Al confirmar, perderá permanentemente el acceso a su historial de pedidos, favoritos y datos guardados.</p><p class="text-warning mt-3">¿Desea continuar con la eliminación de su cuenta?</p></div>
                <div class="modal-footer border-top-0"><button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Mantener Mi Cuenta</button><a id="btnConfirmarEliminar" href="#" class="btn btn-danger">Sí, Eliminar Permanentemente</a></div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const confirmarModal = document.getElementById('confirmarEliminarModal');
            if (confirmarModal) {
                const btnConfirmar = document.getElementById('btnConfirmarEliminar'); 
                confirmarModal.addEventListener('show.bs.modal', function (event) {
                    const button = event.relatedTarget; 
                    const deleteUrl = button.getAttribute('data-delete-url');
                    if (btnConfirmar && deleteUrl) { btnConfirmar.href = deleteUrl; }
                });
            }
        });
    </script>
</body>
</html>