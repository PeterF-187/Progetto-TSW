<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/IndexStyle.css">
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
                <span>Ciao, <%= username %></span>
                <a href="${pageContext.request.contextPath}/logout">Logout</a>
                <% } %>
            </li>
        </ul>
    </nav>
</div>
<! fine navbar, inizio sezione----------------------------------------------------------------------------------------------------- >


<main class="products-area">
    <c:choose>
        <c:when test="${not empty parametroRicerca}">
            <h2>Risultati della ricerca per: "${parametroRicerca}"</h2>
        </c:when>
        <c:otherwise>
            <h2>Tutti i Giochi</h2>
        </c:otherwise>
    </c:choose>

    <div class="products-grid">
        <c:forEach var="gioco" items="${videogiochi}">
            <a class="product-link"
               href="${pageContext.request.contextPath}/prodotto?id=${gioco.id_prodotto}">

                <div class="product-card">

                    <img src="${pageContext.request.contextPath}/img/giochi/${gioco.img}"
                         alt="${gioco.titolo}">

                    <div class="product-info">
                        <h3>${gioco.titolo}</h3>

                        <p class="description">
                                ${gioco.desc}
                        </p>

                        <div class="price-container">
                                <span class="price">
                                    € ${gioco.prezzo}
                                </span>
                        </div>
                    </div>

                </div>
            </a>
        </c:forEach>

        <c:if test="${empty videogiochi}">
            <p class="empty-message" style="grid-column: 1/-1; text-align: center; color: rgba(255,255,255,0.6); margin-top: 30px;">
                Nessun videogioco trovato con i criteri di ricerca specificati.
            </p>
        </c:if>
    </div>
</main>
</div>



<! fine sezione - inizio footer ----------------------------------------------------------------------------------------------------- >
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
                <li><a href="${pageContext.request.contextPath}/HowTo">Come acquistare</a></li>
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