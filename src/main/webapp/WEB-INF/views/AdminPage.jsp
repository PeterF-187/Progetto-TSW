<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Obj.*" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin.css">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/img/Logo.png">
    <title>Admin - GameOrbit</title>
</head>
<body>

<div class="navbar">
    <!-- Logo statico non cliccabile per l'Admin -->
    <div class="titolo" style="cursor: default;">
        <img src="img/Logo.png" alt="Logo GameOrbit">
        <span>GameOrbit</span>
    </div>

    <% String username = (String) session.getAttribute("username"); %>

    <div class="navbar-autenticazione">
        <% if (username == null) { %>
        <a href="${pageContext.request.contextPath}/login" class="auth-link">
            Accedi | Registrati
        </a>
        <% } else { %>
        <a href="${pageContext.request.contextPath}/dashboardA" class="username-link">
            Ciao, <%= username %>
        </a>
        <span class="auth-pipe">|</span>
        <a href="${pageContext.request.contextPath}/logout" class="logout-link">Logout</a>
        <% } %>
    </div>
</div>

<div class="contenitore-amministrazione">
    <main class="principale-amministrazione">
        <h1 class="titolo-pagina">Pannello di Controllo Admin</h1>

        <% if ("success".equals(request.getParameter("status"))) { %>
        <div class="box-notifica notifica-successo">
            <i class="fa-solid fa-circle-check"></i> Operazione completata con successo!
        </div>
        <% } %>

        <% if ("error".equals(request.getParameter("status"))) { %>
        <div class="box-notifica notifica-errore">
            <i class="fa-solid fa-circle-xmark"></i> Si è verificato un errore durante l'inserimento o la modifica.
        </div>
        <% } %>

        <div class="griglia-amministrazione">

            <%-- SEZIONE 1: MODIFICA UTENTI --%>
            <section class="box-gestione">
                <h2 class="titolo-sottosezione">
                    <i class="fa-solid fa-user-gear"></i> Modifica Permessi e Stato Conto
                </h2>
                <form action="${pageContext.request.contextPath}/admin" method="POST" class="form-amministrazione">
                    <input type="hidden" name="action" value="modificaUtente">

                    <div class="gruppo-form">
                        <label for="usernameSelezionato" class="etichetta-gruppo">Seleziona Utente:</label>
                        <select name="usernameSelezionato" id="usernameSelezionato" class="seleziona-personalizzato" required>
                            <option value="" disabled selected>-- Scegli un account --</option>
                            <%
                                List<Utente> listaUtenti = (List<Utente>) request.getAttribute("listaUtenti");
                                if (listaUtenti != null) {
                                    for (Utente u : listaUtenti) {
                            %>
                            <option value="<%= u.getUsername() %>"><%= u.getUsername() %></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <div class="gruppo-form">
                        <label class="etichetta-gruppo">Grado Account (is_admin):</label>
                        <div class="riga-radio">
                            <label class="etichetta-radio">
                                <input type="radio" name="ruoloAdmin" value="false" checked>
                                <span class="radio-personalizzato">Utente Standard</span>
                            </label>
                            <label class="etichetta-radio">
                                <input type="radio" name="ruoloAdmin" value="true">
                                <span class="radio-personalizzato">Admin</span>
                            </label>
                        </div>
                    </div>

                    <div class="gruppo-form">
                        <label class="etichetta-gruppo">Stato del Conto:</label>
                        <div class="riga-radio">
                            <label class="etichetta-radio">
                                <input type="radio" name="statoSaldo" value="Disponibile" checked>
                                <span class="radio-personalizzato stato-disponibile">● Disponibile</span>
                            </label>
                            <label class="etichetta-radio">
                                <input type="radio" name="statoSaldo" value="Sospeso">
                                <span class="radio-personalizzato stato-sospeso">● Sospeso</span>
                            </label>
                            <label class="etichetta-radio">
                                <input type="radio" name="statoSaldo" value="Bloccato">
                                <span class="radio-personalizzato stato-bloccato">● Bloccato</span>
                            </label>
                        </div>
                    </div>

                    <div class="azioni-form">
                        <button type="submit" class="pulsante-invia">Salva Modifiche</button>
                    </div>
                </form>
            </section>

            <%-- SEZIONE 2: INSERIMENTO SOFTWARE HOUSE --%>
            <section class="box-gestione">
                <h2 class="titolo-sottosezione">
                    <i class="fa-solid fa-building"></i> Nuova Software House
                </h2>
                <form action="${pageContext.request.contextPath}/admin" method="POST" class="form-amministrazione">
                    <input type="hidden" name="action" value="insertSH">

                    <div class="gruppo-form">
                        <label class="etichetta-gruppo">Nome Azienda:</label>
                        <input type="text" name="nomeSH" placeholder="Es. Rockstar Games" required class="input-testo-personalizzato">
                    </div>

                    <div class="gruppo-form">
                        <label class="etichetta-gruppo">Sede Legale:</label>
                        <input type="text" name="sedeLegale" placeholder="Es. New York, USA" required class="input-testo-personalizzato">
                    </div>

                    <div class="gruppo-form">
                        <label class="etichetta-gruppo">Anno di Fondazione:</label>
                        <input type="number" name="annoFondazione" min="1950" max="2026" placeholder="Es. 1998" required class="input-testo-personalizzato">
                    </div>

                    <div class="azioni-form">
                        <button type="submit" class="pulsante-invia">Inserisci Azienda</button>
                    </div>
                </form>
            </section>

            <%-- SEZIONE 3: INSERIMENTO PUBLISHER --%>
            <section class="box-gestione">
                <h2 class="titolo-sottosezione">
                    <i class="fa-solid fa-rectangle-ad"></i> Nuovo Publisher
                </h2>
                <form action="${pageContext.request.contextPath}/admin" method="POST" class="form-amministrazione">
                    <input type="hidden" name="action" value="insertPublisher">

                    <div class="gruppo-form">
                        <label class="etichetta-gruppo">Seleziona Software House:</label>
                        <select name="shEditore" class="seleziona-personalizzato" required>
                            <option value="" disabled selected>-- Scegli dall'elenco SH --</option>
                            <%
                                List<Software_House> listaSH = (List<Software_House>) request.getAttribute("listaSoftwareHouse");
                                if (listaSH != null) {
                                    for (Software_House sh : listaSH) {
                            %>
                            <option value="<%= sh.getNome() %>"><%= sh.getNome() %></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <div class="gruppo-form">
                        <label class="etichetta-gruppo">Budget Marketing Annuo (€):</label>
                        <input type="number" step="0.01" name="budgetMarketing" placeholder="Es. 500000.00" required class="input-testo-personalizzato">
                    </div>

                    <div class="gruppo-form">
                        <label class="etichetta-gruppo">Canali di Distribuzione:</label>
                        <input type="text" name="canaliDistribuzione" placeholder="Es. Steam, Epic Games, PlayStation Network" required class="input-testo-personalizzato">
                    </div>

                    <div class="azioni-form">
                        <button type="submit" class="pulsante-invia">Crea Profilo Publisher</button>
                    </div>
                </form>
            </section>

            <%-- SEZIONE 4: INSERIMENTO SVILUPPATORI --%>
            <section class="box-gestione">
                <h2 class="titolo-sottosezione">
                    <i class="fa-solid fa-code"></i> Team Sviluppatori
                </h2>
                <form action="${pageContext.request.contextPath}/admin" method="POST" class="form-amministrazione">
                    <input type="hidden" name="action" value="insertSviluppatori">

                    <div class="gruppo-form">
                        <label class="etichetta-gruppo">Seleziona Software House:</label>
                        <select name="shSviluppatore" class="seleziona-personalizzato" required>
                            <option value="" disabled selected>-- Scegli dall'elenco SH --</option>
                            <%
                                if (listaSH != null) {
                                    for (Software_House sh : listaSH) {
                            %>
                            <option value="<%= sh.getNome() %>"><%= sh.getNome() %></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <div class="gruppo-form">
                        <label class="etichetta-gruppo">Numero di Sviluppatori:</label>
                        <input type="number" name="numSviluppatori" min="1" placeholder="Es. 150" required class="input-testo-personalizzato">
                    </div>

                    <div class="gruppo-form">
                        <label class="etichetta-gruppo">Tipologia Team:</label>
                        <input type="text" name="tipologiaDev" placeholder="Es. First-party, Indie, AAA" required class="input-testo-personalizzato">
                    </div>

                    <div class="gruppo-form">
                        <label class="etichetta-gruppo">Motore Grafico Principale:</label>
                        <input type="text" name="motoreGrafico" placeholder="Es. Unreal Engine 5, Unity" required class="input-testo-personalizzato">
                    </div>

                    <div class="azioni-form">
                        <button type="submit" class="pulsante-invia">Registra Team Sviluppo</button>
                    </div>
                </form>
            </section>

            <%-- SEZIONE 5: INSERIMENTO FRANCHISE --%>
            <section class="box-gestione">
                <h2 class="titolo-sottosezione">
                    <i class="fa-solid fa-star"></i> Nuovo Franchise
                </h2>
                <form action="${pageContext.request.contextPath}/admin" method="POST" class="form-amministrazione">
                    <input type="hidden" name="action" value="insertFranchise">

                    <div class="gruppo-form">
                        <label class="etichetta-gruppo">Titolo del Franchise:</label>
                        <input type="text" name="titoloFranchise" placeholder="Es. Grand Theft Auto, Assassin's Creed" required class="input-testo-personalizzato">
                    </div>

                    <div class="azioni-form">
                        <button type="submit" class="pulsante-invia">Salva Franchise</button>
                    </div>
                </form>
            </section>

            <%-- SEZIONE 6: INSERIMENTO NUOVO VIDEOGIOCO (CATALOGO) --%>
            <section class="box-gestione blocco-larghezza-piena">
                <h2 class="titolo-sottosezione">
                    <i class="fa-solid fa-gamepad"></i> Inserimento Nuovo Videogioco
                </h2>

                <form action="${pageContext.request.contextPath}/insertVideogioco" method="POST" class="form-amministrazione-video">

                    <%-- Informazioni Principali del Gioco --%>
                    <div class="riga-form-tripla">
                        <div class="gruppo-form">
                            <label class="etichetta-gruppo">Titolo Gioco:</label>
                            <input type="text" name="titolo" placeholder="Es. Elden Ring" required class="input-testo-personalizzato">
                        </div>
                        <div class="gruppo-form">
                            <label class="etichetta-gruppo">Prezzo (€):</label>
                            <input type="number" step="0.01" min="0.00" name="prezzo" placeholder="Es. 59.99" required class="input-testo-personalizzato">
                        </div>
                        <div class="gruppo-form">
                            <label class="etichetta-gruppo">Data di Rilascio:</label>
                            <input type="date" name="dataRilascio" max="2026-12-31" required class="input-testo-personalizzato">
                        </div>
                    </div>

                    <div class="riga-form-doppia">
                        <div class="gruppo-form">
                            <label class="etichetta-gruppo">Nome File Immagine:</label>
                            <input type="text" name="immagine" placeholder="Es. elden_ring.jpeg" required class="input-testo-personalizzato">
                        </div>
                        <div class="gruppo-form">
                            <label class="etichetta-gruppo">Descrizione Breve:</label>
                            <input type="text" name="descrizione" placeholder="Inserisci una descrizione del prodotto..." required class="input-testo-personalizzato">
                        </div>
                    </div>

                    <%-- Dropdown Relazionali (SH, Publisher, Franchise) --%>
                    <div class="riga-form-tripla">
                        <div class="gruppo-form">
                            <label class="etichetta-gruppo">Team Sviluppatore:</label>
                            <select name="sviluppatoreSH" class="seleziona-personalizzato" required>
                                <option value="" disabled selected>-- Seleziona Dev --</option>
                                <%
                                    if (listaSH != null) {
                                        for (Software_House sh : listaSH) {
                                %>
                                <option value="<%= sh.getNome() %>"><%= sh.getNome() %></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>

                        <div class="gruppo-form">
                            <label class="etichetta-gruppo">Publisher / Editore:</label>
                            <select name="publisherSH" class="seleziona-personalizzato" required>
                                <option value="" disabled selected>-- Seleziona Publisher --</option>
                                <%
                                    if (listaSH != null) {
                                        for (Software_House sh : listaSH) {
                                %>
                                <option value="<%= sh.getNome() %>"><%= sh.getNome() %></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>

                        <div class="gruppo-form">
                            <label class="etichetta-gruppo">Franchise di appartenenza:</label>
                            <select name="franchiseAppartenenza" class="seleziona-personalizzato">
                                <option value="">Nessuno (Gioco Standalone)</option>
                                <%
                                    List<Franchise> listaFranchise = (List<Franchise>) request.getAttribute("listaFranchise");
                                    if (listaFranchise != null) {
                                        for (Franchise f : listaFranchise) {
                                %>
                                <option value="<%= f.getTitolo() %>"><%= f.getTitolo() %></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                    </div>

                    <%-- MATRICE DELLE CHECKBOX DELLE RELAZIONI N-TO-N --%>
                    <div class="contenitore-matrice-checkbox">

                        <%-- Piattaforme --%>
                        <div class="blocco-checkbox">
                            <span class="etichetta-matrice">Rilascio su Piattaforma:</span>
                            <div class="lista-scorrimento-checkbox">
                                <label class="contenitore-spunta"><input type="checkbox" name="piattaforme" value="Playstation_5"> PlayStation 5</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="piattaforme" value="Playstation_4"> PlayStation 4</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="piattaforme" value="Xbox"> Xbox Series X/S</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="piattaforme" value="Nintendo_Switch"> Nintendo Switch</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="piattaforme" value="Nintendo_Switch_2"> Nintendo Switch 2</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="piattaforme" value="Pc"> PC Digital</label>
                            </div>
                        </div>

                        <%-- Regioni --%>
                        <div class="blocco-checkbox">
                            <span class="etichetta-matrice">Regioni Attivazione:</span>
                            <div class="lista-scorrimento-checkbox">
                                <label class="contenitore-spunta"><input type="checkbox" name="regioni" value="Europa"> Europa</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="regioni" value="Global"> Global Key</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="regioni" value="Italia"> Italia Only</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="regioni" value="Turchia"> Turchia region</label>
                            </div>
                        </div>

                        <%-- Lingue --%>
                        <div class="blocco-checkbox">
                            <span class="etichetta-matrice">Lingue Supportate:</span>
                            <div class="lista-scorrimento-checkbox">
                                <label class="contenitore-spunta"><input type="checkbox" name="lingue" value="Italiano"> Italiano</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="lingue" value="Inglese"> Inglese</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="lingue" value="Spagnolo"> Spagnolo</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="lingue" value="Russo"> Russo</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="lingue" value="Mandarino"> Mandarino</label>
                            </div>
                        </div>

                        <%-- Generi --%>
                        <div class="blocco-checkbox">
                            <span class="etichetta-matrice">Generi del Gioco:</span>
                            <div class="lista-scorrimento-checkbox">
                                <label class="contenitore-spunta"><input type="checkbox" name="generi" value="Azione"> Azione</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="generi" value="Avventura"> Avventura</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="generi" value="Sparatutto"> Sparatutto</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="generi" value="RPG"> RPG</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="generi" value="Strategia"> Strategia</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="generi" value="Simulazione"> Simulazione</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="generi" value="Sport"> Sport</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="generi" value="Picchiaduro"> Picchiaduro</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="generi" value="Platform"> Platform</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="generi" value="Pazzle"> Puzzle</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="generi" value="Survival"> Survival</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="generi" value="Horror"> Horror</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="generi" value="Racing"> Racing</label>
                            </div>
                        </div>

                        <%-- Categorie --%>
                        <div class="blocco-checkbox">
                            <span class="etichetta-matrice">Caratteristiche / Categorie:</span>
                            <div class="lista-scorrimento-checkbox">
                                <label class="contenitore-spunta"><input type="checkbox" name="categorie" value="AAA"> Classificazione AAA</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="categorie" value="Indie"> Produzione Indie</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="categorie" value="AA"> Produzione AA</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="categorie" value="Free_to_play"> Free to Play</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="categorie" value="Single_player"> Single Player</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="categorie" value="Co_op"> Co-Op Cooperativo</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="categorie" value="Multiplayer"> Multiplayer Online</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="categorie" value="MMO"> Categoria MMO</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="categorie" value="VR"> Supporto VR</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="categorie" value="Casual"> Casual Gaming</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="categorie" value="Hardcore"> Hardcore Gaming</label>
                                <label class="contenitore-spunta"><input type="checkbox" name="categorie" value="Esport"> Scena Esport</label>
                            </div>
                        </div>

                    </div>

                    <div class="azioni-form">
                        <button type="submit" class="pulsante-invia"><i class="fa-solid fa-plus"></i> Inserisci Gioco nel Catalogo</button>
                    </div>
                </form>
            </section>

        </div>
    </main>
</div>

<footer class="footer">
    <div class="footer-basso">
        &copy; 2026 GameOrbit - Tutti i diritti riservati.
    </div>
</footer>

</body>
</html>