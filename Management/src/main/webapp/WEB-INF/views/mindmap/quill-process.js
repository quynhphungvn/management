var toolbarOptions = [
		['bold', 'italic', 'underline', 'strike'],
		['blockquote', 'code-block'],
		[{'header': 1}, {'header': 2}],
		[{'list': 'ordered'}, {'list': 'bullet'}],
		[{'script': 'sub'}, {'script': 'super'}],
		[{'indent': '-1'}, {'indent': '+1'}],
		[{'direction': 'rtl'}],
		[{'size': ['small', false, 'large', 'huge']}],
		['link', 'image', 'video', 'formula'],
		[{'color': []}, {'background': []}],
		[{'font': []}],
		[{'align': []}]
		];
	var options = {
			  debug: 'info',
			  modules: {
			    toolbar: toolbarOptions,
			    imageResize: {
			          displaySize: true
			        },
			  },
			  placeholder: 'Textttt',
			  readOnly: false,
			  theme: 'snow'
			};
	var quill = new Quill('#editor', options);