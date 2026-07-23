document.addEventListener("DOMContentLoaded", function () {

    // Selezione degli elementi del DOM necessari per la ricerca
    const searchInput = document.getElementById("searchInput");
    const suggestionsBox = document.getElementById("suggestions");
    const searchForm = document.querySelector(".search-container form");

    // Se il campo di ricerca o la tendina non sono presenti nella pagina, interrompe l'esecuzione
    if (!searchInput || !suggestionsBox) return;

    // Variabili di stato per la gestione di debounce, URL e navigazione da tastiera
    let debounceTimer;
    const baseUrl = contextPath + "/search";
    let selectedIndex = -1;
    let currentResults = [];

    // Gestione dell'autocompletamento in tempo reale durante la digitazione
    searchInput.addEventListener("input", function () {
        clearTimeout(debounceTimer);
        const query = searchInput.value.trim();

        // Se il testo è troppo corto (meno di 2 caratteri), nasconde la tendina e resetta lo stato
        if (query.length < 2) {s
            suggestionsBox.innerHTML = "";
            suggestionsBox.style.display = "none";
            currentResults = [];
            selectedIndex = -1;
            return;
        }

        // Attende 300ms dall'ultima pressione di un tasto prima di inviare la richiesta (Debounce)
        debounceTimer = setTimeout(() => {
            fetch(baseUrl + "?query=" + encodeURIComponent(query))
                .then(response => {
                    if (!response.ok) throw new Error("Errore durante il recupero dei dati");
                    return response.json();
                })
                .then(data => {
                    suggestionsBox.innerHTML = "";
                    currentResults = data || [];
                    selectedIndex = -1;

                    // Messaggio di stato se la ricerca non restituisce elementi
                    if (!data || data.length === 0) {
                        suggestionsBox.innerHTML =
                            `<div class="no-suggestion">Nessun videogioco trovato per "${query}"</div>`;
                    } else {
                        // Creazione e popolamento dinamico degli elementi della lista
                        data.forEach((v, index) => {
                            const item = document.createElement("div");
                            item.className = "suggestion-item";
                            item.dataset.index = index;

                            item.innerHTML =
                                '<div class="suggestion-info">' +
                                '<span class="suggestion-title"><strong>' + v.titolo + '</strong></span>' +
                                '<span class="suggestion-img">' +
                                '<img src="' + contextPath + '/img/giochi/' + v.immagine + '">' +
                                '</span>' +
                                '</div>' +
                                '<span class="suggestion-price">€' + v.prezzo + '</span>';

                            // Cliccando su un elemento si viene reindirizzati alla pagina del prodotto
                            item.addEventListener("click", function () {
                                window.location.href = contextPath + "/prodotto?id=" + encodeURIComponent(v.id);
                            });

                            suggestionsBox.appendChild(item);
                        });
                    }
                    suggestionsBox.style.display = "block";
                })
                .catch(error => {
                    console.error("Errore durante la ricerca:", error);
                });
        }, 300);
    });

    // Gestione della navigazione nella lista tramite tastiera (Frecce e Invio)
    searchInput.addEventListener("keydown", function (e) {
        // Se si preme Invio mentre un suggerimento è selezionato, naviga direttamente al prodotto
        if (e.key === "Enter") {
            if (suggestionsBox.style.display === "block" && selectedIndex >= 0 && currentResults[selectedIndex]) {
                e.preventDefault(); // Impedisce l'invio classico del form
                const v = currentResults[selectedIndex];
                window.location.href = contextPath + "/prodotto?id=" + encodeURIComponent(v.id);
            }
            return; // Se non c'è una selezione attiva, procede con l'invio nativo del form
        }

        // Ignora i tasti freccia se la tendina non è visibile
        if (suggestionsBox.style.display !== "block") return;

        // Scorrimento verso il basso o verso l'alto con le frecce direzionali
        if (e.key === "ArrowDown") {
            e.preventDefault();
            selectedIndex = Math.min(selectedIndex + 1, currentResults.length - 1);
            updateSelection();
        }
        else if (e.key === "ArrowUp") {
            e.preventDefault();
            selectedIndex = Math.max(selectedIndex - 1, 0);
            updateSelection();
        }
    });

    // Impedisce l'invio del form se il campo di ricerca è vuoto o contiene solo spazi
    if (searchForm) {
        searchForm.addEventListener("submit", function (e) {
            const query = searchInput.value.trim();
            if (query.length === 0) {
                e.preventDefault();
            }
        });
    }

    // Chiude la tendina dei suggerimenti quando si clicca all'esterno della ricerca
    document.addEventListener("click", function (e) {
        if (!searchInput.contains(e.target) && !suggestionsBox.contains(e.target)) {
            suggestionsBox.style.display = "none";
        }
    });

    // Aggiorna lo stato visivo (classe CSS) dell'elemento selezionato con la tastiera
    function updateSelection() {
        const items = suggestionsBox.querySelectorAll(".suggestion-item");
        items.forEach((item, index) => {
            item.classList.toggle("selected", index === selectedIndex);
        });
    }
});