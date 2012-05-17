<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Home page JSP
  -
  - Attributes:
  -    communities - Community[] all communities in DSpace
  --%>

<%@ page contentType="text/html;charset=UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace"%>

<%-- add by weicf 2011.12.20 --%>
<%@ taglib uri="http://www.dspace.org/commenting-tags.tld"
	prefix="commenting"%>
<%-- add by weicf --%>

<%-- add by bit 2012.03.26 --%>
<%@ taglib uri="http://www.dspace.org/cloudTag-tags.tld"
	prefix="cloudtag"%>
<%@ taglib uri="http://www.dspace.org/csssolrdoc-tags.tld"
	prefix="solrfacet"%>
<%-- add by bit --%>

<%@ page import="java.io.File"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="java.util.Locale"%>
<%@ page import="javax.servlet.jsp.jstl.core.*"%>
<%@ page import="javax.servlet.jsp.jstl.fmt.LocaleSupport"%>
<%@ page import="org.dspace.core.I18nUtil"%>
<%@ page import="org.dspace.app.webui.util.UIUtil"%>
<%@ page import="org.dspace.content.Community"%>
<%@ page import="org.dspace.core.ConfigurationManager"%>
<%@ page import="org.dspace.browse.ItemCounter"%>

<%-- add by xmu 2012.03.25 --%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>

<%@ page import="org.apache.solr.client.solrj.SolrQuery"%>
<%@ page import="org.apache.solr.client.solrj.SolrServerException"%>
<%@ page
	import="org.apache.solr.client.solrj.impl.CommonsHttpSolrServer"%>
<%@ page import="org.apache.solr.client.solrj.response.FacetField"%>
<%@ page import="org.apache.solr.client.solrj.response.FacetField.Count"%>
<%@ page import="org.apache.solr.client.solrj.response.QueryResponse"%>
<%@ page import="org.apache.solr.common.SolrDocument"%>
<%@ page import="org.apache.solr.common.SolrDocumentList"%>

<%@ page import="org.dspace.core.Context"%>
<%@ page import="org.dspace.content.Bitstream"%>
<%@ page import="org.dspace.content.Item"%>
<%-- add by xmu --%>

<%-- add by weicf --%>
<%@ page import="edu.calis.ir.bit.service.SolrStatisService"%>
<%@ page import="edu.calis.ir.bit.service.SolrQueryService"%>
<%@ page import="org.dspace.browse.BrowseIndex"%>

<%
	Community[] communities = (Community[]) request
	.getAttribute("communities");

	// Locale[] supportedLocales = I18nUtil.getSupportedLocales(); by xmu 2012.03.25
	Locale sessionLocale = UIUtil.getSessionLocale(request);
	Config.set(request.getSession(), Config.FMT_LOCALE, sessionLocale);

	boolean feedEnabled = ConfigurationManager.getBooleanProperty("webui.feed.enable");
	String feedData = "NONE";
	if (feedEnabled) {
		feedData = "ALL:"
		+ ConfigurationManager
		.getProperty("webui.feed.formats");
	}

	ItemCounter ic = new ItemCounter(UIUtil.obtainContext(request));

	// add by xmu 2012.03.25
	// top visit items
	Context context = null;
	context = UIUtil.obtainContext(request);
	CommonsHttpSolrServer solrServer = null;
	try {
		// add by weicf
		solrServer = SolrStatisService.getServer();
	} catch (Exception e) {
		e.printStackTrace();
	}
	SolrQuery solrQuery = new SolrQuery();
	solrQuery.setQuery("type:2");
	solrQuery.setFacet(true);
	solrQuery.addFacetField("id");

	QueryResponse rsp = solrServer.query(solrQuery);
	List<FacetField> facetFields = rsp.getFacetFields();
	// add by xmu

	// add by bit 2012.03.26
	String query = request.getAttribute("q") == null ? "" : (String) request.getAttribute("q");
	if (query.equals("*:*")) {
		query = "";
	}
	
	if(request.getAttribute("queryResponse") == null){
		SolrQueryService solrQueryService = new SolrQueryService();
		String[] filters = request.getParameterValues("fq");
		Map<String, Object> map = solrQueryService.getQueryResult("*:*",
		filters, 0);
		QueryResponse queryResponse = (QueryResponse) map.get("queryResponse");
		SolrQuery params = (SolrQuery) map.get("queryParams");
		request.setAttribute("queryResponse", queryResponse);
		request.setAttribute("queryParams", params);
	}
%>

<script type="text/javascript"
	src="<%=request.getContextPath()%>/resource/js/miaov.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/resource/js/solr-facet.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/search/auto-complete.js"></script>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resource/css/miaov_style.css" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resource/css/main.css" />
<script type="text/javascript">
	rssAjax('<%=request.getContextPath() %>');
</script>
<dspace:layout locbar="off" navbar="off" titlekey="jsp.home.title"
	feedData="<%= feedData %>">

	<%-- add by bit 2012.03.26 --%>
	<h3>
		&nbsp;&nbsp;
		<fmt:message key="jsp.home.search1" />
	</h3>
	<form name="solrSearchForm" action="<%=request.getContextPath()%>/solr-search" method="get">
		<div style="margin: 0 auto;">
			<table align="center">
				<tr>
					<td>
						<p>
							<label for="tquery"><fmt:message key="jsp.home.search2" />
							</label>
						</p>
						<p>
							<input id="tquery" type="text" name="q" value="<%=query%>" onblur="setTimeout(function(){clearTable();},1000)"
								onkeyup="autoComplete(event,'<%=request.getContextPath()%>')"
								style="width: 600px;" /> <input type="hidden" name="start"
								value="0" /> <input type="hidden" name="rows" value="10" />&nbsp;
							<input type="submit" name="submit" class="solr-search"
									value="<fmt:message key="jsp.general.search.button"/>" />
						</p>
						<div style="margin-top: -15px; width: 602px;">
							<table id="suggesttion" width="100%">
					        </table>
				        </div>
						<p style="text-align: center;">
							<%-- add by weicf 2012.03.27 --%>
							<a href="<%=request.getContextPath()%>/community-list"><fmt:message
									key="jsp.layout.navbar-default.communities-collections" /></a>

							<%-- Insert the dynamic browse indices here --%>
							<%
								BrowseIndex[] bis = BrowseIndex.getBrowseIndices();
																										for (int i = 0; i < bis.length; i++)
																										{
																											BrowseIndex bix = bis[i];
																											String key = "browse.menu." + bix.getName();
							%>

							| <a
								href="<%=request.getContextPath()%>/browse?type=<%=bix.getName()%>"><fmt:message
									key="<%= key %>" /></a>

							<%
								}
							%>
							<%-- add by weicf --%>
						</p>
					</td>
				</tr>
			</table>
		</div>
	</form>

	<solrfacet:checkSolrDocList attributeName="queryResponse"
		type="notnull">
		<DIV class="price-range-order" onClick="" onMouseOver="" onMouseOut="">
			<h3>
				<fmt:message key="jsp.home.search.filter" />
			</h3>
			<div style="float: right; margin: -10px 20px 0 0;">
				<a id="ShowOrHide" href="javascript:void(0);" onclick="refineShowOrHide(this)">收起-</a>
			</div>
			<input type="hidden" id="facet_show" value="false" /> <br>
			<div>
				<div class="price-range-showbox" id="popup" style="display: block;">
					<solrfacet:facetList queryName="queryParams"
						facetResName="queryResponse" queryTemplate="query"></solrfacet:facetList>
				</div>
			</div>
		</DIV>
	</solrfacet:checkSolrDocList>

	<table height="100%" width="100%">
		<tr>
			<td valign="top">
				<%
					if(request.getAttribute("queryResponse") != null && ((QueryResponse)request.getAttribute("queryResponse")).getResults().size() <= 0){
				%>
				<table style="margin: 0 auto;">
					<tr>
						<td align="right" style="border: #3333ff 0px solid;" colspan="5">
							<ul style="list-style: none; float: right; padding: 3px;">
								<li style="list-style: none; float: left; padding: 3px;"><fmt:message
										key="jsp.home.search.noresult" /></li>
							</ul></td>
					</tr>
				</table> <%
 	}else{
 %> <solrfacet:checkSolrDocList attributeName="queryResponse"
					type="notnull">
					<br />
					<h3>
						&nbsp;&nbsp;
						<fmt:message key="jsp.search.results.title" />
					</h3>
					<table style="margin-left: 30px;" cellpadding="0" cellspacing="0"
						bgcolor="#ffffff">
						<tr>
							<td width="80" style="border: #3333ff 0px solid">&nbsp;</td>
							<td width="250" style="border: #3333ff 0px solid"><fmt:message
									key="jsp.home.search.time1" /> <%=request.getAttribute("qTime")==null?"0":request.getAttribute("qTime")%>
								<fmt:message key="jsp.home.search.time2" /></td>
							<td width="80" style="border: #3333ff 0px solid">&nbsp;</td>
							<td width="250" style="border: #3333ff 0px solid">&nbsp;</td>
							<td width="80" style="border: #3333ff 0px solid">&nbsp;</td>
							<td width="150" style="border: #3333ff 0px solid">&nbsp;</td>
						</tr>

						<tr>
							<td style="border-bottom: #CCCCCC 1px dashed">&nbsp;</td>
							<td colspan="4" style="border-bottom: #CCCCCC 1px dashed"></td>
						</tr>
					</table>
					<solrfacet:docforeach attributeName="queryResponse"
						docVar="tempDoc" scope="request">
						<table id="solr_result" style="margin-left: 30px;" cellpadding="0"
							cellspacing="0" bgcolor="#ffffff">
							<solrfacet:docTemplate templateId="docList" docVar="tempDoc"></solrfacet:docTemplate>
						</table>
					</solrfacet:docforeach>
					<table style="margin: 0 auto;">
						<solrfacet:docListPage pages="10" queryName="queryParams"
							attributeName="queryResponse"></solrfacet:docListPage>
					</table>
				</solrfacet:checkSolrDocList> <%
 	}
 %>
			</td>
		</tr>
	</table>
	<%-- add by bit --%>
	<br />
	<%-- delete by xmu 2012.03.25 --%>
	<%-- delete by weicf 2012.03.27 --%>
	<dspace:sidebar>

		<%-- add by weicf 2011.12.20 --%>
		<commenting:markedCommentTag />
		<%-- add by weicf --%>

		<%-- Search Term Tag Cloud --%>
		<h3>
			<fmt:message key="jsp.home.cloudtag" />
		</h3>
		<cloudtag:cloud tagNum="15"></cloudtag:cloud>
		<br/>
		<br/>
		<%-- Recently Submitted items --%>
		<h3>
			<fmt:message key="jsp.home.recentsub" />
		</h3>
		<div id="recent_sub" style="width: 200px; margin: 0 auto;">
			<jsp:include page="recentsub.html" flush="true" />
		</div>

		<%-- add by xmu 2012.03.25 --%>
		<%-- top visit items --%>
		<h3>
			<fmt:message key="jsp.home.top-visit" />
		</h3>
		<div id="top_visit" style="width: 200px; margin: 0 auto; padding-left: 30px;">
			<ol>
			<%
				for (FacetField facetField : facetFields) {
											List<Count> countList = facetField.getValues();
											if(countList != null){
												int size = (countList.size() > 10 ? 10 : countList
														.size());
												for (int i = 0; i < size; i++) {
													if (countList.get(i).getCount() > 0) {
														int it_id = Integer.parseInt(countList.get(i)
																.getName());
														Item item = Item.find(context, it_id);
														String itname = item.getName();
														String name = "";
														if (itname != null && itname.length() >= 8) {
															name = item.getName().substring(0, 8);
														} else {
															name = itname;
														}
														String handle = item.getHandle();
			%>
			<li><a href='<%=request.getContextPath()%>/handle/<%=handle%>'
				target='_blank' title='<%=itname%>'><%=name%>...(<%=countList.get(i).getCount()%>)</a></li>
			<%
				}
												}
											} else{
			%>
			</ol>
			<center>
			<h4>
				<fmt:message key="jsp.home.top-visit.nodata" />
			</h4>
			</center>									
			<%
											}
										}
			%>
		</div>
		<%-- add by xmu --%>

		<h3>
			<fmt:message key="jsp.home.community.statis" />
		</h3>
		<%
			if (communities.length != 0) {
		%>
		<div id="community_stat" style="width: 200px; margin: 0 auto; padding-left: 30px;">
			<table border="0" cellpadding="2">
				<%
					for (int i = 0; i < communities.length; i++) {
				%>
				<tr>
					<td class="standard"><a
						href="<%=request.getContextPath()%>/handle/<%=communities[i].getHandle()%>"><%=communities[i].getMetadata("name")%></a>
						<%
							if (ConfigurationManager
																								.getBooleanProperty("webui.strengths.show")) {
						%> [<%=ic.getCount(communities[i])%>] <%
							}
						%>
					</td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
		<%
			}
		%>

		<h3>
			<fmt:message key="jsp.home.search.filter.statis" />
		</h3>
		<div id="filter_stat" style="height: 100%; align: left; margin: 0px;">
			<solrfacet:facetList facetNum="10"></solrfacet:facetList>
		</div>

		<%
			if (feedEnabled) {
		%>
		<center>
			<h4>
				<fmt:message key="jsp.home.feeds" />
			</h4>
			<%
				String[] fmts = feedData.substring(
														feedData.indexOf(':') + 1).split(",");
												String icon = null;
												int width = 0;
												for (int j = 0; j < fmts.length; j++) {
													if ("rss_1.0".equals(fmts[j])) {
														icon = "rss1.gif";
														width = 80;
													} else if ("rss_2.0".equals(fmts[j])) {
														icon = "rss2.gif";
														width = 80;
													} else {
														icon = "rss.gif";
														width = 36;
													}
			%>
			<a style="text-decoration: none;"
				href="<%=request.getContextPath()%>/feed/<%=fmts[j]%>/site"><img
				src="<%=request.getContextPath()%>/image/<%=icon%>" alt="RSS Feed"
				width="<%=width%>" height="15" vspace="3" border="0" /> </a>
			<%
				}
			%>
		</center>
		<%
			}
		%>

	</dspace:sidebar>
	<script type="text/javascript">
		refineShowOrHide($$('#ShowOrHide')[0]);
		document.getElementById("tquery").focus();
		$$('#solr_result').each(function(item) {
			item.observe('mouseover', function() {
				item.setStyle({
					backgroundColor : '#ddd',
					border : '1px solid #ddd'
				});
			});
			item.observe('mouseout', function() {
				item.setStyle({
					backgroundColor : '#fff',
					border : '0'
				});
			});
		});
	</script>
</dspace:layout>
