document.addEventListener("DOMContentLoaded", function () {

    const searchInput = document.getElementById("searchInput");
    const suggestionsBox = document.getElementById("suggestions");
    const searchForm = document.querySelector(".search-container form");

    if (!searchInput || !suggestionsBox) return;

    let debounceTimer;
    const baseUrl = contextPath + "/search";
    let selectedIndex = -1;
    let currentResults = [];

    // 1. SUGGERIMENTI IN TEMPO REALE (Mentre l'utente scrive)
    searchInput.addEventListener("input", function () {
        clearTimeout(debounceTimer);
        const query = searchInput.value.trim();

        // Se scrive meno di 2 lettere, nascondiamo la tendina asincrona
        if (query.length < 2) {
            suggestionsBox.innerHTML = "";
            suggestionsBox.style.display = "none";
            currentResults = [];
            selectedIndex = -1;
            return;
        }

        debounceTimer = setTimeout(() => {
            fetch(baseUrl + "?query=" + encodeURIComponent(query))
                .then(response => {
                    if (!response.ok) throw new Error("Errore nel server");
                    return response.json();
                })
                .then(data => {
                    suggestionsBox.innerHTML = "";
                    currentResults = data || [];
                    selectedIndex = -1;

                    if (!data || data.length === 0) {
                        suggestionsBox.innerHTML =
                            `<div class="no-suggestion">Nessun videogioco trovato per "${query}"</div>`;
                    } else {
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

                            item.addEventListener("click", function () {
                                window.location.href = contextPath + "/prodotto?id=" + encodeURIComponent(v.id);
                            });

                            suggestionsBox.appendChild(item);
                        });
                    }
                    suggestionsBox.style.display = "block";
                })
                .catch(error => {
                    console.error("Errore AJAX:", error);
                });
        }, 300);
    });

    // 2. NAVIGAZIONE TASTIERA E GESTIONE TASTO INVIO
    searchInput.addEventListener("keydown", function (e) {
        // Se l'utente preme invio, controlliamo SE c'era una selezione attiva nella tendina dei suggerimenti
        if (e.key === "Enter") {
            if (suggestionsBox.style.display === "block" && selectedIndex >= 0 && currentResults[selectedIndex]) {
                e.preventDefault(); // Blocca l'invio del form tradizionale
                const v = currentResults[selectedIndex];
                window.location.href = contextPath + "/prodotto?id=" + encodeURIComponent(v.id);
            }
            return; // In tutti gli altri casi (anche con 1 sola lettera), lascia procedere l'invio nativo del form alla servlet
        }

        // Se la tendina non è aperta, non catturare le frecce direzionali
        if (suggestionsBox.style.display !== "block") return;

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

    // 3. BLOCCO SULL'INVIO DI STRINGHE VUOTE
    if (searchForm) {
        searchForm.addEventListener("submit", function (e) {
            const query = searchInput.value.trim();
            if (query.length === 0) {
                e.preventDefault(); // Impedisce di mandare una ricerca bianca
            }
        });
    }

    // Chiude la tendina cliccando fuori
    document.addEventListener("click", function (e) {
        if (!searchInput.contains(e.target) && !suggestionsBox.contains(e.target)) {
            suggestionsBox.style.display = "none";
        }
    });

    function updateSelection() {
        const items = suggestionsBox.querySelectorAll(".suggestion-item");
        items.forEach((item, index) => {
            item.classList.toggle("selected", index === selectedIndex);
        });
    }
});