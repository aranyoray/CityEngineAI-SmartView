const stationData = [
    { name: 'Attiguppe (AGPP)', kannada: 'ಅತ್ತಿಗುಪ್ಪೆ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Baiyappanahalli (BYPL)', kannada: 'ಬೈಯ್ಯಪ್ಪನಹಳ್ಳಿ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Benniganahalli (JTPM)', kannada: 'ಬೆನ್ನಿಗಾನಹಳ್ಳಿ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Banashankari (BSNK)', kannada: 'ಬನಶಂಕರಿ', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Krantivira Sangolli Rayanna Railway Station (SRCS)', kannada: 'ಕ್ರಾಂತಿವೀರ ಸಂಗೊಳ್ಳಿ ರಾಯಣ್ಣ ರೈಲು ನಿಲ್ದಾಣ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Challaghatta (CLGA)', kannada: 'ಚಲ್ಲಘಟ್ಟ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Chickpete (CKPE)', kannada: 'ಚಿಕ್ಕಪೇಟೆ', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Cubbon Park (CBPK)', kannada: 'ಕಬ್ಬನ್ ಪಾರ್ಕ್', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Dasarahalli (DSH)', kannada: 'ದಾಸರಹಳ್ಳಿ', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Deepanjali Nagar (DJNR)', kannada: 'ದೀಪಾಂಜಲಿ ನಗರ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Doddakallasandra (KLPK)', kannada: 'ದೊಡ್ಡಕಲ್ಲಸಂದ್ರ', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Garudacharapalya (GDCP)', kannada: 'ಗರುಡಾಚಾರ್‍‍ಪಾಳ್ಯ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Goraguntepalya (YPI)', kannada: 'ಗೊರಗುಂಟೆಪಾಳ್ಯ', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Halasuru (HLRU)', kannada: 'ಹಲಸೂರು', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Hoodi (DKIA)', kannada: 'ಹೂಡಿ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Hopefarm Channasandra (UWVL)', kannada: 'ಹೋಪ್ ಫಾರ್ಮ್ ಚನ್ನಸಂದ್ರ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Sri Balagangadharanatha Swamiji Station, Hosahalli (HSLI)', kannada: 'ಶ್ರೀ ಬಾಲಗಂಗಾಧರನಾಥ ಸ್ವಾಮೀಜಿ ನಿಲ್ದಾಣ, ಹೊಸಹಳ್ಳಿ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Indiranagar (IDN)', kannada: 'ಇಂದಿರಾ ನಗರ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Jalahalli (JLHL)', kannada: 'ಜಾಲಹಳ್ಳಿ', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Jayanagar (JYN)', kannada: 'ಜಯನಗರ', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Jayaprakash Nagar (JPN)', kannada: 'ಜಯಪ್ರಕಾಶ ನಗರ', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Jnanabharathi (BGUC)', kannada: 'ಜ್ಞಾನಭಾರತಿ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Kadugodi Tree Park (KDGD)', kannada: 'ಕಾಡುಗೋಡಿ ಟ್ರೀ ಪಾರ್ಕ್', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Krishna Rajendra Market (KRMT)', kannada: 'ಕೃಷ್ಣ ರಾಜೇಂದ್ರ ಮಾರುಕಟ್ಟೆ', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Krishnarajapura (KRAM)', kannada: 'ಕೃಷ್ಣರಾಜಪುರ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Kengeri (KGIT)', kannada: 'ಕೆಂಗೇರಿ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Kengeri Bus Terminal (MLSD)', kannada: 'ಕೆಂಗೇರಿ ಬಸ್ ಟರ್ಮಿನಲ್', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Konanakunte Cross (APRC)', kannada: 'ಕೋಣನಕುಂಟೆ ಕ್ರಾಸ್', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Kundalahalli (KDNH)', kannada: 'ಕುಂದಲಹಳ್ಳಿ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Lalbagh (LBGH)', kannada: 'ಲಾಲ್ ಬಾಗ್', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Magadi Road (MIRD)', kannada: 'ಮಾಗಡಿ ರಸ್ತೆ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Mahalakshmi (MHLI)', kannada: 'ಮಹಾಲಕ್ಷ್ಮೀ', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Mahakavi Kuvempu Road (KVPR)', kannada: 'ಮಹಾಕವಿ ಕುವೆಂಪು ರಸ್ತೆ', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Nadaprabhu Kempegowda Station, Majestic (KGWA)', kannada: 'ನಾಡಪ್ರಭು ಕೆಂಪೇಗೌಡ ನಿಲ್ದಾಣ, ಮೆಜೆಸ್ಟಿಕ್', line: 'Interchange', bgColor: '#f7e200' },
    { name: 'Mahatma Gandhi Road (MAGR)', kannada: 'ಮಹಾತ್ಮಾ ಗಾಂಧಿ ರಸ್ತೆ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Mysuru Road (MYRD)', kannada: 'ಮೈಸೂರು ರಸ್ತೆ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Nagasandra (NGSA)', kannada: 'ನಾಗಸಂದ್ರ', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Nallurhalli (VDHP)', kannada: 'ನಲ್ಲೂರುಹಳ್ಳಿ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'National College (NLC)', kannada: 'ನ್ಯಾಷನಲ್ ಕಾಲೇಜ್', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Pantharapalya - Nayandahalli (NYHM)', kannada: 'ಪಂತರಪಾಳ್ಯ - ನಾಯಂಡಹಳ್ಳಿ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Pattanagere (PATG)', kannada: 'ಪಟ್ಟಣಗೆರೆ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Pattandur Agrahara (ITPL)', kannada: 'ಪಟ್ಟಂದೂರು ಅಗ್ರಹಾರ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Peenya (PEYA)', kannada: 'ಪೀಣ್ಯ', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Peenya Industry (PYID)', kannada: 'ಪೀಣ್ಯ ಇಂಡಸ್ಟ್ರಿ', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Rajajinagar (RJNR)', kannada: 'ರಾಜಾಜಿನಗರ', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Rajarajeshwari Nagar (RRRN)', kannada: 'ರಾಜರಾಜೇಶ್ವರಿ ನಗರ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Rashtreeya Vidyalaya Road (RVR)', kannada: 'ರಾಷ್ಟ್ರೀಯ ವಿದ್ಯಾಲಯ ರಸ್ತೆ', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Mantri Square Sampige Road (SPGD)', kannada: 'ಮಂತ್ರಿ ಸ್ಕ್ವೇರ್, ಸಂಪಿಗೆ ರಸ್ತೆ', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Sandal Soap Factory (SSFY)', kannada: 'ಸ್ಯಾಂಡಲ್ ಸೋಪ್ ಫ್ಯಾಕ್ಟರಿ', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Seetharampalya (VWIA)', kannada: 'ಸೀತಾರಾಮಪಾಳ್ಯ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Singayyanapalya (MDVP)', kannada: 'ಸಿಂಗಯ್ಯನಪಾಳ್ಯ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Silk Institute (APTS)', kannada: 'ರೇಷ್ಮೆ ಸಂಸ್ಥೆ', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Sir M. Visvesvaraya Station, Central College (VSWA)', kannada: 'ಸರ್ ಎಂ.ವಿಶ್ವೇಶ್ವರಯ್ಯ ನಿಲ್ದಾಣ, ಸೆಂಟ್ರಲ್ ಕಾಲೇಜು', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Swami Vivekananda Road (SVRD)', kannada: 'ಸ್ವಾಮಿ ವಿವೇಕಾನಂದ ರಸ್ತೆ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'South End Circle (SECE)', kannada: 'ಸೌತ್ ಎಂಡ್ ಸರ್ಕಲ್', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Srirampura (SPRU)', kannada: 'ಶ್ರೀರಾಮ್‍ಪುರ', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Sri Sathya Sai Hospital (SSHP)', kannada: 'ಶ್ರೀ ಸತ್ಯ ಸಾಯಿ ಆಸ್ಪತ್ರೆ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Thalaghattapura (TGTP)', kannada: 'ತಲಘಟ್ಟಪುರ', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Trinity (TTY)', kannada: 'ಟ್ರಿನಿಟಿ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Vajarahalli (VJRH)', kannada: 'ವಾಜರಹಳ್ಳಿ', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Dr. B. R. Ambedkar Station, Vidhana Soudha (VDSA)', kannada: 'ಡಾ. ಬಿ. ಆರ್. ಅಂಬೇಡ್ಕರ್ ನಿಲ್ದಾಣ, ವಿಧಾನ ಸೌಧ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Vijayanagar (VJN)', kannada: 'ವಿಜಯನಗರ', line: 'Purple Line', bgColor: '#8b3a62' },
    { name: 'Yelachenahalli (PUTH)', kannada: 'ಯಲಚೇನಹಳ್ಳಿ', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Yeshwanthpur (YPM)', kannada: 'ಯಶವಂತಪುರ', line: 'Green Line', bgColor: '#22b14c' },
    { name: 'Whitefield (Kadugodi) (WHTM)', kannada: 'ವೈಟ್ ಫೀಲ್ಡ್ (ಕಾಡುಗೋಡಿ)', line: 'Purple Line', bgColor: '#8b3a62' }
];

// Function to populate dropdowns with station data
function populateDropdown(dropdown) {
    stationData.forEach(station => {
        const option = document.createElement('option');
        option.value = station.name;
        option.text = `${station.name} / ${station.kannada}`;
        option.style.backgroundColor = station.bgColor; // Set background color based on line
        dropdown.appendChild(option);
    });
}

document.addEventListener('DOMContentLoaded', () => {
    const fromStationDropdown = document.getElementById('fromStation');
    const toStationDropdown = document.getElementById('toStation');
    const searchRoutesBtn = document.getElementById('searchRoutesBtn');
    const routeDisplay = document.getElementById('routeDisplay');
    const routeDetailsSection = document.getElementById('routeDetails');

    // Populate the dropdowns
    populateDropdown(fromStationDropdown);
    populateDropdown(toStationDropdown);

    // Event listener for the search button click
    searchRoutesBtn.addEventListener('click', () => {
        const fromStation = fromStationDropdown.value;
        const toStation = toStationDropdown.value;

        if (fromStation && toStation) {
            const routeInfo = `Route from ${fromStation} to ${toStation}`;
            routeDisplay.innerHTML = `<h3>${routeInfo}</h3><p>Details about the route, stops, etc.</p>`;
            routeDetailsSection.style.display = 'block';
        } else {
            alert('Please select both stations.');
        }
    });
});