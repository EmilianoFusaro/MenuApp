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

//in caso di esito positivo aggiungo la casella


function inserisci_riga(data) {
  var  nuova_riga='<div class="col-lg-3 col-md-4 col-xs-12 thumb" id="div_riga_'+ data.id +'"> \
                   <div style="background-color:white;height:150px;"> \
                   <div id="div_nome_'+ data.id +'"><h2>'+ data.nome +'</h2></div> \
                   <div id="div_descrizione_'+ data.id +'"> \
                   <h4>'+ data.descrizione +'</h4></div> \
                   </div>\
                   <button type="button" class="btn btn-primary btn-lg" style="width:120px" id="btn_edita_'+ data.id +'">Edita</button>\
                   <button type="button" class="btn btn-danger btn-lg"  style="width:120px" id="btn_elimina_'+ data.id +'">Elimina</button>\
                   <button type="button" class="btn btn-success btn-lg" style="width:120px;display:none;" id="btn_salva_'+ data.id +'">Salva</button>\
                   <button type="button" class="btn btn-warning btn-lg"  style="width:120px;display:none;" id="btn_annulla_'+ data.id +'">Annulla</button>\
                   <div id="nascosto_nome_'+ data.id +'" style="display:none;"><h2></h2></div>\
                   <div id="nascosto_descrizione_'+ data.id +'" style="display:none;"><h4></h4></div>\
                  </div>';
  //$('#riga').append(nuova_riga).hide().fadeIn('slow');
  $('#riga').append(nuova_riga);
  //Aggiunta azione ad elemento dinamico
  //$(document).on('click', '#btn_elimina_' + data.id , function() {
  //  alert('elimino');
  // });

  //Aggiunge Azioni Dinamicamente
  $(document).on('click', '#btn_edita_' + data.id , function() {
    seleziona_azione('#btn_edita_' + data.id,'dinamico');
   });
  $(document).on('click', '#btn_elimina_' + data.id , function() {
    seleziona_azione('#btn_elimina_' + data.id,'dinamico');
  });
  $(document).on('click', '#btn_salva_' + data.id , function() {
    seleziona_azione('#btn_salva_' + data.id,'dinamico');
  });
  $(document).on('click', '#btn_annulla_' + data.id , function() {
    seleziona_azione('#btn_annulla_' + data.id,'dinamico');
  });

}

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

  // $('#div_riga_1').hide();

  //------------------------------------------------------gestione finestra modale aggiunta riga
  $('#btn_salva_add').click(function() {
    //alert('Caio');
    $('#myModal').modal('toggle');

    $.ajax({
     type: "POST",
     url: "/allergens/",
     data: {
       allergen: {
       nome: $('#frm_nome').val(),
       descrizione: $('#frm_descrizione').val(),
       img: "",
       img1: "",
       img2: ""
      }
     },
    success: function(data) {  //ritorna oggetto json senza array
    //alert(data.id);
    //debugger;
    inserisci_riga(data)
    return false;
    },
    error: function(data) {
    alert('Attenzione! problemi nell inserimento');
    return false;
    }
  });
  });

});

//svuota inserimento finestra modale
$('#href_nuovo').click(function() {
  $('#frm_nome').val('');
  $('#frm_descrizione').val('');
  $('#btn_salva_add').show();
});


// $('#btn_elimina').click(function() {
//   $.ajax({
//       url: "/allergens/" + div_selezionato,
//       type: 'DELETE',
//       success: function(result) {
//           alert('ok');
//           $('#div_riga_' + div_selezionato ).fadeOut(600, function(){ $(this).remove();});
//       }
//   });
// });
