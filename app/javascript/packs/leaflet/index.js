
var mymap = L.map('map').setView([-33.8658567,151.1981942], 12);


L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}', {
  attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
  maxZoom: 17,
  id: 'mapbox/streets-v11',
  tileSize: 512,
  zoomOffset: -1,
  accessToken: 'pk.eyJ1IjoidnpvdHRtYW5uIiwiYSI6ImNrbTh6cmZ0cTFkN2IydXBiNmZnY2NoM2UifQ.xZGcGO6IhY22ETZajNOoTg'
}).addTo(mymap);


// Chatswood
L.marker([-33.796751, 151.184798]).addTo(mymap).bindPopup("<p>STEAMdeck Chatswood<br><br> Mon - Fri: 9am to 6pm</p>");

// Neutral Bay
L.marker([-33.829701, 151.220881]).addTo(mymap).bindPopup("<p>STEAMdeck Neutral Bay<br><br> Mon - Fri: 9am to 5pm</p>");

// Sydney CBD
L.marker([-33.869438, 151.208278]).addTo(mymap).bindPopup("<p>STEAMdeck Sydney CBD<br><br> Mon - Fri: 9am to 9pm</p>");

// Newtown
L.marker([-33.896899, 151.179284]).addTo(mymap).bindPopup("<p>STEAMdeck Newtown<br><br> Mon - Fri: 9am to 7pm</p>");

// Strathfield
L.marker([-33.874646, 151.093418]).addTo(mymap).bindPopup("<p>STEAMdeck Strathfield Beach<br><br> Mon - Fri: 9am to 5pm</p>");

// Coogee
L.marker([-33.921854, 151.256488]).addTo(mymap).bindPopup("<p>STEAMdeck Coogee<br><br> Mon - Fri: 9am to 6pm</p>");

// Manly
L.marker([-33.797082, 151.286346]).addTo(mymap).bindPopup("<p>STEAMdeck Manly<br><br> Mon - Fri: 9am to 6pm</p>");



// Mapbox
mapboxgl.accessToken = 'pk.eyJ1IjoidnpvdHRtYW5uIiwiYSI6ImNrbTh6cmZ0cTFkN2IydXBiNmZnY2NoM2UifQ.xZGcGO6IhY22ETZajNOoTg';

var map = new mapboxgl.Map({
  container: 'map',
  style: 'mapbox://styles/mapbox/streets-v11'
});