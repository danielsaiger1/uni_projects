document.getElementById('searchField').addEventListener('input', function () {
    console.log("Search.js geladen");
    const searchValue = this.value.toLowerCase();
    const items = document.querySelectorAll('.rest_item');
    let hasVisibleItems = false;

    items.forEach(item => {
        const name = item.querySelector('.card-title').textContent.toLowerCase();
        if (name.includes(searchValue)) {
            item.classList.remove('hidden'); // Zeige Element
            hasVisibleItems = true;
        } else {
            item.classList.add('hidden'); // Verstecke Element
        }
    });

    // Zeige "Keine Ergebnisse"-Meldung, falls keine sichtbaren Elemente existieren
    document.getElementById('noResults').style.display = hasVisibleItems ? 'none' : 'block';
}); 