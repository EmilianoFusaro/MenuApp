
// $(document).ready(function(){
//$("allergeni").ready(function(){
$.ajax({
  type: "GET",
  url: "/allergens",
  dataType: "json",
  success: function(data){
    alert(data[1].nome) // Will alert Max
  }
});
//});
