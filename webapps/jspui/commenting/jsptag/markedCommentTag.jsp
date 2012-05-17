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
<%@ page language="java" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ page import="org.dspace.app.webui.util.UIUtil" %>
<%@ page import="org.dspace.core.Context" %>
<%@ page import="org.dspace.core.Constants" %>
<%@ page import="pt.uminho.dsi.commenting.comment.Comment" %>
<%@ page import="pt.uminho.dsi.resource.Resource" %>
<%@ page errorPage="/internal-error" %>


<%
	/** Global properties **/
	Context context = UIUtil.obtainContext(request);
	Resource[] markedResources = (Resource[])request.getAttribute("commenting.markedResources");
	String callerUrl = (String)session.getAttribute("commenting.callerUrl");
	Integer resourceID = (Integer)session.getAttribute("commenting.resourceID");
	Integer resourceType = (Integer)session.getAttribute("commenting.resourceType");
	
%>

<%

	if (markedResources.length == 0)  
		return;

%>

		<div class='commentMarkedResourcesFloat'>
			<div class='commentMarkedResourcesTitle'>
				<%= markedResources.length%> <fmt:message key="jsp.comment.label.resources.marked"/>
			</div>
			<ul style='margin-left:0px;padding-left:1em'>
		
<%	
	    for (int i=0; i<markedResources.length; i++) {
	    	
	    	Resource resource = markedResources[i];
%>	    	

<%
			if(resource.getType() == Resource.COMMENT) { 
				Comment comment = (Comment)resource.getResource();
%>
				<li class='commentListItem'>
					<span>
						<a href="javascript: void(null);" onClick='javascript:showHideCommentBody(this)'>
							<strong>
								<%= comment.getSubject() %> 
							</strong>
						</a>
					</span>
					
					<br/>
					<div class="commentBodyText">
						<%-- Actions --%>
						<div style='background-color: #dddddd;'>
							<a href="<%= request.getContextPath() %>/comment?callerUrl=<%= callerUrl %>&action=unmarkResource&resourceID=<%= resource.getID() %>&resourceType=<%= resource.getType() %>">
								<fmt:message key="jsp.comment.label.unmark" />
							</a>
						</div>
						<%-- Comment Body --%>
						<div>
							<%= comment.getComment() %>
						</div>
					</div>
				</li>
<%
		} else { // not a comment
%>				
					<li class='commentListItem'>
					<span>
						<a href="javascript: void(null);" onClick='javascript:showHideCommentBody(this)'>
							<strong>
								<%= resource.getDescription() %> 
							</strong>
						</a>
					</span>
					
					<br/>
					<div class="commentBodyText">
						<%-- Actions --%>
						<div style='background-color: #dddddd;'>
							<a href="<%= request.getContextPath() %>/comment?callerUrl=<%= callerUrl %>&action=unmarkResource&resourceID=<%= resource.getID() %>&resourceType=<%= resource.getType() %>">
								<fmt:message key="jsp.comment.label.unmark" />
							</a>
						</div>
					</div>
				</li>
<%
		}
	}
%>		
			</ul>
<% 
		if(context.getCurrentUser() != null) {	// only allow replying if user is logged in	
%>
			<div class='commentMarkedEntities'>
				<%-- comment all marked link --%>
				<a href="javascript:popUp('<%= request.getContextPath() %>/commenting/jsp/postCommentForm.jsp?action=commentMarked&callerUrl=<%= callerUrl %>&resourceID=<%= resourceID %>&resourceType=<%= resourceType %>')">
					<fmt:message key="jsp.comment.label.resources.marked.reply" />
				</a>
			</div>  
<%
		}
%>		
		
		</div>
		<br/>
