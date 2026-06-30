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

<!-- fine navbar, inizio sezione----------------------------------------------------------------------------------------------------- -->

<section class="hero">

    <video autoplay muted loop playsinline class="hero-video">
        <source src="${pageContext.request.contextPath}/video/home.mp4" type="video/mp4">
    </video>

    <div class="hero-overlay"></div>

    <div class="hero-content">
        <h1>Benvenuti su GameOrbit</h1>
        <p>Dove i migliori giochi orbitano a prezzi imperdibili</p>
    </div>

</section>

<div class="home-container">

    <!-- SIDEBAR FILTRI -->
    <aside class="filters-sidebar">
        <h2>Filtri</h2>

        <form action="" method="GET">

            <!-- Categoria -->
            <div class="filter-group">
                <h3>Categoria</h3>

                <label><input type="checkbox" name="categoria[]" value="AAA">AAA</label>
                <label><input type="checkbox" name="categoria[]" value="AA">AA</label>
                <label><input type="checkbox" name="categoria[]" value="Indie">Indie</label>
                <label><input type="checkbox" name="categoria[]" value="Free_to_play">Free_to_play</label>
                <label><input type="checkbox" name="categoria[]" value="Single_player">Single_player</label>
                <label><input type="checkbox" name="categoria[]" value="Co_op">Co_op</label>
                <label><input type="checkbox" name="categoria[]" value="Multiplayer">Multiplayer</label>
                <label><input type="checkbox" name="categoria[]" value="MMO">MMO</label>
                <label><input type="checkbox" name="categoria[]" value="VR">VR</label>
                <label><input type="checkbox" name="categoria[]" value="Casual">Casual</label>
                <label><input type="checkbox" name="categoria[]" value="Hardcore">Hardcore</label>
                <label><input type="checkbox" name="categoria[]" value="Esport">Esport</label>
            </div>
            <div class="filter-group">
                <h3>Genere</h3>

                <label><input type="checkbox" name="genere[]" value="Azione">Azione</label>
                <label><input type="checkbox" name="genere[]" value="Avventura">Avventura</label>
                <label><input type="checkbox" name="genere[]" value="Sparatutto">Sparatutto</label>
                <label><input type="checkbox" name="genere[]" value="RPG">RPG</label>
                <label><input type="checkbox" name="genere[]" value="Strategia">Strategia</label>
                <label><input type="checkbox" name="genere[]" value="Simulazione">Simulazione</label>
                <label><input type="checkbox" name="genere[]" value="Sport">Sport</label>
                <label><input type="checkbox" name="genere[]" value="Picchiaduro">Picchiaduro</label>
                <label><input type="checkbox" name="genere[]" value="Platform">Platform</label>
                <label><input type="checkbox" name="genere[]" value="Pazzle">Pazzle</label>
                <label><input type="checkbox" name="genere[]" value="Survival">Survival</label>
                <label><input type="checkbox" name="genere[]" value="Horror">Horror</label>
                <label><input type="checkbox" name="genere[]" value="Racing">Racing</label>
            </div>

            <!-- Prezzo -->
            <div class="filter-group">
                <h3>Prezzo in</h3>
                <label>Da:<input type="number" name="minPrice" min="0"></label>
                <label>A:<input type="number" name="maxPrice" min="0"></label>
            </div>

            <!-- Piattaforma -->
            <div class="filter-group">
                <h3>Piattaforma</h3>

                <label><input type="checkbox" name="piattaforma[]" value="Playstation_5">PS5</label>
                <label><input type="checkbox" name="piattaforma[]" value="Playstation_4">PS4</label>
                <label><input type="checkbox" name="piattaforma[]" value="XBOX">XBOX</label>
                <label><input type="checkbox" name="piattaforma[]" value="Nintendo_Switch">Nintendo switch</label>
                <label><input type="checkbox" name="piattaforma[]" value="Nintendo_Switch_2">Nintendo swtch 2</label>
                <label><input type="checkbox" name="piattaforma[]" value="Pc">PC</label>
            </div>

            <!-- Lingua -->
            <div class="filter-group">
                <h3>Lingua</h3>

                <label><input type="checkbox" name="lingua[]" value="Italiano">Italiano</label>
                <label><input type="checkbox" name="lingua[]" value="Inglese">Inglese</label>
                <label><input type="checkbox" name="lingua[]" value="Spagnolo">Spagnolo</label>
                <label><input type="checkbox" name="lingua[]" value="Russo">Russo</label>
                <label><input type="checkbox" name="lingua[]" value="Mandarino">Mandarino</label>
            </div>

            <!-- Regione -->
            <div class="filter-group">
                <h3>Regione</h3>

                <label><input type="checkbox" name="regione[]" value="Global">Global</label>
                <label><input type="checkbox" name="regione[]" value="Europa">Europa</label>
                <label><input type="checkbox" name="regione[]" value="Italia">Italia</label>
                <label><input type="checkbox" name="regione[]" value="Turchia">Turchia</label>
            </div>

            <button type="submit" class="filter-btn">
                Applica filtri
            </button>

        </form>
    </aside>

    <!-- PRODOTTI -->
    <main class="products-area">
        <h2>Giochi In Evidenza</h2>

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
                <p>Nessun gioco disponibile nel catalogo.</p>
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