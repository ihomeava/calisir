<%
/**
*
* add by weicf
* show all suggests of a suggester
*
**/
%> 
<%@ page language="java" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="edu.calis.ir.pku.components.*" %>
<%@ page errorPage="/internal-error" %>

<%
%>

<%
	/** Global properties **/
	Integer itemSuggestsStat = (Integer)session.getAttribute("suggest.itemSuggestsStat");
	if(itemSuggestsStat.intValue() == 0) return;
%>

<style type="text/css">
.diggit {
    background: url("<%=request.getContextPath() %>/suggest/image/upup.gif") no-repeat scroll 0 0 transparent;
    height: 52px;
    margin-top: 2px;
    padding-top: 5px;
    text-align: center;
    width: 46px;
}
</style>

<div class="diggit"> 
	<span class="diggnum" id="digg_count"><%= itemSuggestsStat.intValue() %></span>
</div>