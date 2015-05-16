<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Upload</title>
<link rel="stylesheet" type="text/css" href="./css/jquery.contextMenu.css">
<script src="./js/jquery.contextMenu.js"></script>
<script src="./js/jquery.ui.position.js"></script>
<script>
	$(function() {
		$.contextMenu({
			selector : '.context-menu-one',
			callback : function(key, options) {
				console.log("window" + window.getSelection().toString());
				var m = "clicked: " + options;

				//window.console && console.log(m) || alert(m);
			},

			items : {
				"edit" : {
					name : "Edit",
					icon : "edit"
				},
				"cut" : {
					name : "Cut",
					icon : "cut"
				},
				"copy" : {
					name : "Copy",
					icon : "copy"
				},
				"paste" : {
					name : "Paste",
					icon : "paste"
				},
				"delete" : {
					name : "Delete",
					icon : "delete"
				},
				"sep1" : "---------",
				"quit" : {
					name : "Quit",
					icon : "quit"
				}
			}
		});
	});

	
</script>


</head>
<body>


</body>
</html>