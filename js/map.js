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

function getStationCoordinates(stationName) {
    const coordinates = {
        'Attiguppe (AGPP)': { lat: 12.9617, lng: 77.5371 },
        'Baiyappanahalli (BYPL)': { lat: 12.9829, lng: 77.6515 },
        'Benniganahalli (JTPM)': { lat: 12.9976, lng: 77.6541 },
        'Banashankari (BSNK)': { lat: 12.9257, lng: 77.5462 },
        'Krantivira Sangolli Rayanna Railway Station (SRCS)': { lat: 12.9772, lng: 77.5701 },
        'Challaghatta (CLGA)': { lat: 12.9356, lng: 77.4976 },
        'Chickpete (CKPE)': { lat: 12.9633, lng: 77.5811 },
        'Cubbon Park (CBPK)': { lat: 12.9761, lng: 77.5952 },
        'Dasarahalli (DSH)': { lat: 13.0516, lng: 77.5162 },
        'Deepanjali Nagar (DJNR)': { lat: 12.9452, lng: 77.5318 },
        'Doddakallasandra (KLPK)': { lat: 12.8714, lng: 77.5483 },
        'Garudacharapalya (GDCP)': { lat: 12.9927, lng: 77.6793 },
        'Goraguntepalya (YPI)': { lat: 13.0307, lng: 77.5196 },
        'Halasuru (HLRU)': { lat: 12.9768, lng: 77.6194 },
        'Hoodi (DKIA)': { lat: 12.9953, lng: 77.7067 },
        'Hopefarm Channasandra (UWVL)': { lat: 12.9931, lng: 77.7463 },
        'Sri Balagangadharanatha Swamiji Station, Hosahalli (HSLI)': { lat: 12.9682, lng: 77.5198 },
        'Indiranagar (IDN)': { lat: 12.9784, lng: 77.6404 },
        'Jalahalli (JLHL)': { lat: 13.0311, lng: 77.5336 },
        'Jayanagar (JYN)': { lat: 12.9261, lng: 77.5902 },
        'Jayaprakash Nagar (JPN)': { lat: 12.9063, lng: 77.5856 },
        'Jnanabharathi (BGUC)': { lat: 12.9502, lng: 77.5085 },
        'Kadugodi Tree Park (KDGD)': { lat: 12.9911, lng: 77.7578 },
        'Krishna Rajendra Market (KRMT)': { lat: 12.9611, lng: 77.5783 },
        'Krishnarajapura (KRAM)': { lat: 12.9988, lng: 77.6962 },
        'Kengeri (KGIT)': { lat: 12.9171, lng: 77.4807 },
        'Kengeri Bus Terminal (MLSD)': { lat: 12.9137, lng: 77.4872 },
        'Konanakunte Cross (APRC)': { lat: 12.8693, lng: 77.5552 },
        'Kundalahalli (KDNH)': { lat: 12.9652, lng: 77.7271 },
        'Lalbagh (LBGH)': { lat: 12.9494, lng: 77.5849 },
        'Magadi Road (MIRD)': { lat: 12.9782, lng: 77.5412 }
    };
    return coordinates[stationName];
}

    stationData.forEach(station => {
        const marker = new google.maps.Marker({
            position: { lat: station.lat, lng: station.lng },
            map: map,
            title: station.name,
            icon: {
                url: `http://maps.google.com/mapfiles/ms/icons/${station.line === 'Purple Line' ? 'purple' : 'green'}-dot.png`
            }
        });

        const infoWindow = new google.maps.InfoWindow({
            content: `<h4>${station.name}</h4><p>Line: ${station.line}</p>`
        });

        marker.addListener('click', () => {
            infoWindow.open(map, marker);
        });
    });
}

// Load the map when the DOM content is fully loaded
document.addEventListener('DOMContentLoaded', () => {
    initMap();
});