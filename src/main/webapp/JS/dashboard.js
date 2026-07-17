
    function scrollCarousel(direction) {
    const carousel = document.getElementById("ordersCarousel");
    // Calcoliamo lo spostamento in base alla larghezza di una card (220px) + il gap (20px)
    const scrollAmount = 240 * 2; // Sposta di 2 giochi alla volta

    carousel.scrollBy({
    left: direction * scrollAmount,
    behavior: 'smooth'
});
}
    // Funzione principale per lo switch dei pannelli
    function showSection(sectionId) {
    // Nascondi tutte le sezioni
    const sections = document.querySelectorAll('.dashboard-section');
    sections.forEach(sec => sec.classList.add('hidden'));

    // Rimuovi lo stato attivo da tutti i pulsanti della sidebar
    const buttons = document.querySelectorAll('.tab-btn');
    buttons.forEach(btn => btn.classList.remove('active'));

    // Mostra la sezione selezionata
    const targetSection = document.getElementById(sectionId);
    if (targetSection) {
    targetSection.classList.remove('hidden');
}

    // Cerca il bottone corrispondente nella sidebar e rendilo attivo
    const targetBtn = document.querySelector(`.tab-btn[onclick="showSection('${sectionId}')"]`);
    if (targetBtn) {
    targetBtn.classList.add('active');
} else if (window.event && window.event.currentTarget) {
    window.event.currentTarget.classList.add('active');
}
}

    // Gestione dello scorrimento sezione ordini passati
    function scrollCarousel(direction) {
    const carousel = document.getElementById("ordersCarousel");
    const scrollAmount = 240 * 2;
    carousel.scrollBy({
    left: direction * scrollAmount,
    behavior: 'smooth'
});
}

    //Controllo del ticket all'avvio pagina
    window.addEventListener('DOMContentLoaded', () => {
    // Legge i parametri dall'URL
    const urlParams = new URLSearchParams(window.location.search);
    const activeTab = urlParams.get('tab');

    if (activeTab) {
    // Se c'è un parametro valido, mostra quella sezione
    showSection(activeTab);
} else {
    // Altrimenti di default mostra sempre la panoramica
    showSection('panoramica');
}
});
