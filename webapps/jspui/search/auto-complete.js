function autoComplete(event,ctxPath) {
	var myevent = event||window.event;
	var mykeyCode = myevent.keyCode;
	if (mykeyCode >= 65 && mykeyCode <= 90 || mykeyCode == 8 || mykeyCode == 46
			|| mykeyCode == 32) {
		// keyword为空，将不发送Ajax请求
		if ($F("tquery") == "") {
			return;
		}
		// 如果不为空，发送Ajax请求检索
		new Ajax.Request(ctxPath + "/autocomplete", {
			method : "post",
			parameters : {
				keys : $F("tquery")
			},
			onSuccess : function(req) {
				var rs = req.responseText.evalJSON();
				clearTable();// 清空列表
				$("suggesttion").parentNode.style.border = "1px solid #bbbbbb";
				for (i = 0; i < rs.length; i++) {
					var tr = $("suggesttion").insertRow($("suggesttion").rows.length);
					// 鼠标移上去添加行背景色
					tr.onmouseover = function() {
						this.style.backgroundColor = "#FFFF66";
						this.style.fontWeight = "bold";
					}
					// 鼠标移开恢复行背景色
					tr.onmouseout = function() {
						this.style.backgroundColor = "#FFFFFF";
						this.style.fontWeight = "normal";
					}
					var nameTd = tr.insertCell(tr.cells.length);
					nameTd.innerHTML = rs[i].name + "(" + rs[i].count + ")";
					// 为单元格添加单击事件
					nameTd.onclick = function() {
						$("tquery").value = this.innerHTML.substring(0, this.innerHTML.indexOf('('));
						clearTable();// 清空列表
						document.solrSearchForm.submit.click();
					}
				}
			}
		});
	}
}

function clearTable() {
	for (j = $("suggesttion").rows.length - 1; j >= 0; j--) {
		$("suggesttion").deleteRow(j);
	}
	$("suggesttion").parentNode.style.border = "none";
}