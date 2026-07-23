<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/checkout.css">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/img/Logo.png">
    <title>checkout</title>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <a href="${pageContext.request.contextPath}/home" class="titolo">
        <img src="${pageContext.request.contextPath}/img/Logo.png" alt="Logo GameOrbit">
        <span>GameOrbit</span>
    </a>
</div>
<!-- fine navbar, inizio pagina -->

<div class="checkout-page-container">

    <c:choose>

        <c:when test="${successo}">

            <div class="icon-circle success">
                ✓
            </div>

            <h2>Acquisto completato!</h2>
            <p>Grazie per il tuo ordine.</p>

            <div class="product-key-box">

                <button type="button" onclick="toggleKeys()" class="btn-home">
                    Mostra / Nascondi Product Key
                </button>

                <div id="keysContainer" style="display:none; margin-top:20px;">

                    <c:forEach var="k" items="${productKeys}">
                        <div class="key-item">
                            <strong>${k.titolo}:</strong>
                            <span class="key">${k.key}</span>
                        </div>
                    </c:forEach>

                </div>
            </div>

        </c:when>

        <c:otherwise>

            <div class="icon-circle error">
                ✕
            </div>

            <h2>Pagamento fallito</h2>
            <p>${messaggioError}</p>

            <a href="${pageContext.request.contextPath}/carrello"
               class="btn-home">
                Torna al carrello
            </a>

        </c:otherwise>

    </c:choose>

</div>

<script>
    function toggleKeys() {
        const el = document.getElementById("keysContainer");
        el.style.display = (el.style.display === "none") ? "block" : "none";
    }
</script>

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
                <li><a href="${pageContext.request.contextPath}/HowTo">Come acquistare</a></li>
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