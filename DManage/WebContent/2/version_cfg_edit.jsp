<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page errorPage="error.jsp"%>
<%
    int menuId=12;
%>
<%@ include file="checkauth.jsp"%>
<%
    try{
        VersionCfg userStates=new VersionCfg();
        String id=request.getParameter("id");
        String osid = request.getParameter("osid");
        String accessid = request.getParameter("accessid");
        String stdver = request.getParameter("stdver");
        Hashtable hashtable=userStates.getVersionCfg(id);
        Vector osvserion = userStates.getOsversion();
        Vector access = userStates.getAccess();
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>版本配置---编辑</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bims.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/icon.css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/plugins/jquery.linkbutton.js"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            $('.easyui-linkbutton').linkbutton();
        });

        function ok(){
            var val= document.forms['mod'].elements['opetype'].options[document.forms['mod'].elements['opetype'].selectedIndex].value;

            if (val == 5) {
                document.getElementById("opesecid").style.display="";

            } else  {
                document.getElementById("opesecid").style.display="none";
            }

            document.getElementById("fil2").style.display="none";
            document.getElementById("fil1").style.display="";
        }
        function modqq() {
            var stdver = document.forms["mod"].elements["stdver"].value;

            var chidver = document.forms["mod"].elements["chidver"].value;

            var fileid=document.forms["mod"].elements["fileid"].value;

            var filemd5=document.forms["mod"].elements["filemd5"].value;

            var filemd5s=document.forms["mod"].elements["filemd5s"].value;

            var opesec=document.forms["mod"].elements["opesec"].value;

            var opetype=document.forms["mod"].elements["opetype"].value;

            var filetmppath=document.forms["mod"].elements["filetmppath"].value;

            var opeworkpath=document.forms["mod"].elements["opeworkpath"].value;

            var opetargetpath=document.forms["mod"].elements["opetargetpath"].value;

            var opecmd=document.forms["mod"].elements["opecmd"].value;

            var filetype = document.forms["mod"].elements["filetype"].value;

            var accessid = document.forms["mod"].elements["accessid"].value;

            var osid=document.forms["mod"].elements["osid"].value;

            if (stdver == "") {
                alert("标准版本号不能为空！");
                return false;
            }

            if (chidver == "") {
                alert("子版本号不能为空！");
                document.forms["mod"].elements["chidver"].focus();
                return false;
            }
            if(fileid==""){
                 filemd5=document.forms["mod"].elements["filemd5s"].value;
            }
            if (filemd5 == "") {
                if (fileid == "") {
                    alert("请选择上传安装包文件！");
                    return false;
                }
            }
            if (filemd5 == "") {
                alert("上传安装包的Md5摘要不能为空！");
                return false;
            }

            if (opetype == 5) {
                if (opesec == "") {
                    alert("延迟时间不能为空！");
                    document.forms["mod"].elements["opesec"].focus();
                    return false;
                }
                if (opesec != "") {
                    var myreg = /^\d+$/;
                    if (!myreg.test(trim(opesec))) {
                        alert("延迟时间只能输入一个正整数");
                        return false;
                    }
                }
            }
            if (filetmppath == "") {
                alert("客户端下载文件路径不能为空！");
                return false;
            }
            if (opeworkpath == "") {
                alert("执行安装包工作路径不能为空！");
                return false;
            }
            if (opetargetpath == "") {
                alert("执行安装包目的路径不能为空！");
                return false;
            }
         /*   if (opecmd == "") {
                alert("执行安装包命令不能为空！");
                return false;
            }*/
            if (confirm("您确定编辑版本配置吗？")) {
            document.forms["mod"].action = "Version_cfg_edit_save.jsp?fileid="+fileid+"&osid="+osid+"&accessid="+accessid+"&stdver="+stdver+"&chidver="+chidver+"&filemd5="+filemd5+"&opesec="+opesec+"&opetype="+opetype+"&filetmppath="+filetmppath+"&opeworkpath="+opeworkpath+"&opetargetpath="+opetargetpath+"&opecmd="+opecmd+"&filetype="+filetype+"&fileids=<%=hashtable.get("fileid")%>&id=<%=id%>";
            document.forms["mod"].submit();
            }
            return true;
        }
        function trim(str) {
            return  str.replace(/^\s*(.*?)[\s\n]*$/g, '$1');

        }
        function clears(){
            var fileid=document.forms["mod"].elements["fileid"].value;
            if (fileid != "") {
                document.getElementById("fil2").style.display="";
                document.getElementById("fil1").style.display="none";
                document.forms["mod"].elements["filemd5"].value="";
                document.forms["mod"].elements["filemd5"].focus();
            }
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

<body  style="padding-top: 10px" onload="ok();">
<form  target="actions" name="mod" method="post" enctype="multipart/form-data">
    <table width="80%" align="center"  border="0" cellpadding="0" cellspacing="1" class="tableform">
      <tr>
         <td class="title" width="220">系统版本</td>
            <td    class="block">
                <select name="osid"  class="table_normal" style="border:1;font-size: 12px;width:220px">
                    <%
                        for(int j=0;j<osvserion.size();j++){
                            Hashtable ht2=(Hashtable)osvserion.elementAt(j);
                            int osId=Integer.parseInt((String)ht2.get("osid"));
                            String osName=(String)ht2.get("osname");
                            String sel="";
                            if (osId==Integer.parseInt((String)hashtable.get("osid"))){
                                sel="selected";
                            }else{
                                sel="";
                            }
                            out.println("<option class='b9' value="+osId+" "+sel+">"+osName);
                        }
                    %>
                </select></td>  </tr>
        <tr>
            <td class="title">客户端类型</td>
            <input type="hidden" name="id" value="<%=id%>">
            <td  class="block" >
                <select name="accessid"  class="table_normal" style="border:1;font-size: 12px;width:220px" >
                    <%
                        for(int j=0;j<access.size();j++){
                            Hashtable ht2=(Hashtable)access.elementAt(j);
                            int accessids=Integer.parseInt((String)ht2.get("accessid"));
                            String accessnames=(String)ht2.get("accessname");
                            String sel="";
                            if (accessids==Integer.parseInt((String)hashtable.get("accessid"))){
                                sel="selected";
                            }else{
                                sel="";
                            }
                            out.println("<option class='b9' value="+accessids+" "+sel+">"+accessnames);
                        }
                    %>
                </select></td>
        </tr>
        <tr>
            <td class="title">标准版本号</td>
            <td  class="block" >
                <input type="text" name="stdver" class="b9"    style="width: 215px" value="<%=hashtable.get("stdver")%>">
            </td>
        </tr>
        <tr>
            <td class="title">子版本号</td>
            <td  class="block" >
                <input type="text" name="chidver" class="b9"    style="width: 215px" value="<%=hashtable.get("childver")%>">
            </td>
        </tr>
        <tr>
            <td class="title">上传安装包</td>
            <td  class="block" >
                <input type="FILE" name="fileid" class="b9"    style="width: 215px" onchange="clears();">
            </td>
        </tr>
        <tr id="fil1">
            <td class="title">上传安装包的Md5摘要</td>
            <td  class="block" >
                <%=hashtable.get("filemd5")%>
                <input type="hidden" name="filemd5s" class="b9" value="<%=hashtable.get("filemd5")%>"  style="width: 215px" >
            </td>
        </tr>
        <tr id="fil2">
            <td class="title">上传安装包的Md5摘要</td>
            <td  class="block" >
                <input type="text" name="filemd5" class="b9" value="<%=hashtable.get("filemd5")%>"  style="width: 215px" >
            </td>
        </tr>
        <tr>
            <td class="title">上传安装包类型</td>
            <td  class="block" >
                <select name="filetype" class="table_normal" style="border:1;font-size: 12px;width:220px">
                    <option value="0" <%if(hashtable.get("filetype").equals("0")){%>selected="selected" <%}%>>exe</option>
                    <option value="1" <%if(hashtable.get("filetype").equals("1")){%>selected="selected" <%}%>>zip</option>
                    <option value="2" <%if(hashtable.get("filetype").equals("2")){%>selected="selected" <%}%>>file</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="title">操作执行方式</td>
            <td  class="block" > <%--操作是否立即执行下拉选项：0\立即执行；1\启动时执行；2\重启并执行；3\退出时执行；4\覆盖替换；5\延迟执行。选择5的时候，可以填写“延迟执行时间”，该字段只能填写数字，代表秒。--%>
                <select name="opetype" class="table_normal" onchange="ok();" style="border:1;font-size: 12px;width:220px">
                    <option value="0" <%if(hashtable.get("opetype").equals("0")){%>selected="selected" <%}%>>立即执行</option>
                    <option value="1" <%if(hashtable.get("opetype").equals("1")){%>selected="selected" <%}%>>启动时执行</option>
                    <option value="2" <%if(hashtable.get("opetype").equals("2")){%>selected="selected" <%}%>>重启并执行</option>
                    <option value="3" <%if(hashtable.get("opetype").equals("3")){%>selected="selected" <%}%>>退出时执行</option>
                    <option value="4" <%if(hashtable.get("opetype").equals("4")){%>selected="selected" <%}%>>覆盖替换</option>
                    <option value="5" <%if(hashtable.get("opetype").equals("5")){%>selected="selected" <%}%>>延迟执行</option>
                </select>
            </td>
        </tr>
        <tr id="opesecid">
            <td class="title">延迟时间</td>
            <td  class="block" >
                <input type="text" name="opesec" value="<%=hashtable.get("opesec")%>"  class="b9" style="width: 215px"   >
            </td>
        </tr>
        <tr>
            <td class="title">客户端下载文件路径</td>  <%--相对路径--%>
            <td  class="block" >
                <input type="text" name="filetmppath" value="<%=hashtable.get("filetmppath")%>"  class="b9"    style="width: 215px">
            </td>
        </tr>
        <tr>
            <td class="title">执行安装包工作路径</td>
            <td  class="block" >
                <input type="text" name="opeworkpath" class="b9" value="<%=hashtable.get("opeworkpath")%>"    style="width: 215px">
            </td>
        </tr>
        <tr>
            <td class="title">执行安装包目的路径</td>
            <td  class="block" >
                <input type="text" name="opetargetpath" value="<%=hashtable.get("opetargetpath")%>" class="b9"    style="width: 215px">
            </td>
        </tr>
        <tr>
            <td class="title">执行安装包命令</td>
            <td  class="block" >
                <input type="text" name="opecmd" class="b9" value="<%=hashtable.get("opecmd")%>"   style="width: 215px">
            </td>
        </tr>
        <tr>
            <td align="center" colspan="2">
                <table width="100%">
                    <tr>
                        <td  align="center">
                            <a onclick="modqq();" id="edit" icon="icon-edit"  class="easyui-linkbutton" href="#">编辑</a>
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
    }
%>
