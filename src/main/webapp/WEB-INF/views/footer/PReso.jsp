<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css">
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/img/Logo.png">
  <title>Politica reso</title>
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
<h1>Politica di reso</h1>

<p>Nel settore dei prodotti digitali, la legge (in particolare il Codice del Consumo in Europa) prevede che il diritto di recesso di 14 giorni decada nel momento in cui il codice viene visualizzato o riscattato, poiché il bene viene "consumato".
  La politica deve quindi tutelare noi proprietari del sito da chi prova a fare il furbo, pur rimanendo onesta in caso di chiavi difettose.
</p>
<br><br>
  <h3>Politica di Reso e Rimborso (Prodotti Digitali)</h3>
<br>
<p>
  Grazie per aver acquistato su GameOrbit. La presente Politica di Reso e Rimborso disciplina gli acquisti di chiavi digitali (product-key) ed elementi scaricabili effettuati sul nostro sito.
  A causa della natura digitale dei nostri prodotti, la preghiamo di leggere attentamente le condizioni descritte di seguito prima di richiedere un rimborso.
<p>
<br><br>
<h3>1. Diritto di Recesso e Beni Digitali</h3>
<br>
<p>Ai sensi della normativa vigente in materia di contratti a distanza (Codice del Consumo), i prodotti digitali forniti tramite supporto non materiale costituiscono un'eccezione al diritto di recesso standard di 14 giorni.
  Prima della visualizzazione/consegna: Se il codice non è ancora stato mostrato a schermo, inviato via e-mail o riscattato, l'utente ha il diritto di richiedere l'annullamento dell'ordine e il rimborso totale entro 14 giorni dall'acquisto.
  Dopo la visualizzazione/consegna: Dal momento in cui la product-key viene visualizzata sul sito, mostrata nel proprio account o spedita via e-mail, il diritto di recesso decade automaticamente e non sarà più possibile richiedere un rimborso per "ripensamento" o errato acquisto.
</p>
<br><br>
<h3>2. Condizioni per l'ottenimento di un Rimborso</h3>
<br>
<p>Il rimborso o la sostituzione della chiave digitale sono garantiti esclusivamente nelle seguenti circostanze:
  Chiave non visualizzata: L'acquirente non ha mai cliccato sul pulsante per mostrare la chiave o accedere al codice.
  Chiave non funzionante o già duplicata: Se la product-key risulta non valida, già riscattata o difettosa al momento del riscatto sulla piattaforma di destinazione (Steam, Epic Games, PlayStation Network, Xbox Live, ecc.).
  Prodotto non corrispondente: Se per un errore del sistema è stata consegnata una chiave per un gioco o una piattaforma diversi da quelli acquistati.
</p>>
<br><br>
<h3>3. Procedura di Verifica in Caso di Chiave Difettosa</h3>>
  <br>
<p>Per prevenire frodi, in caso di segnalazione di una chiave non funzionante, il nostro team di supporto richiederà le seguenti prove visive prima di procedere al rimborso o alla sostituzione:
  Uno o più screenshot a schermo intero (non ritagliati) che mostrino chiaramente l'errore restituito dalla piattaforma (es. "Codice già duplicato" o "Codice non valido").
  L'orologio di sistema del computer/console visibile nello screenshot.
  La prova che si sta tentando il riscatto sull'account corretto e nella regione corretta (es. Global, Europa, ecc.).
  ⚠️ Nota Importante: GameOrbit si riserva il diritto di verificare la validità del codice direttamente con i propri distributori o con il supporto della piattaforma interessata prima di emettere il rimborso. Questo processo può richiedere fino a [es. 24/48 ore].
</p>
  <br><br>
<h3>4. Esclusioni dal Rimborso</h3>
<br>
<p>Non verrà concesso alcun rimborso nei seguenti casi:
  Incompatibilità hardware del gioco con il proprio computer (il cliente è tenuto a verificare i requisiti minimi prima dell'acquisto).
  Errori di acquisto dovuti a restrizioni geografiche (se il prodotto è chiaramente contrassegnato come "Regione: Europa" e l'utente prova a risvattarlo da un account americano).
  Ban dell'account dell'utente sulla piattaforma di destinazione causato da violazioni dei termini di servizio della piattaforma stessa.
</p>
<br><br>
<h3>5. Tempistiche e Modalità di Rimborso</h3>
  <br>
<p>Una volta approvata la richiesta, il rimborso verrà elaborato utilizzando lo stesso metodo di pagamento scelto durante l'acquisto (Carta di Credito, PayPal, ecc.). I tempi di accredito dipendono dal circuito bancario e variano solitamente tra i 3 e i 7 giorni lavorativi.
<br><br>
  <h3>6. Contatti</h3>
  <p>Per avviare una richiesta di reso o segnalare un problema con una chiave, contatta il nostro Servizio Clienti all'indirizzo e-mail: [Tua E-mail di Supporto] o tramite la sezione "Supporto" del tuo account, indicando il numero d'ordine.</p>

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
