<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/wish.css">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/img/Logo.png">
    <title>Game Orbit</title>
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

<!-- fine navbar, inizio sezione----------------------------------------------------------------------------------------------------- -->

<main class="wishlist-container">

    <c:if test="${empty prodottiWishlist}">
        <p class="empty-message">La tua lista dei desideri è vuota!</p>
    </c:if>

    <c:if test="${not empty prodottiWishlist}">
        <c:forEach var="gioco" items="${prodottiWishlist}">
            <c:if test="${not empty gioco.titolo}">

                <div class="wishlist-item-row">

                    <div class="game-box">

                        <div class="game-info-left">
                            <c:choose>
                                <c:when test="${not empty gioco.img}">
                                    <img src="${pageContext.request.contextPath}/img/${gioco.img}" alt="${gioco.titolo}" class="wishlist-game-img">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/img/default-game.png" alt="Default" class="wishlist-game-img">
                                </c:otherwise>
                            </c:choose>
                            <span class="game-title">${gioco.titolo}</span>
                        </div>

                        <div class="game-actions-right">
                            <span class="game-price">${gioco.prezzo} €</span>

                            <form action="${pageContext.request.contextPath}/wishlist" method="POST" class="remove-form">
                                <input type="hidden" name="idProdotto" value="${gioco.id_prodotto}">
                                <input type="hidden" name="action" value="remove">
                                <button type="submit" class="btn-heart-remove">
                                    <i class="fa-solid fa-heart" style="color: red;"></i>
                                </button>
                            </form>
                        </div>

                    </div>

                    <div class="cart-action-box">
                        <form action="${pageContext.request.contextPath}/carrello" method="POST">
                            <input type="hidden" name="idProdotto" value="${gioco.id_prodotto}">
                            <button type="submit" class="btn-add-to-cart">Aggiungi al carrello</button>
                        </form>
                    </div>

                </div>

            </c:if>
        </c:forEach>
    </c:if>

</main>

<!-- fine sezione - inizio footer ----------------------------------------------------------------------------------------------------- -->
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