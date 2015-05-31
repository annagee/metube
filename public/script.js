

function getVideo(){
 $.ajax({
       type: 'GET',
       url:'/videos',
       datatype: 'json'
 }).done(function(data){
  $.each(data, function(index, item){
    appendNewItem(item);
  })
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
    type: "DELETE"
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


});












  