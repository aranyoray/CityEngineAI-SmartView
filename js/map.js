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

    const stationData = [
        { name: 'Attiguppe (ATGP)', lat: 12.9679, lng: 77.5417, line: 'Purple Line' },
        { name: 'Baiyappanahalli (BYPL)', lat: 12.9905, lng: 77.6389, line: 'Purple Line' },
        { name: 'Banashankari (BSK)', lat: 12.9289, lng: 77.5463, line: 'Green Line' },
        { name: 'Bangalore City Station (BLCY)', lat: 12.9758, lng: 77.5734, line: 'Purple Line' },
        { name: 'Banashankari (BSNK)', lat: 12.9257, lng: 77.5462, line: 'Green Line' },
        { name: 'Krantivira Sangolli Rayanna Railway Station (SRCS)', lat: 12.9772, lng: 77.5701, line: 'Purple Line' },
        { name: 'Challaghatta (CLGA)', lat: 12.9356, lng: 77.4976, line: 'Purple Line' },
        { name: 'Chickpete (CKPE)', lat: 12.9633, lng: 77.5811, line: 'Green Line' },
        { name: 'Cubbon Park (CBPK)', lat: 12.9761, lng: 77.5952, line: 'Purple Line' },
        { name: 'Dasarahalli (DSH)', lat: 13.0516, lng: 77.5162, line: 'Green Line' },
        { name: 'Deepanjali Nagar (DJNR)', lat: 12.9452, lng: 77.5318, line: 'Purple Line' },
        { name: 'Doddakallasandra (KLPK)', lat: 12.8714, lng: 77.5483, line: 'Green Line' },
        { name: 'Garudacharapalya (GDCP)', lat: 12.9927, lng: 77.6793, line: 'Purple Line' },
        { name: 'Goraguntepalya (YPI)', lat: 13.0307, lng: 77.5196, line: 'Green Line' },
        { name: 'Halasuru (HLRU)', lat: 12.9768, lng: 77.6194, line: 'Purple Line' },
        { name: 'Hoodi (DKIA)', lat: 12.9953, lng: 77.7067, line: 'Purple Line' },
        { name: 'Hopefarm Channasandra (UWVL)', lat: 12.9931, lng: 77.7463, line: 'Purple Line' },
        { name: 'Sri Balagangadharanatha Swamiji Station, Hosahalli (HSLI)', lat: 12.9682, lng: 77.5198, line: 'Purple Line' },
        { name: 'Indiranagar (IDN)', lat: 12.9784, lng: 77.6404, line: 'Purple Line' },
        { name: 'Jalahalli (JLHL)', lat: 13.0311, lng: 77.5336, line: 'Green Line' },
        { name: 'Jayanagar (JYN)', lat: 12.9261, lng: 77.5902, line: 'Green Line' },
        { name: 'Jayaprakash Nagar (JPN)', lat: 12.9063, lng: 77.5856, line: 'Green Line' },
        { name: 'Jnanabharathi (BGUC)', lat: 12.9502, lng: 77.5085, line: 'Purple Line' },
        { name: 'Kadugodi Tree Park (KDGD)', lat: 12.9911, lng: 77.7578, line: 'Purple Line' },
        { name: 'Krishna Rajendra Market (KRMT)', lat: 12.9611, lng: 77.5783, line: 'Green Line' },
        { name: 'Krishnarajapura (KRAM)', lat: 12.9988, lng: 77.6962, line: 'Purple Line' },
        { name: 'Kengeri (KGIT)', lat: 12.9171, lng: 77.4807, line: 'Purple Line' },
        { name: 'Kengeri Bus Terminal (MLSD)', lat: 12.9137, lng: 77.4872, line: 'Purple Line' },
        { name: 'Konanakunte Cross (APRC)', lat: 12.8693, lng: 77.5552, line: 'Green Line' },
        { name: 'Kundalahalli (KDNH)', lat: 12.9652, lng: 77.7271, line: 'Purple Line' },
        { name: 'Lalbagh (LBGH)', lat: 12.9494, lng: 77.5849, line: 'Green Line' },
        { name: 'Magadi Road (MIRD)', lat: 12.9782, lng: 77.5412, line: 'Purple Line' }
    ];    

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
