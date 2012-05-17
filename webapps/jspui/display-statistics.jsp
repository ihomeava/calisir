<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Display item/collection/community statistics
  -
  - Attributes:
  -    statsVisits - bean containing name, data, column and row labels
  -    statsMonthlyVisits - bean containing name, data, column and row labels
  -    statsFileDownloads - bean containing name, data, column and row labels
  -    statsCountryVisits - bean containing name, data, column and row labels
  -    statsCityVisits - bean containing name, data, column and row labels
  -    isItem - boolean variable, returns true if the DSO is an Item 
  --%>

<%@ page contentType="text/html;charset=UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace"%>

<%@page import="org.dspace.app.webui.servlet.MyDSpaceServlet"%>

<%-- (all bellow)add by xmu 2012.03.25 --%>
<%@page import="java.awt.*"%>
<%@page import="java.awt.Font"%>
<%@page import="java.util.*"%>

<%@page import="org.jfree.chart.*"%>
<%@page import="org.jfree.chart.axis.*"%>
<%@page import="org.jfree.chart.ChartFactory"%>
<%@page import="org.jfree.chart.JFreeChart"%>
<%@page import="org.jfree.chart.labels.*"%>
<%@page import="org.jfree.chart.renderer.category.BarRenderer"%>
<%@page import="org.jfree.chart.plot.*"%>
<%@page import="org.jfree.chart.plot.PlotOrientation"%>
<%@page import="org.jfree.chart.plot.XYPlot"%>
<%@page import="org.jfree.chart.renderer.xy.XYLineAndShapeRenderer"%>
<%@page import="org.jfree.chart.renderer.xy.XYItemRenderer"%>
<%@page import="org.jfree.chart.servlet.*"%>
<%@page import="org.jfree.chart.servlet.ServletUtilities"%>
<%@page import="org.jfree.chart.title.TextTitle"%>
<%@page import="org.jfree.data.category.*"%>
<%@page import="org.jfree.data.time.TimeSeries"%>
<%@page import="org.jfree.data.time.TimeSeriesCollection"%>
<%@page import="org.jfree.data.time.Month"%>
<%@page import="org.jfree.ui.*"%>
<%@page import="org.jfree.ui.RectangleInsets"%>
<%@page import="edu.calis.ir.xmu.components.JFreeChartManager" %>


<% Boolean isItem = (Boolean)request.getAttribute("isItem"); %>


<dspace:layout titlekey="jsp.statistics.title">
	<h1>
		<fmt:message key="jsp.statistics.title" />
	</h1>
	<h2>
		<fmt:message key="jsp.statistics.heading.visits" />
	</h2>
	<table class="statsTable">
		<tr>
			<th>
				<!-- spacer cell -->
			</th>
			<th>
				<fmt:message key="jsp.statistics.heading.views" />
			</th>
		</tr>
		<c:forEach items="${statsVisits.matrix}" var="row" varStatus="counter">
			<c:forEach items="${row}" var="cell" varStatus="rowcounter">
				<c:choose>
					<c:when test="${rowcounter.index % 2 == 0}">
						<c:set var="rowClass" value="evenRowOddCol" />
					</c:when>
					<c:otherwise>
						<c:set var="rowClass" value="oddRowOddCol" />
					</c:otherwise>
				</c:choose>
				<tr class="${rowClass}">
					<td>
						<c:out value="${statsVisits.colLabels[counter.index]}" />
						<td>
							<c:out value="${cell}" />
						</td>
						</tr>
			</c:forEach>
		</c:forEach>
	</table>

	<h2>
		<fmt:message key="jsp.statistics.heading.monthlyvisits" />
	</h2>
	<table class="statsTable">
		<tr>
			<th>
				<!-- spacer cell -->
			</th>
			<c:forEach items="${statsMonthlyVisits.colLabels}" var="headerlabel"
				varStatus="counter">
				<th>
					<c:out value="${headerlabel}" />
				</th>
			</c:forEach>
		</tr>
		<c:forEach items="${statsMonthlyVisits.matrix}" var="row"
			varStatus="counter">
			<c:choose>
				<c:when test="${counter.index % 2 == 0}">
					<c:set var="rowClass" value="evenRowOddCol" />
				</c:when>
				<c:otherwise>
					<c:set var="rowClass" value="oddRowOddCol" />
				</c:otherwise>
			</c:choose>
			<tr class="${rowClass}">
				<td>
					<c:out value="${statsMonthlyVisits.rowLabels[counter.index]}" />
				</td>
				<c:forEach items="${row}" var="cell">
					<td>
						<c:out value="${cell}" />
					</td>
				</c:forEach>
			</tr>
		</c:forEach>
	</table>

<br/>

	<!-- Total Visits per Month -->
	<%
DefaultCategoryDataset datasetVisit = new DefaultCategoryDataset();
%>
	<%-- 设置数据集 --%>
	<c:forEach items="${statsMonthlyVisits.matrix}" var="row"
		varStatus="counter">
		<c:set var="visits" value="${row}" />
	</c:forEach>
	<c:set var="times" value="${statsMonthlyVisits.colLabels}" />
	<%-- 读取数据集并给图赋值 --%>
	<c:if test="${fn:length(times) > 0}">
	<c:forEach var="i" begin="0" end="${fn:length(times)-1}">
		<c:set var="time" value="${times[i]}" />
		<c:out value="${times[i]}" />
		<c:set var="visit" value="${visits[i]}" />
		<%
datasetVisit.addValue(Integer.parseInt((String)pageContext.getAttribute("visit")), "", (String)pageContext.getAttribute("time"));
%>
	</c:forEach>
	</c:if>

	<%
JFreeChart chartVisit = ChartFactory.createBarChart("Total Visits per Month", 
                  "Month",
                  "vistis",
                  datasetVisit,
                  PlotOrientation.VERTICAL,
                  false,
                  false,
                  false);
chartVisit = JFreeChartManager.configFont(chartVisit);
String filenameVisit = ServletUtilities.saveChartAsPNG(chartVisit, 720, 300, null, session);
String graphURLVisit = request.getContextPath() + "/DisplayChart?filename=" + filenameVisit;
%>
	<div align="center">
		<img src="<%= graphURLVisit %>" width=720 height=300 border=0>
	</div>

	<% if(isItem) { %>

	<h2>
		<fmt:message key="jsp.statistics.heading.filedownloads" />
	</h2>
	<table class="statsTable">
		<tr>
			<th>
				<!-- spacer cell -->
			</th>
			<th>
				<fmt:message key="jsp.statistics.heading.views" />
			</th>
		</tr>
		<c:forEach items="${statsFileDownloads.matrix}" var="row"
			varStatus="counter">
			<c:forEach items="${row}" var="cell" varStatus="rowcounter">
				<c:choose>
					<c:when test="${rowcounter.index % 2 == 0}">
						<c:set var="rowClass" value="evenRowOddCol" />
					</c:when>
					<c:otherwise>
						<c:set var="rowClass" value="oddRowOddCol" />
					</c:otherwise>
				</c:choose>
				<tr class="${rowClass}">
					<td>
						<c:out value="${statsFileDownloads.colLabels[rowcounter.index]}" />
						<td>
							<c:out value="${cell}" />
						</td>
						</tr>
			</c:forEach>
		</c:forEach>
	</table>

	<% } %>

	<h2>
		<fmt:message key="jsp.statistics.heading.countryvisits" />
	</h2>
	<table class="statsTable">
		<tr>
			<th>
				<!-- spacer cell -->
			</th>
			<th>
				<fmt:message key="jsp.statistics.heading.views" />
			</th>
		</tr>
		<c:forEach items="${statsCountryVisits.matrix}" var="row"
			varStatus="counter">
			<c:forEach items="${row}" var="cell" varStatus="rowcounter">
				<c:choose>
					<c:when test="${rowcounter.index % 2 == 0}">
						<c:set var="rowClass" value="evenRowOddCol" />
					</c:when>
					<c:otherwise>
						<c:set var="rowClass" value="oddRowOddCol" />
					</c:otherwise>
				</c:choose>
				<tr class="${rowClass}">
					<td>
						<c:out value="${statsCountryVisits.colLabels[rowcounter.index]}" />
						<td>
							<c:out value="${cell}" />
				</tr>
			</c:forEach>
		</c:forEach>
	</table>
	<br />
	<!-- Top Country Views -->
	<%
DefaultCategoryDataset datasetCountry = new DefaultCategoryDataset();
%>
	<c:forEach items="${statsCountryVisits.matrix}" var="row"
		varStatus="counter">
		<c:forEach items="${row}" var="cell" varStatus="rowcounter">
			<c:set var="valueCountry" value="${cell}" />
			<c:set var="countries"
				value="${statsCountryVisits.colLabels[rowcounter.index]}" />
			<%
datasetCountry.addValue(Integer.parseInt((String)pageContext.getAttribute("valueCountry")),"China",(String)pageContext.getAttribute("countries"));
%>
		</c:forEach>
	</c:forEach>

	<% JFreeChart chartCountry = ChartFactory.createBarChart("Top Country Views",
                  "Country",
                  "Views",
                  datasetCountry,
                  PlotOrientation.HORIZONTAL,
                  false,
                  false,
                  false);
                  
CategoryPlot plotCountry = chartCountry.getCategoryPlot();  
//设置网格背景颜色
plotCountry.setBackgroundPaint(Color.white);
//设置网格竖线颜色
plotCountry.setDomainGridlinePaint(Color.pink);
//设置网格横线颜色
plotCountry.setRangeGridlinePaint(Color.pink);

//显示每个柱的数值，并修改该数值的字体属性
BarRenderer rendererCountry = new BarRenderer();
rendererCountry.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
rendererCountry.setBaseItemLabelsVisible(true);

//默认的数字显示在柱子中，通过如下两句可调整数字的显示
//注意：此句很关键，若无此句，那数字的显示会被覆盖，给人数字没有显示出来的问题
rendererCountry.setBasePositiveItemLabelPosition(new ItemLabelPosition(ItemLabelAnchor.OUTSIDE3, TextAnchor.BASELINE_RIGHT));
rendererCountry.setItemLabelAnchorOffset(20D);

plotCountry.setRenderer(rendererCountry);

String filenameCountry = ServletUtilities.saveChartAsPNG(chartCountry, 700, 400, null, session);
String graphURLCountry = request.getContextPath() + "/DisplayChart?filename=" + filenameCountry;
%>
	<div align="center">
		<img src="<%= graphURLCountry %>" width=700 height=400 border=0>
	</div>


<br/>

	<h2>
		<fmt:message key="jsp.statistics.heading.cityvisits" />
	</h2>
	<table class="statsTable">
		<tr>
			<th>
				<!-- spacer cell -->
			</th>
			<th>
				<fmt:message key="jsp.statistics.heading.views" />
			</th>
		</tr>
		<c:forEach items="${statsCityVisits.matrix}" var="row"
			varStatus="counter">
			<c:forEach items="${row}" var="cell" varStatus="rowcounter">
				<c:choose>
					<c:when test="${rowcounter.index % 2 == 0}">
						<c:set var="rowClass" value="evenRowOddCol" />
					</c:when>
					<c:otherwise>
						<c:set var="rowClass" value="oddRowOddCol" />
					</c:otherwise>
				</c:choose>
				<tr class="${rowClass}">
					<td>
						<c:out value="${statsCityVisits.colLabels[rowcounter.index]}" />
						<td>
							<c:out value="${cell}" />
						</td>
				</tr>
			</c:forEach>
		</c:forEach>
	</table>


<br/>

	<!-- Top City Views -->
	<%
DefaultCategoryDataset datasetCity = new DefaultCategoryDataset();
%>
	<c:forEach items="${statsCityVisits.matrix}" var="row"
		varStatus="counter">
		<c:forEach items="${row}" var="cell" varStatus="rowcounter">
			<c:set var="valueCity" value="${cell}" />
			<c:set var="cities"
				value="${statsCityVisits.colLabels[rowcounter.index]}" />
			<%
datasetCity.addValue(Integer.parseInt((String)pageContext.getAttribute("valueCity")),"China",(String)pageContext.getAttribute("cities"));
%>
		</c:forEach>
	</c:forEach>

	<% JFreeChart chartCity = ChartFactory.createBarChart("Top City Views",
                  "City",
                  "Views",
                  datasetCity,
                  PlotOrientation.HORIZONTAL,
                  false,
                  false,
                  false);
                  
CategoryPlot plotCity = chartCity.getCategoryPlot();  
//设置网格背景颜色
plotCity.setBackgroundPaint(Color.white);
//设置网格竖线颜色
plotCity.setDomainGridlinePaint(Color.pink);
//设置网格横线颜色
plotCity.setRangeGridlinePaint(Color.pink);

//显示每个柱的数值，并修改该数值的字体属性
BarRenderer rendererCity = new BarRenderer();
rendererCity.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator());
rendererCity.setBaseItemLabelsVisible(true);

//默认的数字显示在柱子中，通过如下两句可调整数字的显示
//注意：此句很关键，若无此句，那数字的显示会被覆盖，给人数字没有显示出来的问题
rendererCity.setBasePositiveItemLabelPosition(new ItemLabelPosition(ItemLabelAnchor.OUTSIDE3, TextAnchor.BASELINE_RIGHT));
rendererCity.setItemLabelAnchorOffset(20D);

plotCity.setRenderer(rendererCity);

String filenameCity = ServletUtilities.saveChartAsPNG(chartCity, 700, 400, null, session);
String graphURLCity = request.getContextPath() + "/DisplayChart?filename=" + filenameCity;
%>
	<div align="center">
		<img src="<%= graphURLCity %>" width=700 height=400 border=0>
	</div>

</dspace:layout>
