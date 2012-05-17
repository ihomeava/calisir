<%
/**
* add by weicf
* show all favorites of a favoriter
*
**/
%> 
<%@ page language="java" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ page import="edu.calis.ir.pku.components.*" %>
<%@ page errorPage="/internal-error" %>

<%
%>

<%
	/** Global properties **/
	Favorite[] myFavorites = (Favorite[])session.getAttribute("favorite.myFavorites");
	if(myFavorites.length == 0) return;
%>

<% if(myFavorites.length > 0 ) { %>
<H2><fmt:message key="jsp.favorite.submitted" /></H2>
<% } %>

<div style='margin-left:50px'>
<%
	for(int i=0; i<myFavorites.length; i++) {
		Favorite myFavorite = myFavorites[i];
		out.write(myFavorite.toHtmlSimple(request));
	}
%>	
</div>