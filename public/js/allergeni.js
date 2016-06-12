//invia richiesta json
// $(function(){
// //if ($('#ultimaw').load){
//    $.ajax({
//    type: "GET",
//    url: "/allergens",
//    dataType: "json",
//    //async: false,
//    success: function(data){
//       //alert(data[1].nome + ' ciao');
//       alert(' ciao');
//     }
// });
// });

//al caricamento di una jmg o div
// $(function(){
//   $('#ultima').on('load',function(){
//     alert('ciao');
// });
// $('#finito').ready(function(){
//   alert('ciao');
// });
// $(document).ready(function(){
//   alert('ciao');
// });
//});


$(function(){
    //$('#footer').hide();  //nascondo da css
    if ($('.container').length > 0){
        $('#riga').load('/allergens/lista').hide().fadeIn(5000);
        //$('#riga').load('/allergens/lista');
    }
   $('#footer').fadeIn('slow');

  //  $("button").click(function() {
  //   alert(this.id);
  //  });

  $('#div_riga_1').hide();

});
