function refineShowOrHide(aCtrl){
	var refine = document.getElementById("popup");
	if(document.getElementById("facet_show").value == "true"){
		for(var i = 1; i < refine.children[0].children.length; i++){
			refine.children[0].children[i].style.display = "";
		}
		document.getElementById("facet_show").value = "false";
		aCtrl.innerHTML = "收起-";
	}else{
		for(var i = 1; i < refine.children[0].children.length; i++){
			refine.children[0].children[i].style.display = "none";
		}
		document.getElementById("facet_show").value = "true";
		aCtrl.innerHTML = "展开+";
	}
}