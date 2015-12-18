<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK" session="true" %>
<%@page import="com.adsl.*" %>
<%@page import="java.util.*" %>
<%@page errorPage="../error.jsp" %>
<%
	String menuId = "35";
%>
<%
	
	ConStraCR user = null;
    
	try {
    	
		user = new ConStraCR();
			
        Vector city = user.getCity();
        String ls_type = request.getParameter("city_type")==null?"1":request.getParameter("city_type");
        String school_type = request.getParameter("school_type");           
        Vector School = user.getSchool(ls_type);
        
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

	                document.forms["search"].submit();
	            });
	            
	            $('#add').click(function() {
	                citycodea = document.forms["search"].elements["citycodea"].value;
	                if(citycodea==""){
	                    alert("所属地区不能为空！");
	                    return false;
	                }
	                
	                school = document.forms["search"].elements["school"].value;	
	                if(school==""){
	                    alert("所属学校不能为空！");
	                    return false;
	                }
					
	                var startyear = document.forms["search"].elements["startyear"].value;
		            var endyear = document.forms["search"].elements["endyear"].value;
		            var startmonth = document.forms["search"].elements["startmonth"].value;
		            var endmonth = document.forms["search"].elements["endmonth"].value;
		            var startday = document.forms["search"].elements["startday"].value;
		            var endday = document.forms["search"].elements["endday"].value;
	                
	                var valucity = document.forms['search'].elements['citycodea'].options[document.forms['search'].elements['citycodea'].selectedIndex].value;
	                var valuschool = document.forms['search'].elements['school'].options[document.forms['search'].elements['school'].selectedIndex].value;
	                var vagrouptype = document.forms['search'].elements['grouptype'].options[document.forms['search'].elements['grouptype'].selectedIndex].value;
                    var msgname = document.forms["search"].elements["msgname"].value;
	                var starttime1 = new Date(document.getElementById("startyear").value,document.getElementById("startmonth").value-1,document.getElementById("startday").value);
	                var endtime1 = new Date(document.getElementById("endyear").value,document.getElementById("endmonth").value-1,document.getElementById("endday").value);
	                ss=(endtime1-starttime1)/1000/60/60/24;
	                if(ss<0){
	                	alert("选择发布时间时，结束时间必须大于起始时间！");
	                    return;
	                }
	                
	                document.frames['main'].location="conStra_release.jsp?school_type="+valuschool+"&city_type="+valucity+"&grouptype="+vagrouptype+"&startyear="+startyear+"&endyear="+endyear+"&startmonth="+startmonth+"&endmonth="+endmonth+"&startday="+startday+"&endday="+endday+"&msgname="+msgname;
	            })
	        });
	
	        function getSelect(myForm, myName) {
	        	
	            val = document.forms[myForm].elements[myName].options[document.forms[myForm].elements[myName].selectedIndex].value;
	            document.forms[myForm].elements['city_type'].value = val;
	            document.forms[myForm].action = "conStra_release_frame.jsp";
	            document.forms[myForm].target = "";
	            document.forms[myForm].submit();	
	        }
            function type3delete(){
                var startyear = document.forms["search"].elements["startyear"].value;
                var endyear = document.forms["search"].elements["endyear"].value;
                var startmonth = document.forms["search"].elements["startmonth"].value;
                var endmonth = document.forms["search"].elements["endmonth"].value;
                var startday = document.forms["search"].elements["startday"].value;
                var endday = document.forms["search"].elements["endday"].value;

                var valucity = document.forms['search'].elements['citycodea'].options[document.forms['search'].elements['citycodea'].selectedIndex].value;
                var valuschool = document.forms['search'].elements['school'].options[document.forms['search'].elements['school'].selectedIndex].value;
                var vagrouptype = document.forms['search'].elements['grouptype'].options[document.forms['search'].elements['grouptype'].selectedIndex].value;

                var msg;
                var strKey = "";
                var r = window.frames['main'].document.getElementsByName("order");
                for (var i = 0; i < r.length; i++) {
                    if (r[i].checked) {
                        strKey = strKey + r[i].value + ",";
                    }
                }
                if (strKey == "") {
                    if (r.length > 0) {
                        alert('请选择要删除维护策略');
                        return false;
                    } else if (r.checked) {
                        strKey = r.value + ",";
                    } else {
                        alert('请选择要删除维护策略');
                        return false;
                    }
                }
                if(confirm("确定好删除选择的维护策略，此操作不可恢复?"))
                {
                    document.frames['main'].location="conStra_release_del_batch.jsp?school_type="+valuschool+"&city_type="+valucity+"&grouptype="+vagrouptype+"&startyear="+startyear+"&endyear="+endyear+"&startmonth="+startmonth+"&endmonth="+endmonth+"&startday="+startday+"&endday="+endday+"&strKey="+strKey;
                }
            }
	    </script>
	    <style type="text/css">
	        * {
	            font-size: 12px;
	        }
	    </style>
	
	    <title></title>
	</head>
	
<body style="width:1100px">
<div class="main_title">
    <div class="white_14_b left">查询</div>
</div>
<div class="main_co">

    <form target="main" action="conStra_release.jsp" method="post" name="search" style="margin:0">
        <table cellpadding=2 cellspacing=1 border=0 >
            <tr>
            <table>
                <input type="hidden" name="city_type" value="<%=ls_type%>">
                <td align="center" height="30">&nbsp;所属地区：&nbsp;</td>
                <td align="center" class="block" >
                    <select id="citycodea" name="citycodea" class="table_normal" style="border:1;font-size: 12px;width:250px" onchange="getSelect('search','citycodea');">
                        <%

                            for(int j=0;j<city.size();j++){
                                Hashtable ht2=(Hashtable)city.elementAt(j);
                                int citycodes1=Integer.parseInt((String)ht2.get("citycode"));
                                String citynames=(String)ht2.get("cityname");
                                String ls_trim="";
                                int levelid=Integer.parseInt((String)ht2.get("levels"));
                                for (int i=0;i<levelid;i++) {
                                    ls_trim+="　";
                                }
                                String sel="";
                                if (citycodes1==Integer.parseInt(ls_type==null?"1":ls_type)){
                                    sel="selected";
                                }else{
                                    sel="";
                                }
                                out.println("<option class='b9' value="+citycodes1+" "+sel+">"+ls_trim+citynames);
                            }
                        %>
                    </select>
                </td>
                
                <td align="center"  height="30">&nbsp;所属学校：&nbsp;</td>
                <td align="center" class="block" >
                    <select name="school" class="table_normal" style="border:1;font-size: 12px;width:250px">
                        <%
                           if(School.size()>0){
                               %>
                          <option value="-1" selected="selected">所有</option>
                        <%
                           }
                            for(int j=0;j<School.size();j++){
                                Hashtable ht2=(Hashtable)School.elementAt(j);
                                int schoolids=Integer.parseInt((String)ht2.get("schoolid"));
                                String schoolnames=(String)ht2.get("schoolname");
                                String sel="";
                                if(schoolids==Integer.parseInt(school_type==null?"-1":school_type)){
                                    sel="selected";
                                }else{
                                    sel="";
                                }
                                out.println("<option class='b9' value="+schoolids+" "+sel+">"+schoolnames);
                            }
                        %>
                    </select>
                </td>
                				            
				<td align="center" height="30">&nbsp;分组类型：&nbsp;</td>
				<td align="center" class="block" height="30" >
					<select name="grouptype" class="table_normal"  style="border:1;font-size: 12px;width:120px">
				                	<option value="-1"></option>
				                    <option value="0">Default</option>
				                    <option value="2" selected="selected">普通组</option>
				                </select>
				</td>
				</table>
				</tr>
				<tr>
				<table>
				
                   <td align="center">&nbsp;发布时间：</td><%@ include file="startdate.htm" %><td>&nbsp;至&nbsp;</td><%@ include file="enddate.htm" %>
                    <td>控制策略名称：</td>
                    <td><input type="text" name="msgname"></td>
	                <td>&nbsp;<a id="add"  icon="icon-add" plain="true" class="easyui-linkbutton" href="#">查询</a></td>

                    <td>&nbsp;<a id="del" onclick="type3delete();"  icon="icon-edit" plain="true" class="easyui-linkbutton" href="#">批量删除</a></td>
	              </table>
	        	</tr>
	        </table>
	    </form>
	</div>
	<div class="main_title">
	    <div class="white_14_b left">操作面板</div>
	</div>
	<div class="main_iframe"><iframe name="main" width="100%" frameborder="0" height="380" src="../blank.htm"></iframe></div>
	</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {   	
    	user.close();
    }
%>
