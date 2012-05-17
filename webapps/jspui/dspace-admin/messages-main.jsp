<%--
  - messages-main.jsp
  - Description: 进行语言文件选择
  - Attributes: Pulipuli
  -
  --%>


<%--
  - Display list of Groups, with 'edit' and 'delete' buttons next to them
  -
  - Attributes:
  -
  -   groups - Group [] of groups to work on
  --%>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"
    prefix="fmt" %>


<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>
<%@ page import="org.dspace.core.Constants" %>

<%
try
{
    String submit_save = (String)request.getAttribute("submit_save");

    if (submit_save == null)
        submit_save = "false";

	String position = (String)request.getAttribute("position");	
	if (position == null)
		position = "";
	
	String defaultLanguage = (String)request.getAttribute("defaultLanguage");
	if (defaultLanguage == null)
		defaultLanguage = "";
	
	String defaultLanguageFilename = (String)request.getAttribute("defaultLanguageFilename");
	if (defaultLanguageFilename == null)
		defaultLanguageFilename = "";
	
	String[] messagesProperties = (String[])request.getAttribute("messagesProperties");
	if (messagesProperties == null)
		messagesProperties = new String[0];
%>

<dspace:layout titlekey ="jsp.dspace-admin.messages-main.title"
               navbar="admin"
               locbar="link"
               parenttitlekey="jsp.administer"
               parentlink="/dspace-admin"
               nocache="true">
    
  <table width="95%">
    <tr>
      <td align="left">
        <%-- <h1>News Editor</h1> --%>
        <h1>
			<fmt:message key="jsp.dspace-admin.messages-main.heading"/>
		</h1>
      </td>
      <td align="right" class="standard">
        <dspace:popup page="<%= LocaleSupport.getLocalizedMessage(pageContext, \"help.site-admin\") + \"#editmessages\" %>"><fmt:message key="jsp.help"/></dspace:popup>
      </td>
    </tr>
  </table>
<style type="text/css">
.help { font-size: smaller; font-weight:normal;}
</style>
<%
if ( submit_save.equals("true") && !position.equals("") )
{
	out.print("<div>"
		+position
		+LocaleSupport.getLocalizedMessage(pageContext
			, "jsp.dspace-admin.messages-main.submit_saved")
		+"</div>");
}
else if ( submit_save.equals("no") && position.equals("") )
{
	out.print("<div>"
		+LocaleSupport.getLocalizedMessage(pageContext
			, "jsp.dspace-admin.messages-main.submit_cancel")
		+position
		+"</div>");
}
%>
	<h2>
		<fmt:message key="jsp.dspace-admin.messages-main.default.language"/>
		<%
			out.print(defaultLanguage);
		%>
	</h2>
	
	
	<div class="help">
		<fmt:message key="jsp.dspace-admin.messages-main.change-default-language"/>
	</div>
 <form action="<%= request.getContextPath() %>/dspace-admin/messages-edit" method="post">
    <table class="miscTable" align="center" width="60%">
            <tr>
				<th id="t2" class="evenRowOddCol" width="30%">
					<label for="position">
						<fmt:message key="jsp.dspace-admin.messages-main.edit"/>
					</label>
				</th>
                <td headers="t2" class="evenRowEvenCol">
					<select name="position" id="position">
						<%
					try
					{
						String active = LocaleSupport.getLocalizedMessage(pageContext
				, "jsp.dspace-admin.messages-main.lang-active");
						String filename = "Messages.properties";
						if (!defaultLanguage.equals("en") && !defaultLanguage.equals("en_US"))
							filename = "Messages_"+defaultLanguage+".properties";
						for (int i = 0; i < messagesProperties.length; i++)
						{
							if (messagesProperties[i] == null)
								continue;
							String lang = messagesProperties[i];

							if (lang.equals(filename))
								out.println("<option value=\""+lang+"\" selected=\"true\">"+lang+" ("+active+")</option>");
							else
								out.println("<option value=\""+lang+"\">"+lang+"</option>");
						}
					}
					catch (Exception e) { e.printStackTrace(); }
						%>
					</select>
					<input type="hidden" name="submit_action" value="submit_edit" />
                    <input type="submit" value="<fmt:message key="jsp.dspace-admin.general.edit"/>" />
                </td>
			</tr>
    </table>
  </form>

	<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
	<script type="text/javascript">
	<!--
	function checkCreate(thisForm)
	{
		if (thisForm.filename.value == '') 
		{ 
			alert('<%=LocaleSupport.getLocalizedMessage(pageContext
				, "jsp.dspace-admin.messages-main.lang-empty") %>');
			this.filename.focus();
			return false; 
		}
		
		var filename = "Messages" + "_" + thisForm.filename.value + ".properties";
		
		var opts = jQuery(thisForm.source).children("option");
		for (var i = 0; i < opts.length; i++)
		{
			var exsitFilename = opts.eq(i).attr("value");
			//alert([filename, exsitFilename]);
			if (exsitFilename == filename)
			{
				alert('<%=LocaleSupport.getLocalizedMessage(pageContext
				, "jsp.dspace-admin.messages-main.lang-collision") %>');
				return false;
			}
		}
		
		return true;
	}
	-->
	</script>
  </form>
</dspace:layout>
<%
}
catch (Exception e) { e.printStackTrace(); }
%>