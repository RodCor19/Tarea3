/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function clickear(elem){
    elem.style.color='black';
}
function listaralbumes(nick){
        $.ajax({
            type: 'POST', //tipo de request
            url: '/EspotifyMovil/ServletGeneral',
            dataType: 'text', // tipo de dato esperado en la respuesta(text, json, etc.)
            data: {// Parametros que se pasan en el request
                listaralbumes: nick
            },
            success: function (data) { //en el success ponemos lo que queremos hacer cuando obtenemos la respuesta
                $('#listaArtGen').load('/EspotifyMovil/Vistas/listaalbumes.jsp');
            }
        });
    }
    
function consultaalbum(nomalbum){

        $.ajax({
            type: 'POST', //tipo de request
            url: '/EspotifyMovil/ServletGeneral',
            dataType: 'text', // tipo de dato esperado en la respuesta(text, json, etc.)
            data: {// Parametros que se pasan en el request
                consultaalbum: nomalbum
            },
            success: function (data) { //en el success ponemos lo que queremos hacer cuando obtenemos la respuesta
                $('#listaArtGen').load('/EspotifyMovil/Vistas/consultaalbum.jsp');
            }
        });
    }

$(document).ready(function () {
    
    $(document).click(function(event) {
       if(!$(event.target).closest('#mitabla').length){
            var filas = document.getElementsByTagName("TR");
            var i;
            for (i=0;i<filas.length;i++){
                filas[i].style.color='white';
            }
        }
    });
    
    $('tr').click(function () {
        var filas = document.getElementsByTagName("TR");
        var i;
        for (i=0;i<filas.length;i++){
            filas[i].style.color='white';
            //filas[i].style.background='';
        }
        $(this).css('color', 'black');
        //$(this).css('background', 'white');
    });
    
    $('#btnartistas').click(function () {
        $('.navbar-toggle').click();
        $.ajax({
            type: 'POST', //tipo de request
            url: '/EspotifyMovil/ServletGeneral',
            dataType: 'text', // tipo de dato esperado en la respuesta(text, json, etc.)
            data: {// Parametros que se pasan en el request
                Inicio: true
            },
            success: function (data) { //en el success ponemos lo que queremos hacer cuando obtenemos la respuesta
                $('#listaArtGen').load('/EspotifyMovil/Vistas/listaArtistas.jsp');
            }
        });
    });
    
    $('#btngeneros').click(function () {
        $('.navbar-toggle').click();
        $.ajax({
            type: 'POST', //tipo de request
            url: '/EspotifyMovil/ServletGeneral',
            dataType: 'text', // tipo de dato esperado en la respuesta(text, json, etc.)
            data: {// Parametros que se pasan en el request
                Inicio: true
            },
            success: function (data) { //en el success ponemos lo que queremos hacer cuando obtenemos la respuesta
                $('#listaArtGen').load('/EspotifyMovil/Vistas/listaGeneros.jsp');
            }
        });
    });
    
    
});
