function inserisci_riga(data) {
  var  nuova_riga='<div class="col-lg-3 col-md-4 col-xs-12 thumb" id="div_riga_'+ data.id +'"> \
                   <div style="background-color:white;height:150px;"> \
                   <div id="div_nome_'+ data.id +'"><h2>'+ data.titolo +'</h2></div> \
                   <div id="div_descrizione_'+ data.id +'"> \
                   <h4>'+ data.descrizione +'</h4></div> \
                   </div>\
                   <button type="button" class="btn btn-primary btn-lg" style="width:120px" id="btn_edita_'+ data.id +'">Edita</button>\
                   <button type="button" class="btn btn-danger btn-lg"  style="width:120px" id="btn_elimina_'+ data.id +'">Elimina</button>\
                   <button type="button" class="btn btn-success btn-lg" style="width:120px;display:none;" id="btn_salva_'+ data.id +'">Salva</button>\
                   <button type="button" class="btn btn-warning btn-lg"  style="width:120px;display:none;" id="btn_annulla_'+ data.id +'">Annulla</button>\
                   <div id="nascosto_titolo_'+ data.id +'" style="display:none;"><h2></h2></div>\
                   <div id="nascosto_descrizione_'+ data.id +'" style="display:none;"><h4></h4></div>\
                  </div>';

  $('#riga').append(nuova_riga);

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

    if ($('.container').length > 0){
        $('#riga').load('/categories').hide().fadeIn(5000);
    }
   $('#footer').fadeIn('slow');

  //------------------------------------------------------gestione finestra modale aggiunta riga
  $('#btn_salva_add').click(function() {
    $('#myModal').modal('toggle');

    $.ajax({
     type: "POST",
     url: "/categories/",
     data: {
       category: {
       titolo: $('#frm_titolo').val(),
       descrizione: $('#frm_descrizione').val(),
       ordine:9999
      }
     },
    success: function(data) {  //ritorna oggetto json senza array
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


//------------------------------------------------------gestione modalità ricerca
$('#btn_menu_cerca').click(function() {
  $('#footer').hide();
  if ($('#menu_cerca').val().trim()!="") {
    $('#riga').load('/allergens/lista_filtra/'+ $('#menu_cerca').val() ).hide().fadeIn(1000);
  } else {
    $('#riga').load('/allergens/lista').hide().fadeIn(1000);
    }
  $('#footer').fadeIn('slow');
});
