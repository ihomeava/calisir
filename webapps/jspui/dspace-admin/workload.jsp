<%@ page contentType="text/html;charset=UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace"%>

<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport"%>
<%@ page import="org.dspace.core.Constants"%>
<%@ page import="org.dspace.eperson.EPerson" %>

<%
	EPerson user = (EPerson) request.getAttribute("dspace.current.user");
%>

<script src="../jquery-1.6.4.min.js" charset="utf-8"></script>
<script src="../jquery.json-2.3.min.js" charset="utf-8"></script>
<script type="text/javascript">
	function go() {
		var email = $('#submitter_email').val();
		if (email == ''	|| !isEmail(email)) {
			alert('<fmt:message key="jsp.dspace-admin.workload.email.msg"/>');
			return;
		}
		$.ajaxSetup({
			cache : false
		});
		
		$
				.getJSON(
						"<%=request.getContextPath()%>/dspace-admin/workload",
						{
							email : email
						},
						
						function(json) {
							if (json.msg) {
								var fullName = "";
								if(!json.eperson){
									email = '<fmt:message key="jsp.dspace-admin.workload.eperson"/>';
								}else{
									fullName = ", <b>" + json.fullname + "</b>";
								}
								$('#p_total').html('<font color="blue">' + email + '</font> ' + fullName + ' <fmt:message key="jsp.dspace-admin.workload.total"/> <font color="red"><strong>' + json.total + '</strong></font> <fmt:message key="jsp.dspace-admin.workload.list"/>');
								var list = json.list;
								var html = '<tr><th width="50%" align="center"><fmt:message key="jsp.dspace-admin.workload.month"/></th><th width="50%" align="center"><fmt:message key="jsp.dspace-admin.workload.number"/></th></tr>';
								$.each(list, function(i) {
									html += '<tr>';
									html += '<td width="50%" align="center">' + list[i][1] + '</td>';		
									html += '<td width="50%" align="center">' + list[i][0] + '</td>';
									html += '</tr>';
								});
								$('#t_workload').empty();
								$('#t_workload').append(html);
								$('#img_chart')[0].style.display = "block";
								$('#img_chart')[0].src = "<%=request.getContextPath()%>/DisplayChart?filename="	+ json.filename;
							}
						});
	}

	function isEmail(str) {
		var regex = /^[\w\-\.]+@[\w\-\.]+(\.\w+)+$/;
		if (regex.test(str)) {
			return true;
		} else {
			return false;
		}
	}
</script>

<dspace:layout titlekey="jsp.dspace-admin.messages-main.title"
	navbar="admin" locbar="link" parenttitlekey="jsp.administer"
	parentlink="/dspace-admin" nocache="true">

	<div align="center">
		<h2><fmt:message key="jsp.dspace-admin.workload.title"/></h2>
	</div>

	<p align="center">
		<fmt:message key="jsp.dspace-admin.workload.email"/><input id="submitter_email" name="submitter_email"
			type="text" size="40" value="<%=user.getEmail() %>" /> <input type="button" name="Submit"
			value='<fmt:message key="jsp.dspace-admin.workload.search"/>' onclick="go()" />
	</p>


	<p id="p_total" align="center">
	</p>

	<table id="t_workload" width="70%" border="1" align="center">

	</table>
	<br />

	<div align="center">
		<img id="img_chart" src="" style="display: none;" width="800" height="350" border="0">
	</div>

</dspace:layout>