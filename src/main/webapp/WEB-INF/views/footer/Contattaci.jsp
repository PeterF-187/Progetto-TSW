<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/img/Logo.png">
    <title>Contattaci</title>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <a href="${pageContext.request.contextPath}/home" class="titolo">
        <img src="${pageContext.request.contextPath}/img/Logo.png" alt="Logo GameOrbit">
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

            <button type="submit">Cerca</button>
        </form>
        <div id="suggestions"></div>
    </div>

    <script>
        const contextPath = "${pageContext.request.contextPath}";
    </script>
    <script src="${pageContext.request.contextPath}/JS/search.js"></script>
    <nav>
        <ul>
            <li><a href="${pageContext.request.contextPath}/wishlist" class="icon-link preferiti" title="Preferiti">Preferiti</a></li>
            <li><a href="${pageContext.request.contextPath}/carrello" class="icon-link carrello" title="Carrello">Carrello</a></li>
            <%
                String username = (String) session.getAttribute("username");
            %>

            <li>
                <% if (username == null) { %>
                <a href="${pageContext.request.contextPath}/WEB-INF/View/auth.jsp">
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

<!-- fine navbar, inizio sezione -->
<div class="container">
    <h1>Contattaci</h1>
    <br><br>
    <p>Potete contattare direttamente i proprietari:
        - Pietro Fiore: fpietro187@gmail.com
        - Michele D'ambola: micheledambola5@gmail.com</p>
</div>

<!-- fine sezione, inizio footer -->
<footer class="footer">
    <div class="footer-container">
        <div class="footer-column">
            <h3>Scarica la nostra app</h3>
            <p>Scarica l'app ufficiale di GameOrbit per non perdere nessuna offerta.</p>

            <div class="app-buttons">
                <a href="#" class="btn-app">
                    <div class="btn-text">
                        <span>Disponibile su</span>
                        <strong>Google Play</strong>
                    </div>
                </a>

                <a href="#" class="btn-app">
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
                <a href="#">Discord</a>
                <a href="#">Facebook</a>
                <a href="#">Instagram</a>
                <a href="#">Twitter</a>
                <a href="#">Twitch</a>
            </div>
        </div>
    </div>
    <div class="footer-bottom">
        &copy; 2026 GameOrbit - Tutti i diritti riservati.
    </div>
</footer>

</body>
</html>