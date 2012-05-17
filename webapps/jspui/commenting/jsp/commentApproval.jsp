
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
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page errorPage="/internal-error"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace"%>

<%@ page import="pt.uminho.dsi.commenting.comment.Comment"%>
<%@ page import="org.dspace.eperson.EPerson"%>

<%
	/** Properties **/
	Boolean approvedStatusChanged = (Boolean) session
			.getAttribute("commenting.approvedStatusChanged");

	Comment comment = (Comment) session
			.getAttribute("commenting.comment");
	EPerson approver = (EPerson) session
			.getAttribute("commenting.approver");
	Comment[] parentComments = (Comment[]) session
			.getAttribute("commenting.parentComments");

%>

<dspace:layout locbar="nolink" title="">

	<%
		
	%>


	<%
		if (parentComments.length > 0) {
	%>
	<br />
	<div
		style="font-size: 8pt; padding: 5px; margin-right: 10%; margin-left: 10%; margin-top: 15px;">
		<fmt:message key="jsp.comment.label.replyingto" />

	</div>
	<%
		}
	%>
	<%
		for (int i = 0; i < parentComments.length; i++) {
	%>
	<div
		style="font-size: 8pt; padding: 5px; background-color: #fffefe; border-width: 1px; border-style: dotted; margin-right: 10%; margin-left: 10%; margin-top: 15px">
		<strong> <fmt:message key="jsp.comment.label.subject" /> </strong>
		<%=parentComments[i].getSubject()%>
		<br /> <strong> <fmt:message key="jsp.comment.label.date" />
		</strong>
		<%=parentComments[i].getLastModifiedAsString(true,
							request)%>
		<br /> <strong> <fmt:message
				key="jsp.comment.label.commenter" /> </strong>
		<%=parentComments[i].getCommenterFullName()%>
		<br /> <strong> <fmt:message key="jsp.comment.label.comment" />:
		</strong> <br />
		<%=parentComments[i].getComment()%>
		<br /> <br />
	</div>
	<%
		}
	%>

	<br />
	<div
		style="font-size: 8pt; padding: 5px; margin-right: 10%; margin-left: 10%; margin-top: 15px;">
		<fmt:message key="jsp.comment.label.submitted" />

	</div>
	<div
		style="font-size: 8pt; padding: 5px; background-color: #ffeeee; border-width: 1px; border-style: dotted; margin-right: 10%; margin-left: 10%; margin-top: 15px">
		<strong> <fmt:message key="jsp.comment.label.subject" /> </strong>
		<%=comment.getSubject()%>
		<br /> <strong> <fmt:message key="jsp.comment.label.date" />
		</strong>
		<%=comment.getLastModifiedAsString(true, request)%>
		<br /> <strong> <fmt:message
				key="jsp.comment.label.commenter" /> </strong>
		<%=comment.getCommenterFullName()%>
		<br /> <strong> <fmt:message key="jsp.comment.label.comment" />:</strong>
		<br />
		<%=comment.getComment()%>
		<br /> <br />
	</div>

	<div
		style="text-align: center; font-size: 8pt; padding: 5px; border-width: 0px; border-style: dotted; margin-right: 10%; margin-left: 10%; margin-top: 15px">
		<%
			if (comment.getApprover() != null
						|| (approvedStatusChanged != null && !approvedStatusChanged
								.booleanValue())) {
		%>
		<fmt:message key="jsp.comment.label.comment.submitted.already" />
		<strong>
			<%
				if (comment.isApproved()) {
			%> <fmt:message
				key="jsp.comment.label.approved" /> <%
 	} else {
 %><fmt:message
				key="jsp.comment.label.disapproved" />
			<%
				}
			%>
		</strong>.
		<%
			} else if (approvedStatusChanged != null
						&& approvedStatusChanged.booleanValue()) {
		%>
		<fmt:message key="jsp.comment.label.comment.was" />
		<strong> <%
 	if (comment.isApproved()) {
 %> <fmt:message
				key="jsp.comment.label.approved" /> <%
 	} else {
 %><fmt:message
				key="jsp.comment.label.disapproved" /> <%
 	}
 %>
		</strong> (<%=approver.getFullName()%>).
		<%
			} else {
		%>
		<input
			onclick="javascript: location='<%=request.getContextPath()%>/commentApproval?action=approveComment&ID=<%=comment.getID()%>'"
			type='button' name='approveComment' value='<fmt:message key="jsp.comment.label.approve"/>' /> <input
			onclick="javascript: location='<%=request.getContextPath()%>/commentApproval?action=reproveComment&ID=<%=comment.getID()%>'"
			type='button' name='approveComment' value='<fmt:message key="jsp.comment.label.disapprove"/>' />
		<%
			}
		%>
	</div>

	<br>
	<br>

	<%@ taglib uri="http://www.dspace.org/commenting-tags.tld"
		prefix="papadocs"%>
	<papadocs:unrevisedCommentTag excludeCommentID="<%= comment.getID() %>" />

</dspace:layout>

<%
	// to avoid colateral damages
	session.setAttribute("commenting.comment", null);
	session.setAttribute("commenting.approver", null);
	session.setAttribute("commenting.approvedStatusChanged", null);
%>

