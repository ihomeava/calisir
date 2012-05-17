   //全局变量
  var xmlHttp;											  //XMLHttpRequest对象							
  var bar_color = 'green';                            //进度条背景颜色
  var no_color="";                                     //解决浏览器兼容设置的无颜色变量
  var clear = "";                                         //清空背景颜色用的变量
		
		function process(ctxPath) {
            createXMLHttpRequest();  					//创建XMLHttpRequest
            checkDiv(); 						 				//检查processBar所在div
            var url = ctxPath +　"/progressbar?task=first&itemid="+document.getElementById("itemid").value+"&t="+new Date();
            xmlHttp.open("GET", url, true);
            xmlHttp.onreadystatechange = function(){goCallback(ctxPath);}; //设置回调函数
            xmlHttp.send(null);
        }
        
		//创建XMLHttpRequest
        function createXMLHttpRequest() {
            if (window.ActiveXObject) {
                xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
            } 
            else if (window.XMLHttpRequest) {
                xmlHttp = new XMLHttpRequest(); 
                clear =  "&nbsp;" 
                 //进入进度条，默认设置第1个block，否则非IE内核浏览器进度条显示不正常
                 var elem = document.getElementById("block1");
                 elem.innerHTML = clear;					
                 elem.style.backgroundColor = no_color; 
            }
        }
	
		//回调函数
        function goCallback(ctxPath) {
            if (xmlHttp.readyState == 4) {
                if (xmlHttp.status == 200) {
                    setTimeout(function(){pollServer(ctxPath);}, 1000);
                }
            }
        }
        
        function pollServer(ctxPath) {
            createXMLHttpRequest();
            var url = ctxPath + "/progressbar?task=poll&itemid="+document.getElementById("itemid").value+"&t="+new Date();
            xmlHttp.open("GET", url, true);
            xmlHttp.onreadystatechange = function(){pollCallback(ctxPath);}; //设置回调函数
            xmlHttp.send(null);
        }
        
        function pollCallback(ctxPath) {
            if (xmlHttp.readyState == 4) {
                if (xmlHttp.status == 200) {
                	//得到当前进度百分比
                    var percent_complete = xmlHttp.responseText;
                    var index = percent_complete / 2; 				//100个百分点，显示在50个block上
                    for (var i = 1; i <= index; i++) {
                        var elem = document.getElementById("block" + i);
                        elem.innerHTML = clear;					//不设置innerHTML属性，非IE内核浏览器不会显示进度
                        elem.style.backgroundColor = bar_color; //为block设置背景颜色
                        document.getElementById("finish").innerHTML
								= "<font style='font-weight:bold;color:blue'>" + percent_complete + "%"+"</font>";
                    }
                    //只要进度小于100%继续每隔1000毫秒调用一次pollServer()
                    if (percent_complete < 100) {
                    	if(percent_complete == 76){
                    		setTimeout(function(){pollServer(ctxPath);},3000);
                    	}else{
                    		setTimeout(function(){pollServer(ctxPath);},1000);
                    	}
                    } else if(percent_complete == 100){
                    	document.charset="utf-8";
            		    var redirectResultView=ctxPath+"/preview/step2.jsp";
            		    var urlInfo = "Loading... Please click to redirect. <a href='javascript:void(0);' onclick='";
            		    urlInfo += "javascript: document.form1.action = \"" + redirectResultView;
            		    urlInfo += "\"; document.form1.submit();'><font color='red'>here</font></a>";
            		    document.getElementById("complete").innerHTML = urlInfo;
            		    if(confirm('Preview Online')) {
                		    document.form1.action = redirectResultView;
                		    document.form1.submit();
                    	}
                    }
                    //定义percent超过100后的错误信息
                    else if(percent_complete == 102){
                    	alert("处理过程出现XX错误！");
                    }
                }
            }
        }
    	
    	//检查processBar所在div，设置其是否显示
        function checkDiv() {
            var progress_bar = document.getElementById("progressBar");
            if (progress_bar.style.visibility == "visible") {
                clearBar();
                document.getElementById("complete").innerHTML = "";
            } else {
                progress_bar.style.visibility = "visible"
            }
        }
        
        //清空processBar所在div
        function clearBar() {
            for (var i = 1; i < 10; i++) {
                var elem = document.getElementById("block" + i);
                elem.innerHTML = clear;
                //elem.style.backgroundColor = "white";
            }
        }