<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.Obj.TipoMetodo" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/dashboard.css">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/img/Logo.png">
    <title>Dashboard utente</title>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <a href="${pageContext.request.contextPath}/home" class="titolo">
        <img src="${pageContext.request.contextPath}/img/Logo.png" alt="Logo GameOrbit">
        <span>GameOrbit</span>
    </a>
</div>

<!-- navbar, inizio sezione -->
<div class="dashboard-container">
    <aside class="sidebar">
        <button onclick="showSection('panoramica')" class="tab-btn active">Panoramica</button>
        <button onclick="showSection('saldo')" class="tab-btn">Saldo</button>
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

                <section class="orders-section">
                    <h2 style="border-bottom: 2px solid rgba(255, 255, 255, 0.1); padding-bottom: 12px; margin-bottom: 20px;">I miei ordini</h2>
                    <c:choose>
                        <c:when test="${empty acquistiUtente}">
                            <p style="margin-top: 15px; font-style: italic; color: rgba(255,255,255,0.6);">Non hai ancora effettuato nessun acquisto.</p>
                        </c:when>
                        <c:otherwise>
                            <div class="carousel-wrapper">
                                <button class="carousel-btn prev-btn" onclick="scrollCarousel(-1)">&#10094;</button>
                                <div class="carousel-container" id="ordersCarousel">
                                    <div class="recommended-grid">
                                        <c:forEach var="g" items="${acquistiUtente}">
                                            <a class="recommended-card" href="${pageContext.request.contextPath}/prodotto?id=${g.id_prodotto}">
                                                <img src="${pageContext.request.contextPath}/img/giochi/${g.img}" alt="${g.titolo}">
                                                <div class="recommended-info">
                                                    <h3>${g.titolo}</h3>
                                                    <span>€ ${g.prezzo}</span>
                                                </div>
                                            </a>
                                        </c:forEach>
                                    </div>
                                </div>
                                <button class="carousel-btn next-btn" onclick="scrollCarousel(1)">&#10095;</button>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </section>

                <div class="logout-wrapper">
                    <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Log out</a>
                </div>
            </div>
        </section>

        <!-- Saldo -->
        <section id="saldo" class="dashboard-section hidden">
            <h1 class="section-title">Gestione Saldo</h1>
            <div class="panoramica-box">
                <div class="info-utente">
                    <div class="info-riga saldo-display">
                        <span><strong>Saldo Disponibile:</strong></span>
                        <span class="saldo-valore">
                            <c:choose>
                                <c:when test="${not empty saldoVirtuale}">
                                    <fmt:formatNumber value="${saldoVirtuale.saldo}" type="number" minFractionDigits="2" maxFractionDigits="2"/> ${saldoVirtuale.valuta}
                                </c:when>
                                <c:otherwise>0.00 EUR</c:otherwise>
                            </c:choose>
                        </span>
                    </div>

                    <div class="info-riga stato-display">
                        <span><strong>Stato Conto:</strong></span>
                        <c:choose>
                            <c:when test="${saldoVirtuale.stato != null and saldoVirtuale.stato.toString() == 'Disponibile'}">
                                <span class="stato-badge stato-attivo">● Attivo</span>
                            </c:when>
                            <c:when test="${saldoVirtuale.stato != null and saldoVirtuale.stato.toString() == 'Sospeso'}">
                                <span class="stato-badge stato-sospeso">● Sospeso</span>
                            </c:when>
                            <c:otherwise>
                                <span class="stato-badge stato-bloccato">● Bloccato</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <div class="sezione-metodo-pagamento">
                    <c:choose>
                        <c:when test="${haMetodoAttivo and not empty metodiUtente}">
                            <h3 class="subsection-title">Ricarica Rapida</h3>
                            <form id="formRicaricaRapida" class="form-inline-ricarica">
                                <select name="idMetodo" class="info-riga select-custom">
                                    <c:forEach var="m" items="${metodiUtente}">
                                        <option value="${m.idMetodo}">${m.provider} (**** ${m.ultime4Cifre})</option>
                                    </c:forEach>
                                </select>
                                <input type="number" name="importo" placeholder="€" min="5" max="500" required class="info-riga input-importo">
                                <button type="submit" class="tab-btn active btn-submit-inline">+ Ricarica</button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <h3 class="subsection-title">Associa un Metodo di Pagamento</h3>
                            <p class="section-description">Non hai ancora configurato un metodo per ricaricare. Aggiungine uno adesso:</p>

                            <form id="formNuovoMetodo" class="form-nuovo-metodo" method="POST" action="${pageContext.request.contextPath}/metodoPagamento">
                                <div class="form-row-split">
                                    <select name="tipoMetodo" id="tipoMetodo" required class="info-riga select-custom">
                                        <option disabled selected value="">-- Seleziona metodo --</option>
                                        <option value="Carta">Carta di Credito</option>
                                        <option value="Paypal">PayPal</option>
                                        <option value="Bonifico">Bonifico</option>
                                        <option value="Apple_pay">Apple Pay</option>
                                        <option value="Google_pay">Google Pay</option>
                                    </select>
                                    <input type="text" name="provider" placeholder="Circuito (es. Visa, Mastercard)" required class="info-riga">
                                </div>

                                <input type="text" name="tokenPagamento" placeholder="Numero Carta / Email Account" required class="info-riga input-fullwidth">

                                <div class="form-row-scadenza">
                                    <input type="number" name="scadenzaMese" placeholder="MM" min="1" max="12" required class="info-riga input-center">
                                    <input type="number" name="scadenzaAnno" placeholder="AAAA" min="2026" max="2050" required class="info-riga input-center">
                                    <input type="text" name="ultime4Cifre" placeholder="Ultime 4" maxlength="4" required class="info-riga input-center">
                                </div>

                                <button type="submit" class="tab-btn active btn-submit-full">Salva e Attiva Metodo</button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="sezione-riscatta-codice">
                    <h3 class="subsection-title">Hai una Gift Card o un codice?</h3>
                    <form action="${pageContext.request.contextPath}/riscattaCodice" method="POST" class="form-riscatta">
                        <input type="text" name="codiceValore" placeholder="XXXX-XXXX-XXXX-XXXX" required class="info-riga input-codice">
                        <button type="submit" class="btn-logout btn-riscatta-submit">Riscatta</button>
                    </form>
                </div>
            </div>
        </section>

        <!-- Impostazioni -->
        <section id="impostazioni" class="dashboard-section hidden">
            <h1 class="section-title">Impostazioni Account</h1>

            <c:if test="${not empty param.status}">
                <div class="box-notifica ${param.status == 'success' ? 'notifica-successo' : 'notifica-errore'}">
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
                <!-- CAMBIO PASSWORD -->
                <div class="scheda-impostazioni">
                    <h3 class="subsection-title">
                        <i class="fa-solid fa-lock icona-sezione"></i> Cambio Password
                    </h3>
                    <p class="section-description">Inserisci la password attuale prima di scegliere quella nuova.</p>

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
                    <p class="section-description">Ricevi una mail di conferma ad ogni nuovo accesso.</p>

                    <form action="${pageContext.request.contextPath}/impostazioni" method="POST" class="form-impostazioni-linea">
                        <input type="hidden" name="action" value="toggle2FA">
                        <select name="stato2FA" class="info-riga select-personalizzata-impostazioni">
                            <option value="false" ${!impostazioni.dueFattori ? 'selected' : ''}>Disattivata</option>
                            <option value="true" ${impostazioni.dueFattori ? 'selected' : ''}>Attiva (Email)</option>
                        </select>
                        <button type="submit" class="tab-btn active btn-invia-linea-impostazioni">Salva Preferenza</button>
                    </form>
                </div>
            </div>
        </section>

        <!-- Ticket -->
        <section id="ticket" class="dashboard-section sezione-dashboard hidden">
            <h1 class="titolo-sezione">Assistenza e Ticket</h1>

            <!-- Form Nuovo Ticket -->
            <div class="scatola-gestione scatola-ticket">
                <h3 class="titolo-sottosezione">
                    <i class="fa-solid fa-envelope-open-text icona-sezione"></i>
                    Apri Nuovo Ticket
                </h3>

                <form action="${pageContext.request.contextPath}/inviaTicket" method="POST" class="modulo-amministrazione">
                    <div class="riga-modulo-doppia">
                        <div class="gruppo-modulo">
                            <label class="etichetta-gruppo" for="selettoreTipoTicket">
                                Tipo di Problema
                            </label>
                            <select name="tipoTicket" id="selettoreTipoTicket" class="selettore-personalizzato" required onchange="gestisciMenuProdotti()">
                                <option value="" disabled selected>-- Seleziona una categoria --</option>
                                <option value="generico">Domanda Generica</option>
                                <option value="Account">Problemi con l'Account</option>
                                <option value="acquisto">Problemi con un Acquisto</option>
                            </select>
                        </div>

                        <div class="gruppo-modulo nascosto" id="divSelezioneProdotto">
                            <label class="etichetta-gruppo" for="idProdottoTicket">
                                Relativo al Gioco
                            </label>
                            <select name="idProdottoTicket" id="idProdottoTicket" class="selettore-personalizzato">
                                <option value="" disabled selected>-- Seleziona il gioco --</option>
                                <c:forEach var="gioco" items="${acquistiUtente}">
                                    <option value="${gioco.id_prodotto}">${gioco.titolo}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="gruppo-modulo">
                        <label class="etichetta-gruppo" for="ticketMotivazione">
                            Descrivi il problema
                        </label>
                        <textarea id="ticketMotivazione" name="motivazione" rows="4" class="input-testo-personalizzato textarea-ticket" placeholder="Spiega nel dettaglio di cosa hai bisogno..." required></textarea>
                    </div>

                    <div class="azioni-modulo">
                        <button type="submit" class="pulsante-invia">
                            <i class="fa-solid fa-paper-plane"></i>
                            Invia Ticket all'Assistenza
                        </button>
                    </div>
                </form>

                <!-- Script inline per il toggle del prodotto -->
                <script>
                    function gestisciMenuProdotti() {
                        var selettore = document.getElementById("selettoreTipoTicket");
                        var divProdotto = document.getElementById("divSelezioneProdotto");
                        var inputProdotto = document.getElementById("idProdottoTicket");

                        // 🔥 MODIFICATO: Ora rimuove e aggiunge coerentemente la classe "nascosto"
                        if (selettore.value === "acquisto") {
                            divProdotto.classList.remove("nascosto");
                            inputProdotto.required = true;
                        } else {
                            divProdotto.classList.add("nascosto");
                            inputProdotto.required = false;
                            inputProdotto.value = "";
                        }
                    }
                </script>
            </div>

            <!-- Storico Ticket -->
            <div class="scatola-gestione">
                <h3 class="titolo-sottosezione">
                    <i class="fa-solid fa-clock-rotate-left icona-sezione"></i>
                    I tuoi Ticket
                </h3>
                <c:choose>
                    <c:when test="${empty ticketUtente}">
                        <p class="descrizione-sezione">
                            Non hai ancora aperto nessun ticket di assistenza.
                        </p>
                    </c:when>
                    <c:otherwise>
                        <div class="lista-ticket-contenitore">
                            <c:forEach var="t" items="${ticketUtente}">
                                <article class="scheda-ticket">
                                    <div class="intestazione-ticket">
                                        <span class="tipo-ticket">${t.tipo}</span>
                                        <span class="data-ticket">
                                    <fmt:formatDate value="${t.data}" pattern="dd/MM/yyyy"/>
                                </span>
                                        <c:choose>
                                            <c:when test="${t.stato == 'Aperto'}">
                                                <span class="etichetta-stato ticket-aperto">Aperto</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="etichetta-stato ticket-chiuso">Chiuso</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="corpo-ticket">
                                        <p>${t.motivazione}</p>
                                    </div>
                                </article>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
    </main>
</div>

<script>
    const contextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/JS/dashboard.js"></script>

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