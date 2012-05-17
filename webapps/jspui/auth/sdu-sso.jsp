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

<script type="text/javascript">
	function changeRegImg() {
		document.getElementById("regimg").src = "http://58.194.172.14:8080/authcenter/verifycode?"
				+ Math.random();
	}
</script>

<dspace:layout navbar="off" locbar="off"
	titlekey="jsp.login.calis.sso.title" nocache="true">
	<table border="0" width="90%">
		<tr>
			<td align="left">
				<h1>
					<fmt:message key="jsp.login.calis.sso.heading" />
				</h1></td>
			<td align="right" class="standard"><dspace:popup
					page="<%= LocaleSupport.getLocalizedMessage(pageContext, \"help.index\") + \"#login\"%>">
					<fmt:message key="jsp.help" />
				</dspace:popup></td>
		</tr>
	</table>

	<table class="miscTable" align="center" width="70%">
		<tr>
			<td class="evenRowEvenCol">
				<form name="loginform" id="loginform" method="post"
					action="http://58.194.172.14:8080/authcenter/authcenter/idp.action">
					<p>
						<fmt:message key="jsp.components.calis-form.enter" />
					</p>

					<table border="0" cellpadding="5" align="center">
						<tr>
							<%-- add by weicf 2011.09.03 --%>
							<td class="standard" align="right"><label for="tlogin_email"
								id="label_userid"><strong><fmt:message
											key="jsp.components.login-form.userid" /> </strong> </label></td>
							<td><input type="text" name="accountId" id="tlogin_userid"
								tabindex="1" /></td>
							<%-- add by weicf --%>
						</tr>
						<tr>
							<td class="standard" align="right"><label
								for="tlogin_password"><strong><fmt:message
											key="jsp.components.login-form.password" /> </strong> </label></td>
							<td>
								<%-- add by weicf 2011.09.06 --%> <input type="password"
								name="password" id="password" tabindex="2" /> <%-- add by weicf --%>
							</td>
						</tr>
						<tr>
							<td class="standard" align="right"><label><strong>verify
										code：</strong> </label>
							</td>
							<td><input type="text" name="verifycode" value=""
								id="idp_verifycode" style="width: 50px" /> <img id="regimg"
								src="http://58.194.172.14:8080/authcenter/verifycode" /></td>
						</tr>
						<tr>
							<td class="standard" align="right">&nbsp;</td>
							<td><a href="javascript:changeRegImg()">change another</a>
							</td>
						</tr>
						<%-- add by weicf 2011.09.03 --%>
						<tr>
							<td align="center" colspan="2"><input type="hidden"
								name="goto"
								value="http://cuas.calis.edu.cn:8090/amconsole/AuthServices?verb=splogin&amp;goto=<%=request.getScheme()%>%3A%2F%2F<%=request.getServerName()%>%3A<%=request.getServerPort()%><%=request.getContextPath()%>%2Fcalis-handle&amp;idp=237010"
								id="idp_goto" /> <input type="hidden" name="idp" value="237010"
								id="idp_idp" /> <input type="hidden" name="sp"
								value="http://uas.sd.calis.edu.cn:8090/amconsole/AuthServices/237010?verb=splogin"
								id="idp_sp" /></td>
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
