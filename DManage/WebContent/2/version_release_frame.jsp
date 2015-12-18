<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK" session="true" %>
<%@page import="com.adsl.*" %>
<%@page errorPage="../error.jsp" %>
<%
	String menuId = "13#16";
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

        String ls_groupid = request.getParameter("ls_groupid")==null?"":request.getParameter("ls_groupid");
        String ls_cfgid = request.getParameter("ls_cfgid")==null?"":request.getParameter("ls_cfgid");
        String str_disable = "";
        //if ("".equals(ls_groupid)) {
        	str_disable = "disabled";
        //}
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
	    
	    function advancesearch() {
	    	
	    	var vcfgid = document.forms["search"].elements["cfgid"].value;
            w_option = "dialogWidth:780px;dialogHeight:540px;help:No;resizable:No;status:No";
            var a = window.showModalDialog ('version_query_release.jsp',0, w_option);
            //alert(a);
            if (a != null) {
                document.location = "version_release_frame.jsp?ls_groupid="+a+"&ls_cfgid="+vcfgid;
            }
        }
	    
	    function advancesearch2() {
	    	
	    	var vcgroupid = document.forms["search"].elements["groupid"].value;
            w_option = "dialogWidth:700px;dialogHeight:500px;help:No;resizable:No;status:No";
            var a = window.showModalDialog ('version_query_release_cfg.jsp',0, w_option);
            //alert(vcgroupid);
            if (a != null) {
                document.location = "version_release_frame.jsp?ls_cfgid="+a+"&ls_groupid="+vcgroupid;
            }
        }
	    
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
		                    document.forms["search"].action = "version_release.jsp?groupid=<%=ls_groupid%>&cfgid=<%=ls_cfgid%>";
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
	
<body>

<form action="version_release.jsp" target="main" method="post" name="search" style="margin:0">
<div class="main_title">
    <div class="white_14_b left">版本策略发布</div>
</div>
<div class="main_co">
  
        <table cellpadding=2 cellspacing=1 border=0 >
            <tr>
            	<table>   
            		<td align="center">&nbsp;<input class="b9" type="button" value="选择分组" onclick="advancesearch()">&nbsp;<input type="text" name="groupid" class="b9" size="15" maxlength="30" <%=str_disable%> value="<%=ls_groupid%>"></td>          	     
	             	<td align="center">&nbsp;<input class="b9" type="button" value="选择版本" onclick="advancesearch2()">&nbsp;<input type="text" name="cfgid" class="b9" size="15" maxlength="30" <%=str_disable%> value="<%=ls_cfgid%>"></td>          	                               		            
	            	<td align="center">&nbsp;发布时间：</td><%@ include file="startdate.htm" %><td>至</td><%@ include file="enddate.htm" %>	                
	                <td align="center" height="30">&nbsp;发布状态 ：&nbsp; </td>
	               			<td align="center" class="block" height="30">
		                    	<select name="state" class="table_normal" style="border:1;font-size: 12px;width:100px">		
		                    		<option value="-1"></option>	                       
			                        <option value="0">未激活</option>
			                        <option value="1">激活</option>
		                    	</select>
	                </td>
				    <td><a href="#" class="easyui-linkbutton" plain="true" icon="icon-search" id="search">查询</a>
              </table>
            </tr>
        </table>
</div>
</form>
<div class="main_title">
    <div class="white_14_b left">操作面板</div>
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