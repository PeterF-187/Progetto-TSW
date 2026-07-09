<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/auth.css">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/img/Logo.png">
    <title>Auth</title>
</head>
<body>

<div class="navbar">
    <a href="${pageContext.request.contextPath}/home" class="titolo">
        <img src="${pageContext.request.contextPath}/img/Logo.png" alt="Logo GameOrbit">
        <span>GameOrbit</span>
    </a>
</div>

<section class="auth-section">

    <div class="auth-container">

        <!-- LOGIN -->
        <div class="auth-box" id="loginBox">
            <h2>Accedi</h2>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <input type="text" placeholder="Username" name="username" required>
                <input type="password" placeholder="Password" name="password" required>
                <% if (request.getParameter("loginError") != null) { %>
                <p style="color:red; margin-top:8px;">
                    Password o username errati
                </p>
                <% } %>
                <% if (request.getParameter("checkMail") != null) { %>

                <p style="color:green; margin-top:8px;">
                    Controlla la tua email e conferma l'accesso.
                </p>

                <% } %>
                <button type="submit">Login</button>
            </form>

            <p>
                Non hai un account?
                <a onclick="showRegister()">Registrati</a>
            </p>
        </div>

        <!-- REGISTRAZIONE -->
        <div class="auth-box hidden" id="registerBox">
            <h2>Registrati</h2>

            <form action="${pageContext.request.contextPath}/register" method="post">
                <input type="text" placeholder="Username" name="username" required>
                <input type="text" placeholder="Nome" name="nome" required>
                <input type="text" placeholder="Cognome" name="cognome" required>
                <input type="email" placeholder="Email" name="email" required>
                <input type="password" placeholder="Password" name="password" required>
                <input type="date" name="data_nascita" required>
                <input type="text" placeholder="Cellulare" name="telefono" required>

                <% if (request.getParameter("registerError") != null) { %>
                <p style="color:red; margin-top:8px;">
                    Utente già registrato
                </p>
                <% } %>
                <button type="submit">Crea account</button>
            </form>

            <p>
                Hai già un account?
                <a onclick="showLogin()">Accedi</a>
            </p>
        </div>
    </div>

</section>

<script>
    function showRegister() {
        document.getElementById("loginBox").classList.add("hidden");
        document.getElementById("registerBox").classList.remove("hidden");
    }

    function showLogin() {
        document.getElementById("registerBox").classList.add("hidden");
        document.getElementById("loginBox").classList.remove("hidden");
    }

    <% if (request.getParameter("registerError") != null) { %>
    showRegister();
    <% } %>
</script>


<!-- Footer -->
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