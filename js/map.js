// Initialize and add the map
function initMap() {
    // Set default map options
    const mapOptions = {
        zoom: 12,
        center: { lat: 12.9716, lng: 77.5946 }, // Coordinates for Bangalore
    };

    // Create the map object
    const map = new google.maps.Map(document.getElementById('map'), mapOptions);

    // Add markers for each metro station
    stationData.forEach(station => {
        const marker = new google.maps.Marker({
            position: getStationCoordinates(station.name),
            map: map,
            title: station.name,
        });

        // Add an info window for each marker
        const infoWindow = new google.maps.InfoWindow({
            content: `<h4>${station.name}</h4><p>${station.kannada}</p><p>Line: ${station.line}</p>`
        });

        // Show info window on marker click
        marker.addListener('click', () => {
            infoWindow.open(map, marker);
        });
    });
}

// Dummy function to simulate coordinates for stations (replace with real data)
function getStationCoordinates(stationName) {
    const coordinates = {
        'Attiguppe (AGPP)': { lat: 12.9679, lng: 77.5417 },
        'Baiyappanahalli (BYPL)': { lat: 12.9905, lng: 77.6389 },
        'Banashankari (BSNK)': { lat: 12.9289, lng: 77.5463 },
        // Add other stations' coordinates here
    };

    return coordinates[stationName] || { lat: 12.9716, lng: 77.5946 }; // Default to Bangalore
}

// Call the map initialization when the page loads
document.addEventListener('DOMContentLoaded', () => {
    initMap();
});