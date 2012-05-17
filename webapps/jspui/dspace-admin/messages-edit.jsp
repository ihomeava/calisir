<%--
  -
  - messages-edit.jsp
  - Description: 进行语言文件编辑
  - Attributes: Pulipuli
  -
--%>

<%@ page contentType="text/html;charset=UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace"%>

<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport"%>
<%@ page import="org.dspace.core.Constants"%>
<%
	String position = (String)request.getAttribute("position");
	
	//get the existing messages
    String messages = (String)request.getAttribute("messages");

    if (messages == null)
    {
        messages = "";
    }
    
    System.out.print(messages);

	request.setAttribute("LanguageSwitch", "hide");
%>

<dspace:layout titlekey="jsp.dspace-admin.messages-edit.title"
	navbar="admin" locbar="link" parenttitlekey="jsp.administer"
	parentlink="/dspace-admin">

	<script type="text/javascript"
		src="js/jquery-1.4.2.min.js">
	</script>
	<style type="text/css">
textarea.file_text {
	display: none;
}

div.functionArea {
	text-align: center;
}

div.list-container {
	text-align: center;
}

div.encode_demo {
	text-align: center;
}

div.list-container table {
	margin: auto;
	width: 100%;
}

div.list-container table tbody tr td {
	text-align: center;
	vertical-align: top;
}

div.list-container table tbody tr td .input-text {
	width: 100%;
}

div.list-container table tbody tr td .input-text.expand {
	height: 10em;
}

div.list-container table tbody tr td .invalid {
	background-color: #FF6666;
}

div.list-container table tbody tr td div.hint {
	font-size: small;
	color: #FF0000;
}

div.list-container table tbody tr td.function button {
	font-size: smaller;
}

div.filterArea {
	text-align: center;
}

div.filterArea table {
	margin: auto;
}

div.filterArea table tbody tr th {
	width: 4em;
	text-align: left;
}
</style>

	<form
		action="<%= request.getContextPath() %>/dspace-admin/messages-edit"
		method="post">
		<h1>
			<fmt:message key="jsp.dspace-admin.messages-edit.editing-position">
				<fmt:param><%=position%></fmt:param>
			</fmt:message>
		</h1>
		<input type="hidden" name="position" value="<%=position %>" />
		<input type="hidden" name="submit_action" value="submit_save" />

		<textarea id="file_text" name="messages" class="file_text"><%= messages %></textarea>

		<div class="filterArea">
			<table>
				<tbody>
					<tr>
						<td>
							<fmt:message key="jsp.dspace-admin.messages-edit.filter.key" />
							<input type="text" class="filter-key" value="" id="filterKey" />
						</td>
						<td>
							<select id="filterCond">
								<option selected="true" value="or">
									<fmt:message key="jsp.dspace-admin.messages-edit.filter.or" />
								</option>
								<option value="and">
									<fmt:message key="jsp.dspace-admin.messages-edit.filter.and" />
								</option>
							</select>
						</td>
						<td>
							<fmt:message key="jsp.dspace-admin.messages-edit.filter.key" />
							<input type="text" class="filter-value" value="" id="filterValue" />
						</td>
						<td>
							<button type="button" id="filterDo">
								<fmt:message key="jsp.dspace-admin.messages-edit.filter.do" />
							</button>
							<button type="button" id="filterReset">
								<fmt:message key="jsp.dspace-admin.messages-edit.filter.reset" />
							</button>
						</td>
					</tr>
				</tbody>
			</table>
		</div>

		<div class="functionArea">
			<input type="button" name="submit_save" class="file_save"
				value="<fmt:message key="jsp.tools.general.update" />" />
			<input type="button" class="addMessage"
				value="<fmt:message key="jsp.dspace-admin.messages-edit.function.create" />" />
			<input type="button" class="scrollToButton"
				value="<fmt:message key="jsp.dspace-admin.messages-edit.function.scroll-to-button" />" />

			<input type="button" class="submit_cancel" name="cancel"
				value="<fmt:message key="jsp.dspace-admin.general.cancel"/>" />
		</div>

		<div class="list-container" id="list_container">
			<table cellspacing="5" cellpadding="5">
				<thead>
					<th width="30%">
						<fmt:message key="jsp.dspace-admin.messages-edit.table.key" />
					</th>
					<th>
						<fmt:message key="jsp.dspace-admin.messages-edit.table.value" />
					</th>
					<th style="width: 8em;">
						&nbsp;
					</th>
				</thead>
				<tbody>

				</tbody>
				<tfoot>
					<th width="30%">
						<fmt:message key="jsp.dspace-admin.messages-edit.table.key" />
					</th>
					<th>
						<fmt:message key="jsp.dspace-admin.messages-edit.table.value" />
					</th>
					<th>
						&nbsp;
					</th>
				</tfoot>
			</table>
		</div>

		<div class="functionArea">
			<input type="button" name="submit_save" class="file_save"
				value="<fmt:message key="jsp.tools.general.update" />" />
			<input type="button" class="addMessage"
				value="<fmt:message key="jsp.dspace-admin.messages-edit.function.create" />" />
			<input type="button" class="scrollToTop"
				value="<fmt:message key="jsp.dspace-admin.messages-edit.function.scroll-to-top" />" />
			<input type="button" class="submit_cancel" name="cancel"
				value="<fmt:message key="jsp.dspace-admin.general.cancel"/>" />
		</div>
	</form>

	<script type="text/javascript">
jQuery(document).ready(function() {

	MessageTable.setup();

});

function MessageTableController() {
	var mObj = this;

	var LANG
= {
		"nowLoading": "<%=LocaleSupport.getLocalizedMessage(pageContext
				, "jsp.dspace-admin.messages-edit.js.nowLoading") %>", 
		"deleteButton": "<%=LocaleSupport.getLocalizedMessage(pageContext
				, "jsp.dspace-admin.messages-edit.js.deleteButton") %>", 
		"deleteConfirm": "<%=LocaleSupport.getLocalizedMessage(pageContext
				, "jsp.dspace-admin.messages-edit.js.deleteConfirm") %>", 
		"insertButton": "<%=LocaleSupport.getLocalizedMessage(pageContext
				, "jsp.dspace-admin.messages-edit.js.insertButton") %>", 
		"moveUpButton": "<%=LocaleSupport.getLocalizedMessage(pageContext
				, "jsp.dspace-admin.messages-edit.js.moveUpButton") %>", 
		"moveDownButton": "<%=LocaleSupport.getLocalizedMessage(pageContext
				, "jsp.dspace-admin.messages-edit.js.moveDownButton") %>", 
		"error": {
			"heading": "<%=LocaleSupport.getLocalizedMessage(pageContext
				, "jsp.dspace-admin.messages-edit.js.error.heading") %>", 
			"name": "<%=LocaleSupport.getLocalizedMessage(pageContext
				, "jsp.dspace-admin.messages-edit.js.error.name") %>", 
			"message": "<%=LocaleSupport.getLocalizedMessage(pageContext
				, "jsp.dspace-admin.messages-edit.js.error.message") %>", 
			"ValueEmpty": "<%=LocaleSupport.getLocalizedMessage(pageContext
				, "jsp.dspace-admin.messages-edit.js.error.ValueEmpty") %>", 
			"WithSlash": "<%=LocaleSupport.getLocalizedMessage(pageContext
				, "jsp.dspace-admin.messages-edit.js.error.WithSlash") %>\\", 
			"WithNewLine": "<%=LocaleSupport.getLocalizedMessage(pageContext
				, "jsp.dspace-admin.messages-edit.js.error.WithNewLine") %>", 
			"CharsetError": "<%=LocaleSupport.getLocalizedMessage(pageContext
				, "jsp.dspace-admin.messages-edit.js.error.CharsetError") %>" 
		},
		"save": {
			"KeyEmptyError": "<%=LocaleSupport.getLocalizedMessage(pageContext
				, "jsp.dspace-admin.messages-edit.js.save.KeyEmptyError") %>", 
			"ValueEncodeError": "<%=LocaleSupport.getLocalizedMessage(pageContext
				, "jsp.dspace-admin.messages-edit.js.save.ValueEncodeError") %>" 
		},
		"filter": {
			"processing": "<%=LocaleSupport.getLocalizedMessage(pageContext
				, "jsp.dspace-admin.messages-edit.js.filter.processing") %>", 
			"NotFound": "<%=LocaleSupport.getLocalizedMessage(pageContext
				, "jsp.dspace-admin.messages-edit.js.filter.not-found") %>", 
		},
		"sortConfirm": "<%=LocaleSupport.getLocalizedMessage(pageContext
				, "jsp.dspace-admin.messages-edit.js.sortConfirm") %>" 
	};
	
	mObj.config = {
		"source": "#file_text",
		"save": ".file_save",
		"container" : "#list_container",
		"filterKey" : "#filterKey",
		"filterValue" : "#filterValue",
		"filterDo" : "#filterDo",
		"filterReset" : "#filterReset",
		"filterCond" : "#filterCond",
		"addMessage": ".addMessage",
		"functionArea": ".functionArea",
		"filterArea": ".filterArea",
		"scrollToTop": ".scrollToTop",
		"scrollToButton": ".scrollToButton",
		"sortMessage": ".sortMessage",
		"cancel": ".submit_cancel",
		"encodeDemo": {
			"forText": "#forText",
			"forDspace": "#forDspace",
			"textToDspace": ".textToDspace",
			"dspaceToText": ".dspaceToText"
		}
	};
	
	mObj.debug = false;	//false;
		
	mObj.setup = function () {
		try
		{
			var processing = jQuery("<div class='help'>"+LANG.nowLoading+"</div>");
			
			if (mObj.debug == true)
			{
				jQuery(mObj.config.source).show();
			}
			
			jQuery(mObj.config.container).prepend(processing);
			
			mObj.loadFromSource(function () {
				processing.remove();
			});
			
			var addClickListener = function (jQueryObj, func)
			{
				for (var i = 0; i < jQueryObj.length; i++)
				{
					jQueryObj.eq(i).click(func);
				}
			}
			
			//jQuery(mObj.config.filterDo).click(function () { 
			//	filterDo(); 
			//});
			addClickListener(jQuery(mObj.config.filterDo), function () {
				filterDo(); 
			});
			//jQuery(mObj.config.filterReset).click(function () { 
			//	filterReset(); 
			//});
			addClickListener(jQuery(mObj.config.filterReset), function () {
				filterReset(); 
			});
			//jQuery(mObj.config.save+":eq(0)").click(function () {
			//	saveToSource(this.form);
			//});
			addClickListener(jQuery(mObj.config.save), function () {
				saveToSource(this.form);
			});
			//jQuery(mObj.config.addMessage).click(function () {
			//	addRow();
			//});
			addClickListener(jQuery(mObj.config.addMessage), function () {
				addRow();
			});
			//jQuery(mObj.config.scrollToTop).click(function () {
			//	document.body.scrollIntoView(true);
			//});
			addClickListener(jQuery(mObj.config.scrollToTop), function () {
				window.scrollTo(0, 0);
			});
			//jQuery(mObj.config.scrollToButton).click(function () {
			//	jQuery().scrollIntoView(true);
			//});
			addClickListener(jQuery(mObj.config.scrollToButton), function () {
				window.scrollTo(0, jQuery("body").height());
			});
			addClickListener(jQuery(mObj.config.cancel), function () {
				submitCancel(this.form);
			});
			
			addClickListener(jQuery(mObj.config.encodeDemo.textToDspace), function () {
				textToDspace();
			});
			
			addClickListener(jQuery(mObj.config.encodeDemo.dspaceToText), function () {
				dspaceToText();
			});
			//jQuery(mObj.config.sortMessage).click(function () {
			//	sortRow();
			//});
			return mObj;
		}
		catch (e) {
			alert(LANG.error.heading + "\n" 
				+ LANG.error.name + e.name + "\n"
				+ LANG.error.msg + e.message);
		}
	};
	
	var textToDspace = function () {
		var forText = jQuery(mObj.config.encodeDemo.forText);
		var forDspace = jQuery(mObj.config.encodeDemo.forDspace);
		
		var input = forText.val();
		input = encode(input);
		forDspace.val(input);
	};
	
	var dspaceToText = function () {
		var forText = jQuery(mObj.config.encodeDemo.forText);
		var forDspace = jQuery(mObj.config.encodeDemo.forDspace);
		
		var input = forDspace.val();
		input = decode(input);
		forText	.val(input);
	};
	
	var submitCancel = function (form) {
		jQuery(form).find("input[type='hidden'][name='submit_action']").val("submit_cancel");
		jQuery(form).submit();
	};
	
	mObj.loadFromSource = function (callback) {
		setTimeout(function () {
			var source = jQuery(mObj.config.source).val();
			var sourceLineAry = source.split("%0d%0a");
			
			//jQuery(mObj.config.container).hide();
			functionDisable();
			
			var target = jQuery(mObj.config.container+" table tbody");
			
			var i = 0;
			var limit = sourceLineAry.length;
			if (mObj.debug == true)
				limit = 10;
			
			var forLoop = function (i, forCallBack)
			{
				if (i < limit)
				{
					var line = sourceLineAry[i];
					line = unescape(line);
					line = jQuery.trim(line);
					if (line != "")
					{
						if (line.substr(0, 1) != "#")
						{
							//var lineAry = line.split("=", 2);
							var equalIndex = line.indexOf("=");
							//var key = jQuery.trim(lineAry[0]);
							var key = line.substring(0, equalIndex);
								key = jQuery.trim(key);
							var value = line.substring((equalIndex + 1));
								value = jQuery.trim(value);
							//var value = jQuery.trim(lineAry[1]);
						}
						else
						{
							var key = line;
							var value = "";
						}
						
						var tr = createRow(key, value);
						
						tr.appendTo(target);
					}
					i++;
					
					var help = jQuery(mObj.config.container).children(".help:first");
					help.html(LANG.nowLoading + " "+i+"/"+limit+" ("+parseInt((i/limit)*100)+"%)");
					
					setTimeout(function () {
						forLoop(i, forCallBack);
					}, 10);
				}
				else
				{
					forCallBack();
				}
			}
			
			forLoop(i, function () {
				functionEnable();
				callback();
			});
		}, 0);
	};
	
	var sortRow = function () 
	{
		return;
		
		if (!window.confirm(LANG.sortConfirm))
			return;
		
		var forLoop = function (i, limit, exec, callback) {
			if (i < limit)
			{
				exec(i);
				i++;
				setTimeout(function () {
					forLoop(i, limit, exec, callback);
				}, 50);
			}
			else
				callback();
		};
		
		//先取出所有的key值
		var sourceTbody = jQuery(mObj.config.container+" table tbody").hide();
		var trs = jQuery(mObj.config.container+" table tbody tr");
		var keysAry = new Array();
		forLoop(0, trs.length, function (i) {
			var key = trs.eq(i).find("td input.key").val();
			keysAry.push(key);
		}, function () {
			keysAry.sort();
		
			var sortTbody = sourceTbody.clone().empty().show()
				.insertBefore(sourceTbody)			
			var limit = keysAry.length;
			
			/*
			for (var i = 0; i < limit; i++)
			{
				
			}*/
			forLoop(0, limit, function (i) {			
				var key = keysAry[i];
				var tr = sourceTbody.find("tr:has(td input.key[value='"+key+"']):first");
				tr.appendTo(sortTbody);
			}, function () {
				sourceTbody.remove();
			});
		});
	};
	
	var addRow = function (thisBtn)
	{
		var tbody = jQuery(mObj.config.container+" table tbody");
		var tr = createRow();
		
		if (typeof(thisBtn) == "undefined")
			tbody.append(tr);
		else
			jQuery(thisBtn).parents("tr:first").after(tr);
		tr.find(".key").focus();
	};
	
	var createRow = function(key, value)
	{
		var tr = jQuery("<tr></tr>");
		
		var keyInput = jQuery("<input type='text' value='' class='input-text key' />")
			.blur(function () {
				var result = checkValueValid(this.value, true);
				if (result != "")
				{
					if (!jQuery(this).hasClass("invalid"))
					{
						jQuery(this).addClass("invalid");
						jQuery(this).before(jQuery("<div class='hint'>"+result+"</div>"));
					}
				}
				else if (jQuery(this).hasClass("invalid"))
				{
					jQuery(this).removeClass("invalid");
					jQuery(this).prevAll().remove();
				}
				
				var tr = jQuery(this).parents("tr:first");
				if (this.value.substr(0, 1) != "#")
				{
					if (tr.children("td:visible").length == 2)
					{
						tr.children("td:hidden").show();
						tr.children("td:eq(0)").attr("colspan", 1);
					}
				}
				else
				{
					if (tr.children("td:visible").length == 3)
					{
						tr.children("td:eq(1)").hide();
						tr.children("td:eq(0)").attr("colspan", 2);
					}
				}
			});
		
		var valueInput = jQuery("<textarea class='input-text value'></textarea>")
			.focus(function () {
				jQuery(this).toggleClass("expand");
			})
			.blur(function () {
				jQuery(this).toggleClass("expand");
				var result = checkValueValid(this.value);
				if (result != "")
				{
					if (!jQuery(this).hasClass("invalid"))
					{
						jQuery(this).addClass("invalid");
						jQuery(this).before(jQuery("<div class='hint'>"+result+"</div>"));
					}
				}
				else if (jQuery(this).hasClass("invalid"))
				{
					jQuery(this).removeClass("invalid");
					jQuery(this).prevAll().remove();
				}
			});
		
		tr.append(jQuery("<td></td>").append(keyInput))
			.append(jQuery("<td></td>").append(valueInput))
			.append("<td class='function'></td>");
		
		var btnDel = jQuery("<button class='delete' type='button'>"+LANG.deleteButton+"</button>")
					.click(function () { deleteRow(this); });
		var btnInsert = jQuery("<button class='insert' type='button'>"+LANG.insertButton+"</button>")
					.click(function () { addRow(this); });
		var btnMoveUp = jQuery("<button class='move' type='button'>"+LANG.moveUpButton+"</button>")
					.click(function () { rowMoveUp(this); });
		var btnMoveDown = jQuery("<button class='move' type='button'>"+LANG.moveDownButton+"</button>")
					.click(function () { rowMoveDown(this); });
		tr.find(".function")
			.append(btnDel)
			.append(btnInsert)
			.append("<br />")
			.append(btnMoveUp)
			.append(btnMoveDown);
		
		if (typeof(key) != "undefined")
		{
			if (!isComment(key))
				key = mObj.decode(key);
			tr.find(".key").val(key);
		}
		if (typeof(value) != "undefined")
		{
			value = mObj.decode(value);
			//valueInput.attr("innerHTML", value);
			valueInput.val(value);
			//alert([valueInput.val(), value]);
		}
		
		if (typeof(key) != "undefined"
			&& key.substr(0, 1) == "#")
		{
			tr.children("td:eq(0)").attr("colspan", 2);
			tr.children("td:eq(1)").remove();
		}
		return tr;
	}
	
	var checkValueValid = function (value, isKey)
	{
		value = jQuery.trim(value);
		if (value == "")
			return LANG.error.ValueEmpty;	//"不能是空白！"
		else if (typeof(isKey) != "undefined"
			&& isComment(value))
			return "";
		else if (value.indexOf("\\") != -1)
			return LANG.error.WithSlash;	//"不能包含「\\」！";
		else if (value.indexOf("\n") != -1)
			return LANG.error.WithNewLine;
		else if (typeof(isKey) != "undefined" 
			&& mObj.encode(value) != value)
			return LANG.error.CharsetError;
		else
			return "";
	};
	
	var deleteRow = function (thisBtn)
	{
		if (window.confirm(LANG.deleteConfirm))
		{
			var tr = jQuery(thisBtn).parents("tr:first");
			tr.remove();
		}
	};
	
	var rowMoveUp = function (thisBtn)
	{
		var tr = jQuery(thisBtn).parents("tr:first");
		tr.insertBefore(tr.prev());
		thisBtn.focus();
	} 
	var rowMoveDown = function (thisBtn)
	{
		var tr = jQuery(thisBtn).parents("tr:first");
		tr.insertAfter(tr.next());
		thisBtn.focus();
	} 
	
	var filterDo = function() {
		functionDisable();
		var filterKey = jQuery.trim(jQuery(mObj.config.filterKey).val());
		var filterValue = jQuery.trim(jQuery(mObj.config.filterValue).val());
		var filterCond = jQuery(mObj.config.filterCond).val();
		
		if (filterKey == "" && filterValue == "")
		{
			filterReset();
			functionEnable();
			return;
		}
		else
			filterAll();
		
		var helpFiltering = LANG.filter.processing;
		var found = false;
		var msg = jQuery("<div class='help'>"+helpFiltering+"</div>");
		var area = jQuery(mObj.config.filterArea);
		for (var i = 0; i < area.length; i++)
			area.eq(i).append(msg.clone());
		
		setTimeout(function () {		
			if (filterCond == "or")
			{
				if (filterKey != "")
				{
					var trs = jQuery(mObj.config.container+" table tbody tr:hide");
					for (var i = 0; i < trs.length; i++)
					{
						var tr = trs.eq(i);
						
						var key = tr.find("input.key:first").val();
						if (key.indexOf(filterKey) != -1)
						{
							tr.show();
							found = true;
						}
					}
				}
				
				if (filterValue != "")
				{
					var trs = jQuery(mObj.config.container+" table tbody tr:hidden");
					for (var i = 0; i < trs.length; i++)
					{
						var tr = trs.eq(i);
						if (tr.find(".value").length == 0)
							continue;
						
						
						var value = tr.find(".value:first").val();
						if (value.indexOf(filterValue) != -1)
						{
							tr.show();
							found = true;
						}
					}
				}
			}	//if (filterCond == "or")
			else
			{
				var trs = jQuery(mObj.config.container+" table tbody tr:hidden");
				for (var i = 0; i < trs.length; i++)
				{
					var tr = trs.eq(i);
					
					var key = tr.find("input.key:first").val();
					if (tr.find(".value").length > 0)
					{						
						var value = tr.find(".value:first").val();
						if (key.indexOf(filterKey) != -1
							&& value.indexOf(filterValue) != -1)
						{
							tr.show();
							found = true;
						}
					
					}
				}
			}
			
			if (found == false)
			{
				var notFound = jQuery("<div class=\"help \">"+LANG.filter.NotFound+"</div>");
				setTimeout(function () {
					notFound.remove();
				}, 5000);
				jQuery(mObj.config.container).prepend(notFound);
			}
			functionEnable();
		}, 100);
		area.children(".help").remove();
	};
	
	var filterAll = function () {
		var target = jQuery(mObj.config.container+" table tbody tr");
		target.hide();
	}
	
	var filterReset = function() {
		var target = jQuery(mObj.config.container+" table tbody tr:hidden");
		target.show();
	};
	
	var saveToSource = function(form) {
		
		functionDisable();
		
		var trs = jQuery(mObj.config.container+" table tbody tr");
		var output = "";
		var lastKey = "";
		var lastState = "key";
		
		for (var i = 0; i < trs.length; i++)
		{
			var tr = trs.eq(i);
			var key = jQuery.trim(tr.find("input.key:first").val());
			var value = jQuery.trim(tr.find(".value:first").attr("value"));
			
			if (key == "" && value == "")
			{
				output = output + "\n";
				continue;
			}
			
			if (key == "")
			{
				var msg = LANG.save.KeyEmptyError.replace("[0]", value);
				alert(msg);
				tr.show();
				tr.find("input.key:first").focus();
				functionEnable();
				return false;
			}
			else
			{
				if (!isComment(key))
					key = mObj.encode(key);
			}
			
			if (value != "")
			{
				try
				{
					//alert([value , mObj.encode(value)]);
					value = mObj.encode(value);
					value = replaceAll(value, "\n", "");
				}
				catch (e)
				{
					var msgTitle = (LANG.save.ValueEncodeError).replace("[0]", value);
					alert(msgTitle + "\n"
						+ LANG.error.name + e.name + "\n"
						+ LANG.error.msg + e.message);
					tr.find(".value:first").focus();
					functionEnable();
					return false;
				}
			}
			
			if (key.substr(0, 1) != "#")
			{
				var line = key + " = " + value + "\n";
				
				if (lastState != "key")
					line = "\n" + line;
				else
				{
					var keyTrimAry = key.split(".");
					var lastKeyTrimAry = lastKey.split(".");
					
					var matchCount = 0;
					for (var k = 0; k < 3 && k < keyTrimAry.length && k < lastKeyTrimAry.length; k++)
					{
						if (keyTrimAry[k] == lastKeyTrimAry[k])
							matchCount++;
					}
					
					if (matchCount < 3
						&& !(keyTrimAry.length < 4 && lastKeyTrimAry.length < 4 && matchCount == 2))
						line = "\n" + line;
				}
				
				lastKey = key;
				lastState = "key";
			}
			else
			{	
				var line = key + "\n";
				if (lastState == "key")
					line = "\n" + line;
				lastState = "comment";
			}	
			output = output + line;
		}
		
		jQuery(mObj.config.source).attr("innerHTML", output);
		jQuery(mObj.config.source).attr("value", output);
		if (mObj.debug == true)
		{
			alert([jQuery(mObj.config.source).attr("innerHTML")
				,jQuery(mObj.config.source).attr("value")]);
		}
		else
			jQuery(form).submit();
		//正式使用的时候，把下面的注释去掉，才能正确地送出去
		//jQuery(mObj.config.source).show();
		
		//return false;
		//return true;
		
		//jQuery(form).submit();
	};
	
	var disableFunction = [
		mObj.config.filterDo,
		mObj.config.filterReset,
		mObj.config.addMessage,
		mObj.config.save,
		mObj.config.sortMessage
	];
	
	var functionDisable = function () {
		for (var i = 0; i < disableFunction.length; i++)
		{
			var func = disableFunction[i];
			var funcObj = jQuery(func);
			for (var j = 0; j < funcObj.length; j++)
				funcObj.eq(j).attr("disabled", true);
		}
	};
	
	var functionEnable = function () {
		for (var i = 0; i < disableFunction.length; i++)
		{
			var func = disableFunction[i];
			var funcObj = jQuery(func);
			for (var j = 0; j < funcObj.length; j++)
				funcObj.eq(j).removeAttr("disabled");
		}
		//jQuery(disableFunction.toString()).removeAttr("disabled");
	};
	
	var replaceAll = function (str, reallyDo, replaceWith)
	{
		return str.replace(new RegExp(reallyDo, 'g'), replaceWith);
	};
	
	var isComment = function (key)
	{
		key = jQuery.trim(key);
		if (key.substr(0, 1) == "#")
			return true;
		else
			return false;
	}
	
	var matchStr = new RegExp(/[0-9]|[a-z]|[A-Z]|[ ]|[-]|[.]|[(]|[)]|[_]|[<]|[>]|[\/]|["]|[']|[=]|[,]|[:]|[{]|[}]|[*]|[?]|[#]|[!]|[+]|[;]|[&]|[~]|[\[]|[\]]/i);	//'"
	mObj.encode = function (source)
	{
	  //var source = document.getElementById("source").value;
	  var utf = "";
	  
	  //转换成UTF8编码
	  for (var i = 0; i < source.length; i++)
	  {
		char = source.substr(i, 1);
	 
	 	//if (char == " ")
		//	utf = utf + "&amp;nbsp;";
		//else if (char == "&")
		//	utf = utf + "&amp;";
		var encoded = source.charCodeAt(i).toString(16);
	 	//if (char.match(matchStr) == null
		//	|| encoded.length == 4)
		if (encoded.length == 4)
			utf = utf + "\\u" + encoded;
		else
	   		utf = utf + char;
	  }
	  
	  var result = utf;
	  //result = replaceAll(result, "&amp;", "&");
	  //result = replaceAll(result, " ", "&amp;nbsp;");
	  //result = replaceAll(result, "&", "&amp;");
	  //result = replaceAll(result, " ", "&nbsp;");
	  //document.getElementById("target").value = result;
	  return result;
	};
	
	mObj.decode = function(source)
	{
	 // var source = document.getElementById("target").value;
	  var utf = "";
	  
		for (var i = 0; i < source.length; i++)
		{
			char = source.substr(i, 1);
			
			if (char == "\\" && i < source.length - 1)
			{
				char = source.substr(i, 2);
			   
			   if (char == "\\u" && i < source.length - 5)
			   {
					code = source.substr(eval(i+2), 4);
					if (code.indexOf("\\") == -1 && code.indexOf(" ") == -1)
					{
						utf = utf + String.fromCharCode(HEXtoDEC(code));
						i = i + 5;
					}
					else
						utf = utf + char;
				}
				else
					utf = utf + char
			}
			else
				utf = utf + char
		}
	  
	  var result = utf;
	  //result = replaceAll(result, "&", "&amp;amp;");
	  //result = replaceAll(result, " ", "&amp;nbsp;");
	  //result = replaceAll(result, "&amp;nbsp;", " ");
	  //result = replaceAll(result, "&amp;amp;", "&");
	  //document.getElementById("source").value = result;
	  return result;
	};

	var HTMLtoTXT = function (str){
	  var RexStr = /\<|\>|\"|\'|\&/g;
	  str = str.replace(RexStr, function(MatchStr){
		switch(MatchStr){
		  case "<":
			return "&lt;";
			break;
		  case ">":
			return "&gt;";
			break;
		  case "\"":
			return "&quot;";
			break;
		  case "'":
			return "&#39;";
			break;
		  case "&":
			return "&amp;";
			break;
		  default :
			break;
		}
	  })
	  return str;
	}
	
	var HEXtoDEC = function(six)
	{
		  var ten = 0;
		  
		  for (var i = 0; i < six.length; i++)
		  {
			char = six.substr(i, 1);
		 number = 0;
		 
		 switch (char)
		 {
		   case 'a':
			 number = 10;break;
		   case 'b':
			 number = 11;break;
		   case 'c':
			 number = 12;break;
		   case 'd':
			 number = 13;break;
		   case 'e':
			 number = 14;break;
		   case 'f':
			 number = 15;break;  
		   default:
			 number = char;break;
		 }
		
		 for (var j = 0; j < (six.length - i - 1); j++)
		 {
		   number = number * 16;
		 }
		 ten = ten + parseInt(number);
		  }
		  
		  return ten;
	};


	
	return mObj;
}
var MessageTable = MessageTableController();
</script>
	</form>
</dspace:layout>