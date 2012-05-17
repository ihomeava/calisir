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

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page import="pt.uminho.dsi.commenting.comment.*" %>
<%@ page errorPage="/internal-error" %>

<%
	/** Global properties **/
	Comment[] relevantComments = (Comment[])session.getAttribute("commenting.relevantComments");
%>

<%
	if (relevantComments.length > 0) {
%>

	  <div class='relevantCommentThreadFloat'>

			<div class='relevantCommentThreadTitle'>
				<fmt:message key="jsp.comment.label.relevant.most"/>
			</div>
		
			<ul>
			<%	
				    for (int i=0; i<relevantComments.length; i++) {
				    	  Comment c = relevantComments[i];
				    	  out.write(c.toHtmlSimple(request));
				     }
			%>	    	
		</ul>
	</div>
<%		
	}
%>

