<!DOCTYPE html>
<html>
<head>


<script src="./js/jquery.js"></script>
<script src="./js/tree.jquery.js"></script>
<link rel="stylesheet" href="./css/tree.css">
<!-- <script src="jquery.cookie.js"></script>

 -->
<script type="text/javascript">
function onLoad(fileName){
	var $tree = $('#tree1');

	var data = null;
	var actualData = null;
		
	if(fileName != "null"){
	$.getJSON('./uploadFiles/'+fileName)
	.done(function(json) {
		data = json;
		console.log("before");
	   console.log(json);
	    callMain(data);
	  })
	  .fail(function( jqxhr, textStatus, error ) {
		  console.log(jqxhr);
	    var err = textStatus + ", " + error;
	    console.log( "Request Failed: " + err );
	});
	}
}
	//console.log(data);
	/* var data = [ {
		label : 'Entities on Organism Side',
		id : 1,
		children : [ {
			label : 'Disorder:',
			id : 2
		}, {
			label : 'Pathological Process',
			id : 3
		}, {
			label : 'Disease',
			id : 4
		}, {
			label : 'Predisposition to Disease of Type X',
			id : 5
		}, {
			label : 'Etiological Process',
			id : 6
		}, {
			label : 'Disease Course',
			id : 7
		}, {
			label : 'Transient Disease Course',
			id : 8
		}, {
			label : 'Chronic Disease Course',
			id : 9
		}, {
			label : 'Progressive Disease Course',
			id : 10
		} ]
	},

	{
		label : 'Genetic Disorders',
		id : 11,
		children : [

		{
			label : 'Genetic Disorder',
			id : 12
		}, {
			label : 'Constitutional Genetic Disorder',
			id : 13
		}, {
			label : 'Acquired Genetic Disorder',
			id : 14
		}, {
			label : 'Constitutional Genetic Disease',
			id : 15
		}, {
			label : 'Acquired Genetic Disease',
			id : 16
		}, {
			label : 'Genetic predisposition to Disease of Type X',
			id : 17
		} ]

	},

	{
		label : 'Infections',
		id : 18,
		children : [

		{
			label : 'Infectious Disorder',
			id : 19
		}, {
			label : 'Infectious Disease',
			id : 20
		}, {
			label : 'Secondary Infection',
			id : 21
		} ]

	}, {

		label : 'Clinical Evaluations',
		id : 22,
		children : [

		{
			label : 'Sign',
			id : 23
		}, {
			label : 'Vital Sign',
			id : 24
		}, {
			label : 'Symptom',
			id : 25
		}, {
			label : 'Clinical History',
			id : 26
		}, {
			label : 'Physical Examination',
			id : 27
		}, {
			label : 'Laboratory Test',
			id : 28
		}, {
			label : 'Laboratory Finding',
			id : 29
		}, {
			label : 'Normal Value',
			id : 30
		}, {
			label : 'Manifestation of Disease',
			id : 31
		}, {
			label : 'Preclinical Manifestation of a Disease',
			id : 32
		}, {
			label : 'Clinical Manifestation of a Disease',
			id : 33
		}, {
			label : 'Clinical Picture',
			id : 34
		}, {
			label : 'Diagnosis',
			id : 35
		} ]

	}

	]; */
 function callMain(data){
	//$(function() {
		actualData = data;
		$('#tree1').tree(
				{
					data : data,
					autoOpen : 1,
					onCreateLi : function(node, $li) {
						// Append a link to the jqtree-element div.
						// The link has an url '#node-[id]' and a data property 'node-id'.
						$li.find('.jqtree-element').append('<div style="float:right;padding-right:10%;padding-left:10%;text-align: left;color:black;" id=div'+node.id+'>'+node.setData+'</div>'
								//'<input type="hidden" id=text'+node.id+' />'
								//+	'<span class="jqtree-title jqtree_common" id='+node.id+'/>'+
						// '&lt;a href="#node-'+ node.id +'" class="edit" data-node-id="'+
						// node.id +'"&gt;edit&lt;/a&gt;'
						);
					}/* ,
					saveState: true */
				});
	//});
	}
	function call() {
		data = actualData;
		var i = null;
		var data1 = $("#treeid").val().split(",");
		var mainId = data1[0];
		var subId = data1[1];
		var content = $("#textArea").val();
	//	console.log(data);
		for (i = 0; data.length > i; i += 1) {
			if (data[i].id == mainId) {
				var childData = data[i].children;
				for (var j = 0; childData.length > j; j += 1) {
					if (childData[j].id == subId) {
						childData[j].setData = content;
						//$("#" + subId).append(content);
						document.getElementById("div"+subId).innerHTML = content;
						//childData[j].label += ' asd';
						//$("#2").append("some Text");
						//console.log($tree.reload());
						//console.log($('#tree1').data[i].children[j].label);
						//$('#tree1').data[i].children[j].label.innerHTML = 'change';
					}
				}

			}
		}
		$("#second").css("display","none");

	};
	
	
	/* function getDataForAppend() {
		var i = null;
		var data1 = $("#treeid").val().split(",");
		var mainId = data1[0];
		var subId = data1[1];
		var content = $("#textArea").val();
		//console.log(data[mainId].children[subId].label);
		for (i = 0; data.length > i; i += 1) {
			if (data[i].id == mainId) {
				var childData = data[i].children;
				for (var j = 0; childData.length > j; j += 1) {
					if (childData[j].id == subId) {
						alert("val");
						$("#textArea").val(" "+$("#textArea").val());
						//$("#" + subId).append(content);
						//childData[j].label += ' asd';
						//$("#2").append("some Text");
						//console.log($tree.reload());
						//console.log($('#tree1').data[i].children[j].label);
						//$('#tree1').data[i].children[j].label.innerHTML = 'change';
					}
				}

			}
		}

	}; */
	
	
	function sendJSONData(){
		var pathValue = $("#pathValue").val();
		$.ajax({
		    type: 'POST', // it's easier to read GET request parameters
		    url: './JsonWriter',
		    dataType: 'JSON',
		    data: { 
		      loadProds: 1,
		      test: JSON.stringify(data),
		      pathValue: pathValue// look here!
		    },
		   
		    done: function() {
		    	
		    alert("Data Saved SuccessFully");
		    	//console.log("done");
				//alert("success");
		    },
		    error: function() {
		    	alert("Data Saved SuccessFully");
		    	//console.log("error");
		       // console.log(data);
		    }
		});
	};
	
	
	
	
	

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
</head>
<body>
	 <div id="tree1"></div> 
	
	

<!-- 		<table class="table" id="second" style="display: block;" >
<tr><td>Select:</td><td><select  id="treeid" onchange="getDataForAppend()">
		<option selected="selected" value="0">SELECT</option>
		<option value="1,0">Entities on Organism Side</option>
		<option	value="1,2">Disorder</option>
		<option value="1,3">Pathological Process</option>
		<option value="1,4">Disease</option>
		<option value="1,5">Predisposition to Disease of Type X</option>
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
		<option value="11,17">Genetic predisposition to Disease of Type X</option>
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
		<option value="22,32">Preclinical Manifestation of a Disease</option>
		<option value="22,33">Clinical Manifestation of a Disease</option>
		<option value="22,34">Clinical Picture</option>
		<option value="22,35">Diagnosis</option>
	</select></td></tr>
	
	<tr><td>Data :</td><td colspan="2"><textarea style="width: 344px; height: 61px;" id="textArea"></textarea></td></tr>
	<tr><td><input type="button" onclick="call()"
		name="submit" value="send"/></td></tr>
		
</table> -->

<footer class="footer">
<input type="text" name="path" id="pathValue" value="<%=request.getAttribute("jsonpath")%>"/>
    <button type="submit" class="btn btn-primary btn-block" onclick="sendJSONData()">Save</button>
    
  </footer>
</body>
</html>