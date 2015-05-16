<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@
taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>

<!--  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script> -->



<link rel="stylesheet" type="text/css" href="./css/bootstrap.css" />
<script type="text/javascript" src="./js/jquery.js"></script>
<script type="text/javascript" src="./js/bootstrap.js"></script>
<script src="./js/jquery.contextMenu.js"></script>
<script src="./js/jquery.ui.position.js"></script>

<!-- <script src="jquery.cookie.js"></script>

 -->
<script type="text/javascript">
	$(document).ready(
			function() {
				var hiddenValueForTab = $("#hiddenValueForTab").val();
				if(hiddenValueForTab == "null"){
					$("#profile").show();
					//alert("show");
				}
				var src_str = $("#tableIdData").html();
				var termArray = [ "Pathological Process","Genetic predisposition to Disease of Type X","Acquired", "Genetic" ,"Disorder",
				                  "Predisposition to Disease of Type X",
									"Etiological Process",
									"Progressive",
									"Transient",
								    "Chronic",
									"Constitutional",
									"Infectious", 
									"Secondary", 
									"Vital", 
									"Symptom",
									"History",
			 						"Physical Examination",
									"Laboratory", 
									"Finding","Test",
									"Normal Value",
			 						"Manifestation",
									"Preclinical",
									"Clinical",
									"Picture", 
									"Diagnosis" , 
									"Disease",
									"Sign","Course" ];
				
				
				/*
				var termArray = [ "Pathological Process","Genetic predisposition to Disease of Type X",
				                  "Predisposition to Disease of Type X",
									"Etiological Process",
									"Progressive Disease Course",
									"Transient Disease Course",
								    "Chronic Disease Course",
									"Disease Course", 
									"Constitutional Genetic Disorder",
									"Acquired Genetic Disorder",
									"Constitutional Genetic Disease",
									"Genetic Disorder","Disorder",
									"Acquired Genetic Disease",
									
									"Infectious Disorder", 
									"Infectious Disease",
									"Secondary Infection", 
									"Vital Sign", 
									"Symptom",
									"Clinical History",
			 						"Physical Examination",
									"Laboratory Test", 
									"Laboratory Finding",
									"Normal Value",
			 						"Manifestation of Disease",
									"Preclinical Manifestation of a Disease",
									"Clinical Manifestation of a Disease",
									"Clinical Picture", 
									"Diagnosis" , 
									"Disease",
									"Sign" ];

				*/

				/*  termArray.push("is");
				 termArray.push("pain"); */
				for (var i = 0; i < termArray.length; i++) {
					var term = ""+termArray[i]+"";
					term = term.replace(/(\s+)/, "(<[^>]+>)*$1(<[^>]+>)*");
					var pattern = new RegExp("(" + term + ")", "gi");

					src_str = src_str.replace(pattern, "<mark>$1</mark>");
					src_str = src_str.replace(
							/(<mark>[^<>]*)((<[^>]+>)+)([^<>]*<\/mark>)/,
							"$1</mark>$2<mark>$4");

					
				}
				$("#tableIdData").html(src_str);

			});

	$("#myTab .dropdown-menu a").mouseover(function() {
		var source = $(this).data("source");
		if (source) {
			$('#myTab a[href="#' + source + '"]').tab('show');
		}

		return false;
	});

	$("#myTab .dropdown-menu a").click(function(e) {
		var source = $(this).data("source");
		if (source) {
			$('#myTab a[href="#' + source + '"]').tab('show');
		}

		return false;
	});

	function onCopy() {
		$("#second").css("display", "block");
		$("#treeid").val(0);
		$("#textArea").val(window.getSelection().toString());
		//alert(window.getSelection().toString());
	}

	//$('.item .author:contains("John J")').addClass("highlight");

	/* $.ajax({
	    type: 'GET', // it's easier to read GET request parameters
	    url: './JsonWriter',
	    success: function(data) {
	    	//console.log(data);
	    	var arr = [];
	    	arr = data;
	    	console.log(arr);
	    	for (i=0;i<arr.length;i++){
	    		   $('<option/>').val(arr[i]).html(arr[i]).appendTo('#mySelect');
	    		}
	    	//console.log(data);
			//alert("success");
	    },
	    error: function(data) {
	    	
	    	console.log("error");
	       // console.log(data);
	    }
	}); */

	function closeResult(value) {
		if(value == "upload"){
			$("#profile").show();
			$("#tweets").hide();
		}
		if(value == "open"){
			$("#profile").hide();
			$("#tweets").show();
		}
		$("#website").css("display", "none");
		$("#websiteBlock").hide();
		
	}
</script>


<link rel="stylesheet" type="text/css"
	href="./css/jquery.contextMenu.css">
<style type="text/css">
span.highlight {
	font-weight: bold;
	text-decoration: underline;
}

.highlight {
	font-weight: bold;
	text-decoration: underline;
}

mark {
	background-color: purple;
	color: white;
}

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
	height: 300px;
	display: inline-block;
	width: 100%;
	overflow: auto;
}

.tbody {
	height: 300px;
	display: inline-block;
	width: 30%;
	overflow: auto;
}

footer {
	position: fixed;
	bottom: 0px;
	width: 100%;
	height: 40px;
	background-color: #D3CFCF;
	float: right;
}

body {
	height: 100%;
}
</style>

</head>
<body onload="onLoad('<%=request.getAttribute("fileName")%>')">


	<div class="tabbable">
	<input type="hidden" id="hiddenValueForTab" value="<%=request.getAttribute("fileName")%>"/>
		<ul id="myTab" class="nav nav-tabs">
			<li class="active"><a href="#profile" data-toggle="tab"
				onclick="closeResult('upload')">Upload File</a></li>


			<%
				if (request.getAttribute("result") == "open") {
			%>
			<li class="active"><a href="#tweets" data-toggle="tab"
				onclick="closeResult('open')">Open File</a></li>
			<%
				} else {
			%>
			<li><a href="#tweets" data-toggle="tab" onclick="closeResult('open')">Open
					File</a></li>
			<%
				}
			%>


			<%
				if (request.getAttribute("result") == "result") {
			%>
			<li class="active" id="website"><a href="#website"
				data-toggle="tab">Result</a></li>
			<%
				} else {
			%>
			<!-- <li><a href="#website" data-toggle="tab">Result</a></li> -->
			<%
				}
			%>










		</ul>
		<div class="tab-content">

			<div class="tab-pane" id="profile">
				<form method="post" action="FileProcessingServlet"
					enctype="multipart/form-data">
					<div class="row">
						<div class="col-md-2">Select file to upload:</div>
						<div class="col-md-4">
							<input type="file" name="file" size="60" />
						</div>
					</div>
					<div class="row">
						<div class="col-md-4">
							<input type="submit" value="Upload" />
						</div>
					</div>

				</form>
			</div>

			<div class="tab-pane" id="tweets">
				<!-- Start open-->
				<form action="./FileProcessingServletReady" method="POST">

					Open File: <select name="selectedValue">
						<c:forEach var="fileData" items="${fileNames}">
							<option value="${fileData}">${fileData}</option>
						</c:forEach>


					</select> <input type="submit" value="submit" />
				</form>
				<!-- End open -->
			</div>
			<div class="tab-pane active" id="website">
				<!-- Start Result -->
				<%-- <jsp:include page="./contextMenufinal.jsp"></jsp:include>  --%>
				<div style="float: left; width: 60%;"
					class="context-menu-one box menu-1">

					<table oncopy="onCopy()" id="tableIdData">
						<tbody>
							<c:forEach var="doc" items="${doctor}">
								<c:if test="${doc.value == 'Positive'}">
									<c:if test="${fn:substring(doc.key, 0, 1) == 'P' || fn:substring(doc.key, 0, 1) == 'p'}">


										<tr>
											<td><c:set var="dataParts"
													value="${fn:split(doc.key,':')}" /> <span>${dataParts[0]}</span>:<span
												class="word-g">${dataParts[1]}</span></td>
										</tr>
									</c:if>
									<c:if test="${fn:substring(doc.key, 0, 1) == 'D' || fn:substring(doc.key, 0, 1) == 'd'}">
										<tr>
											<td>
												<p>${doc.key}</p>
											</td>
										</tr>
									</c:if>

								</c:if>
								<c:if test="${doc.value == 'Negative'}">
									<c:if test="${fn:substring(doc.key, 0, 1) == 'P' || fn:substring(doc.key, 0, 1) == 'p'}">
										<tr>
											<td><c:set var="dataParts"
													value="${fn:split(doc.key,':')}" /> <span>${dataParts[0]}</span>:<span
												class="word-r">${dataParts[1]}</span></td>
										</tr>
									</c:if>
									<c:if test="${fn:substring(doc.key, 0, 1) == 'D' || fn:substring(doc.key, 0, 1) == 'd'}">
										<tr>
											<td>
												<p>${doc.key}</p>
											</td>
										</tr>
									</c:if>
								</c:if>
								<c:if test="${doc.value == 'Neutral'}">
									<c:if test="${fn:substring(doc.key, 0, 1) == 'P' || fn:substring(doc.key, 0, 1) == 'p'}">
										<tr>
											<td><c:set var="dataParts"
													value="${fn:split(doc.key,':')}" /> <span>${dataParts[0]}</span>:<span
												class="word-b">${dataParts[1]}</span></td>
										</tr>
									</c:if>
									<c:if test="${fn:substring(doc.key, 0, 1) == 'D' || fn:substring(doc.key, 0, 1) == 'd'}">
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

					<table class="table" id="second" style="display: none;">
						<tr>
							<td>Select:</td>
							<td><select id="treeid">
									<option selected="selected" value="0">SELECT</option>
									<option value="1,0">Entities on Organism Side</option>
									<option value="1,2">Disorder</option>
									<option value="1,3">Pathological Process</option>
									<option value="1,4">Disease</option>
									<option value="1,5">Predisposition to Disease of Type
										X</option>
									<option value="1,6">Etiological Process</option>
									<option value="1,7">Disease Course</option>
									<option value="1,8">Transient Disease Course</option>
									<option value="1,9">Chronic Disease Course</option>
									<option value="1,10">Progressive Disease Course</option>
									<option value="11,0">Genetic Disorders</option>
									<option value="11,12">Genetic Disorder</option>
									<option value="11,13">Constitutional Genetic Disorder</option>
									<option value="11,14">Acquired Genetic Disorder</option>
									<option value="11,15">Constitutional Genetic Disease</option>
									<option value="11,16">Acquired Genetic Disease</option>
									<option value="11,17">Genetic predisposition to
										Disease of Type X</option>
									<option value="18,0">Infections</option>
									<option value="18,19">Infectious Disorder</option>
									<option value="18,20">Infectious Disease</option>
									<option value="18,21">Secondary Infection</option>
									<option value="22,0">Clinical Evaluations</option>
									<option value="22,23">Sign</option>
									<option value="22,24">Vital Sign</option>
									<option value="22,25">Symptom</option>
									<option value="22,26">Clinical History</option>
									<option value="22,27">Physical Examination</option>
									<option value="22,28">Laboratory Test</option>
									<option value="22,29">Laboratory Finding</option>
									<option value="22,30">Normal Value</option>
									<option value="22,31">Manifestation of Disease</option>
									<option value="22,32">Preclinical Manifestation of a
										Disease</option>
									<option value="22,33">Clinical Manifestation of a
										Disease</option>
									<option value="22,34">Clinical Picture</option>
									<option value="22,35">Diagnosis</option>
							</select></td>
						</tr>

						<tr>
							<td>Data :</td>
							<td colspan="2"><textarea
									style="width: 344px; height: 61px;" id="textArea"></textarea></td>
						</tr>
						<tr>
							<td><input type="button" onclick="call()" name="submit"
								value="send" /></td>
						</tr>
					</table>


				</div>
				<div style="float: left; height: 80%; width: 40%;">

					<jsp:include page="./tree.jsp"></jsp:include>
				</div>




				<!-- End Result -->
			</div>

		</div>


		<!-- <div id="footer">

footer
</div> -->


		<footer class="footer">
			<%
				if (request.getAttribute("result") == "result") {
			%>
			<button type="submit" class="btn btn-primary btn-block"
				onclick="sendJSONData()" id="websiteBlock">Save</button>
			<%
				}
			%>
		</footer>


	</div>



</body>
</html>