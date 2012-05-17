<%--
  - Title: fileupload.jsp
  - Description: 上传图片文件和css文件
  - Attributes: xmu
  -
  --%>


<%--
  - Display list of Groups, with 'edit' and 'delete' buttons next to them
  -
  - Attributes:
  -
  -   groups - Group [] of groups to work on
  --%>

<%@ page contentType="text/html;charset=UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace"%>

<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport"%>
<%@ page import="org.dspace.core.Constants"%>

<%
	try {
		String result = (String) request.getAttribute("result");
%>

<dspace:layout titlekey="jsp.dspace-admin.messages-main.title"
	navbar="admin" locbar="link" parenttitlekey="jsp.administer"
	parentlink="/dspace-admin" nocache="true">

	<div>
		<h2><fmt:message key="jsp.layout.navbar-admin.uploadfiles" /></h2>
	</div>

	<%
		if (result != null) {
	%>
	<%=result%><br />
	<%
		}
	%>

	<form
		action="<%=request.getContextPath()%>/dspace-admin/fileupload?flag=image"
		method="post" enctype="multipart/form-data">
		<table width="90%" border="0" align="center">
			<caption>
				<fmt:message key="jsp.dspace-admin.fileupload.imgheading" />
			</caption>
			<tr>
				<td><fmt:message key="jsp.dspace-admin.fileupload.imgnote" /></td>
			</tr>
			<tr>
				<td><fmt:message key="jsp.dspace-admin.fileupload.imgselect" />
					<input name="upfile" type="file" size="50" /></td>
			</tr>
			<tr>
				<td align="center"><input name="submit" type="submit"
					value="<fmt:message key="jsp.dspace-admin.fileupload.submit"/>" />
					&nbsp;&nbsp; <input name="reset" type="reset"
					value='<fmt:message key="jsp.dspace-admin.fileupload.reset"/>' />
				</td>
			</tr>
		</table>
	</form>
	<p />
	<form
		action="<%=request.getContextPath()%>/dspace-admin/fileupload?flag=css"
		method="post" enctype="multipart/form-data">
		<table width="90%" border="0" align="center">
			<caption>
				<fmt:message key="jsp.dspace-admin.fileupload.cssheading" />
			</caption>
			<tr>
				<td><fmt:message key="jsp.dspace-admin.fileupload.cssnote" /></td>
			</tr>
			<tr>
				<td><fmt:message key="jsp.dspace-admin.fileupload.cssselect" />
					<input name="upfile" type="file" size="50" /></td>
			</tr>
			<tr>
				<td align="center"><input name="submit" type="submit"
					value="<fmt:message key="jsp.dspace-admin.fileupload.submit"/>" />
					&nbsp;&nbsp; <input name="reset" type="reset"
					value='<fmt:message key="jsp.dspace-admin.fileupload.reset"/>' />
				</td>
			</tr>
		</table>
	</form>
</dspace:layout>
<%
	} catch (Exception e) {
		e.printStackTrace();
	}
%>