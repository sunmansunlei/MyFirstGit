<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK" language="java" %>
<%@ include file="menu_include.jsp"%>
<html>
<head>
    <style type="text/css">
        *{margin:0; padding:0;}
        a{color:#FFF;}
        .body{font-family:"微软雅黑" ; font-size:12px;}
        .header{height:60px; width:100%; float:left; background:url(img/top_bg.jpg) repeat-x; float:left;}
        .header .left{ width:796px; height:60px; background:url(img/logo.jpg); float:left;}
        .header .right{ width:310px; height:60px; background:url(img/3.jpg); float:right;}
        .header .right .name{ width:251px; height:60px; float:right;  color:#FFF; background:url(img/rlLinks.png) no-repeat bottom ;}
        .header .right .name .admin{ width:131px; height:60px;  padding-top:40px; float:left; text-align:right;}
        .header .right .name .out{ width:100px; height:20px;   float:left; background:url(img/logout.png) no-repeat; margin-top:20px; margin-left:20px; padding-top:2px;    }
        .header .right .name .out a{  color:#FFF; text-decoration:none;}
        .header .right .name .out a:hover{ color: #F00; text-decoration:none; font-weight:bold;}
        .nav{width:100%; height:33px; background: url(img/bar_bg.jpg) repeat-x #1a6cdc bottom; float:left;}
        .navgation{width:100%; height:28px; float:left; margin:0; padding:0;}
        .navgation li {width:121px; height:25px; float:left; list-style:none; color:#FFF; text-align:center; padding-top:4px; background:url(img/li.png)  center no-repeat; }
        .navgation li a{text-decoration:none;}
        .navgation li:hover{width:121px; height:25px; float:left; list-style:none; color:#FFF; text-align:center; padding-top:4px; background:url(img/ali.png)  center no-repeat; }
        .cur{ background:url(img/acli.png);width:120px; height:23px; float:left;color:#593e07; font-weight:bold; padding-top:1px;}

 </style>
    <script language="JavaScript">

        function about(){
            parent.frames["main"].document.location="about.html";
            document.all["menuname"].innerText="关于";
        }

        function exit(){
            if(confirm("您确定要退出吗？")){
                top.document.location="./";
            }
        }

        function goOldSystem(){
            if(confirm("您确定要跳转到老系统么？")){
                top.document.location="http://221.192.190.15:8005";
            }
        }

        function changePWD(){
            parent.frames["main"].document.location="changepwd.jsp";
            document.all["menuname"].innerText="修改密码";
        }
        function changetopmenuid(id){
            var topid=document.getElementById('topid').value;
            if(topid!=id){
                document.getElementById(id).className='cur';

                document.getElementById(topid).className='';
                document.getElementById('topid').value=id;

            }
            window.parent.frames['leftFrame'].location="menu_left.jsp?topid="+id+"";
            parent.frames["mainFrame"].document.location="blank.htm";
        }
    </script>
    <title></title>
</head>
<%
    Menu[] topmenus = (Menu[])session.getAttribute("topmenus");
    
    if(topmenus == null)
        return;
    String topid=request.getParameter("topmenuid");
    if(topid==null||topid==""){
        topid="first";
    }
%>
<body >
<form name="menu" >
    <div class="body">
    <div class="header">
        <div class="left"></div>
        <div class="right">
            <div class="name">&nbsp; &nbsp; &nbsp; &nbsp;<div class="admin">当前操作员：<%=userInfo.get("login")%> </div><div class="out">&nbsp;&nbsp;&nbsp; &nbsp;<a href="#" onclick="exit();">退出</a></div></div>

        </div>

    </div>
        <div class="nav">
            <ul class="navgation">
            <%
                for(int i=0;i<topmenus.length;i++){
                    Menu topmenu = topmenus[i];
                    int id=topmenu.getId();
                    int father=topmenu.getFather();
                    String url=topmenu.getUrl();
                    String name=topmenu.getName();
                    if("first".equals(topid)){
                        topid=String.valueOf(id);;
            %>
            <li ><a href='#'class="cur" id="<%=id %>" onclick="javascript:changetopmenuid('<%=id %>');"><%=name %></a></li>
            <%
            }else{
            %>
            <li ><a href='#' class="" id="<%=id %>" onclick="javascript:changetopmenuid('<%=id %>');"><%=name %></a></li>
            <%
                    }
                }
            %>
            </ul>
        </div>
        <input type="hidden" name="topid" id="topid" value="<%=topid %>">

</div>
        </div>
    </form>
</body>
</html>