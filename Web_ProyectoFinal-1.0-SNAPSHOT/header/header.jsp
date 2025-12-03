<!-- ===============================
     Header con hamburguesa
=============================== -->
<header class="main-header">
    <div class="header-left">
        <button class="btn btn-link" id="hamburgerBtn" aria-label="Menú">
            <i class="bi bi-list"></i>
        </button>
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
        <a href="inicio.jsp">Iniciar Sesion</a>
        <a href="catalogo.jsp">Catálogo</a>
        <a href="categoria.jsp?cat=ropa">Ropa</a>
        <a href="categoria.jsp?cat=accesorios">Accesorios</a>
        <a href="categoria.jsp?cat=calzado">Calzado</a>
        <a href="ofertas.jsp">Ofertas</a>
        <a href="acerca.jsp">Acerca de</a>
        <a href="contacto.jsp">Contacto</a>
        <a href="terminos.jsp">Términos y Condiciones</a>
    </div>
</header>

