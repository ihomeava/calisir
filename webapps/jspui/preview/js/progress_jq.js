var bar_color = 'green';
var no_color="";
var clear = "&nbsp;";

function process(){
			checkDiv();
			$.ajax({
				type: "GET",
				url: "/jspui/progressbar?task=first&itemid="+$("#itemid").val()+"&t="+new Date(),
				dataType: "text",
				async: false,
				timeout : 1000,
				success: function(){
					setTimeout(function(){ pollServer(); },1);
				},
				error : function() {
					alert("An error occured!");
				}
			});
		}
		
function pollServer() {
			$.ajax({
				type: "GET",
				url: "/jspui/progressbar?task=poll&itemid="+$("#itemid").val()+"&t="+new Date(),
				dataType: "text",
				async: false,
				timeout : 1000,
				success: function(percent_complete){
					pollCallback(percent_complete);
				},
				error : function() {
					alert("An error occured!");
				}
			});
        }
        
function pollCallback(percent_complete) {
					var index = percent_complete / 2;
                    for (var i = 1; i <= index; i++) {
						var elem = $("#block"+i);
						elem.html(clear);
						elem.css("backgroundColor",bar_color);
						var htmlVal = "<font style='font-weight:bold;color:blue'>"
							   htmlVal +=percent_complete;
							   htmlVal += "%"
							   htmlVal +="</font>"; 
						$("#finish").html(htmlVal);
                    }
					
                    if (percent_complete < 100) {
                        setTimeout(function(){ pollServer(); },1000);
                    } else if(percent_complete == 100){
                    	document.charset="utf-8";
            		    var redirectResultView="/jspui/preview/step2.jsp";
            		    var urlInfo = "Loading... Please click to redirect. <a href='javascript:void(0);' onclick='";
            		    urlInfo += "javascript: document.form1.action = \"" + redirectResultView;
            		    urlInfo += "\"; document.form1.submit();'><font color='red'>here</font></a>";
            		    document.getElementById("complete").innerHTML = urlInfo;
            		    if(confirm('Preview Online')) {
                		    document.form1.action = redirectResultView;
                		    document.form1.submit();
                    	}
                    }
                    else if(percent_complete == 102){
                    	alert("Background error occured!");
                    }
        }
    	
 function checkDiv() {
			var process_bar = $("#progressBar");
			if(process_bar.css("visibility") == "visible"){
				clearBar();
				$("#complete").html("");
			}else{
				process_bar.css("visibility","visible");
			}
        }

function clearBar() {
            for (var i = 1; i < 50; i++) {
				var elem = $("block"+i);
				elem.html(clear);
            }
     }