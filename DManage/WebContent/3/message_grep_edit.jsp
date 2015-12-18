<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page errorPage="error.jsp"%>
<%
    int menuId=21;
%>
<%@ include file="checkauth.jsp"%>
<%
	MessageGrep userStates = null;

	try{
    	
        userStates = new MessageGrep();
        Vector city = userStates.getCity();
        
        String id = request.getParameter("id");
        String ls_type = request.getParameter("city_type");
        String goupid = request.getParameter("goupid");
        String goupname = request.getParameter("goupname");
        String grouptype = request.getParameter("grouptype");
        String school = request.getParameter("school");
        String loginname = request.getParameter("loginname");
        Vector School = userStates.getSchool(ls_type);
        String loginnamestr = request.getParameter("str_loginname");
        String grouptypeold = request.getParameter("grouptypeold");
        String str = "";
        String disnull = "";
        // alert("当前学校下面没有用户或者是您没有选择用户！！");
        if (loginnamestr != null) {
            str = "";
            if (userStates.isNumeric(loginnamestr)) {

                str = userStates.getUserMond(loginnamestr, ls_type, school, grouptype);
                if (str.trim().length() == 0) {
                    disnull = "温馨提示当前学校下面没有用户！！";
%>
<script type="text/javascript">
    alert('<%=disnull%>');
</script>
<%
}else {
    int numcount=userStates.getUserMondCount(loginnamestr, ls_type, school, grouptype);
    if ( numcount< Integer.parseInt(loginnamestr)) {
        disnull = "温馨提示当前学校下面的用户小于" + loginnamestr + "数量，库里实际数量为" + numcount + "！！";
%>
<script type="text/javascript">
    alert('<%=disnull%>');
</script>
<%
                    return;
                }
            }
        } else {
            str = loginnamestr;
        }
    }


        String strdisenable = "";
            if(loginnamestr==null)loginnamestr="";
            if (loginnamestr.trim().length() != 0) {
                if (grouptype.equals("1") || grouptype.equals("2")) {
                strdisenable = "disabled";
            }
        }
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>消息分组---编辑</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bims.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/plugins/jquery.linkbutton.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $('.easyui-linkbutton').linkbutton();
        });

        function modw(){
            goupname=document.forms["mod"].elements["goupname"].value;
            var loginname_add=document.forms["mod"].elements["loginname"].value;
            var strflag='<%=grouptypeold%>';
            if (goupname==""){
                alert("请输入组名！");
                document.forms["add"].elements["goupname"].focus();
                return false;
            }
            var oldloginname=document.forms["mod"].elements["oldloginname"].value;
            if(oldloginname.length==0){
                var grouptype=document.forms["mod"].elements["grouptype"].value;
                document.forms["mod"].elements["group_type"].value=grouptype;
                if(strflag==0){
                    if (grouptype==1||grouptype==2){
                        if (loginname_add==""){
                            alert("用户帐号不能为空！");
                            document.forms["mod"].elements["loginname"].focus();
                            return false;
                        }
                    }
                }
            }else{
                var grouptype=document.forms["mod"].elements["group_type"].value;
                if(strflag==0){
                    if (grouptype==1||grouptype==2){
                        if (loginname_add==""){
                            alert("用户帐号不能为空！");
                            document.forms["mod"].elements["loginname"].focus();
                            return false;
                        }
                    }
                }
            }
            if(!confirm("确实要修改吗？")){
                return;
            }
            document.forms["mod"].action="message_grep_edit_save.jsp?id=<%=id%>&oldgrouptype=<%=grouptypeold%>";
            document.forms["mod"].submit();
        }

        function advancesearch(i)
        {
            var valucity= document.forms['mod'].elements['city_type'].value;
            var valuschool= document.forms['mod'].elements['school_type'].value;
            var valugrouptype= document.forms['mod'].elements['grouptype'].options[document.forms['mod'].elements['grouptype'].selectedIndex].value;
            var goupname = document.forms['mod'].elements['goupname'].value;


            w_option = "dialogWidth:780px;dialogHeight:500px;help:No;resizable:No;status:No";
            a = window.showModalDialog("query_user_share_frame.jsp?citycode="+valucity+"&school="+valuschool+"&group_type="+valugrouptype, 0, w_option);

            if (a != null)
            {
                document.forms['mod'].elements['loginname'+i].value = a;
            }
        }
        
        function getSelect(myForm, myName) {
            val = document.forms[myForm].elements[myName].options[document.forms[myForm].elements[myName].selectedIndex].value;
            document.forms[myForm].elements['city_type'].value = val;
            document.forms[myForm].elements['id'].value = <%=id%>;
            document.forms[myForm].action = "message_grep_edit.jsp";
            document.forms[myForm].target = "";
            document.forms[myForm].submit();

        }
        
        function okfg(){
            var val = document.forms['mod'].elements['grouptype'].options[document.forms['mod'].elements['grouptype'].selectedIndex].value;
            var strflag='<%=grouptypeold%>';
            if(strflag==0){
                if (val == 2||val==1) {
                    /* document.getElementById("addtable").style.display="";*/
                    document.getElementById("ed0").style.display="";
                    document.getElementById("ed12").style.display="none";
                }else{
                    document.getElementById("ed0").style.display="none";
                    document.getElementById("ed12").style.display="none";
                }
            } else{
                if (val == 2||val==1) {
                    /* document.getElementById("addtable").style.display="";*/
                    document.getElementById("ed0").style.display="none";
                    document.getElementById("ed12").style.display="";
                } else  {
                    /*  document.getElementById("addtable").style.display="none";*/
                    document.getElementById("ed0").style.display="none";
                    document.getElementById("ed12").style.display="none";
                }
            }
        }
        
        function del(i,id,ls_type,grouptype,school){

            if(!confirm("确认要删除吗用户？")){
                return;
            }
            document.forms["mod"].action="message_grep_del_user.jsp?ids="+id+"&city_type="+ls_type+"&grouptype="+grouptype+"&school="+school;
            document.forms["mod"].submit();
        }
        
        function moduser(i,id,ls_type,school){
            var loginname=document.forms['mod'].elements['loginname'+i].value;
            if (loginname==""){
                alert("用户帐号不能为空！");
                document.forms["mod"].elements['loginname'+i].focus();
                return false;
            }
            if(!confirm("确认要编辑用户吗？")){
                return;
            }

            document.forms["mod"].action="message_grep_mod_user.jsp?id="+id+"&city_type="+ls_type+"&school="+school+"&loginname="+loginname;
            document.forms["mod"].submit();
        }
        
        function advancesearch0() {

            var valucity= document.forms['mod'].elements['city_type'].value;
            var valuschool= document.forms['mod'].elements['school_type'].value;
            var valugrouptype= document.forms['mod'].elements['grouptype'].options[document.forms['mod'].elements['grouptype'].selectedIndex].value;
            var goupname = document.forms['mod'].elements['goupname'].value;

            w_option = "dialogWidth:780px;dialogHeight:500px;help:No;resizable:No;status:No";
            a = window.showModalDialog("query_user_share_frame_add.jsp?citycode="+valucity+"&school="+valuschool+"&group_type="+valugrouptype, 0, w_option);

            if (a != null)  {
                document.location = "message_grep_edit.jsp?str_loginname=" + a + "&city_type=" + valucity + "&school=" + valuschool + "&grouptype=" + valugrouptype + "&goupname=" + goupname + "&loginname="+a+"&id=<%=id%>&grouptypeold=<%=grouptypeold%>";
            }
        }
        
        function advancesearchw(i) {
            var valucity= document.forms['mod'].elements['city_type'].value;
            var valuschool= document.forms['mod'].elements['school_type'].value;
            var valugrouptype= document.forms['mod'].elements['grouptype'].options[document.forms['mod'].elements['grouptype'].selectedIndex].value;
            var goupname = document.forms['mod'].elements['goupname'].value;

            w_option = "dialogWidth:780px;dialogHeight:500px;help:No;resizable:No;status:No";
            a = window.showModalDialog("query_user_share_frame_add.jsp?citycode="+valucity+"&school="+valuschool+"&group_type="+valugrouptype, 0, w_option);

            if (a != null)  {
                document.location = "message_grep_edit.jsp?str_loginname=" + a + "&city_type=" + valucity + "&school=" + valuschool + "&grouptype=" + valugrouptype + "&goupname=" + goupname + "&loginname="+a+"&id=<%=id%>&grouptypeold=<%=grouptypeold%>";
            }
        }
        
        function adduser(ls_type,school){
            var loginname=document.forms['mod'].elements['loginnamew'].value;
            if (loginname==""){
                alert("用户帐号不能为空！");
                document.forms["mod"].elements['loginnamew'].focus();
                return false;
            }
            if(!confirm("确认要添加用户吗？")){
                return;
            }

            document.forms["mod"].action="message_grep_add_user.jsp?city_type="+ls_type+"&school="+school+"&loginname="+loginname;
            document.forms["mod"].submit();
        }
    </script>
    <style type="text/css">
        .blue_24_b {
            color:#005dc6;
            font-weight:bold;
            font-size:24px;
            font:'Microsoft YaHei','华文细黑','宋体',sans-serif;
            line-height:160%;
        }
        .center {
            text-align:center;
        }
    </style>
</head>

<body onload="okfg();" style="padding-top: 10px">
<form  method="post" target="actions" name="mod">
<table width="80%" align="center"  border="0" cellpadding="0" cellspacing="1" class="tableform">
    <input type="hidden" name="oldloginname" value="<%=loginnamestr%>">
    <input type="hidden" name="city_type" value="<%=ls_type%>">
    <input type="hidden" name="school_type" value="<%=school%>">
    <input type="hidden" name="id" value="<%=id%>">
    <input type="hidden" name="group_type" value="<%=grouptype%>">
    <tr bgcolor="#ffffff" > <input type="hidden" name="goupid" value="<%=goupid%>">
        <td class="title">组名</td> <td class="block" height="30"><input type="text" name="goupname" size="10" style="border:1;font-size: 12px;width:160px" value="<%=goupname%>"></td>
    </tr>
    <tr>  <td class="title">组类别</td>
        <td class="block" height="30">
            <select name="grouptype" <%=strdisenable%> class="table_normal" style="border:1;font-size: 12px;width:160px" onchange="okfg();">
                <option value="0"<%if(grouptype.equals("0")){%>selected="selected" <%}%>>Default</option>
                <option value="1"<%if(grouptype.equals("1")){%>selected="selected" <%}%>>红名单</option>
                <option value="2"<%if(grouptype.equals("2")){%>selected="selected" <%}%>>普通组</option>
            </select>
        </td>
    </tr>
      <tr> <td class="title">所属地区</td><td  class="block" >
            <select id="citycode1" disabled="disabled"  name="citycode" class="table_normal" style="border:1;font-size: 12px;width:160px" onchange="getSelect('mod','citycode');">
                <%
                    for(int j=0;j<city.size();j++){
                        Hashtable ht2=(Hashtable)city.elementAt(j);
                        int citycodes1=Integer.parseInt((String)ht2.get("citycode"));
                        String citynames=(String)ht2.get("cityname");
                        String sel="";
                        if (citycodes1==Integer.parseInt(ls_type)){
                            sel="selected";
                        }else{
                            sel="";
                        }
                       %><option class='b9' value="<%=citycodes1%>" <%=sel%>><%=citynames%><%
                    }
                %>
            </select>
        </td>
      </tr>
    <tr> <td class="title">所属学校</td>
        <td  class="block" >
            <select name="school1" disabled="disabled" class="table_normal" style="border:1;font-size: 12px;width:160px">
                <%
                    for(int j=0;j<School.size();j++){
                        Hashtable ht2=(Hashtable)School.elementAt(j);
                        int schoolids=Integer.parseInt((String)ht2.get("schoolid"));
                        String schoolnames=(String)ht2.get("schoolname");
                        String sel="";
                        if (schoolids==Integer.parseInt(school==null?"0":school)){
                            sel="selected";
                        }else{
                            sel="";
                        }
                        out.println("<option class='b9' value="+schoolids+" "+sel+">"+schoolnames);
                    }
                %>
            </select>
        </td>

    </tr>

    <%
        Vector userinfo=userStates.getVersionGrepUserinfo(id);
    %>
    <tr id="addtable">
        <td class="title" >用户账号</td>
        <td  class="block" height="30" >
            <table  border="0" cellspacing="0" cellpadding="0" id="ed0">
                <tr>
                    <TD class="nm_td size20"><input type="text" name="loginname" class="b9" size="15" maxlength="30" readonly="readonly" value="<%=str%>"></TD>

                    <td><input  class="b9" type="button" value="选择..." onclick="advancesearch0()"></td>
                </tr>
            </TABLE>
            <table align="left"  border="0" cellpadding="0" cellspacing="1" class="tableform" id="ed12">
            <tr>
                <tr>
                    <%-- <td class="title">所属编号</td>--%>
                    <td class="title">用户名</td>
                    <td class="title">操作</td>
                </tr>
                <tr>
                    <%--<td align="center" class="block" height="30"><%=ht2.get("id")%></td>--%>
                    <td align="center" class="block" height="30">
                        <table  border="0" cellspacing="0" cellpadding="0" >
                            <tr>
                                <TD class="nm_td size20"><input type="text" name="loginnamew" class="b9" size="15" maxlength="30" readonly="readonly" value="<%=str%>"></TD>

                                <td><input  class="b9" type="button" value="选择..." onclick="advancesearchw()"></td>
                            </tr>
                        </TABLE>
                    </td>
                    <td align="center">
                        <a id="add" icon="icon-edit"  onclick="adduser('<%=ls_type%>','<%=school%>')" class="easyui-linkbutton" href="#">添加</a>
                    </td>
                </tr>
                <%
                    for(int i=0;i<userinfo.size();i++){
                        Hashtable ht2 = (Hashtable) userinfo.elementAt(i);
                %>
                <tr>
                    <%--<td align="center" class="block" height="30"><%=ht2.get("id")%></td>--%>
                    <td align="center" class="block" height="30">
                        <table  border="0" cellspacing="0" cellpadding="0" >
                            <tr>
                                <TD class="nm_td size20"><input type="text" name="loginname<%=i%>" class="b9" size="15" maxlength="30" readonly="readonly" value="<%=ht2.get("loginname")%>"></TD>

                                <td><input  class="b9" type="button" value="选择..." onclick="advancesearch('<%=i%>')"></td>
                            </tr>
                        </TABLE>
                    </td>
                    <td align="center">
                        <table width="100%">
                            <tr>
                                <td onclick="moduser('<%=i%>','<%=ht2.get("id")%>','<%=ls_type%>','<%=grouptype%>','<%=school%>')" align="center">
                                    <a id="edit1" icon="icon-edit"  class="easyui-linkbutton" href="#">编辑</a>
                                </td>
                                <td onclick="del(<%=i%>,'<%=ht2.get("id")%>','<%=ls_type%>','<%=grouptype%>','<%=school%>')" align="center">
                                    <a id="del" icon="icon-remove"  class="easyui-linkbutton" href="#">删除</a>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <%
                    }
                %>
            </TABLE>
        </td>
    </tr>
    <tr>
        <td align="center" colspan="2">
            <table width="100%">
                <tr>
                    <td  align="center">
                        <a onclick="modw();" id="edit" icon="icon-edit"  class="easyui-linkbutton" href="#">编辑</a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</form>
<iframe name="actions" width="0" height="0" src="../blank.htm" frameborder="0"></iframe>

</body>
</html>
<%
    }finally{
    	userStates.close();
    }
%>
