<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Upload</title>

<script src="./js/jquery.js"></script>
<script src="./js/tree.jquery.js"></script>
<link rel="stylesheet" href="./css/tree.css">
<!-- <script src="jquery.cookie.js"></script>

 -->
<script type="text/javascript">




var data = [
            {
                label: 'Entities on Organism Side', id: 1,
                children: [
                    { label: 'Disorder', id:2 },
						{ label: 'Pathological Process', id:3 },
						{ label: 'Disease' , id:4},
						{ label: 'Predisposition to Disease of Type X', id:5 },
						{ label: 'Etiological Process', id:6 },
						{ label: 'Disease Course', id: 7}, 
						{ label: 'Transient Disease Course', id:8 },
						{ label: 'Chronic Disease Course', id:9 },
						{ label: 'Progressive Disease Course', id:10 }
                ]
            },
           
            
            {    
            label: 'Genetic Disorders', id:11,
            children: [
              
{ label: 'Genetic Disorder', id:12 },
{ label: 'Constitutional Genetic Disorder', id:13 },
{ label: 'Acquired Genetic Disorder', id:14 },
{ label: 'Constitutional Genetic Disease', id:15 },
{ label: 'Acquired Genetic Disease', id:16 },
{ label: 'Genetic predisposition to Disease of Type X', id:17 }
            ]

            },


            {
label: 'Infections', id:18,
            children: [
               
{ label: 'Infectious Disorder', id:19 },
{ label: 'Infectious Disease', id:20 },
{ label: 'Secondary Infection', id:21 }
            ]

            },{

label: 'Clinical Evaluations', id:22,
            children: [
              
{ label: 'Sign', id:23 },
{ label: 'Vital Sign', id:24 },
{ label: 'Symptom' , id:25},
{ label: 'Clinical History', id:26 },
{ label: 'Physical Examination', id:27 },
{ label: 'Laboratory Test', id:28 },
{ label: 'Laboratory Finding' , id:29},
{ label: 'Normal Value' , id:30},
{ label: 'Manifestation of Disease' , id:31},
{ label: 'Preclinical Manifestation of a Disease', id:32 },
{ label: 'Clinical Manifestation of a Disease', id: 33},
{ label: 'Clinical Picture', id:34 },
{ label: 'Diagnosis', id:35 }
            ]
            
            
            } 
            
        ];

        $(function() {
            $('#tree1').tree({
                data: data
            });
        });
/* 
        $.getJSON(
            '/some_url/',
            function(data) {
                $('#tree1').tree({
                    data: data
                });
            }
        );
 */

</script>
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

<link rel="stylesheet" type="text/css"
	href="./css/jquery.contextMenu.css">
<style type="text/css">
.word-r {
	color: red;
}

.word-b {
	color: blue;
}

.word-g {
	color: green;
}

.word:before {
	color: black;
	content: "Client ";
}

tbody {
	height: 400px;
	display: inline-block;
	width: 100%;
	overflow: auto;
}

.tbody {
	height: 400px;
	display: inline-block;
	width: 30%;
	overflow: auto;
}

.tree {
	color: #46CFB0;
}

.tree li, .tree li>a, .tree li>span {
	padding: 2pt;
	border-radius: 2px;
}

.tree li a {
	color: #46CFB0;
	text-decoration: none;
	line-height: 10pt;
	border-radius: 2px;
}

.tree li a:hover {
	background-color: #34BC9D;
	color: #fff;
}

.active {
	background-color: #34495E;
	color: white;
}

.active a {
	color: #fff;
}

.tree li a.active:hover {
	background-color: #34BC9D;
}
</style>
</head>
<body>
	<div style="float: left; width: 70%;"
		class="context-menu-one box menu-1">

		<table>
			<tbody>
				<c:forEach var="doc" items="${doctor}">
					<c:if test="${doc.value == 'Positive'}">
						<c:if test="${fn:substring(doc.key, 0, 1) == 'P'}">


							<tr>
								<td><c:set var="dataParts" value="${fn:split(doc.key,':')}" />
									<span>${dataParts[0]}</span>:<span class="word-g">${dataParts[1]}</span></td>
							</tr>
						</c:if>
						<c:if test="${fn:substring(doc.key, 0, 1) == 'D'}">
							<tr>
								<td>
									<p>${doc.key}</p>
								</td>
							</tr>
						</c:if>

					</c:if>
					<c:if test="${doc.value == 'Negative'}">
						<c:if test="${fn:substring(doc.key, 0, 1) == 'P'}">
							<tr>
								<td><c:set var="dataParts" value="${fn:split(doc.key,':')}" />
									<span>${dataParts[0]}</span>:<span class="word-r">${dataParts[1]}</span>


								</td>
							</tr>
						</c:if>
						<c:if test="${fn:substring(doc.key, 0, 1) == 'D'}">
							<tr>
								<td>
									<p>${doc.key}</p>
								</td>
							</tr>
						</c:if>
					</c:if>
					<c:if test="${doc.value == 'Neutral'}">
						<c:if test="${fn:substring(doc.key, 0, 1) == 'P'}">
							<tr>
								<td><c:set var="dataParts" value="${fn:split(doc.key,':')}" />
									<span>${dataParts[0]}</span>:<span class="word-b">${dataParts[1]}</span>


								</td>
							</tr>
						</c:if>
						<c:if test="${fn:substring(doc.key, 0, 1) == 'D'}">
							<tr>
								<td>
									<p>${doc.key}</p>
								</td>
							</tr>
						</c:if>
					</c:if>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div style="float: left; height: 50%;" id="tree1">

	</div>

</body>
</html>