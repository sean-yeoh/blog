// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require jquery_ujs
//= require foundation
//= require quill/dist/quill.min
//= require turbolinks
//= require_tree .

$(document).on("turbolinks:load", function() {
  $("textarea#descriptions").bind("change keypress keyup keydown input", function() {
		var height = this.scrollHeight - 16
		$(this).height(height)
	})

  if ($("#editor-container")[0]) {
    var Font = Quill.import('formats/font');
    Font.whitelist = ['arial', 'helvetica'];
    Quill.register(Font, true);

    var editor = new Quill('#editor-container', {
      modules: {
        toolbar: {
        	container: '#toolbar',
        	handlers: {
        		image: imageHandler
        	}
        }
      },
    	theme: 'snow'
    });

    editor.on("text-change", function() {
      setContainerHeight()
    })

    setContainerHeight()
  }

  function setContainerHeight() {
    var height = $(".ql-editor")[0].scrollHeight + 20
    $("#editor-container").height(height)
  }

  $(".post-form").submit(function() {
		var content = quill.container.firstChild.innerHTML
		var postContent = $("input[name='post[content]']")
		postContent.val(content)
	})

	function imageHandler() {
		const input = document.createElement('input');
	  input.setAttribute('type', 'file');
	  input.setAttribute('accept', 'image/*');
	  input.click();
    input.addEventListener("change", function() {
      const file = input.files[0];
      if (/^image\//.test(file.type)) {
        sendImageToServer(file)
      } else {
        console.warn('You could only upload images.');
      }
    })
	}

  function sendImageToServer(file) {
    $(".loading").show()
    const data = new FormData();
    data.append('file', file);

    $.ajax({
      url: "/api/images",
      data: data,
      cache: false,
      contentType: false,
      processData: false,
      type: "post",
      dataType: "json",
      success: function(data, status, jqXHR){
        insertToEditor(data.url)
        $(".loading").hide()
      }
    })
  }

  function insertToEditor(url) {
    var index = 0
    var range = editor.getSelection();
    if (range) {
      index = range.index
    }
    editor.insertEmbed(index, 'image', url, Quill.sources.USER);
    setContainerHeight()
  }
})
