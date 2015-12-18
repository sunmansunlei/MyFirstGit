<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK" session="true" %>
<%@page import="com.adsl.*" %>
<%@page errorPage="../error.jsp" %>
<%
	String menuId = "11#15";
%>
<%@ include file="./checkauth.jsp" %>
<%
    try{
    	
        String citycodes=request.getParameter("citycode");
        String school=request.getParameter("school");
        String grouptype=request.getParameter("grouptype");
        String osid_id=request.getParameter("osid_id");
        String accessid_id=request.getParameter("accessid_id");
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
                    alert("�ϴβ�ѯ���ڽ����У�");
                    return;
                }
                /* if (document.forms["searchbusiness"].elements["loginname"].value == "") {
                 alert("δ�����û���½��!");
                 return;
                 }*/
                document.forms["searchbusiness"].submit();
            }) ;

        });

        function ok(i){
            if (i == 1) {
                document.getElementById("tables").style.display="none";
                document.getElementById("div1").style.display="none";
                document.getElementById("div2").style.display="none";
                document.getElementById("div3").style.display="none";
                document.getElementById("div4").style.display="none";
                document.getElementById("del1").style.display="";

            } else if (i == 2) {
                document.getElementById("tables").style.display="";
                document.getElementById("div1").style.display="";
                document.getElementById("div2").style.display="";
                document.getElementById("div3").style.display="";
                document.getElementById("div4").style.display="";
                document.getElementById("del1").style.display="none";
            }
        }

        function type1(myForm){

             var retur;
            var msg;
            retur=document.forms[myForm].elements['loginnamenum'].value;
            if(retur==""){
                alert("����дҪ�������û��ʺŸ�������")
                    return false;
            }
            msg="���ѡ��ǰ";
            if(confirm(msg+retur+"���û�?"))
            {
                parent.parent.window.returnValue=retur;
                parent.parent.window.close();
            }
        }

        var types=-1;
        function type3(){
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
                    alert('��ѡ���û�');
                    return false;
                } else if (r.checked) {
                    strKey = r.value + ",";
                } else {
                    alert('��ѡ���û�');
                    return false;
                }
            }
            msg="�û��˺�";
            if(confirm("ѡ��"+msg+"Ϊ"+strKey+"���û�?"))
            {
                parent.parent.window.returnValue=strKey;
                parent.parent.window.close();
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
<body>
<div class="main_title">
    <div class="white_14_b left">ѡ���û���Ϣ��ѯ</div>
</div>
<div class="main_co">
    <form target="main" method="post" name="search" style="margin:0">
        <table cellpadding=2 cellspacing=1 border=0>
            <tr>

                <td> <input name="rad" onclick="ok('1');" type="radio" id="rad0" value="1" >���ѡ��</td>
                <td>
                    <input name="loginnamenum" type="Text"></td>
                <td >  <a id="del1" onclick="type1('search');"  icon="icon-ok"  class="easyui-linkbutton" href="#" style="display: none;">ȷ��</a></td>
            </tr>
            <tr>
                <td> <input name="rad" onclick="ok('2');" type="radio"  id="rad1" value="2" >�˹�ѡ��</td>
                <td >
                </td>
            </tr>

        </table>
    </form>
</div>
<div class="main_title" id="div3" style="display: none;">
    <div class="white_14_b left">�û���Ϣ��ѯ</div>
</div>
<div class="main_co" id="div4" style="display: none;">
    <form action="version_user_lists.jsp" target="main" method="post" name="searchbusiness" style="margin:0">
        <table cellpadding=2 cellspacing=1 border=0 id="tables" style="display: none;">
            <tr>

                <td>�û���½����</td>
                <td>
                    <input name="loginname" type="Text"></td>
                <input name="school" type="HIDDEN" value="<%=school%>">
                <input name="citycode" type="HIDDEN" value="<%=citycodes%>">
                <input name="grouptype" type="hidden" value="<%=grouptype%>">
                <input name="osid_id" type="HIDDEN" value="<%=osid_id%>">
                <input name="accessid_id" type="HIDDEN" value="<%=accessid_id%>">
                <%-- <td>
                   ѧУ��
                </td>
                <td>
                    <select name="school" class="table_normal" style="border:1;font-size: 12px;width:160px">
                        <%
                            VersionGrep userStates=new VersionGrep();
                            Vector School = userStates.getSchool(citycodes);
                            for(int j=0;j<School.size();j++){
                                Hashtable ht2=(Hashtable)School.elementAt(j);
                                int schoolids=Integer.parseInt((String)ht2.get("schoolid"));
                                String schoolnames=(String)ht2.get("schoolname");
                                String sel="";

                                out.println("<option class='b9' value="+schoolids+" "+sel+">"+schoolnames);
                            }
                        %>
                    </select>
                </td>--%>
                <td>
                    <a href="#" class="easyui-linkbutton" plain="true" icon="icon-search" id="search">��ѯ</a>
                </td>
                <td>
                    <a href="#" onclick="type3();" class="easyui-linkbutton" plain="true" icon="icon-edit" id="edit">ȷ��</a>
                </td>
                <td>

                </td>

            </tr>
        </table>
    </form>
</div>
<div class="main_title" id="div1" style="display: none;">
    <div class="white_14_b left">��ѯ���</div>
</div>
<div class="main_iframe" id="div2"  style="display: none;">
    <iframe name="main" width="100%" frameborder="0" height="470" src="../new_main.jsp"></iframe>
</div>
</body>
</html>
<%
    } catch (Exception e) {
        System.out.println("ÿ��������¼:" + e);
    } finally {
    }
%>