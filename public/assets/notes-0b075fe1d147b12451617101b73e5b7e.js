(function() {
  window.Notes = {
    init: function() {
      $("<div id='preview' class='wikistyle'></div>").insertAfter($('#note_body'));
      $('.edit a').click(function() {
        $(this).parent().addClass('active');
        $('.preview a').parent().removeClass('active');
        $('#preview').hide();
        $('#note_body').show();
        return false;
      });
      return $('.preview a').click(function() {
        $(this).parent().addClass('active');
        $('.edit a').parent().removeClass('active');
        $('#preview').html('Loading...');
        $('#note_body').hide();
        $('#preview').show();
        $.post('/notes/preview', {
          body: $('#note_body').val()
        }, function(data) {
          $('#preview').html(data);
          return false;
        });
        return false;
      });
    }
  };

  $(document).ready(function() {
    var _ref;

    if ((_ref = $('body').data('controller-name')) === 'notes') {
      return Notes.init();
    }
  });

}).call(this);
