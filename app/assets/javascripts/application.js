// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).on('ready page:load', function() {
  $('a.disable_click').click(function(){
    $(this).attr('disabled', 'disabled');
  });

  $('.refresh_users').click(function(){
    $('#users_table').addClass('loading');
  });

  $("#users_table").tablesorter({
    sortList: [[1,0]]
  });

  $("#admins_table").tablesorter({
    sortList: [[0,0]]
  });
});
