<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="it">
<head>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/dashboardA.css">
  <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/img/Logo.png">
  <title>Dashboard Admin - GameOrbit</title>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
  <div class="titolo">
    <a href="${pageContext.request.contextPath}/admin" class="titolo">
      <img src="img/Logo.png" alt="Logo GameOrbit">
      <span>GameOrbit</span>
    </a>
  </div>
</div>

<!-- fine navbar, inizio sezione -->
<div class="dashboard-container">

  <aside class="sidebar">
    <button onclick="showSection('panoramica')" class="tab-btn active">Panoramica</button>
    <button onclick="showSection('impostazioni')" class="tab-btn">Impostazioni</button>
    <button onclick="showSection('ticket')" class="tab-btn">Ticket</button>
  </aside>

  <main class="main-content">

    <!-- Panoramica -->
    <section id="panoramica" class="dashboard-section">
      <div class="panoramica-box">
        <div class="info-utente">
          <div class="info-riga"><strong>Nome:</strong> ${utente.nome} ${utente.cognome}</div>
          <div class="info-riga"><strong>Email:</strong> ${utente.email}</div>
          <div class="info-riga"><strong>Telefono:</strong> ${utente.numero > 0 ? utente.numero : 'Non inserito'}</div>
          <div class="info-riga">
            <strong>Data di Nascita:</strong>
            <fmt:formatDate value="${utente.data_di_nascita}" pattern="dd/MM/yyyy"/>
          </div>
        </div>

        <div class="logout-wrapper">
          <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Log out</a>
        </div>
      </div>
    </section>

    <!-- Impostazioni -->
    <section id="impostazioni" class="dashboard-section hidden">
      <h1 class="section-title">Impostazioni Account</h1>

      <c:if test="${not empty param.status}">
        <div class="box-notifica ${param.status == 'success' ? 'notifica-successo':'notifica-errore'}">
          <c:choose>
            <c:when test="${param.status == 'success'}">
              <i class="fa-solid fa-circle-check"></i> Modifica salvata con successo!
            </c:when>
            <c:when test="${param.status == 'wrong_pass'}">
              <i class="fa-solid fa-circle-xmark"></i> Password attuale errata.
            </c:when>
            <c:when test="${param.status == 'no_match'}">
              <i class="fa-solid fa-triangle-exclamation"></i> Le password non coincidono.
            </c:when>
            <c:otherwise>
              <i class="fa-solid fa-circle-xmark"></i> Errore durante la modifica.
            </c:otherwise>
          </c:choose>
        </div>
      </c:if>

      <div class="contenitore-impostazioni">
        <!-- Cambio password -->
        <div class="scheda-impostazioni">
          <h3 class="subsection-title">
            <i class="fa-solid fa-lock icona-sezione"></i> Cambio Password
          </h3>
          <p class="section-description">
            Inserisci la password attuale prima di scegliere quella nuova.
          </p>

          <form action="${pageContext.request.contextPath}/impostazioni" method="POST" class="form-impostazioni">
            <input type="hidden" name="action" value="cambioPassword">
            <input type="password" name="oldPassword" placeholder="Password attuale" required class="info-riga input-fullwidth">
            <input type="password" name="newPassword" placeholder="Nuova password" required class="info-riga input-fullwidth">
            <input type="password" name="confirmPassword" placeholder="Conferma nuova password" required class="info-riga input-fullwidth">
            <button type="submit" class="tab-btn active btn-invia-impostazioni">Aggiorna Password</button>
          </form>
        </div>

        <hr class="divisore-impostazioni">

        <!-- 2FA -->
        <div class="scheda-impostazioni">
          <h3 class="subsection-title">
            <i class="fa-solid fa-shield-halved icona-sezione"></i> Autenticazione a due fattori
          </h3>
          <p class="section-description">
            Ricevi una mail di conferma ad ogni nuovo accesso.
          </p>

          <form action="${pageContext.request.contextPath}/impostazioni" method="POST" class="form-impostazioni-linea">
            <input type="hidden" name="action" value="toggle2FA">
            <select name="stato2FA" class="info-riga select-personalizzata-impostazioni">
              <option value="false" <c:if test="${!impostazioni.dueFattori}">selected</c:if>>Disattivata</option>
              <option value="true" <c:if test="${impostazioni.dueFattori}">selected</c:if>>Attiva (Email)</option>
            </select>
            <button type="submit" class="tab-btn active btn-invia-linea-impostazioni">Salva Preferenza</button>
          </form>
        </div>
      </div>
    </section>

    <!-- Ticket Admin -->
    <section id="ticket" class="dashboard-section sezione-dashboard hidden">
      <h1 class="titolo-sezione">Pannello Gestione Ticket</h1>

      <div class="box-gestione">
        <!-- Ticket Aperti -->
        <h2 class="titolo-sottosezione">
          <i class="fa-solid fa-folder-open"></i> Ticket Aperti (In Attesa)
        </h2>

        <c:choose>
          <c:when test="${empty ticketAperti}">
            <p class="descrizione-sezione">Nessun ticket da gestire al momento.</p>
          </c:when>
          <c:otherwise>
            <div class="lista-ticket-contenitore aperti-admin">
              <c:forEach var="t" items="${ticketAperti}">
                <article class="scheda-ticket aperto-admin">
                  <div class="intestazione-ticket">
                    <span class="tipo-ticket">[${t.tipo}]</span>
                    <span class="data-ticket">
                  Aperto da: <strong><c:out value="${t.username}"/></strong> in data:
                  <fmt:formatDate value="${t.data}" pattern="dd/MM/yyyy"/>
                </span>
                    <span class="etichetta-stato ticket-aperto">Aperto</span>
                  </div>

                  <div class="corpo-ticket admin">
                    <p>
                      <strong>Messaggio Utente:</strong><br>
                      <c:out value="${t.motivazione}"/>
                    </p>
                  </div>

                  <!-- Modulo di evasione e risposta via email -->
                  <form action="${pageContext.request.contextPath}/rispondiTicket" method="POST" class="modulo-amministrazione modulo-ticket-admin">
                    <input type="hidden" name="idTicket" value="${t.id_Ticket}">

                    <div class="riga-modulo-doppia">
                      <div class="gruppo-modulo">
                        <label class="etichetta-gruppo">Testo della Risposta da inviare via Mail:</label>
                        <textarea name="rispostaAdmin" rows="3" class="input-testo-personalizzato textarea-ticket" placeholder="Scrivi qui le istruzioni o la risoluzione per l'utente..." required></textarea>
                      </div>
                      <div class="gruppo-modulo">
                        <label class="etichetta-gruppo">Cambia Stato Pratica:</label>
                        <select name="nuovoStato" class="selettore-personalizzato" required>
                          <option value="Aperto">Lascia in gestione (Rimani Aperto)</option>
                          <option value="Chiuso">Risolto (Invia mail e Chiudi Ticket)</option>
                        </select>
                      </div>
                    </div>

                    <div class="azioni-modulo admin-ticket">
                      <button type="submit" class="pulsante-invia">
                        <i class="fa-solid fa-reply"></i> Spedisci Risposta all'Utente
                      </button>
                    </div>
                  </form>
                </article>
              </c:forEach>
            </div>
          </c:otherwise>
        </c:choose>

        <!-- Ticket Chiusi -->
        <h2 class="titolo-sottosezione sezione-chiusi">
          <i class="fa-solid fa-folder-closed"></i> Storico Ticket Chiusi
        </h2>

        <c:choose>
        <c:when test="${empty ticketChiusi}">
        <p class="descrizione-sezione">Storico dei ticket vuoto.</p>
        </c:when>
        <c:otherwise>
        <div class="lista-ticket-contenitore">
          <c:forEach var="t" items="${ticketChiusi}">
            <article class="scheda-ticket chiuso-admin">

              <div class="intestazione-ticket">
                <span class="tipo-ticket chiuso">[${t.tipo}]</span>
                <span class="data-ticket">
              Gestito per: <strong><c:out value="${t.username}"/></strong> -
              <fmt:formatDate value="${t.data}" pattern="dd/MM/yyyy"/>
            </span>
                <span class="etichetta-stato ticket-chiuso">Chiuso</span>
              </div>

              <div class="corpo-ticket-storico">
                <div class="messaggio-originale-utente">
                  <strong>Richiesta dell'utente:</strong>
                  <p><c:out value="${t.motivazione}"/></p>
                </div>

                <div class="risposta-ufficiale-admin">
                  <strong>Risolto da: <c:out value="${t.usernameAdmin}"/></strong>
                  <p><c:out value="${t.rispostaAdmin}"/></p>
                </div>
              </div>

            </article>
          </c:forEach>
        </div>
        </c:otherwise>
        </c:choose>
    </section>

  </main>
</div>

<script>
  const contextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/JS/dashboard.js"></script>

<!-- fine sezione, inizio footer -->
<footer class="footer">
  <div class="footer-bottom">
    &copy; 2026 GameOrbit - Tutti i diritti riservati.
  </div>
</footer>

</body>
</html>