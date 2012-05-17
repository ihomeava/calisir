<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript" src="<%=request.getContextPath() %>/preview/js/progress.js"></script>

<div style="top:145px;width: expression(body.clientWidth);z-index: 100;border: none;height: 300px;margin-top: 150px;">
 			<%int i = 1; %>
	<table border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td height="20" colspan="3" valign="top">
				<center><h2>数据正在处理中，请稍候……</h2></center>
			</td>
		</tr>
		<tr>
			<td colspan="3" valign="top">
				<table align="center">
					<tr>
						<td align="center">
						     <div id="progressBar" style="padding:2px;border:solid green 1px;visibility:hidden" align="left">
							       <div style="width:800px">
							                <c:forEach begin="1" end="50" step="1" >
							                	<span id="block<%=i++ %>" style="width:2%;"></span>
							                </c:forEach>
							        </div>
						      </div>
						 </td>
						 <td align="center" id="finish"></td>
					</tr>
					<tr>
						<td align="center" id="complete">
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>   
</div>

<form id="form1" name="form1" action="" method="post" accept-charset="utf-8" >
	<input type="hidden" id="itemid" name="itemid" value="<%=request.getAttribute("itemID") %>"  />
	<input type="hidden" id="filename" name="filename" value="<%=request.getAttribute("fileName") %>"  />
</form>
<script>
	process("<%=request.getContextPath() %>");
</script>