<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="menu_include.jsp"%>
<html>

<head>
    <link rel="stylesheet" rev="stylesheet" href="css/css.css" type="text/css" media="all"/>
</head>

<script type="text/javascript">
    function changesubid(id){
        var a=document.getElementById(id);
        if(a.style.display == "none"){
            a.style.display = "block";
            var str='img'+id;
            document.getElementById('img'+id).setAttribute("src","./img/ico_002.gif");

        }else{a.style.display = "none";
            var str='img'+id;
            document.getElementById('img'+id).setAttribute("src","./img/ico_003.gif");
        }
    }

    function plow(str,event,flag){

        if(document.getElementsByTagName('div')){
            var arrLink = document.getElementsByTagName('div');
            for(i = 0; i < arrLink.length; i++) {
                var link = arrLink[i];
                if(link.className == 'left_font_weight') {
                    link.className = 'left';
                }else if(link.className == 'red_14_b left') {
                    link.className = 'white_14_b left';
                }
            }
        }
        if(flag==1) {
            event.className = 'red_14_b left';
        }else if(flag==2) {
            event.className = 'left_font_weight';
        }


        if(str=="")
        {
            alert("对不起您没有权限查看子菜单！请联系超级管理员！");
            parent.frames['mainFrame'].location='../new_main.jsp';
            return;
        }
        parent.frames['mainFrame'].location='./'+str;

    }
</script>
<body class="left_body"  >
<form name="left">
    <%
    	Menu[] topmenus = (Menu[])session.getAttribute("topmenus");
        if(topmenus == null)
            return;
        String topid=request.getParameter("topid");
        if(topid==null||topid=="") topid="first";
        for(int i = 0; i < topmenus.length; i++) {
            Menu topmenu = topmenus[i];
            if(topmenu.getId()==((!"first".equals(topid))? Integer.parseInt(topid):((Menu)topmenus[0]).getId())){
                Menu[] subMenus = topmenu.getSubMenu();
                if(subMenus != null) {
                    for(int j = 0; j < subMenus.length; j++) {

                        Menu subMenu = subMenus[j];
                        int subid=subMenu.getId();
                        int subfather=subMenu.getFather();
                        String subname=subMenu.getName();
                        String suburl=subMenu.getUrl();
                        Menu[] subMenus2 = subMenu.getSubMenu();



                        if(subMenus2 != null) {
    %>
    <a class="left_title01" href="#"  onclick="javascript:changesubid('<%=subid %>');">
        <div class="white_14_b left"><%=subname %></div>
        <div class="right"><img name=<%="img"+subid %> id=<%="img"+subid %> src="./img/ico_003.gif" /></div>
    </a>
    <div style="display:none" name='<%=subid %>' id='<%=subid %>' class="left_co" >
        <%
            for(int k = 0; k < subMenus2.length; k++) {
                Menu subMenu2 = subMenus2[k];
                int sub2id=subMenu2.getId();
                int sub2father=subMenu2.getFather();
                String sub2name=subMenu2.getName();
                String sub2url=subMenu2.getUrl();
        %>

        <a class="left_co_li" href="#">
            <div class="left left_co_li_ico"><img src="./img/ico_004.gif" /></div>
            <div class="left" onclick="plow('<%=sub2url %>',this,2)"><%=sub2name %></div>
        </a>
        <%
            }
        %>
    </div>
    <%
    }else{
    %>
    <a class="left_title01" href="#">
        <div class="white_14_b left" onclick="plow('<%=suburl %>',this,1)" ><%=subname %></div>
        <div class="right"  ></div>
    </a>
    <%
                        }
                    }
                }
            }
        }
    %>


</form>
</body>
</html>
