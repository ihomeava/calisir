<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Initial questions for keeping UI as simple as possible.
  -
  - Attributes to pass in:
  -    submission.info    - the SubmissionInfo object
  -    submission.inputs  - the DCInputSet object
  --%>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"
    prefix="fmt" %>

<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport" %>

<%@ page import="org.dspace.core.Context" %>
<%@ page import="org.dspace.app.webui.servlet.SubmissionController" %>
<%@ page import="org.dspace.submit.AbstractProcessingStep" %>
<%@ page import="org.dspace.app.webui.util.UIUtil" %>
<%@ page import="org.dspace.app.util.SubmissionInfo" %>
<%@ page import="org.dspace.app.util.DCInputSet" %>
<%@ page import="org.dspace.core.ConfigurationManager" %>

<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%
    request.setAttribute("LanguageSwitch", "hide");

        DCInputSet inputSet =
        (DCInputSet) request.getAttribute("submission.inputs");

	// Obtain DSpace context
    Context context = UIUtil.obtainContext(request);

	//get submission information object
    SubmissionInfo subInfo = SubmissionController.getSubmissionInfo(context, request);
	String colName = subInfo.getSubmissionItem().getCollection().getName();
%>

<script type="text/javascript">

	function checkTypeRadioValue() {
		var temp = document.getElementsByName("submittype");
		var Checked = false;
		for (i = 0; i < temp.length; i++) {
			if (temp[i].checked) {
				Checked = true;
				break;
			} else {
				Checked = false;
			}
		}
		if (Checked == false) {
			alert('<fmt:message key="jsp.submit.initial-questions.radio.msg"/>');
			return false;
		}
		return true;
	}
	
</script>

<dspace:layout locbar="off"
               navbar="off"
               titlekey="jsp.submit.initial-questions.title"
               nocache="true">

    <form action="<%= request.getContextPath() %>/submit" method="post" onkeydown="return disableEnterKey(event);" onsubmit="return checkTypeRadioValue();">

        <jsp:include page="/submit/progressbar.jsp" />

        <%-- <h1>Submit: Describe Your Item</h1> --%>
		<h1><fmt:message key="jsp.submit.initial-questions.heading"/></h1>
    
        <%-- <p>Please check the boxes next to the statements that apply to your
        submission.
        <object><dspace:popup page="/help/index.html#describe1">(More Help...)</dspace:popup></object></p> --%>

        <div><fmt:message key="jsp.submit.initial-questions.info" /> 
        <dspace:popup page="<%= LocaleSupport.getLocalizedMessage(pageContext, \"help.index\") + \"#describe1\"%>"><fmt:message key="jsp.morehelp"/></dspace:popup></div>

        <center>
            <table class="miscTable">
<%
	// Don't display MultipleTitles if no such form box defined
    if (inputSet.isDefinedMultTitles())
    {
%>
                <tr class="oddRowOddCol">
                    <td class="oddRowOddCol" align="left">
                        <table border="0">
                            <tr>
                                <td valign="top">
                                <input type="hidden" name="multiple_titles" value="true" />
</td>
                                <%-- <td class="submitFormLabel" nowrap>The item has more than one title, e.g. a translated title</td> --%>
								<td class="submitFormLabel" nowrap="nowrap">
<input name="submittype" type="radio" value="book" /> <label id="book"><fmt:message key="jsp.submit.initial-questions.submittype.book"/></label>
<input name="submittype" type="radio" value="qklw" /> <label id="qklw"><fmt:message key="jsp.submit.initial-questions.submittype.qklw"/></label> 
<input name="submittype" type="radio" value="hylw" /> <label id="hylw"><fmt:message key="jsp.submit.initial-questions.submittype.hylw"/></label>
<input name="submittype" type="radio" value="xwlw" /> <label id="xwlw"><fmt:message key="jsp.submit.initial-questions.submittype.xwlw"/></label>
<input name="submittype" type="radio" value="yjbg" /> <label id="yjbg"><fmt:message key="jsp.submit.initial-questions.submittype.yjbg"/></label>
<input name="submittype" type="radio" value="traditional" /> <label id="traditional"><fmt:message key="jsp.submit.initial-questions.submittype.other"/></label>
</td>
                            </tr>
                        </table>
                    </td>
                </tr>
<%
    }
    // Don't display PublishedBefore if no form boxes defined
if (inputSet.isDefinedPubBefore())
    {
%>
                <tr>
                    <td align="left">
<input type="hidden" name="published_before" value="true" />
                    </td>
                </tr>
<%
    }
    // Don't display file or thesis questions in workflow mode
    if (!subInfo.isInWorkflow())
    {
%>
<tr>
                    <td align="left">                     
		<input type="hidden" name="multiple_files" value="true" />	
                    </td>
                </tr>			
				
<%
        if (ConfigurationManager.getBooleanProperty("webui.submit.blocktheses"))
        {
%>
                <tr class="evenRowOddCol">
                    <td class="evenRowOddCol" align="left">
                        <table border="0">
                            <tr>
                                <td valign="top"><input type="checkbox" name="is_thesis" value="true"></td>
                                <%-- <td class="submitFormLabel" nowrap>The item is a thesis</td> --%>
								<td class="submitFormLabel" nowrap="nowrap"><fmt:message key="jsp.submit.initial-questions.elem4"/></td>
                            </tr>
                        </table>
                    </td>
                </tr>
<%
        }
    }
%>
            </table>
        </center>

        <p>&nbsp;</p>

		<%-- Hidden fields needed for SubmissionController servlet to know which step is next--%>
        <%= SubmissionController.getSubmissionParameters(context, request) %>
        <center>
            <table border="0" width="80%">
                <tr>
					<td width="100%">&nbsp;</td>
				<%  //if not first step, show "Previous" button
					if(!SubmissionController.isFirstStep(request, subInfo))
					{ %>
                    <td>
                        <input type="submit" name="<%=AbstractProcessingStep.PREVIOUS_BUTTON%>" value="<fmt:message key="jsp.submit.general.previous"/>" />
                    </td>
				<%  } %>
                    <td>
                        <input type="submit" name="<%=AbstractProcessingStep.NEXT_BUTTON%>" value="<fmt:message key="jsp.submit.general.next"/>" />
                    </td>
                    <td>&nbsp;&nbsp;&nbsp;</td>
                    <td align="right">
                        <input type="submit" name="<%=AbstractProcessingStep.CANCEL_BUTTON%>" value="<fmt:message key="jsp.submit.general.cancel-or-save.button"/>" />
                    </td>
                </tr>
            </table>
        </center>
    </form>

</dspace:layout>
<script type="text/javascript">
	
	function setTypeRadioValue(colName) {
		if(colName.indexOf('[') > 0){
			colName = colName.substring(colName.indexOf('['), (colName.length - 1));
		}
		var obj = document.getElementsByName("submittype");
		for (var i = 0; i < obj.length; i++) {
			if ($$("#"+obj[i].value)[0].innerHTML.replace(/(^\s*)|(\s*$)/g, "") == colName) {
				obj[i].checked = true
				break;
			}
		}
	}

	setTypeRadioValue("<%=colName %>");
</script>