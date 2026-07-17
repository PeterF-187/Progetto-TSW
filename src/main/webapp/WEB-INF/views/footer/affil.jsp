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
    <h1>Diventa Affiliato</h1>

    <p>
        Hai un canale Twitch, YouTube, un profilo social dedicato al gaming o semplicemente una community di amici appassionati di videogiochi?
        Trasforma la tua passione in un vero e proprio guadagno! Unisciti al programma di affiliazione di GameOrbit e inizia a guadagnare commissioni
        ogni volta che qualcuno acquista un gioco consigliato da te.
    </p>
    <br><br>

    <h3>Come Funziona?</h3>
    <br>
    <p>
        Il funzionamento è semplicissimo e immediato. Per prima cosa iscriviti gratuitamente compilando il modulo di richiesta in pochi secondi per entrare a far parte della nostra crew.
        Successivamente, genera i tuoi link personalizzati per i giochi in catalogo e condividili sui tuoi canali o con i tuoi amici.
        Infine, guadagna su ogni vendita: riceverai una commissione fino al 10% per ogni product-key acquistata direttamente tramite il tuo link personalizzato.
    </p>
    <br><br>

    <h3>I Vantaggi per Te</h3>
    <br>
    <p>
        Entrando nel programma avrai accesso a guadagni elevati con commissioni competitive su tutto il nostro catalogo di giochi PC, console e abbonamenti.
        Potrai contare su un tracciamento trasparente grazie a una dashboard personale per monitorare i tuoi clic, le vendite e i tuoi guadagni in tempo reale.
        Ti forniremo inoltre un supporto dedicato con grafiche, banner e assistenza prioritaria per aiutarti a ottimizzare i tuoi contenuti.
        I pagamenti sono sempre puntuali e vengono accreditati ogni mese direttamente sul tuo conto tramite PayPal o bonifico bancario.
    </p>
    <br><br>

    <h3>Pronto a Spiccare il Volo?</h3>
    <br>
    <p>
        Non importa quanti follower o iscritti hai sui tuoi canali social, l'unica cosa che conta davvero per noi è la tua reale passione per il mondo del gaming.
        Diventa subito un partner ufficiale di GameOrbit, clicca sul pulsante di candidatura e inizia a crescere insieme a tutta la nostra community!
    </p>

    <br><br>
    <div class="download">
    <a href="path_del_tuo_file.pdf" class="btn-download" download>
        Scarica Modulo di Candidatura <i class="fas fa-file-download"></i>
    </a>
</div>

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
