
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
<%@ page import="pt.uminho.dsi.util.Utility"%>
<%@ page import="java.util.*"%>
<%@ page import="org.dspace.app.webui.util.UIUtil"%>
<%@ page import="org.dspace.core.Context"%>
<%@ page import="pt.uminho.dsi.resource.Resource"%>

<%@ page errorPage="/internal-error"%>

<%-- 
// debug code
// Display Session Variables


Enumeration enum = request.getSession().getAttributeNames();
while(enum.hasMoreElements()) {
	String name = (String)enum.nextElement();
	String value = request.getSession().getAttribute(name).toString();
	out.write( name + " = " + value + "<br/>");
}
--%>


<form name="hiddenForm" method="post"
	action="<%=request.getContextPath()%>/comment">
	<input type="hidden" name="callerUrl" value=""> <input
		type="hidden" name="resourceType" value=""> <input
		type="hidden" name="resourceID" value=""> <input type="hidden"
		name="action" value=""> <input type="hidden" name="comment"
		value=""> <input type="hidden" name="subject" value="">
</form>



<div class='commentMainFloat'>
	<%
		/** global properties **/

		Vector markedResources = (Vector) session
				.getAttribute("commenting.markedResources");
		if (markedResources == null)
			markedResources = new Vector();
		String callerUrl = (String) session
				.getAttribute("commenting.callerUrl");
		Integer resourceID = (Integer) session
				.getAttribute("commenting.resourceID");
		Integer resourceType = (Integer) session
				.getAttribute("commenting.resourceType");
		Context context = UIUtil.obtainContext(request);
	%>




	<div class='commentEntity'>
		<%-- Comment this document --%>
		<a
			href="javascript:popUp('<%=request.getContextPath()%>/commenting/jsp/postCommentForm.jsp?action=addComment&callerUrl=<%=callerUrl%>&resourceID=<%=resourceID%>&resourceType=<%=resourceType%>')">
			<fmt:message key="jsp.comment.label.comment" /></a>

		<%
			if (!Resource.isResourceMarked(resourceID.intValue(),
					resourceType.intValue(), markedResources)) {
		%>
		<%-- Mark comment --%>
		<a
			href="<%=request.getContextPath()%>/comment?action=markResource&resourceID=<%=resourceID%>&resourceType=<%=resourceType%>&callerUrl=<%=callerUrl%>"><fmt:message
				key="jsp.comment.label.mark" /></a>
		<%
			} else {
		%>
		<%-- Unmark comment link--%>
		<a
			href="<%=request.getContextPath()%>/comment?action=unmarkResource&resourceID=<%=resourceID%>&resourceType=<%=resourceType%>&callerUrl=<%=callerUrl%>"><fmt:message
				key="jsp.comment.label.unmark" /></a>
		<%
			}
		%>



		<%-- Web of Communication --%>
		<%--
	if(resourceType.intValue() == Resource.ITEM || 
		resourceType.intValue() == Resource.EPERSON || 
		resourceType.intValue() == Resource.COMMENT) {
--%>
		<!-- a href="<%--= request.getContextPath() --%>/webcommunication?action=webcommunication&resourceID=<%--= resourceID %>&resourceType=<%= resourceType --%>"><%--= showWebCommunicationLabel --%></a-->
		<%--
	}
--%>



		<%-- Reply to marked comments --%>
		<%
			if (markedResources.size() > 0 && context.getCurrentUser() != null) {
		%>
		<a
			href="javascript:popUp('<%=request.getContextPath()%>/commenting/jsp/postCommentForm.jsp?action=commentMarked&callerUrl=<%=callerUrl%>&resourceID=<%=resourceID%>&resourceType=<%=resourceType%>')"><fmt:message
				key="jsp.comment.label.comment.marked" /></a>
		<%
			}
		%>
	</div>
	<br />


	<%-- List thread of comments --%>
	<%
		Comment[] comments = (Comment[]) request
				.getAttribute("commenting.comments");
		if (comments != null && comments.length > 0) {
	%>

	<div class='commentThreadFloat'>

		<div class="commentThreadTitle">
			<strong><fmt:message key="jsp.comment.label.comments" /></strong>
		</div>

		<ul>
			<%
				for (int i = 0; i < comments.length; i++) {
						Comment comment = comments[i];
						out.write(comment.toHtml(callerUrl, true, true,
								markedResources, request));
					}
			%>
		</ul>
	</div>


	<%
		}
	%>


</div>


