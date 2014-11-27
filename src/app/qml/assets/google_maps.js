function initialize() {
    console.log("Initializing Google Maps")
    var mapOptions = {
        center: { lat: 47.599675, lng: -122.333863},
        zoom: 8
    };

    var map = new google.maps.Map(document.getElementById('map-canvas'),
        mapOptions);
}
google.maps.event.addDomListener(window, 'load', initialize);
