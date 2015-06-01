


function appendNewVideo(data){
   $('<li class="'+ (data.done == 't' ? "completed" : "") + '">' + '<input class="toggle" type="checkbox" data-id="' + data.id +'" '+ (data.done == 't' ? 'checked="checked"' : "") + '>'+'<label>'+ data.item +'</label>'+'<button class="destroy" data-id="'+data.id +'"></button>'+
    '</li>').prependTo("#todo-list")


}

function getVideo(){
 $.ajax({
       type: 'GET',
       url:'/videos',
       datatype: 'json'
 }).done(function(data){
  $.each(data, function(index, video){
    appendNewVideo(video);
  })
 })

}

function showVideoGenre(){
  var videoGenre = $(this).data("id")
  $.ajax({
    type:'GET',
    url:'/videos' + videoGenre,
    dataType: 'json',
    data: {item: videoGenre}
  }).done(function(data){
    appendNewItem(data);
    $('#video-genre').val('')
  })
}

function createVideo(){
  var newVideo = $('#new-video').val();
  $.ajax({
    type: "POST",
    url: "/videos",
    dataType:'json',
    data: {item: newVideo}
  }).done(function(data){
    appendNewItem(data);
    $('#new-video').val('')
  })
}

function deleteVideo () {
  deleteButton = $(this);
  var videoId = $(this).data("id")
  $.ajax({
    type: "DELETE",
    url: "/videos/" + videoId,
    dataType: 'json'

  }).done(function(data){
    deleteButton.closest('li').remove()
  })

}






$(document).ready(function(){

  getVideo();
  $('.submit').on('keypress', function(event){
    if(event.which === 13){
      playItem()
    }
  })
  $('#video-genre').on('click', showVideoGenre);

});












  