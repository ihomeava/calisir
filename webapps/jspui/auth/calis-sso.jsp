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
			+ request.getServerName() + ":" + request.getServerPort()
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
				<form name="ssoForm"
					action="<%=request.getAttribute("selfSSOHost")%>/amconsole/AuthServices/<%=request.getAttribute("idp")%>"
					method="post">
					<p>
						<fmt:message key="jsp.components.calis-form.enter" />
					</p>
					<div id="login">
						<table border="0" cellpadding="5" align="center">
							<tr>
								<td class="standard" align="right"><label
									for="tcalis_userid"><strong><fmt:message
												key="jsp.login.calis.sso.name" />
									</strong>
								</label>
								</td>
								<td><input type="text" name="userid" id="tcalis_userid"
									tabindex="1" />
								</td>
							</tr>
							<tr>
								<td class="standard" align="right"><label
									for="tlogin_password"><strong><fmt:message
												key="jsp.components.login-form.password" />
									</strong>
								</label>
								</td>
								<td><input type="password" name="password"
									id="tcalis_password" tabindex="2" />
								</td>
							</tr>
							<tr>
								<td align="center" colspan="2"><input type="submit"
									value="<fmt:message key="jsp.components.login-form.login"/>"
									tabindex="3" /></td>
							</tr>
						</table>
						<div class="row">
							<%
								String authresult = (String) request.getAttribute("authresult");
									if (authresult != null && authresult.equals("false")) {
							%>
							<fmt:message key="jsp.login.calis.sso.msg" />
							<%
								}
							%>
						</div>
					</div>
					<div id="bot"></div>
					<input type="hidden" name="goto" value="<%=gotoUrl%>" /> <input
						type="hidden" name="verb" value="login" />
				</form>
			</td>
		</tr>
	</table>

</dspace:layout>
