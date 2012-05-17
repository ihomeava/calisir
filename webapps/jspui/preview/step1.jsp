<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Page that displays the netid/password login form
  --%>

<%@ page contentType="text/html;charset=UTF-8"%>

<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<title>STEP 1</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="shortcut icon" href="pku-favicon.ico" type="image/x-icon"/>
<script>
function Init()
{
        window.moveTo(0,0);
        window.resizeTo(window.screen.width,window.screen.height);
}
</script>
</head>
<body onload="Init()" bgcolor="#ffffff">
	<dspace:include page="/preview/progress.jsp" />
</body>
</html>