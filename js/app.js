document.addEventListener('DOMContentLoaded', () => {
    const fromStationDropdown = document.getElementById('fromStation');
    const toStationDropdown = document.getElementById('toStation');
    const searchRoutesBtn = document.getElementById('searchRoutesBtn');
    const routeDisplay = document.getElementById('routeDisplay');
    const routeDetailsSection = document.getElementById('routeDetails');

    // Populate station names
    const stationNames = [
        { name: 'Attiguppe (ATGP)', kannada: 'ಅಟ್ಟಿಗುಪ್ಪೆ' },
        { name: 'Baiyappanahalli (BYPL)', kannada: 'ಬೈಯಪ್ಪನಹಳ್ಳಿ' },
        { name: 'Banashankari (BSK)', kannada: 'ಬನಶಂಕರಿ' },
        { name: 'Bangalore City Station (BLCY)', kannada: 'ಬೆಂಗಳೂರು ನಗರ' },
        { name: 'Cubbon Park (CBPK)', kannada: 'ಕಬ್ಬನ್ ಪಾರ್ಕ್' },
        { name: 'Kempegowda (KGWA)', kannada: 'ಕಂಪೆಗೌಡ' },
        { name: 'Mysuru Road (MRRD)', kannada: 'ಮೈಸೂರು ರಸ್ತೆ' },
        { name: 'Indiranagar (INDN)', kannada: 'ಇಂದಿರಾನಗರ' },
        { name: 'Trinity (TNTY)', kannada: 'ಟ್ರಿನಿಟಿ' },
        { name: 'Vijayanagar (VJNG)', kannada: 'ವಿಜಯನಗರ' },
        { name: 'Mahalakshmi (MLKM)', kannada: 'ಮಹಾಲಕ್ಷ್ಮಿ' },
        { name: 'Rajajinagar (RJNG)', kannada: 'ರಾಜಾಜಿನಗರ' },
        { name: 'Peenya (PNYA)', kannada: 'ಪೀನ್ಯ' },
        { name: 'Yeshwanthpur (YSWR)', kannada: 'ಯಶವಂತಪುರ' },
        { name: 'Nagasandra (NGSD)', kannada: 'ನಾಗಸಂದ್ರ' }
        // Add more stations as required
    ];

    function populateDropdown(dropdown) {
        stationNames.forEach(station => {
            const option = document.createElement('option');
            option.value = station.name;
            option.text = `${station.name} / ${station.kannada}`;
            dropdown.appendChild(option);
        });
    }

    populateDropdown(fromStationDropdown);
    populateDropdown(toStationDropdown);

    // Event listener for button click
    searchRoutesBtn.addEventListener('click', () => {
        const fromStation = fromStationDropdown.value;
        const toStation = toStationDropdown.value;
    
        console.log('From Station:', fromStation);
        console.log('To Station:', toStation);
    
        if (fromStation && toStation) {
            if (fromStation === toStation) {
                routeDisplay.innerHTML = `<h3>Invalid Selection</h3><p>Please select different stations for your route.</p>`;
            } else {
                const routeInfo = `Route from ${fromStation} to ${toStation}`;
                console.log('Route Info:', routeInfo);
                routeDisplay.innerHTML = `<h3>${routeInfo}</h3><p>Details about the route, stops, etc.</p>`;
                routeDetailsSection.style.display = 'block';
            }
        } else {
            alert('Please select both stations.');
        }
    });
});