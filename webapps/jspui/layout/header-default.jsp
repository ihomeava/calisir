<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - HTML header for main home page
  --%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="org.dspace.app.webui.util.JSPManager" %>
<%@ page import="org.dspace.core.ConfigurationManager" %>
<%@ page import="org.dspace.app.util.Util" %>
<%@ page import="javax.servlet.jsp.jstl.core.*" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.*" %>

<%-- add by xmu 2012.03.25 --%>
<%@ page import="org.dspace.content.Community"%>
<%@ page import="org.dspace.core.Context"%>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>
<%@ page import="java.util.Locale"%>
<%@ page import="org.dspace.core.I18nUtil" %>
<%-- add by xmu --%>
<%-- add by weicf 2012.03.27 --%>
<%@ page import="org.dspace.eperson.EPerson" %>

<%
    String title = (String) request.getAttribute("dspace.layout.title");
    String navbar = (String) request.getAttribute("dspace.layout.navbar");
    boolean locbar = ((Boolean) request.getAttribute("dspace.layout.locbar")).booleanValue();

    String siteName = ConfigurationManager.getProperty("dspace.name");
    String feedRef = (String)request.getAttribute("dspace.layout.feedref");
    boolean osLink = ConfigurationManager.getBooleanProperty("websvc.opensearch.autolink");
    String osCtx = ConfigurationManager.getProperty("websvc.opensearch.svccontext");
    String osName = ConfigurationManager.getProperty("websvc.opensearch.shortname");
    List parts = (List)request.getAttribute("dspace.layout.linkparts");
    String extraHeadData = (String)request.getAttribute("dspace.layout.head");
    String dsVersion = Util.getSourceVersion();
    String generator = dsVersion == null ? "DSpace" : "DSpace "+dsVersion;
    
    // add by xmu 2012.03.25
    Locale[] supportedLocales = I18nUtil.getSupportedLocales();
    // add by xmu
    
    // add by weicf 2012.03.27
    // Is anyone logged in?
    EPerson user = (EPerson) request.getAttribute("dspace.current.user");

    // Is the logged in user an admin
    Boolean admin = (Boolean)request.getAttribute("is.admin");
    boolean isAdmin = (admin == null ? false : admin.booleanValue());

    // E-mail may have to be truncated
    String navbarEmail = null;
    String navbarNetid = null;

    if (user != null)
    {
        navbarEmail = user.getEmail();
        navbarNetid = user.getNetid();
        if (navbarEmail.length() > 18)
        {
            navbarEmail = navbarEmail.substring(0, 17) + "...";
        }
    }
    
    boolean isCALISSSO = false;
    if(request.getSession().getAttribute("calis.sso.login") != null){
    	isCALISSSO = (Boolean)request.getSession().getAttribute("calis.sso.login");
    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head>
        <title><%= siteName %>: <%= title %></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="Generator" content="<%= generator %>" />
        <link rel="stylesheet" href="<%= request.getContextPath() %>/styles.css" type="text/css" />
        <link rel="stylesheet" href="<%= request.getContextPath() %>/print.css" media="print" type="text/css" />
        <link rel="shortcut icon" href="<%= request.getContextPath() %>/favicon.ico" type="image/x-icon"/>
<%
    if (!"NONE".equals(feedRef))
    {
        for (int i = 0; i < parts.size(); i+= 3)
        {
%>
        <link rel="alternate" type="application/<%= (String)parts.get(i) %>" title="<%= (String)parts.get(i+1) %>" href="<%= request.getContextPath() %>/feed/<%= (String)parts.get(i+2) %>/<%= feedRef %>"/>
<%
        }
    }
    
    if (osLink)
    {
%>
        <link rel="search" type="application/opensearchdescription+xml" href="<%= request.getContextPath() %>/<%= osCtx %>description.xml" title="<%= osName %>"/>
<%
    }

    if (extraHeadData != null)
        { %>
<%= extraHeadData %>
<%
        }
%>
        
    <script type="text/javascript" src="<%= request.getContextPath() %>/utils.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/static/js/scriptaculous/prototype.js"> </script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/static/js/scriptaculous/effects.js"> </script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/static/js/scriptaculous/builder.js"> </script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/static/js/scriptaculous/controls.js"> </script>
    <script type="text/javascript" src="<%= request.getContextPath() %>/static/js/choice-support.js"> </script>
    
    <%-- add by weicf 2011.12.20 --%>
    <%-- addons specific includes --%> 
 	<link rel="stylesheet" href="<%= request.getContextPath() %>/commenting/css/commenting.css"/>		
 	<script type="text/javascript" src="<%= request.getContextPath() %>/commenting/javascript/commenting.js"></script>
	<%-- addons specific includes --%>
	<%-- add by weicf --%>
	
	<%-- add by xmu 2012.03.25 --%>
	<script type="text/javascript" src="<%= request.getContextPath() %>/rssajax.js"> </script>
	<%-- add by xmu --%>
	
	<%-- add by weicf 2012.04.18 --%>
	<script type="text/javascript">
	function logout(){
		if(<%=isCALISSSO %>){
			alert('<fmt:message key="jsp.layout.navbar-default.logout.msg"/>');
		}
		window.location.href = "<%= request.getContextPath() %>/logout";
	}
	</script>
	<%-- add by weicf --%>
	
    </head>

    <%-- HACK: leftmargin, topmargin: for non-CSS compliant Microsoft IE browser --%>
    <%-- HACK: marginwidth, marginheight: for non-CSS compliant Netscape browser --%>
    <body>

        <%-- DSpace top-of-page banner --%>
        <%-- HACK: width, border, cellspacing, cellpadding: for non-CSS compliant Netscape, Mozilla browsers --%>
        <table class="pageBanner" width="80%" border="0" cellpadding="0" cellspacing="0">

            <%-- DSpace logo --%>
            <tr>
                <td>
                	<%-- add by xmu 2012.03.25 --%>
                    <a href="<%= request.getContextPath() %>/"><img src="<%= request.getContextPath() %>/image/ir-logo.jpg" alt="<fmt:message key="jsp.layout.header-default.alt"/>" height="79" border="0"/></a>
                    <%-- add by xmu --%>
                </td>
			<%-- add by xmu 2012.03.25 --%>
			<td nowrap="nowrap" valign="top" align="right">
				<%-- 语种选择 --%> 
			<%
 				if (supportedLocales != null && supportedLocales.length > 1) {
 			%>
				<form method="get" name="repost" action="">
					<input type="hidden" name="locale" />
				</form> 
			<%
 				for (int i = supportedLocales.length - 1; i >= 0; i--) {
 			%> 
 				<a class="langChangeOn"
				onclick="javascript:document.repost.locale.value='<%=supportedLocales[i].toString()%>';
	                  document.repost.submit();"><%=supportedLocales[i].getDisplayLanguage(supportedLocales[i])%> </a> &nbsp; 
	        <%
	        		}
 				}
 			%>
 			<br/>
 			<br/>
 			<%-- Lonin Information --%>
 			<%
			    if (user != null)
			    {
			%>
			  <p class="loggedIn"><fmt:message key="jsp.layout.navbar-default.loggedin">
			      <fmt:param><%= navbarEmail %></fmt:param>
			  </fmt:message>
			    (<a onclick="logout()" href="javascript:void(0);"><fmt:message key="jsp.layout.navbar-default.logout"/></a>)
			<%
				if (navbarNetid != null && !navbarNetid.equals("")){
					out.print("<br/>SSO(Netid) " + navbarNetid);
				}
			%>
			  </p>
			<%
			    }
			%>
			</td>
			<%-- add by xmu --%>
		</tr>
            
		<tr class="stripe"> <%-- Blue stripe --%>
            <td colspan="2">
				<div style="float:right;margin-bottom: 5px;">
					| <a href="<%=request.getContextPath()%>/subscribe"><fmt:message
							key="jsp.layout.navbar-default.receive" />
					</a> | <a href="<%=request.getContextPath()%>/mydspace"><fmt:message
							key="jsp.layout.navbar-default.users" />
					</a>
					| <a href="<%=request.getContextPath()%>/profile"><fmt:message
							key="jsp.layout.navbar-default.edit" />
					</a>
					<%
						if (isAdmin) {
					%>
					| <a href="<%=request.getContextPath()%>/dspace-admin"><fmt:message
							key="jsp.administer" />
					</a>
					<%
						}
					%>
					|
					<dspace:popup page="<%= LocaleSupport.getLocalizedMessage(pageContext, \"help.index\")%>"><fmt:message key="jsp.layout.navbar-default.help" /></dspace:popup>
				</div>
			</td>
        </tr>
			
		</table>

        <%-- Localization --%>
<%--  <c:if test="${param.locale != null}">--%>
<%--   <fmt:setLocale value="${param.locale}" scope="session" /> --%>
<%-- </c:if> --%>
<%--        <fmt:setBundle basename="Messages" scope="session"/> --%>

        <%-- Page contents --%>

        <%-- HACK: width, border, cellspacing, cellpadding: for non-CSS compliant Netscape, Mozilla browsers --%>
        <table class="centralPane" width="80%" border="0" cellpadding="0" cellspacing="0">

            <%-- HACK: valign: for non-CSS compliant Netscape browser --%>
            <tr valign="top">

            <%-- Navigation bar --%>
<%
    if (!navbar.equals("off"))
    {
%>
            <td class="navigationBar">
                <dspace:include page="<%= navbar %>" />
            </td>
<%
    }
%>
            <%-- Page Content --%>

            <%-- HACK: width specified here for non-CSS compliant Netscape 4.x --%>
            <%-- HACK: Width shouldn't really be 100%, but omitting this means --%>
            <%--       navigation bar gets far too wide on certain pages --%>
            <td class="pageContents" width="100%">

                <%-- Location bar --%>
<%
    if (locbar)
    {
%>
                <dspace:include page="/layout/location-bar.jsp" />
<%
    }
%>
