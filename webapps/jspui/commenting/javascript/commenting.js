function showHideElement(element) {
	if (element.style.display != 'block') {
			element.style.display = 'block';
	} else {
			element.style.display = 'none';
	}
}


function showHideCommentBody(startNode) {
    var rootNode = startNode.parentNode.parentNode; 
	var element = rootNode.getElementsByTagName("DIV")[0];
	if(element != null) showHideElement(element);
}

function showHideCommentThread(startNode) {
    var rootNode = startNode.parentNode; 
	var elements = getChildrenByTagName(rootNode, "UL");
	
	if(elements == null) return;

	var imageName =  startNode.src.substring(startNode.src.length-5, startNode.src.length);
	
	if(imageName == "p.gif") {
		startNode.src="../../commenting/image/m.gif";
	} else {
		startNode.src="../../commenting/image/p.gif";
	}
	
	for(var i=0; i< elements.length; i++) {
		showHideElement(elements[i]);
	}
}

function getChildrenByTagName(rootNode, tagName) {
	var children = rootNode.childNodes;
	var result = new Array(0);
	if(children == null) return result;
	for(var i=0; i<children.length; i++) {
		if(children[i].tagName == tagName) {
			var elementArray = new Array(1);
			elementArray[0] = children[i];
			result = result.concat(elementArray);
		}
	}
	return result;
}


function popUp(URL) {
	var page;
	page = window.open(URL, 'commentForm', 'toolbar=0,scrollbars=1,location=0,statusbar=0,menubar=0,resizable=1,width=650,height=450');
}


function confirmOpen(url, message) {
	var answer
	answer = confirm(message)

	if (answer !=0) { 
	  location = url 
	  return true;
	}
}

function disableEnter() {
	if(window.event && window.event.keyCode == 13) {
		window.event.keyCode=0;
		return false;
	} else {
		return true;
	}
}


function isNetscape(v) {
		  /*
		  ** Check if the browser is Netscape compatible
		  **    v  version number
		  ** returns  true if Netscape and version equals or greater
		  */
		  return isBrowser("Netscape", v);
}
	
function isMicrosoft(v) {
		  /*
		  ** Check if the browser is Microsoft Internet Explorer compatible
		  **    v  version number
		  ** returns  true if MSIE and version equals or greater
		  */
		  return isBrowser("Microsoft", v);
}

function isMicrosoft() {
		  /*
		  ** Check if the browser is Microsoft Internet Explorer compatible
		  **    v  version number
		  ** returns  true if MSIE and version equals or greater
		  */
		  return isBrowser("Microsoft", 0);
}


function isBrowser(b,v) {
		  /*
		  ** Check if the current browser is compatible
		  **  b  browser name
		  **  v  version number (if 0 don't check version)
		  ** returns true if browser equals and version equals or greater
		  */
		  browserOk = false;
		  versionOk = false;

		  browserOk = (navigator.appName.indexOf(b) != -1);
		  if (v == 0) versionOk = true;
		  else  versionOk = (v <= parseInt(navigator.appVersion));
		  return browserOk && versionOk;
}


