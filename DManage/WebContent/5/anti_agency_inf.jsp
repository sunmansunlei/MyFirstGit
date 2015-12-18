<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page errorPage="error.jsp"%>
<%
	int menuId=41;
%>
<%@ include file="./checkauth.jsp"%>

<%
	
	Query sq = null;

    try {
    	
    	sq = new Query();
        int[] Sysdate = sq.getCurrDate();
        int year = Sysdate[0];
        int month = Sysdate[1];
        int day = Sysdate[2];
%>
<html>
	<head>
	    <meta http-equiv="Content-Type" content="text/html; charset=GBK">
	    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bims.css">
	    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/default/easyui.css">
	    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/icon.css">
	    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
	    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/plugins/jquery.linkbutton.js"></script>
	    <script language="JavaScript" src="toolbar.js"></script>
	    <script language="JavaScript" src="share/checkdata.js"></script>
	    <script language="JavaScript">
	
	        function checkdate(val) {
	        	
	            var start_checkyear = document.forms["searchPay"].elements["startyear"].value;
	            var end_checkyear = document.forms["searchPay"].elements["endyear"].value;
	            var start_checkmonth = document.forms["searchPay"].elements["startmonth"].value;
	            var end_checkmonth = document.forms["searchPay"].elements["endmonth"].value;
	            if ((start_checkyear == end_checkyear) && (end_checkmonth - start_checkmonth) <= val) {
	                return true;
	            } else if ((end_checkyear - start_checkyear == 1) && (parseInt(end_checkmonth) + parseInt(12 - start_checkmonth)) <= val) {
	                return true;
	            } else {
	                alert("查询时间不得大于" + val + "个月!");
	                return false;
	            }
	        }
	
	
	        $(document).ready(function() {
	        	
	            $('.easyui-linkbutton').linkbutton();
	            
	            $('#print').click(function() {
	            	document.frames["main"].focus();
	            	document.frames["main"].print();
	            })
	            
	            $('#search').click(function() {
	
	                loading = document.frames["main"].document.readyState;
	                if (loading != "complete") {
	                    alert("上次查询正在进行中！");
	                    return;
	                }
	                if (checkdate(1)) {
	                    document.forms["searchPay"].action = "anti_agencyinf.jsp";
	                    document.forms["searchPay"].target = "main";
	                    document.forms["searchPay"].submit();
	                }
	            })
	
	            $('#save').click(function() {
	
	                loading = document.frames["main"].document.readyState;
	                if (loading != "complete") {
	                    alert("上次查询正在进行中！");
	                    return;
	                }
	                document.forms["searchPay"].action = "anti_agency_inf_save.jsp";
	                document.forms["searchPay"].target = "saveinfo";
	                document.forms["searchPay"].submit();
	            })
	        })
	
	
	    </script>
	    <script type="text/javascript">
	        $(document).ready(function() {
	            $('.easyui-linkbutton').linkbutton();
	        });
	    </script>
	    <style type="text/css">
	        * {
	            font-size: 12px;
	        }
	    </style>
	
	    <title></title>
	</head>

	<body class="main_body" style="width:800px">
		<div class="main_title">
		    <div class="white_14_b left">防代理上报查询</div>
		</div>
	
		<div class="main_co">
		    <form method="get" name="searchPay" style="margin:0">
		        <table cellpadding=2 cellspacing=1 border=0>
		
		           <tr>
		                <table border="0">
		                    <tr>
		                        <td>上报时间：</td><%@ include file="startdate.htm" %><td>至</td><%@ include file="enddate.htm" %>
		                        <td><a href="#" class="easyui-linkbutton" plain="true" icon="icon-search" id="search">查询</a></td>
		                        <td><a href="#" class="easyui-linkbutton" plain="true" icon="icon-save" id="save">保存</a></td>
		                        <td><a href="#" class="easyui-linkbutton" plain="true" icon="icon-print" id="print">打印</a></td>		
		                    </tr>
		                </table>
		            </tr>
		        </table>
		    </form>
		</div>
		<div class="main_title"><div class="white_14_b left">查询结果</div></div>
		<div class="main_iframe"><iframe name="main" width="100%" frameborder="0" height="380" src="../blank.htm"></iframe></div>
		<div class="main_iframe"><iframe name="saveinfo" width="100%" frameborder="0" height="0" src="../blank.htm"></iframe></div>
	</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
    	sq.close();
    }
%>
