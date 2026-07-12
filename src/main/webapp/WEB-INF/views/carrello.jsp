<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/carrello.css">
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
                <a href="${pageContext.request.contextPath}/dashboard" class="username-link">
                    Ciao, <%= username %>
                </a>
                <a href="${pageContext.request.contextPath}/logout">Logout</a>
                <% } %>
            </li>
        </ul>
    </nav>
</div>

<!-- fine navbar, inizio sezione----------------------------------------------------------------------------------------------------- -->

<main class="cart-main-container">

    <section class="cart-items-section">
        <h2>Il tuo Carrello</h2>

        <c:if test="${empty prodottiCarrello}">
            <p class="empty-message">Non ci sono articoli nel tuo carrello.</p>
        </c:if>

        <c:if test="${not empty prodottiCarrello}">
            <c:forEach var="gioco" items="${prodottiCarrello}">
                <div class="cart-item-row">
                    <div class="cart-item-info">
                        <c:choose>
                            <c:when test="${not empty gioco.img}">
                                <img src="${pageContext.request.contextPath}/img/giochi/${gioco.img}" alt="${gioco.titolo}" class="cart-game-img">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/img/default-game.png" alt="Default" class="cart-game-img">
                            </c:otherwise>
                        </c:choose>
                        <span class="cart-game-title">${gioco.titolo}</span>
                    </div>

                    <div class="cart-item-actions">
                        <span class="cart-item-price">${gioco.prezzo} €</span>
                        <form action="${pageContext.request.contextPath}/carrello" method="POST">
                            <input type="hidden" name="idProdotto" value="${gioco.id_prodotto}">
                            <input type="hidden" name="action" value="remove">
                            <button type="submit" class="btn-remove-item" title="Rimuovi dal carrello">
                                <i class="fa-solid fa-trash-can"></i>
                            </button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </c:if>
    </section>

    <aside class="cart-summary-sidebar">
        <div class="summary-card">
            <h3>Riepilogo Ordine</h3>
            <hr class="summary-divider">

            <div class="summary-row text-total">
                <span>Totale dell'Ordine:</span>
                <span class="total-amount">${prezzoTotale} €</span>
            </div>

            <div class="payment-method-section">
                <h4>Metodo di Pagamento</h4>

                <c:choose>
                    <c:when test="${not empty sessionScope.username}">
                        <p>Account: <strong>${sessionScope.username}</strong></p>

                        <div class="payment-selector-container" style="margin-bottom: 15px;">
                            <select name="paymentMethod" id="paymentMethodSelect" class="form-select" style="width: 100%; padding: 8px; border-radius: 4px;">
                                <option value="" disabled selected>-- Seleziona Metodo --</option>
                                <option value="saldo">Paga con Saldo Virtuale</option>

                                <c:choose>
                                    <c:when test="${metodoDaConfigurare}">
                                        <option value="aggiungi_metodo">Aggiungi metodo...</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="carta">Carta di Credito / Altro</option>
                                    </c:otherwise>
                                </c:choose>
                            </select>
                        </div>

                        <div class="wallet-status-box" id="walletDetailsBox" style="display: none; margin-top: 10px;">
                            <p>Saldo Disponibile: <span class="wallet-balance">${saldoUtente.saldo} ${saldoUtente.valuta}</span></p>
                            <p>Stato Portafoglio:
                                <span class="status-badge ${saldoUtente.stato}">${saldoUtente.stato}</span>
                            </p>
                        </div>

                        <c:if test="${checkoutDisabilitato}">
                            <div class="alert-box error" id="checkoutAlertBox" style="display: none; margin-top: 10px;">
                                <i class="fa-solid fa-triangle-exclamation"></i> ${motivoBlocco}
                            </div>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <div class="alert-box info">
                            <i class="fa-solid fa-circle-info"></i>
                            <a href="${pageContext.request.contextPath}/login">Accedi</a> per verificare e utilizzare il tuo saldo virtuale.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <form action="${pageContext.request.contextPath}/checkout" method="POST" class="checkout-form">
                <input type="hidden" name="selectedPayment" id="selectedPaymentHidden" value="">

                <button type="submit" id="btnProceedOrder" class="btn-proceed-order"
                        <c:if test="${empty prodottiCarrello}">disabled</c:if>>
                    Procedi all'ordine
                </button>
            </form>
        </div>
    </aside>

    <script>

        document.addEventListener("DOMContentLoaded", function() {
            const selectMethod = document.getElementById("paymentMethodSelect");
            const walletBox = document.getElementById("walletDetailsBox");
            const alertBox = document.getElementById("checkoutAlertBox");
            const btnProceed = document.getElementById("btnProceedOrder");
            const hiddenInput = document.getElementById("selectedPaymentHidden");
            const checkoutForm = document.querySelector(".checkout-form");

            // Controlliamo se il checkout è disabilitato lato server per il saldo
            const isSaldoBloccato = ${checkoutDisabilitato ? true : false};
            const carrelloVuoto = ${empty prodottiCarrello ? true : false};

            // Disabilita il bottone finché non viene scelto un metodo valido
            if(btnProceed && !carrelloVuoto) {
                btnProceed.disabled = true;
            }

            if (selectMethod) {
                selectMethod.addEventListener("change", function() {
                    const value = this.value;
                    hiddenInput.value = value; // Salva il valore nel form nascosto

                    // Reset visibilità standard
                    walletBox.style.display = "none";
                    if(alertBox) alertBox.style.display = "none";
                    if(!carrelloVuoto) btnProceed.disabled = false;

                    if (value === "saldo") {
                        // Mostra dettagli del saldo
                        walletBox.style.display = "block";
                        if (isSaldoBloccato) {
                            if(alertBox) alertBox.style.display = "block";
                            btnProceed.disabled = true; // Blocca se il saldo ha problemi
                        }
                    }
                    // Nota: se seleziona 'aggiungi_metodo' o 'carta', sblocca semplicemente il bottone per permettere l'azione al click
                });
            }

            // INTERCETTAZIONE DEL PULSANTE "PROCEDI ALL'ORDINE"
            if (checkoutForm) {
                checkoutForm.addEventListener("submit", function(e) {
                    const currentPayment = hiddenInput.value;

                    if (currentPayment === "aggiungi_metodo") {
                        e.preventDefault(); // Blocca l'invio del form di checkout
                        // Reindirizza l'utente direttamente al pannello saldo della dashboard
                        window.location.href = "${pageContext.request.contextPath}/dashboard?tab=saldo";
                    }
                    // Se invece è "carta" o "saldo", lascia che il form esegua il POST standard verso /checkout
                });
            }
        });

    </script>


</main>


<!-- fine sezione - inizio footer ----------------------------------------------------------------------------------------------------- -->
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