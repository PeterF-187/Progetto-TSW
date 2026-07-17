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
<h1>Come acquistare</h1>
<br><br>
<p>Primo passo - registrazione, se lo fai avrai accesso a tutte le tue chiavi in
    un unico posto oltre ad un facile accesso tramite i social! Se decidi di registrarti
    prima di comprare qualcosa, fai semplicemente click su "Registrati" e inserisci le informazioni
    richieste.

    Ora che hai impostato il tuo account, sei pronto per comprare i tuoi giochi preferiti!
    Puoi orbitare su GameOrbit per categorie, prezzo, piattaforma, ecc.
    Una volta trovato il titolo che ti piace, selezionalo e verrai portato alla pagina del prodotto.
    Assicurati che il gioco sia per la piattaforma che desideri e che non ti sarà impedito di attivare
    il titolo nella tuo paese.

    Se decidi di acquistare il gioco, non dimenticare di scorrere verso il basso e controllare i consigliati.
    clicca su "Aggiungi al carrello" e quando vorrai acquistarlo si troverà nella sezione "Carrello"in alto.
    Infine nella sezione dedicata, scegli il metodo di pagamento e premi su "check-out" dove ti verrà inviata una mail con la product-key.
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
