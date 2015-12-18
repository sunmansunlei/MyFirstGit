<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK" session="true" %>
<%@page import="com.adsl.*" %>
<%@page errorPage="../error.jsp" %>
<%
	String menuId = "14";
%>
<%@ include file="./checkauth.jsp" %>
<%
	
	VersionCR user = null;
    
	try {
    	
		user = new VersionCR();
		
		int[] Sysdate = user.getCurrDate();
        int year = Sysdate[0];       
        int month = Sysdate[1];
        int day = Sysdate[2];

        int syear = Sysdate[0];
        int smonth = Sysdate[1];
        int sday = Sysdate[2];
        
%>
<html>
	<head>
	    <meta http-equiv="Content-Type" content="text/html; charset=GBK">
	    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bims.css">
	    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/default/easyui.css">
	    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/icon.css">
	    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
	    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/plugins/jquery.linkbutton.js"></script>
	    <script type="text/javascript">
	   	    
	    function checkdate(val) {
        	
            var start_checkyear = document.forms["search"].elements["startyear"].value;
            var end_checkyear = document.forms["search"].elements["endyear"].value;
            var start_checkmonth = document.forms["search"].elements["startmonth"].value;
            var end_checkmonth = document.forms["search"].elements["endmonth"].value;
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
	            
	            $('#search').click(function() {
	            	   loading = document.frames["main"].document.readyState;
		                if (loading != "complete") {
		                    alert("上次查询正在进行中！");
		                    return;
		                }
		                
		                var starttime1 = new Date(document.getElementById("startyear").value,document.getElementById("startmonth").value-1,document.getElementById("startday").value);
		                var endtime1 = new Date(document.getElementById("endyear").value,document.getElementById("endmonth").value-1,document.getElementById("endday").value);
		                ss=(endtime1-starttime1)/1000/60/60/24;
		                if(ss<0){
		                	alert("选择发布时间时，结束时间必须大于起始时间！");
		                    return;
		                }
		               
		                if (checkdate(1)) {
		                    document.forms["search"].action = "version_rollback.jsp";
		                    document.forms["search"].target = "main";
		                    document.forms["search"].submit();
		                }
	            });
	            
	        });
	
	    </script>
	    <style type="text/css">
	        * {
	            font-size: 12px;
	        }
	    </style>
	
	    <title></title>
	</head>
	
<body >

<form  target="main" method="post" name="search" style="margin:0">
<div class="main_title">
    <div class="white_14_b left">策略回退</div>
</div>
<div class="main_co">
  
        <table cellpadding=2 cellspacing=1 border=0 >
            <tr>
            	<table>   
            		          	                               		            
	            	<td align="center">&nbsp;归档时间：&nbsp;从&nbsp;</td><%@ include file="startdate.htm" %><td>&nbsp;至&nbsp;</td><%@ include file="enddate.htm" %>	                
	                
				    <td><a href="#" class="easyui-linkbutton" plain="true" icon="icon-search" id="search">查询</a>
              </table>
            </tr>
        </table>
</div>
</form>
<div class="main_title">
    <div class="white_14_b left">归档策略信息</div>
</div>
<div class="main_iframe"><iframe name="main" width="100%" frameborder="0" height="390" src="../blank.htm"></iframe></div>
</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {   	
    	user.close();
    }
%>