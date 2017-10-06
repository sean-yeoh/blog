'use strict';

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var Inline = Quill.import('blots/inline');
var Block = Quill.import('blots/block');
var BlockEmbed = Quill.import('blots/block/embed');




$(document).on("turbolinks:load", function() {
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
	}

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
	}


  $(".post-form").submit(function() {
		var content = editor.container.firstChild.innerHTML
		var postContent = $("input[name='post[content]']")
		postContent.val(content)
	})
})

