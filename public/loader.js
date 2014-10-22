$(function(){
  loadItems = function() {
    $(".loader").show();
    $.get("/list", function(data){
      $(".loader").hide();
      for (var i = data.length-1; i >= 0; i--) {
        entry = data[i];
        addEntry(entry);
      }
    });
  }

  addEntry = function(entry) {
    if ($('#'+entry.key).length == 0) {
      clone = $("#items .template").clone();
      clone.removeClass("template");
      clone.attr("id", entry.key);
      clone.children(".title").text(entry.title);
      clone.children(".url").attr('href', entry.link);
      relative_time = moment(entry.created_at).fromNow();
      clone.children(".date").text(relative_time);
      $('#items').prepend(clone);
    }
  }

  setInterval(loadItems, 30000);
  loadItems();
});
