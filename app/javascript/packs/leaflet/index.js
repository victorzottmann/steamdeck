var mymap = L.map('map').setView([-33.797851, 151.187254], 15);

L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}', {
  attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
  maxZoom: 18,
  id: 'mapbox/streets-v11',
  tileSize: 512,
  zoomOffset: -1,
  accessToken: 'pk.eyJ1IjoidnpvdHRtYW5uIiwiYSI6ImNrbTh6cmZ0cTFkN2IydXBiNmZnY2NoM2UifQ.xZGcGO6IhY22ETZajNOoTg'
}).addTo(mymap);

L.marker([-33.797851, 151.187254]).addTo(mymap);


// Mapbox
mapboxgl.accessToken = 'pk.eyJ1IjoidnpvdHRtYW5uIiwiYSI6ImNrbTh6cmZ0cTFkN2IydXBiNmZnY2NoM2UifQ.xZGcGO6IhY22ETZajNOoTg';

var map = new mapboxgl.Map({
  container: 'map',
  style: 'mapbox://styles/mapbox/streets-v11'
});