
<%
	/**
	 * add by weicf
	 * show all suggests of a suggester
	 *
	 **/
%>
<%@ page language="java"%>
<%@ page contentType="text/html;charset=UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ page import="edu.calis.ir.pku.components.*"%>
<%@ page errorPage="/internal-error"%>

<%
	
%>

<%
	/** Global properties **/
	Suggest[] mySuggests = (Suggest[]) session
			.getAttribute("suggest.mySuggests");
	if (mySuggests.length == 0)
		return;
%>

<%
	if (mySuggests.length > 0) {
%>
<H2>
	<fmt:message key="jsp.suggest.submitted" />
</H2>
<%
	}
%>

<div style='margin-left: 50px'>
	<%
		for (int i = 0; i < mySuggests.length; i++) {
			Suggest mySuggest = mySuggests[i];
			out.write(mySuggest.toHtmlSimple(request));
		}
	%>
</div>