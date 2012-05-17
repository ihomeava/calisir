
<%
	/*
	 * DSpace 1.1.1 Commenting Add-on
	 * Copyright 2004, by the University of Minho <http://www.uminho.pt>, 
	 * Department of Information Systems <http://www.dsi.uminho.pt>.
	 * 
	 * This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike License. 
	 * To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/2.0/ or 
	 * send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.
	 * 
	 * For more information, please contact the authors: 
	 *   Ana Alice Baptista <analice@dsi.uminho.pt>; 
	 *   Miguel Ferreira <mferreira@dsi.uminho.pt>.
	 * 
	 */
%>
<%@ page language="java"%>
<%@ page contentType="text/html;charset=UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ page import="org.dspace.app.webui.util.UIUtil"%>
<%@ page import="org.dspace.core.Context"%>
<%@ page import="pt.uminho.dsi.commenting.comment.*"%>

<%@ page errorPage="/internal-error"%>


<%
	/** Global properties **/
	Comment[] unrevisedComments = (Comment[]) request
			.getAttribute("commenting.unrevisedComments");

	Context context = UIUtil.obtainContext(request);
	String callerUrl = (String) session
			.getAttribute("commenting.callerUrl");
%>

<%
	if (unrevisedComments.length == 0) {
		return;
	}
%>

<div align="center"
	style="font-size: 8pt; padding: 5px; border-width: 0px; border-style: dotted; margin-right: 10%; margin-left: 10%; margin-top: 15px">
	<div>
		<fmt:message key="jsp.comment.label.comments.unrevised" />
	</div>
	<table style="font-size: 8pt;" align="center">
		<tr style="background-color: #eeeeff">
			<th><fmt:message key="jsp.comment.label.date" />
			</th>
			<th><fmt:message key="jsp.comment.label.subject" />
			</th>
			<th><fmt:message key="jsp.comment.label.action" />
			</th>
		</tr>
		<%
			for (int i = 0; i < unrevisedComments.length; i++) {
				Comment comment = unrevisedComments[i];
		%>
		<tr>
			<td><%=comment.getLastModifiedAsString(false, request)%></td>
			<td><%=comment.getSubject()%></td>
			<td><input
				onclick="javascript: location='<%= request.getContextPath() %>/commentApproval?action=commentApproval&ID=<%= comment.getID() %>'"
				type='button' name='approveComment' value="<fmt:message key='jsp.comment.label.comment.review'/>" /></td>
		</tr>
		<%
			}
		%>
	</table>
</div>

