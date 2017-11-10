/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var idtema=-1;
function get_next(pos){
    var audios = document.getElementById("music");
    var repr = document.getElementById("aurepr");
    var length = audios.rows.length;
    var selected = audios.getElementsByClassName("selected");
    if (selected.length > 0){
        index = selected[0].rowIndex;
        next = Math.abs((index + pos) % length);
        if (next === 0) //para excluir el titulo
            next += 1;
        play(audios.rows[next]);
    };
};
function set_play(value,lab_title){
    var trackData = value.split("|"); 
    var title = document.getElementById("auTitle");
    title.textContent = lab_title;
    var image = document.getElementById("trackImage");
    image.src = trackData[1];
};
function play(row){
    var repr = document.getElementById("aurepr");
        trackData = row.id.split("|"),
        label = row.getElementsByClassName("song")[0].innerText;
    repr.src = trackData[0];
//    set_play(row.id, label);
//    var audios = document.getElementById("music");
//    for (var i=1; i<audios.rows.length; i++){
//        //audios.rows[i].style.backgroundColor = "#262626";
//        audios.rows[i].classList.remove("selected");
//    }
//    row.style.backgroundColor = '#3f3f3f';
//    row.classList.add("selected");
    repr.play();
};

function func(e){
    alert(e).innerHTML;
}

function hola(e,nomart,nomalb,nomtem){
    e = e.parentNode;
    var tabla = e.parentNode;
    var x = tabla.getElementsByTagName("img");
    var i=0,n=x.length;
    for (i;i<n;i++){
        
        if ((x[i].getAttribute("src"))!=="../Imagenes/unavailable.png" && x[i].parentNode.parentNode !== e){
            x[i].setAttribute("src","../Imagenes/play.png");
            x[i].parentNode.parentNode.style.color = 'white';
            x[i].parentNode.parentNode.style.backgroundColor = '';
        }
    }
    var imgselect = e.getElementsByTagName("img");
    if ((imgselect[0].getAttribute("src"))==="../Imagenes/play.png"){
        imgselect[0].setAttribute("src","../Imagenes/pause.png");
        imgselect[0].parentNode.parentNode.style.color = 'black';
        imgselect[0].parentNode.parentNode.style.backgroundColor = 'white';
        var repr = document.getElementById("aurepr");
        if(repr===null){
            idtema = imgselect[0].parentNode.parentNode.getAttribute("id");
            reproducirTema(nomtem,nomalb,nomart);
        }
        else{
            if (repr.currentTime > 0 && idtema===imgselect[0].parentNode.parentNode.getAttribute("id")){
                repr.play();
            }
            else{
                idtema = imgselect[0].parentNode.parentNode.getAttribute("id");
                reproducirTema(nomtem,nomalb,nomart);
            }
        }
    }
    else{
        if ((imgselect[0].getAttribute("src"))==="../Imagenes/pause.png") {
            imgselect[0].setAttribute("src","../Imagenes/play.png");
            imgselect[0].parentNode.parentNode.style.color = 'white';
            imgselect[0].parentNode.parentNode.style.backgroundColor = '';
            var repr = document.getElementById("aurepr");
            repr.pause();
        }
    }
    //alert(n[0].getAttribute("img"));
}

function nuevaReproduccion (artista, album, tema) {
    //alert("nuevareproduccion");
    $.ajax({
        type : 'POST', //tipo de request
        url : '/EspotifyMovil/ServletGeneral',
        dataType : 'text', // tipo de dato esperado en la respuesta(text, json, etc.)
        data:{ // Parametros que se pasan en el request
           artista : artista,
           album : album,
           tema : tema,
           nuevareproduccion : true
        },
        success : function(data){ //en el success ponemos lo que queremos hacer cuando obtenemos la respuesta
        }
    }); 
}

function reproducirTema(tema, album, artista){
    //alert("reproducirtema");
    $.ajax({
        type : 'GET', //tipo de request
        url : '/EspotifyMovil/ServletGeneral',
        dataType : 'text', // tipo de dato esperado en la respuesta(text, json, etc.)
        data:{ // Parametros que se pasan en el request
            reproducirAlbum : album,
            artista: artista,
            tema : tema
        },
        success : function(){ //en el success ponemos lo que queremos hacer cuando obtenemos la respuesta
            $('#divReproductor').load("/EspotifyMovil/Vistas/reproductor.jsp");
            nuevaReproduccion(artista, album, tema);
        }
    });
}

function clickear(elem){
    elem.style.color='black';
}
function listaralbumes(nick){
    $.ajax({
            type: 'POST', //tipo de request
            url: '/EspotifyMovil/ServletGeneral',
            dataType: 'text', // tipo de dato esperado en la respuesta(text, json, etc.)
            data: {// Parametros que se pasan en el request
                Inicio: true
            },
            success: function (data) { //en el success ponemos lo que queremos hacer cuando obtenemos la respuesta
            }
        });    
    $.ajax({
            type: 'POST', //tipo de request
            url: '/EspotifyMovil/ServletGeneral',
            dataType: 'text', // tipo de dato esperado en la respuesta(text, json, etc.)
            data: {// Parametros que se pasan en el request
                listaralbumes: nick
            },
            success: function (data) { //en el success ponemos lo que queremos hacer cuando obtenemos la respuesta
                $("#listaArtGen").empty();
                $('#listaArtGen').load('/EspotifyMovil/Vistas/listaalbumes.jsp');
            }
        });
    }
function listaalbumesg(nombre){
        $.ajax({
            type: 'POST', //tipo de request
            url: '/EspotifyMovil/ServletGeneral',
            dataType: 'text', // tipo de dato esperado en la respuesta(text, json, etc.)
            data: {// Parametros que se pasan en el request
                listaalbumesg: nombre
            },
            success: function (data) { //en el success ponemos lo que queremos hacer cuando obtenemos la respuesta
                $('#listaArtGen').empty();
                $('#listaArtGen').load('/EspotifyMovil/Vistas/listaalbumesgen.jsp');
            }
        });
    }    
function listarlistapd(nombre){
        $.ajax({
            type: 'POST', //tipo de request
            url: '/EspotifyMovil/ServletGeneral',
            dataType: 'text', // tipo de dato esperado en la respuesta(text, json, etc.)
            data: {// Parametros que se pasan en el request
                listarlistapd: nombre
            },
            success: function (data) { //en el success ponemos lo que queremos hacer cuando obtenemos la respuesta
                $("#listaArtGen").empty();
                $('#listaArtGen').load('/EspotifyMovil/Vistas/VerInfoLista.jsp');
            }
        });
    }

function listarlistap(nick,nombre){
        $.ajax({
            type: 'POST', //tipo de request
            url: '/EspotifyMovil/ServletGeneral',
            dataType: 'text', // tipo de dato esperado en la respuesta(text, json, etc.)
            data: {// Parametros que se pasan en el request
            listarlistapnick: nick,
            listarlistap: nombre

            },
            success: function (data) { //en el success ponemos lo que queremos hacer cuando obtenemos la respuesta
                $("#listaArtGen").empty();
                $('#listaArtGen').load('/EspotifyMovil/Vistas/VerInfoLista2.jsp');
            }
        });
    }

function consultaalbum(nomalbum,nomart){

        $.ajax({
            type: 'POST', //tipo de request
            url: '/EspotifyMovil/ServletGeneral',
            dataType: 'text', // tipo de dato esperado en la respuesta(text, json, etc.)
            data: {// Parametros que se pasan en el request
                consultaalbum: nomalbum,
                nomart: nomart
            },
            success: function (data) { //en el success ponemos lo que queremos hacer cuando obtenemos la respuesta
                $("#listaArtGen").empty();
                $('#listaArtGen').load('/EspotifyMovil/Vistas/consultaalbum.jsp');
            }
        });
    }

$(document).ready(function () {
    
//    $(document).click(function(event) {
//       if(!$(event.target).closest('#mitabla').length){
//            var filas = document.getElementsByTagName("TR");
//            var i;
//            for (i=0;i<filas.length;i++){
//                filas[i].style.color='white';
//                filas[i].style.backgroundColor ='';
//            }
//        }
//    });
//    
//    $('tr').click(function () {
//        var filas = document.getElementsByTagName("TR");
//        var i;
//        for (i=0;i<filas.length;i++){
//            filas[i].style.color='white';
//            filas[i].style.backgroundColor ='';
//        }
//        $(this).css('background-color','white');
//        $(this).css('color','black');
//        //$(this).css('background', 'white');
//    });
    
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
                window.location.replace("/EspotifyMovil/Vistas/index.jsp");
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
                $("#listaArtGen").empty();
                $('#listaArtGen').load('/EspotifyMovil/Vistas/listaGeneros.jsp');
            }
        });
    });
    
    $('#btnlistas').click(function () {
        $('.navbar-toggle').click();
        
        $.ajax({
            type: 'POST', //tipo de request
            url: '/EspotifyMovil/ServletGeneral',
            dataType: 'text', // tipo de dato esperado en la respuesta(text, json, etc.)
            data: {// Parametros que se pasan en el request
                Inicio: true
                
            },
            success: function (data) { //en el success ponemos lo que queremos hacer cuando obtenemos la respuesta
                $("#listaArtGen").empty();
                $('#listaArtGen').load('/EspotifyMovil/Vistas/listaListas.jsp');
            }
        });
    });
    
});
