<%--
/**
*
* add by weicf
*
**/
--%>
<%--
  - Favorite form JSP
  -
  - Attributes:
  -    favorite.problem  - if present, report that all fields weren't filled out
  -    favorite.title - item title
  -    authenticated.email - email of authenticated user, if any
  -    eperson.name - name of favorite eperson
  --%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.commons.lang.StringEscapeUtils" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%
	request.setCharacterEncoding("UTF-8");

    boolean problem = (request.getAttribute("favorite.problem") != null);

    String handle = request.getParameter("handle");
    if (handle == null || handle.equals(""))
    {
        handle = "";
    }
    
    String resourceID = request.getParameter("resourceID");
    if (resourceID == null || resourceID.equals(""))
    {
    	resourceID = "";
    }

	String title = (String) request.getAttribute("favorite.title");
	if (title == null)
	{
		title = "";
	}

    String note = request.getParameter("note");
    if (note == null)
    {
    	note = "";
    }
%>

<dspace:layout locbar="off" navbar="off" titlekey="jsp.favorite.title">

<br/>
<h1><fmt:message key="jsp.favorite.heading"/>
    <a href="<%= request.getContextPath() %>/handle/<%= handle %>"><%= title %></a>
</h1>
<p><fmt:message key="jsp.favorite.invitation"/></p>

    <form name="form1" method="post" action="">
        <center>
            <table>
<%
    if (problem)
    {
%>
        		<tr>
            		<td class="submitFormWarn"><fmt:message key="jsp.favorite.warning"/></td>
        		</tr>
<%
    }
%>
				<tr>
                <tr>
                    <td class="submitFormLabel"><fmt:message key="jsp.favorite.note"/></td>
                    <td><textarea name="note" rows="6" cols="46"><%=StringEscapeUtils.escapeHtml(note)%></textarea></td>
                </tr>

                <tr>
                    <td colspan="2" align="center">
                    <input type="hidden" name="handle" value='<%= handle %>'/>
                    <input type="hidden" name="resourceID" value='<%= resourceID %>'/>
                    <input type="submit" name="submit" value="<fmt:message key="jsp.favorite.button.send"/>" />
                    <input type="button" name="cancel" onclick="window.close();" value="<fmt:message key="jsp.favorite.button.cancel"/>" />
                    </td>
                </tr>
            </table>
        </center>
    </form>

</dspace:layout>
