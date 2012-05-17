
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

<%@ page import="pt.uminho.dsi.commenting.comment.Comment"%>
<%@ page import="pt.uminho.dsi.util.*"%>
<%@ page import="org.dspace.core.Context"%>
<%@ page import="org.dspace.core.Constants"%>
<%@ page import="java.util.*"%>
<%@ page import="pt.uminho.dsi.resource.Resource"%>


<html>
<head>
<meta name="generator" content="HTML Tidy, see www.w3.org">
<title>Input Form</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<link rel="shortcut icon"
	href="<%=request.getContextPath()%>/favicon.ico" type="image/x-icon">
<link type="text/css" rel="stylesheet"
	href="<%=request.getContextPath()%>/styles.css.jsp">



<script type="text/javascript"
	src="<%=request.getContextPath()%>/commenting/javascript/commenting.js">
	
</script>

<script type="text/javascript">
	function goToLogin() {
		window.opener.location = "/password-login";
		self.close();
	}

	function checkData() {
		if (document.commentForm.subject.value.length == 0) {
			alert("The Subject field is mandatory!")
			return false;
		}
		return true;
	}

	function sendData() {

		if (!checkData()) {
			return false;
		} else {

			// data is valid, continue with submit

			var par = window.opener;

			//document.commentForm.onsubmit(); // workaround browser bugs.

			par.document.hiddenForm.subject.value = document.commentForm.subject.value;
			par.document.hiddenForm.comment.value = document.commentForm.comment.value;

			par.document.hiddenForm.callerUrl.value = document.commentForm.callerUrl.value;
			par.document.hiddenForm.resourceID.value = document.commentForm.resourceID.value;
			par.document.hiddenForm.resourceType.value = document.commentForm.resourceType.value;
			par.document.hiddenForm.action.value = document.commentForm.action.value;
			par.document.hiddenForm.submit();
			self.close();
			return false;
		}
	}
</script>


</head>

<body>


	<%
		int resourceID = Integer.parseInt(request
				.getParameter("resourceID"));
		int resourceType = Integer.parseInt(request
				.getParameter("resourceType"));
		String callerUrl = request.getParameter("callerUrl");
		String action = request.getParameter("action");
		if (action == null)
			action = "";
		boolean autoApproveAnonymousComments = request.getSession()
				.getAttribute("commenting.autoApproveAnonymousComments") == null
				? true
				: ((Boolean) request.getSession().getAttribute(
						"commenting.autoApproveAnonymousComments"))
						.booleanValue();

		/*
		 * debuging code    
		 * 
		 out.write("action=" + action + "<br/>");
		 out.write("resourceID=" + resourceID+ "<br/>");
		 out.write("resourceType=" + resourceType+ "<br/>");
		 out.write("callerUrl=" + callerUrl + "<br/>");
		 */

		Context context = Utility.obtainNewContext(request);

		String subject = "";
		String comment = "";
		Vector markedResources = new Vector();

		if (action.equals("updateComment")) {
			Comment c = Comment.find(context, resourceID);
			subject = c.getSubject();
			comment = Utility.decodeHtml(c.getComment());
		} else if (action.equals("addComment")
				&& resourceType == Resource.COMMENT) {
			markedResources.add(new Resource(resourceID, resourceType));
		} else if (action.equals("commentMarked")) {
			markedResources = (Vector) request.getSession().getAttribute(
					"commenting.markedResources");
		}
	%>

	<%
		if (action.equals("commentMarked") && markedResources.size() == 0) {
	%>
	<script type="text/javascript">
		self.close();
	</script>
	<%
		}
	%>

	<%
		if (context.getCurrentUser() == null
				&& !autoApproveAnonymousComments) {
	%>
	<div
		style="padding: 5px; background-color: #ffeeee; border-width: 1px; border-style: dotted; margin-right: 10%; margin-left: 10%; margin-top: 15px;">
		<fmt:message key="jsp.comment.label.anonymous.warning" />
	</div>

	<%
		}
	%>


	<%
		if (markedResources.size() > 0) {
	%>
	<div
		style='padding: 5px; background-color: #efefef; border-width: 1px; border-style: dotted; margin-right: 10%; margin-left: 10%; margin-top: 15px'>
		<div>
			<strong><fmt:message key="jsp.comment.label.commenting" />
			</strong>
		</div>
		<ul>

			<%
				for (int i = 0; i < markedResources.size(); i++) {
						Resource resource = (Resource) markedResources.get(i);
						if (resource.getType() == Resource.COMMENT) {
							Comment c = Comment.find(context, resource.getID());
			%>
			<li class='commentListItem'><span> <a
					href="javascript: return false;"
					onClick='javascript:showHideCommentBody(this)'> <strong>
							<%=c.getSubject()%> </strong> </a> </span> <%
 	if (markedResources.size() > 1) {
 %> <span> <a
					href="<%=request.getContextPath()%>/comment?action=unmarkResourceForm&ID=<%=c.getID()%>&type=<%=c.getType()%>&callerUrl=<%=request.getContextPath()%>/commenting/jsp/postCommentForm.jsp&resourceType=<%=resourceType%>&resourceID=<%=resourceID%>&windowOpener=<%=callerUrl%>">[Desmarcar]</a>
			</span> <%
 	}
 %> <br />
				<div class='commentBodyText'>
					<%=c.getComment()%>
				</div>
			</li>
			<%
				} else { // resource is not a comment
			%>
			<li class='commentListItem'><span> <strong> <%=resource.getDescription()%>
				</strong> </span> <%
 	if (markedResources.size() > 1) {
 %> <span> <a
					href="<%=request.getContextPath()%>/comment?action=unmarkResourceForm&ID=<%=resource.getID()%>&type=<%=resource.getType()%>&callerUrl=<%=request.getContextPath()%>/commenting/jsp/postCommentForm.jsp&resourceType=<%=resourceType%>&resourceID=<%=resourceID%>&windowOpener=<%=callerUrl%>">[Desmarcar]</a>
			</span> <%
 	}
 %>
			</li>
			<%
				}
					}
			%>
		</ul>
	</div>


	<%
		}
	%>




	<form name="commentForm" method="post"
		onSubmit="javascript: return false;">


		<table style="border-width: 0px; width: 80%" align="center"
			class="commentForm">
			<tr>
				<td align="left"><strong><fmt:message
							key="jsp.comment.label.commenter" /> </strong> <%
 	if ((context.getCurrentUser() != null)) {
 		out.print(context.getCurrentUser().getFullName());
 	} else {
 %><fmt:message key="jsp.comment.label.anonymous" /> <%
 	}
 %>
				</td>
			</tr>

			<tr>
				<td align="left"><strong><fmt:message
							key="jsp.comment.label.subject" /> </strong><br> <input
					name="subject" type="text" size="75" style="width: 100%"
					value="<%=subject%>">
				</td>
			</tr>
			<tr>
				<td align="left"><strong><fmt:message
							key="jsp.comment.label.comment" />: </strong><br> <textarea
						style="border-style: solid; border-width: 1px; width: 100%;"
						id="comment_textarea" name="comment" rows="12" cols="70"><%=comment%></textarea>
				</td>
			</tr>
			<tr>
				<td>
					<div align="right">
						<input name="addComment" type="button"
							value='<fmt:message key="jsp.comment.label.submit"/>'
							onclick="Javascript: return sendData();">
					</div>
				</td>
			</tr>
		</table>

		<input type="hidden" name="callerUrl" value="<%=callerUrl%>">
		<input type="hidden" name="resourceType" value="<%=resourceType%>">
		<input type="hidden" name="resourceID" value="<%=resourceID%>">
		<input type="hidden" name="action" value="<%=action%>">

	</form>

</body>
</html>

<%
	context.complete();
%>

