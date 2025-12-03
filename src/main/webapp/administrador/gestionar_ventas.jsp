<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="es_PE" />

<c:if test="${empty sessionScope.usuario or (sessionScope.usuario.rol != 'admin' and sessionScope.usuario.rol != 'empleado')}">
    <c:redirect url="/index.jsp"/>
</c:if>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestionar Ventas - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin_dashboard_style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin_gestionar_ventas_style.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/gestionar-admins"><i class="bi bi-person-gear me-2"></i> Gestionar Admins</a></li>                <hr><li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-left me-2"></i> Cerrar Sesión</a></li>
            </ul>
        </nav>

        <div class="admin-main-content">
            <header class="top-header"></header>
            <main class="container-fluid p-4">
                <h2 class="mb-4">Análisis de Ventas</h2>

                <div class="row">
                    <div class="col-lg-4 mb-4"><div class="card kpi-card kpi-4"><div class="card-body"><div><h3><fmt:formatNumber value="${kpiIngresosTotales}" type="currency" currencySymbol="S/ "/></h3><p>Ingresos Totales</p></div><i class="bi bi-cash-stack"></i></div></div></div>
                    <div class="col-lg-4 mb-4"><div class="card kpi-card kpi-2"><div class="card-body"><div><h3>${kpiVentasTotales}</h3><p>Ventas Realizadas</p></div><i class="bi bi-check-circle"></i></div></div></div>
                    <div class="col-lg-4 mb-4"><div class="card kpi-card kpi-3"><div class="card-body"><div><h3>${kpiClientesUnicos}</h3><p>Clientes Únicos</p></div><i class="bi bi-person-check"></i></div></div></div>
                </div>

                <div class="row">
                    <div class="col-12 mb-4">
                        <div class="card">
                            <div class="card-header">Ingresos de los últimos 7 días</div>
                            <div class="card-body"><canvas id="ventasChart"></canvas></div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">Historial de Todos los Pedidos</div>
                            <div class="card-body">
                                <table class="table table-dark table-hover align-middle">
                                    <thead>
                                        <tr>
                                            <th># Pedido</th>
                                            <th>Cliente</th>
                                            <th>Fecha</th>
                                            <th>Total</th>
                                            <th>Estado</th>
                                            <th class="text-end">Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="pedido" items="${listaPedidos}">
                                            <tr>
                                                <td>${pedido.id_pedido}</td>
                                                <td>${pedido.nombreCliente}</td>
                                                <td><fmt:formatDate value="${pedido.fecha_pedido}" pattern="dd/MM/yyyy HH:mm"/></td>
                                                <td><fmt:formatNumber value="${pedido.total}" type="currency" currencySymbol="S/ "/></td>
                                                <td><span class="status-badge status-${pedido.estado}">${pedido.estado}</span></td>
                                                <td class="text-end">
                                                    <button class="btn btn-sm btn-outline-info" title="Ver Detalle"><i class="bi bi-search"></i></button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script>
        const ventasData = [<c:forEach var="venta" items="${ventas7Dias}" varStatus="loop">${venta}${!loop.last ? ',' : ''}</c:forEach>];
        new Chart(document.getElementById('ventasChart'), {
            type: 'bar',
            data: { 
                labels: ['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'], 
                datasets: [{ 
                    label: 'Ingresos (S/)', 
                    data: ventasData, 
                    backgroundColor: '#ffc107', 
                    borderRadius: 5 
                }] 
            },
            options: { scales: { y: { beginAtZero: true, ticks:{color:'#e0e0e0'}, grid:{color:'#333'} }, x: { ticks:{color:'#e0e0e0'}, grid:{color:'#333'} } }, plugins: { legend: { labels: { color: '#e0e0e0' } } } }
        });
    </script>
</body>
</html>