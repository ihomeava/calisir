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

<%@ page import="pt.uminho.dsi.commenting.comment.*" %>
<%@ page errorPage="/internal-error" %>

<%
%>

<%
	/** Global properties **/
	Comment[] myComments = (Comment[])session.getAttribute("commenting.myComments");
	if(myComments.length == 0) return;
%>

<% if(myComments.length > 0 ) { %>
<H2><fmt:message key="jsp.comment.label.comment.submited" /></H2>
<% } %>

<div style='margin-left:50px'>
<%
	for(int i=0; i<myComments.length; i++) {
		Comment myComment = myComments[i];
		out.write(myComment.toHtmlSimple(request));
	}
%>	
</div>