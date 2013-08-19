$ ->
  window.load_google_map = (lat, lng) ->
    myLatlng = new google.maps.LatLng(lat, lng)
    myOptions =
      zoom: 14
      center: myLatlng
      mapTypeId: google.maps.MapTypeId.ROADMAP      
    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions)
