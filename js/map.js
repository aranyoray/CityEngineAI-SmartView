// Function to fetch the Google Maps API key from the JSON file
async function fetchApiKey() {
    try {
        const response = await fetch('/api/api_keys.json');  // Ensure this path is correct based on your project structure
        const data = await response.json();
        return data.google_maps_api_key;
    } catch (error) {
        console.error('Error fetching API key:', error);
        return null;
    }
}

// Initialize and add the map
async function initMap() {
    const apiKey = await fetchApiKey();

    if (!apiKey) {
        console.error('API key not available');
        return;
    }

    const script = document.createElement('script');
    script.src = `https://maps.googleapis.com/maps/api/js?key=${apiKey}&callback=initGoogleMap`;
    script.async = true;
    script.defer = true;
    document.head.appendChild(script);
}

// Actual map initialization after the Google Maps API script loads
function initGoogleMap() {
    const mapOptions = {
        zoom: 12,
        center: { lat: 12.9716, lng: 77.5946 } // Default center to Bangalore
    };

    const map = new google.maps.Map(document.getElementById('map'), mapOptions);

    stationData.forEach(station => {
        const marker = new google.maps.Marker({
            position: getStationCoordinates(station.name),
            map: map,
            title: station.name,
            icon: {
                url: `http://maps.google.com/mapfiles/ms/icons/${station.line === 'Purple Line' ? 'purple' : 'green'}-dot.png`
            }
        });

        const infoWindow = new google.maps.InfoWindow({
            content: `<h4>${station.name}</h4><p>${station.kannada}</p><p>Line: ${station.line}</p>`
        });

        marker.addListener('click', () => {
            infoWindow.open(map, marker);
        });
    });
}

// Dummy function to simulate coordinates for stations (replace with real data)
function getStationCoordinates(stationName) {
    const coordinates = {
        'Attiguppe (AGPP)': { lat: ​⬤