<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Page that displays the email/password login form
  --%>

<%@ page contentType="text/html;charset=UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace"%>

<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport"%>

<%
	String gotoUrl = request.getScheme() + "://"
			+ request.getLocalAddr() + ":" + request.getLocalPort()
			+ request.getContextPath() + "/calis-handle";
%>

<dspace:layout navbar="off" locbar="off"
	titlekey="jsp.login.calis.sso.title" nocache="true">
	<table border="0" width="90%">
		<tr>
			<td align="left">
				<h1>
					<fmt:message key="jsp.login.calis.sso.heading" />
				</h1></td>
			<td align="right" class="standard"><dspace:popup page="<%= LocaleSupport.getLocalizedMessage(pageContext, \"help.index\") + \"#login\"%>"><fmt:message key="jsp.help" /></dspace:popup></td>
		</tr>
	</table>

	<table class="miscTable" align="center" width="70%">
		<tr>
			<td class="evenRowEvenCol">
				<form name="loginform" id="loginform" method="post"
					action="http://login.lib.pku.edu.cn/amconsole/AuthServices">
					<p>
						<fmt:message key="jsp.components.calis-form.enter" />
					</p>

					<table border="0" cellpadding="5" align="center">
						<tr>
							<%-- add by weicf 2011.09.03 --%>
							<td class="standard" align="right"><label for="tlogin_email"
								id="label_userid"><strong><fmt:message
											key="jsp.components.login-form.userid" /> </strong> </label></td>
							<td><input type="text"
								name="userid" id="tlogin_userid" tabindex="1"/></td>
							<%-- add by weicf --%>
						</tr>
						<tr>
							<td class="standard" align="right"><label
								for="tlogin_password"><strong><fmt:message
											key="jsp.components.login-form.password" /> </strong> </label></td>
							<td>
								<%-- add by weicf 2011.09.06 --%> <input type="password"
								name="password" id="password" tabindex="2"/> <%-- add by weicf --%>
							</td>
						</tr>
						<%-- add by weicf 2011.09.03 --%>
						<tr>
							<td align="center" colspan="2"><input type="hidden"
								name="verb" id="verb" value="login" /> <input type="hidden"
								name="Lid" id="Lid" value="portal" /> <input type="hidden"
								name="goto" id="goto"
								value="<%=request.getScheme()%>://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/pku-sso" />
							</td>
						</tr>
						<%-- add by weicf --%>
						<tr>
							<td align="center" colspan="2"><input type="submit"
								name="login_submit"
								value="<fmt:message key="jsp.components.login-form.login"/>"
								tabindex="3" />
							</td>
						</tr>
					</table>

				</form> <script type="text/javascript">
					document.loginform.login_email.focus();
				</script></td>
		</tr>
	</table>

</dspace:layout>
