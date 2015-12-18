<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page errorPage="error.jsp"%>
<%
	int menuId=34;
%>
<%@ include file="./checkauth.jsp"%>

<html>
 <%
 	ConstraGrep userStates = null;
 
    try{
        userStates=new ConstraGrep();
        Vector city = userStates.getCity();
        String ls_type = request.getParameter("city_type")==null?"1":request.getParameter("city_type");
        String school_type = request.getParameter("school_type");
        Vector School = userStates.getSchool(ls_type);

%>
 <head>
     <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
     <title>控制策略分组</title>

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

                    document.forms["search"].submit();
                });
            });

            function getSelect(myForm, myName) {
                val = document.forms[myForm].elements[myName].options[document.forms[myForm].elements[myName].selectedIndex].value;
                document.forms[myForm].elements['city_type'].value = val;               
                document.forms[myForm].action = "conStra_redlist_frame.jsp";
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
    
    <body >
    <div class="main_title">
        <div class="white_14_b left">红名单组</div>
    </div>
    <div class="main_co">

        <form action="conStra_redlist.jsp" target="main" method="post" name="search" style="margin:0">
            <table cellpadding=2 cellspacing=1 border=0 >
                <tr>
                    <input type="hidden" name="city_type" value="<%=ls_type%>">
                    <td align="center" height="30">&nbsp;所属地区：&nbsp;</td>
                    <td align="center" class="block" >
                        <select id="citycodea" name="citycodea" class="table_normal" style="border:1;font-size: 12px;width:220px" onchange="getSelect('search','citycodea');">
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

                                for(int j=0;j<School.size();j++){
                                    Hashtable ht2=(Hashtable)School.elementAt(j);
                                    int schoolids=Integer.parseInt((String)ht2.get("schoolid"));
                                    String schoolnames=(String)ht2.get("schoolname");
                                    String sel="";
                                    if(schoolids==Integer.parseInt(school_type==null?(String)ht2.get("schoolid"):school_type)){
                                        sel="selected";
                                    }else{
                                        sel="";
                                    }
                                    out.println("<option class='b9' value="+schoolids+" "+sel+">"+schoolnames);
                                }
                            %>
                        </select>
                    </td>
            
                    <td>
                        <a href="#" class="easyui-linkbutton" plain="true" icon="icon-search" id="search">&nbsp;查询</a>
                    </td>
                  
                </tr>
            </table>
        </form>
    </div>
    <div class="main_title">
        <div class="white_14_b left">查询结果</div>
    </div>
    <div class="main_iframe">
        <iframe name="main" width="100%" frameborder="0" height="390" src="../blank.htm"></iframe>
    </div>
    </body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
    	userStates.close();
    }
%>
