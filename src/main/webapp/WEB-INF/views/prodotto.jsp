<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="model.Obj.Videogioco"%>

<%
    Videogioco gioco = (Videogioco) request.getAttribute("gioco");
%>
<html>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/prodotto.css">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/img/Logo.png">
    <title><%= gioco.getTitolo() %></title>
</head>
<body>

<div class="navbar">
    <a href="${pageContext.request.contextPath}/home" class="titolo">
        <img src="img/Logo.png" alt="Logo GameOrbit">
        <span>GameOrbit</span>
    </a>

    <div class="search-container">
        <form action="${pageContext.request.contextPath}/risultati" method="GET" autocomplete="off">
            <input type="text"
                   id="searchInput"
                   name="q"
                   placeholder="Cerca il tuo gioco..."
                   autocomplete="off"
                   spellcheck="false"/>

            <button type="submit">
                <i class="fa-solid fa-magnifying-glass"></i>
            </button>
        </form>
        <div id="suggestions"></div>
    </div>

    <script>
        const contextPath = "${pageContext.request.contextPath}";
    </script>
    <script src="${pageContext.request.contextPath}/JS/search.js"></script>
    <nav>
        <ul>
            <li><a href="${pageContext.request.contextPath}/wishlist" class="icon-link preferiti" title="Preferiti"><i class="fa-solid fa-heart icon"></i></a></li>
            <li><a href="${pageContext.request.contextPath}/carrello" class="icon-link carrello" title="Carrello"><i class="fa-solid fa-cart-shopping icon"></i></a></li>
            <%
                String username = (String) session.getAttribute("username");
            %>

            <li>
                <% if (username == null) { %>
                <a href="${pageContext.request.contextPath}/login">
                    Accedi | Registrati
                </a>
                <% } else { %>
                <a href="${pageContext.request.contextPath}/dashboard" class="username-link">
                    Ciao, <%= username %>
                </a>
                <a href="${pageContext.request.contextPath}/logout">Logout</a>
                <% } %>
            </li>
        </ul>
    </nav>
</div>
<!-- fine navbar inizio pagina -->

<div class="product-container">

    <img src="${pageContext.request.contextPath}/img/giochi/${gioco.img}">

    <div class="product-details">

        <h2>€ ${gioco.prezzo}</h2>

        <div class="product-description">
            ${gioco.desc}
        </div>

        <div class="product-section">
            <strong>Sviluppatore:</strong>
            <ul>
                <c:forEach var="s" items="${sviluppatori}">
                    <li>${s}</li>
                </c:forEach>
            </ul>
        </div>

        <div class="product-section">
            <strong>Publisher:</strong>
            <ul>
                <c:forEach var="p" items="${publishers}">
                    <li>${p}</li>
                </c:forEach>
            </ul>
        </div>

        <div class="product-section">
            <strong>Lingue supportate:</strong>
            <ul>
                <c:forEach var="l" items="${lingue}">
                    <li>${l}</li>
                </c:forEach>
            </ul>
        </div>

        <div class="product-section">
            <strong>Regioni:</strong>
            <ul>
                <c:forEach var="r" items="${regioni}">
                    <li>${r}</li>
                </c:forEach>
            </ul>
        </div>

        <c:if test="${not empty franchise}">
            <div class="franchise-box">
                Franchise:
                <c:forEach var="f" items="${franchise}">
                    ${f}
                </c:forEach>
            </div>
        </c:if>

    </div>
</div>

<div class="product-actions">

    <!-- CARRELLO -->
    <form action="${pageContext.request.contextPath}/carrello" method="POST">
        <input type="hidden" name="idProdotto" value="${gioco.id_prodotto}">
        <button type="submit" class="btn-cart">
            <i class="fa-solid fa-cart-plus"></i>
            Aggiungi al carrello
        </button>
    </form>

    <!-- WISHLIST -->
    <form action="${pageContext.request.contextPath}/wishlist" method="POST">
        <input type="hidden" name="idProdotto" value="${gioco.id_prodotto}">
        <button type="submit" class="btn-wishlist">
            <i class="fa-solid fa-heart"></i>
        </button>
    </form>

</div>

<section class="recommended-section">
    <h2>Consigliati</h2>
    <div class="recommended-grid">
        <c:forEach var="g" items="${consigliati}">
            <a class="recommended-card"
               href="${pageContext.request.contextPath}/prodotto?id=${g.id_prodotto}">
                <img src="${pageContext.request.contextPath}/img/giochi/${g.img}">
                <div class="recommended-info">
                    <h3>${g.titolo}</h3>
                    <span>€ ${g.prezzo}</span>
                </div>
            </a>
        </c:forEach>
    </div>
</section>

<!-- fine pagina inizio footer -->
<footer class="footer">
    <div class="footer-container">
        <div class="footer-column">
            <h3>Scarica la nostra app</h3>
            <p>Scarica l'app ufficiale di GameOrbit per non perdere nessuna offerta.</p>

            <div class="app-buttons">
                <a href="#" class="btn-app">
                    <i class="fa-brands fa-google-play"></i>
                    <div class="btn-text">
                        <span>Disponibile su</span>
                        <strong>Google Play</strong>
                    </div>
                </a>

                <a href="#" class="btn-app">
                    <i class="fa-brands fa-apple"></i>
                    <div class="btn-text">
                        <span>Scarica da</span>
                        <strong>App Store</strong>
                    </div>
                </a>
            </div>
        </div>
        <div class="footer-column">
            <h3>GameOrbit</h3>
            <p>Il tuo portale verso l'infinito videoludico. Esplora, colleziona, gioca.</p>
        </div>
        <div class="footer-column">
            <h3>Informazioni</h3>
            <ul>
                <li><a href="${pageContext.request.contextPath}/ChiSiamo">Chi siamo</a></li>
                <li><a href="${pageContext.request.contextPath}/Contattaci">Contattaci</a></li>
                <li><a href="${pageContext.request.contextPath}/affil">Diventa affiliato</a></li>
            </ul>
        </div>

        <div class="footer-column">
            <h3>Assistenza</h3>
            <ul>
                <li><a href="${pageContext.request.contextPath}/Howto">Come acquistare</a></li>
                <li><a href="${pageContext.request.contextPath}/FAQ">FAQ</a></li>
                <li><a href="${pageContext.request.contextPath}/PReso">Politica di reso</a></li>
                <li><a href="#">Crea ticket</a></li>
            </ul>
        </div>
        <div class="footer-column">
            <h3>Seguici</h3>
            <div class="social-icons">
                <a href="#"><i class="fa-brands fa-discord"></i></a>
                <a href="#"><i class="fa-brands fa-facebook"></i></a>
                <a href="#"><i class="fa-brands fa-instagram"></i></a>
                <a href="#"><i class="fa-brands fa-twitter"></i></a>
                <a href="#"><i class="fa-brands fa-twitch"></i></a>
            </div>
        </div>
    </div>
    <div class="footer-bottom">
        &copy; 2026 GameOrbit - Tutti i diritti riservati.
    </div>
</footer>

</body>
</html>
