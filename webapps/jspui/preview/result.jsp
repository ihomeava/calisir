<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	request.setCharacterEncoding("UTF-8");
	String fileName = request.getParameter("filename");
	//String fileName = new String(request.getParameter("filename").getBytes("iso-8859-1"), "UTF-8");
	String itemID = new String(request.getParameter("itemid").getBytes("iso-8859-1"), "UTF-8");
%>

<style type="text/css" media="screen">
#flashContent {
	display: none;
}
</style>

<script type="text/javascript"
	src="<%=request.getContextPath()%>/preview/js/jquery.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/preview/js/flexpaper_flash.js"></script>
<div style="margin-left: 200px; top: 60px;">
	<h2><%=fileName %></h2>
	<p id="viewerPlaceHolder"
		style="width: 800px; height: 553px; display: block">Document
		loading..</p>

	<script type="text/javascript">
	jQuery.noConflict();

	// Use jQuery via jQuery(...)
	jQuery(document).ready(function(){

		function viewDocument(retval) {
			var numPages = retval;
			var doc = "<%=fileName %>";
			var swfFileUrl = '<%=request.getScheme()%>://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/' + escape('{viewswf?itemid=<%=request.getParameter("itemid")%>&filename=' + doc
					+ '&page=[*,0],' + numPages + '}');
			var searchServiceUrl = '<%=request.getScheme()%>://<%=request.getServerName()%>:<%=request.getServerPort()%><%=request.getContextPath()%>/' + escape('swfextract?itemid=<%=request.getParameter("itemid")%>&filename='
					+ doc + '&page=[page]&searchterm=[searchterm]');

			var fp = new FlexPaperViewer('FlexPaperViewer',
					'viewerPlaceHolder', {
						config : {
							SwfFile : swfFileUrl,
							Scale : 1,
							ZoomTransition : 'easeOut',
							ZoomTime : 0.5,
							ZoomInterval : 0.2,
							FitPageOnLoad : false,
							FitWidthOnLoad : false,
							PrintEnabled : true,
							FullScreenAsMaxWindow : false,
							ProgressiveLoading : false,
							MinZoomSize : 0.2,
							MaxZoomSize : 5,
							SearchMatchAll : true,
							SearchServiceUrl : searchServiceUrl,
							InitViewMode : 'Portrait',
							BitmapBasedRendering : false,

							ViewModeToolsVisible : true,
							ZoomToolsVisible : true,
							NavToolsVisible : true,
							CursorToolsVisible : true,
							SearchToolsVisible : true,

							localeChain : 'zh_CN'
						}
					});
		}
		
		jQuery.ajax({
			type: 'POST',
			url: '<%=request.getContextPath()%>/viewswf',
			data: {itemid : '<%=request.getParameter("itemid") %>'},
			dataType : 'text',
			async : false,
			timeout : 1000,
			success : viewDocument,
			error : function() {
				jQuery("#viewerPlaceHolder").html('Error loading document');
			}
		});
	});
	</script>

</div>