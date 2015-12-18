<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK" session="true" %>
<%@page errorPage="../error.jsp" %>
<%@page import="com.sun.service.VersionGrepService" %>
<%@page import="com.sun.service.VersionGrepServiceImpl" %>
<%@page import="org.springframework.web.context.WebApplicationContext" %>
<%
    int menuId = 11;
%>
<%@ include file="../checkauth.jsp" %>
<%
	
	WebApplicationContext context = (WebApplicationContext)this.getServletContext().getAttribute(WebApplicationContext.ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE);  
	VersionGrepService userStates = (VersionGrepServiceImpl)context.getBean("VersionGrepService");
    
	try {
    	 
        Vector city = userStates.getCity();
        String ls_type = request.getParameter("city_type")==null?"1":request.getParameter("city_type");
        String school_type = request.getParameter("school_type");
        String group_type = request.getParameter("group_type")==null?"":request.getParameter("group_type");//group_type       
        Vector School = userStates.getSchool(ls_type);
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
	        $(document).ready(function() {
	            $('.easyui-linkbutton').linkbutton();
	            $('#search').click(function() {
	                loading = document.frames["main"].document.readyState;
	                if (loading != "complete") {
	                    alert("上次查询正在进行中！");
	                    return;
	                }
	               /* if (document.forms["searchbusiness"].elements["loginname"].value == "") {
	                    alert("未输入用户登陆名!");
	                    return;
	                }*/
	                document.forms["search"].submit();
	            });
	            $('#add').click(function() {
	                citycodea=document.forms["search"].elements["citycodea"].value;
	                school=document.forms["search"].elements["school"].value;
	
	                if (school==""){
	                    alert("所属学校不能为空！");
	                    return false;
	                }
	
	                if (citycodea==""){
	                    alert("所属地区不能为空！");
	                    return false;
	                }
	                var valugrouptype= document.forms['search'].elements['grouptype'].options[document.forms['search'].elements['grouptype'].selectedIndex].value;
	                var valucity= document.forms['search'].elements['citycodea'].options[document.forms['search'].elements['citycodea'].selectedIndex].value;
	                var valuschool= document.forms['search'].elements['school'].options[document.forms['search'].elements['school'].selectedIndex].value;
	                //if(!confirm("添加的所属地区为当前查询条件所选的地区！")){
	                //    return;
	                //}
	                document.frames['main'].location="Version_grep_add.jsp?school_type="+valuschool+"&city_type="+valucity+"&grouptype="+valugrouptype;
	            })
	        });
	
	        function getSelect(myForm, myName) {
	        	
	            val = document.forms[myForm].elements[myName].options[document.forms[myForm].elements[myName].selectedIndex].value;
	            var valugrouptype= document.forms['search'].elements['grouptype'].options[document.forms['search'].elements['grouptype'].selectedIndex].value;
	
	            document.forms[myForm].elements['city_type'].value = val;
	            document.forms[myForm].elements['group_type'].value = valugrouptype;
	            document.forms[myForm].action = "Version_grep_frame.jsp";
	            document.forms[myForm].target = "";
	            document.forms[myForm].submit();	
	        }
	    </script>
	    <style type="text/css">
	        * {
	            font-size: 12px;
	        }
	    </style>
	
	    <title></title>
	</head>
<body>
<div class="main_title">
    <div class="white_14_b left">查询条件</div>
</div>
<div class="main_co">

    <form action="version_grep.jsp" target="main" method="post" name="search" style="margin:0">
        <table cellpadding=2 cellspacing=1 border=0 >
            <tr>
                <input type="hidden" name="city_type" value="<%=ls_type%>">
                <input type="hidden" name="group_type" value="<%=group_type%>">
                <td align="center" height="30">&nbsp;所属地区：&nbsp;</td>
                <td align="center" class="block" >
                    <select id="citycodea" name="citycodea" class="table_normal" style="border:1;font-size: 12px;width:220px" onchange="getSelect('search','citycodea');">
                        <%

                            for(int j=0;j<city.size();j++){
                                Hashtable ht2=(Hashtable)city.elementAt(j);
                                int citycodes1= (Integer)ht2.get("citycode");
                                String citynames=(String)ht2.get("cityname");
                                String ls_trim="";
                                int levelid=(Integer)ht2.get("levels");
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
                    <select name="school" class="table_normal" style="border:1;font-size: 12px;width:220px">
                        <%

                            for(int j=0;j<School.size();j++){
                                HashMap ht2=(HashMap)School.elementAt(j);
                                int schoolids= (Integer)ht2.get("schoolid");
                                String schoolnames=(String)ht2.get("schoolname");
                                String sel="";
                                if(schoolids==Integer.parseInt(school_type==null?ht2.get("schoolid").toString():school_type)){
                                    sel="selected";
                                }else{
                                    sel="";
                                }
                                out.println("<option class='b9' value="+schoolids+" "+sel+">"+schoolnames);
                            }
                        %>
                    </select>
                </td>
                <td align="center" height="30">&nbsp;组类别：&nbsp;</td>
                <td align="center" class="block" height="30">
                    <select name="grouptype" class="table_normal" style="border:1;font-size: 12px;width:80px">
                        <option value="">请选择</option>
                        <option value="0"<%if(group_type.equals("0")){%>selected="selected" <%}%>>Default</option>
                        <option value="1"<%if(group_type.equals("1")){%>selected="selected" <%}%>>红名单</option>
                        <option value="2"<%if(group_type.equals("2")){%>selected="selected" <%}%>selected="selected">普通组</option>
                    </select>
                </td>
                <td>
                    <a href="#" class="easyui-linkbutton" plain="true" icon="icon-search" id="search">查询</a>
                </td>
                <td >
                    <a id="add"  icon="icon-add" plain="true" class="easyui-linkbutton" href="#">添加</a>

                </td>
                <td>

                </td>

            </tr>
        </table>
    </form>
</div>
<div class="main_title">
    <div class="white_14_b left">查询结果</div>
</div>
<div class="main_iframe"><iframe name="main" width="100%" frameborder="0" height="390" src="../blank.htm"></iframe></div>
</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }  
%>