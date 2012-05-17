<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Default navigation bar
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="/WEB-INF/dspace-tags.tld" prefix="dspace" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>
<%@ page import="org.dspace.content.Collection" %>
<%@ page import="org.dspace.content.Community" %>
<%@ page import="org.dspace.eperson.EPerson" %>
<%@ page import="org.dspace.core.ConfigurationManager" %>
<%@ page import="org.dspace.browse.BrowseIndex" %>
<%@ page import="org.dspace.browse.BrowseInfo" %>
<%@ page import="java.util.Map" %>
<%
    // Is anyone logged in?
    EPerson user = (EPerson) request.getAttribute("dspace.current.user");

    // Is the logged in user an admin
    Boolean admin = (Boolean)request.getAttribute("is.admin");
    boolean isAdmin = (admin == null ? false : admin.booleanValue());

    // Get the current page, minus query string
    String currentPage = UIUtil.getOriginalURL(request);
    int c = currentPage.indexOf( '?' );
    if( c > -1 )
    {
        currentPage = currentPage.substring( 0, c );
    }
    
    // get the browse indices
    
	BrowseIndex[] bis = BrowseIndex.getBrowseIndices();
    BrowseInfo binfo = (BrowseInfo) request.getAttribute("browse.info");
    String browseCurrent = "";
    if (binfo != null)
    {
        BrowseIndex bix = binfo.getBrowseIndex();
        // Only highlight the current browse, only if it is a metadata index,
        // or the selected sort option is the default for the index
        if (bix.isMetadataIndex() || bix.getSortOption() == binfo.getSortOption())
        {
            if (bix.getName() != null)
    			browseCurrent = bix.getName();
        }
    }
%>

<%-- delete by xmu 2012.03.25 --%>

<%-- delete by weicf 2012.03.28 --%>

<%-- delete by xmu 2012.03.25 --%>

<form name="solrForm" method="get" action="<%= request.getContextPath() %>/solr-search">
  <table width="100%" class="searchBox">
    <tr>
      <td>
        <table width="100%" border="0" cellspacing="0" >
          <tr>
            <td class="searchBoxLabel"><label for="tequery"><fmt:message key="jsp.layout.navbar-default.search"/></label></td>
          </tr>
          <tr>
            <td class="searchBoxLabelSmall" valign="middle" nowrap="nowrap">
              <input type="text" name="q" id="tequery" class="input" size="20"/>
              <label class="label" id="for-tequery" for="tequery" style="display: block;"><fmt:message key="jsp.general.search.button"/></label>
              <span onclick="return formSubmit('solrForm');" class="submit"><fmt:message key="jsp.general.search.button"/></span>
            </td>
          </tr>
        </table>
        <br/>
      </td>
    </tr>
  </table>
</form>

<%-- HACK: width, border, cellspacing, cellpadding: for non-CSS compliant Netscape, Mozilla browsers --%>
<table width="200px" border="0" cellspacing="2" cellpadding="2" style="padding-left: 30px;">

  <tr>
    <td nowrap="nowrap" colspan="2" class="navigationBarSublabel"><div><fmt:message key="jsp.layout.navbar-default.browse"/></div></td>
  </tr>

  <tr class="navigationBarItem">
    <td>
      <img alt="" src="<%= request.getContextPath() %>/image/<%= ( currentPage.endsWith( "/community-list" ) ? "arrow-highlight" : "icon-arrow-home-menu" ) %>.gif" width="16" height="16"/>
    </td>
    <td nowrap="nowrap" class="navigationBarItem">
      <a href="<%= request.getContextPath() %>/community-list"><fmt:message key="jsp.layout.navbar-default.communities-collections"/></a>
    </td>
  </tr>


<%-- Insert the dynamic browse indices here --%>

<%
	for (int i = 0; i < bis.length; i++)
	{
		BrowseIndex bix = bis[i];
		String key = "browse.menu." + bix.getName();
	%>
		<tr class="navigationBarItem">
    		<td>
      			<img alt="" src="<%= request.getContextPath() %>/image/<%= ( browseCurrent.equals(bix.getName()) ? "arrow-highlight" : "icon-arrow-home-menu" ) %>.gif" width="16" height="16"/>
    		</td>
    		<td nowrap="nowrap" class="navigationBarItem">
      			<a href="<%= request.getContextPath() %>/browse?type=<%= bix.getName() %>"><fmt:message key="<%= key %>"/></a>
    		</td>
  		</tr>
	<%	
	}
%>

<%-- End of dynamic browse indices --%>

  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>

  <tr>
    <td nowrap="nowrap" colspan="2" class="navigationBarSublabel"><div><fmt:message key="jsp.layout.navbar-default.sign"/></div></td>
  </tr>

  <tr class="navigationBarItem">
    <td>
      <img alt="" src="<%= request.getContextPath() %>/image/<%= ( currentPage.endsWith( "/subscribe" ) ? "arrow-highlight" : "icon-arrow-home-menu" ) %>.gif" width="16" height="16"/>
    </td>
    <td nowrap="nowrap" class="navigationBarItem">
      <a href="<%= request.getContextPath() %>/subscribe"><fmt:message key="jsp.layout.navbar-default.receive"/></a>
    </td>
  </tr>

  <tr class="navigationBarItem">
    <td>
      <img alt="" src="<%= request.getContextPath() %>/image/<%= ( currentPage.endsWith( "/mydspace" ) ? "arrow-highlight" : "icon-arrow-home-menu" ) %>.gif" width="16" height="16"/>
    </td>
    <td nowrap="nowrap" class="navigationBarItem">
      <a href="<%= request.getContextPath() %>/mydspace"><fmt:message key="jsp.layout.navbar-default.users"/></a><br/>
      <fmt:message key="jsp.layout.navbar-default.users-authorized" />
    </td>
  </tr>

  <tr class="navigationBarItem">
    <td>
      <img alt="" src="<%= request.getContextPath() %>/image/<%= ( currentPage.endsWith( "/profile" ) ? "arrow-highlight" : "icon-arrow-home-menu" ) %>.gif" width="16" height="16"/>
    </td>
    <td nowrap="nowrap" class="navigationBarItem">
      <a href="<%= request.getContextPath() %>/profile"><fmt:message key="jsp.layout.navbar-default.edit"/></a>
    </td>
  </tr>

<%
  if (isAdmin)
  {
%>  
  <tr class="navigationBarItem">
    <td>
      <img alt="" src="<%= request.getContextPath() %>/image/<%= ( currentPage.endsWith( "/dspace-admin" ) ? "arrow-highlight" : "icon-arrow-home-menu" ) %>.gif" width="16" height="16"/>
    </td>
    <td nowrap="nowrap" class="navigationBarItem">
      <a href="<%= request.getContextPath() %>/dspace-admin"><fmt:message key="jsp.administer"/></a>
    </td>
  </tr>
<%
  }
%>

  <tr>
    <td colspan="2">&nbsp;</td>
  </tr>

  <tr class="navigationBarItem">
    <td>
      <img alt="" src="<%= request.getContextPath() %>/image/<%= ( currentPage.endsWith( "/help" ) ? "arrow-highlight" : "icon-arrow-home-menu" ) %>.gif" width="16" height="16"/>
    </td>
    <td nowrap="nowrap" class="navigationBarItem">
            <dspace:popup page="<%= LocaleSupport.getLocalizedMessage(pageContext, \"help.index\")%>"><fmt:message key="jsp.layout.navbar-default.help"/></dspace:popup>
    </td>
  </tr>
</table>

<script type="text/javascript">
	var $ = function(id){return document.getElementById(id);}
	var formSubmit = function(id) {
		document.forms[id].submit();
		return false;
	}
	var tip = function(q, for_q) {
		q = $(q);
		for_q = $(for_q);
		q.onfocus = function() {
			for_q.style.display = 'none';
			q.style.backgroundPosition = "right -17px";
		}
		q.onblur = function() {
			if (!this.value)
				for_q.style.display = 'block';
			q.style.backgroundPosition = "right 0";
		}
		for_q.onclick = function() {
			this.style.display = 'none';
			q.focus();
		}
	};
	tip('tequery', 'for-tequery');
</script>