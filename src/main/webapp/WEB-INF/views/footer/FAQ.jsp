<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer2.css">
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/img/Logo.png">
  <title>FAQ</title>
</head>
<body>
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

<!-- fine navbar inizio pagina -->


<div class="faq-container">

  <h1>Domande Frequenti</h1>

  <div class="faq-item">
    <h2>Come acquisto un gioco?</h2>
    <p>
      Apri la pagina del prodotto, premi "Aggiungi al carrello" e completa l'acquisto.
    </p>
  </div>

  <div class="faq-item">
    <h2>Posso salvare un gioco per dopo?</h2>
    <p>
      Sì, puoi aggiungere un videogioco alla wishlist tramite il pulsante con il cuore presente nella pagina del prodotto.
    </p>
  </div>

  <div class="faq-item">
    <h2>Come trovo un gioco?</h2>
    <p>
      Utilizza la barra di ricerca nella parte superiore del sito. Mentre scrivi verranno suggeriti i titoli più simili.
    </p>
  </div>

  <div class="faq-item">
    <h2>Come funzionano i giochi consigliati?</h2>
    <p>
      Nella pagina di ogni videogioco vengono mostrati fino a tre titoli appartenenti agli stessi generi.
    </p>
  </div>

  <div class="faq-item">
    <h2>Posso filtrare i giochi?</h2>
    <p>
      Sì. È possibile filtrare il catalogo per categoria, genere, piattaforma, lingua, regione e fascia di prezzo.
    </p>
  </div>

  <div class="faq-item">
    <h2>Quali informazioni sono disponibili nella pagina prodotto?</h2>
    <p>
      Prezzo, descrizione, sviluppatore, publisher, lingue supportate, regioni disponibili, franchise di appartenenza e giochi consigliati.
    </p>
  </div>

  <div class="faq-item">
    <h2>Posso effettuare un reso?</h2>
    <p>
      Sì, puoi richiedere il reso e il rimborso totale solo se non hai ancora visualizzato, riscattato o ricevuto la product-key; una volta che il codice ti è stato mostrato o consegnato, il diritto di recesso decade automaticamente trattandosi di un bene digitale.
    </p>
  </div>

  <div class="faq-item">
    <h2>È necessario registrarsi?</h2>
    <p>
      La registrazione permette di accedere alle funzionalità dedicate agli utenti, come carrello e wishlist.
    </p>
  </div>

</div>


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
