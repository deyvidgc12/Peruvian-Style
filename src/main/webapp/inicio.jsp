<%--
    Document   : index
    Created on : 8 sept 2025, 0:52:00
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PERUVIAN&STYLE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style-footer.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/inicio.css">
    
</head>
<body>
    <!-- ===============================
     Header con hamburguesa
=============================== -->
<header class="main-header">
    <div class="header-left">
        <button class="btn btn-link" id="hamburgerBtn" aria-label="Menú">
            <i class="bi bi-list"></i>
        </button>
    </div>

    <div class="logo">
    <img src="img/logo_sin_fondo.png" alt="Peruvian&Style" class="logo-img">
    </div>



    <div class="header-right position-relative">
        <button class="btn btn-link" aria-label="Usuario">
            <i class="bi bi-person fs-5"></i>
        </button>
        <button class="btn btn-link" aria-label="Favoritos">
            <i class="bi bi-heart fs-5"></i>
        </button>
        <button class="btn btn-link position-relative" aria-label="Carrito">
            <i class="bi bi-cart fs-5"></i>
            <span class="cart-counter">3</span>
        </button>
    </div>

    <!-- Mini cuadro del menú hamburguesa -->
    <div class="hamburger-menu" id="hamburgerMenu">
        <a href="index.jsp">Inicio</a>
        <a href="catalogo.jsp">Catálogo</a>
        <a href="categoria.jsp?cat=ropa">Ropa</a>
        <a href="categoria.jsp?cat=accesorios">Accesorios</a>
        <a href="categoria.jsp?cat=calzado">Calzado</a>
        <a href="ofertas.jsp">Ofertas</a>
        <a href="sobre-nosotros.jsp">Acerca de</a>
        <a href="contacto.jsp">Contacto</a>
        <a href="terminos.jsp">Términos y Condiciones</a>
    </div>
</header>
    
    

    <div class="container">
        
        <br></br>
        <div id="carouselExampleIndicators" class="carousel slide carousel-fade" data-bs-ride="carousel" data-bs-interval="2000">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2"></button>
            </div>

            <div class="carousel-inner">
                <div class="carousel-item active">
                    <div class="img-wrapper">
                        <a href="catalogo.jsp?img=1">
                            <img src="img/1.PNG" alt="Foto 1">
                        </a>
                    </div>
                    <div class="carousel-caption">Imagen 1</div>
                </div>

                <div class="carousel-item">
                    <div class="img-wrapper">
                        <a href="catalogo.jsp?img=2">
                            <img src="img/2.jpg" alt="Foto 2">
                        </a>
                    </div>
                    <div class="carousel-caption">Imagen 2</div>
                </div>

                <div class="carousel-item">
                    <div class="img-wrapper">
                        <a href="catalogo.jsp?img=3">
                            <img src="img/3.jpg" alt="Foto 3">
                        </a>
                    </div>
                    <div class="carousel-caption">Imagen 3</div>
                </div>
            </div>

            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Anterior</span>
            </button>

            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Siguiente</span>
            </button>s
        </div>

        <div class="mini-carousel">
            <div class="mini-track">s
                <img src="img/4.jpg" alt="Mini 1">
                <img src="img/5.jpg" alt="Mini 2">
                <img src="img/6.jpg" alt="Mini 3">
                <img src="img/7.jpg" alt="Mini 4">
                <img src="img/4.jpg" alt="Mini 1">
                <img src="img/5.jpg" alt="Mini 2">
                <img src="img/6.jpg" alt="Mini 3">
                <img src="img/7.jpg" alt="Mini 4">
            </div>
        </div>
    </div>
    
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/header.js"></script>

</script>
<br></br>
<br></br>   
<br></br>
<br></br>
<br></br>
<br></br>
<br></br>

<%@ include file="/footer/footer.jsp" %>    
</body> 
</html>