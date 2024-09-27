// Function to check if a station is an interchange
function isInterchangeStation(stationName) {
    const interchangeStations = ['Kempegowda (KGWA)', 'Majestic (KGWA)', 'Nadaprabhu Kempegowda Station, Majestic (KGWA)'];
    return interchangeStations.includes(stationName);
}

// Function to calculate route with interchange
function calculateRouteWithInterchange(fromStation, toStation) {
    // Dummy route logic, to be replaced with actual metro routing data
    const interchangeStation = 'Kempegowda (KGWA)';
    const fromRoute = `Route from ${fromStation} to ${interchangeStation} (Purple Line)`;
    const toRoute = `Route from ${interchangeStation} to ${toStation} (Green Line)`;
    return `${fromRoute}<br>${toRoute}`;
}

document.addEventListener('DOMContentLoaded', () => {
    const searchRoutesBtn = document.getElementById('searchRoutesBtn');
    const routeDisplay = document.getElementById('routeDisplay');

    searchRoutesBtn.addEventListener('click', () => {
        const fromStation = document.getElementById('fromStation').value;
        const toStation = document.getElementById('toStation').value;

        if (fromStation && toStation) {
            if (isInterchangeStation(fromStation) || isInterchangeStation(toStation)) {
                const routeInfo = calculateRouteWithInterchange(fromStation, toStation);
                routeDisplay.innerHTML = `<h3>Route Details:</h3><p>${routeInfo}</p>`;
            } else {
                routeDisplay.innerHTML = `<h3>Route Details:</h3><p>Direct route from ${fromStation} to ${toStation}</p>`;
            }
        } else {
            alert('Please select both stations.');
        }
    });
});