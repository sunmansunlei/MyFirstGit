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
		Vector city = user.getCity();
		String ls_type = request.getParameter("city_type")==null?"0":request.getParameter("city_type");  
        Vector School = user.getSchool(ls_type);
        Vector osvserion = user.getOsversion();
        Vector access = user.getAccess();
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
	          
	                document.forms["releaseQuery"].submit();
	            })
	        });

            window.name="spare" ;
			function getSelect(myForm, myName) {
	        	
	            val = document.forms[myForm].elements[myName].options[document.forms[myForm].elements[myName].selectedIndex].value;	        
	            document.forms[myForm].elements['city_type'].value = val;
	            
	            document.forms[myForm].action = "version_query_release.jsp";
	            document.forms[myForm].target = "spare";
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
	
	<body style="width:700px">
		<div class="main_title">
		    <div class="white_14_b left">选择版本组</div>
		</div>
		
		<form action="version_query_release_list.jsp" target="main" method="post" name="releaseQuery" style="margin:0">	
		<div class="main_co">		   	       
			<table cellpadding=2 cellspacing=1 border=0 >
            <tr>
	            <table>
	                <input type="hidden" name="city_type" value="<%=ls_type%>">
	                <td align="center" height="30">&nbsp;所属地区&nbsp;</td>
	                <td align="center" class="block" >
	                    <select id="citycodea" name="citycodea" class="table_normal" style="border:1;font-size: 12px;width:220px" onchange="getSelect('releaseQuery','citycodea');">
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
                                if (citycodes1==Integer.parseInt(ls_type==null?"0":ls_type)){
                                    sel="selected";
                                }else{
                                    sel="";
                                }
                                out.println("<option class='b9' value="+citycodes1+" "+sel+">"+ls_trim+citynames);
                            }
                        %>
	                    </select>
	                </td>
	                
	                <td align="center"  height="30">&nbsp;所属学校&nbsp;</td>
	                <td align="center" class="block" >
	                    <select name="school" class="table_normal" style="border:1;font-size: 12px;width:300px">
	                        <%
	                            for(int j=0;j<School.size();j++){
	                                Hashtable ht2=(Hashtable)School.elementAt(j);
	                                int schoolids=Integer.parseInt((String)ht2.get("schoolid"));
	                                String schoolnames=(String)ht2.get("schoolname");
	                                
	                                out.println("<option class='b9' value="+schoolids+" >"+schoolnames);
	                            }
	                        %>
	                    </select>
	                </td>			           			                                            
	            </table>
	            </tr>
	                 		
	           <tr>
	            	<table>       	            	
		            	<td class="title">&nbsp;系统版本&nbsp;</td>
			        	<td   height="30" class="block">
			            <select name="osid" class="table_normal" style="border:1;font-size: 12px;width:100px">
			            	<option value="-1"></option>
			                <%
			                    for(int j=0;j<osvserion.size();j++){
			                        Hashtable ht2 = (Hashtable)osvserion.elementAt(j);
			                        int osId = Integer.parseInt((String)ht2.get("osid"));
			                        String osName = (String)ht2.get("osname");
			                        out.println("<option class='b9' value="+osId+">"+osName);
			                    }
			                %>
			            </select></td> 
			            	
		               <td class="title">&nbsp;客户端类型&nbsp;</td>
				        <td  class="block" height="30">
				            <select name="accessid" class="table_normal" style="border:1;font-size: 12px;width:100px">
				            <option value="-1"></option>
				                <%
				                    for(int j=0;j<access.size();j++){
				                        Hashtable ht2 = (Hashtable)access.elementAt(j);
				                        int accessids = Integer.parseInt((String)ht2.get("accessid"));
				                        String accessnames = (String)ht2.get("accessname");
				                        out.println("<option class='b9' value="+accessids+">"+accessnames);
				                    }
				                %>
				            </select></td>  
				                   
		            	<td align="center" height="30">&nbsp;分组类别 &nbsp;&nbsp; </td>
		               			<td align="center" class="block" height="30">
			                    	<select name="grouptype" class="table_normal" style="border:1;font-size: 12px;width:100px">
			                    	<option value="-1"></option>
				                        <option value="0">Default</option>
				                        <option value="1">红名单</option>
				                        <option value="2">普通组</option>
			                    	</select>
		                </td>
		                	             			            
					    <td><a href="#" class="easyui-linkbutton" plain="true" icon="icon-search" id="search">查询</a></td>
	                </table>
	            </tr>
	        </table>	    
		</div>
		</form>
		
		<div class="main_title">
		    <div class="white_14_b left">查询结果</div>
		</div>
		<div class="main_iframe">
		    <iframe name="main" width="100%" frameborder="0" height="300" src="../blank.htm"></iframe>
		</div>
	</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
    	user.close();
    }
%>