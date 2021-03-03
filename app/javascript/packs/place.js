geocoder.geocode({ address: gon.visit_place }, function(results, status){
  if (status === 'OK' && results[0]){  
     new google.maps.Map(target, {
       center: results[0].geometry.location,
       zoom: 14
     });
  }else{
    alert('失敗しました。理由: ' + status);
  }
  console.log(status)
}); 
const googleKey = ENV["GOOGLE_KEY"]