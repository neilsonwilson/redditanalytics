// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


var results = $('#results');
$(document).ready( function(){
    $("#buttonsearch").click(function (e) {
        e.preventDefault();
        redditLoad($('#query').val());
    });
    $("#query").keypress(function (e) {
        if (e.which == 13) {
            e.preventDefault();
            redditLoad($('#query').val());
        }
    });
});



var redditLoad = function (url) {
    $.get('/links/index?link=' + url ).done(function(data){
        $('#results').html(data);
    });
};


function commentLoad(){
    var query = $("#query").val();
    $.getJSON(query, function (data){
		  $.each(data[1].data.children, function (i, item) {
		    var comment = item.data.body
		    var postcomment = '<br>' + comment + '<br>'
    		results.append(postcomment)
 		});
	});
};