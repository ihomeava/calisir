/*
 * Utility Javascript methods for RSSAjax
 */
var http_request = false;
function rssAjax(ctxPath) {//初始化、指定处理函数、发送请求的函数
	http_request = false;

	//开始初始化XMLHttpRequest对象
	if (window.XMLHttpRequest) { //Mozilla 浏览器
		http_request = new XMLHttpRequest();
		if (http_request.overrideMimeType) {//设置MiME类别
			http_request.overrideMimeType('text/xml');
		}
	} else if (window.ActiveXObject) { // IE浏览器
		try {
			http_request = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
				http_request = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {
			}
		}
	}
	if (!http_request) { // 异常，创建对象实例失败
		window.alert("不能创建XMLHttpRequest对象实例.");
		return false;
	}
	http_request.onreadystatechange = processRequest;
	// 确定发送请求的方式和URL以及是否同步执行下段代码
	http_request.open("POST", ctxPath + '/RSSAjaxServlet', true);
	http_request.setRequestHeader("Content-Type",
			"application/x-www-form-urlencoded");
	http_request.send(null);
}
// 处理返回信息的函数
function processRequest() {
	if (http_request.readyState == 4) { // 判断对象状态
		if (http_request.status == 200) { // 信息已经成功返回，开始处理信息
			//alert(http_request.responseText);
			//alert("您所请求任务成功完成！");

		} else { //页面不正常
			alert("您所请求的页面有异常。");
		}
	}
}
