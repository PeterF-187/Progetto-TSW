<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/img/Logo.png">
    <title>Come Acquistare</title>
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
    <h1>Chi siamo</h1>
    <br><br>
    <p>Benvenuto su GameOrbit, il punto di riferimento nello spazio digitale per tutti gli appassionati di videogiochi.
        Siamo una piattaforma nata da videogiocatori, per i videogiocatori. Il nostro obiettivo è abbattere le distanze tra te e le tue avventure preferite, offrendoti un accesso immediato, sicuro e conveniente alle migliori product-key del mercato per PC e console.
    </p>
        <br><br>
    <h3>La Nostra Missione</h3>
       <br>
    <p>In un universo gaming in continua espansione, vogliamo essere la tua rotta più veloce. Selezioniamo e distribuiamo codici digitali ufficiali e garantiti, eliminando i tempi di attesa della spedizione fisica: acquisti con un clic, riscatti sulla tua piattaforma preferita (Steam, Epic Games, PlayStation, Xbox) e sei subito pronto a giocare.
    </p>
    <br><br>
    <h3>Perché Scegliere GameOrbit?</h3>
    <br>
    <p>Velocità Orbitale: Nessuna attesa. Il tuo codice viene generato e consegnato all'istante direttamente nella tua area personale.
        Prezzi Stellari: Lavoriamo costantemente per offrirti i titoli più caldi del momento e i grandi classici ai prezzi più competitivi del web.
        Sicurezza al 100%: Ogni transazione è protetta dai più alti standard di sicurezza e ogni chiave proviene da canali ufficiali e verificati.
        Supporto Sempre Attivo: Il nostro team di assistenza è sempre pronto ad aiutarti a risolvere qualsiasi dubbio o problema con il riscatto dei tuoi giochi.
        Allaccia le cinture e preparati a esplorare nuovi mondi. Il tuo prossimo viaggio videoludico parte da qui.
    </p>
</div>

<!-- fine sezione, inizio footer -->
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
