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
        Vector osvserion = userStates.getOsversion();
        Vector access = userStates.getAccess();         
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>�汾����---����</title>
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
            var val= document.forms['add'].elements['opetype'].options[document.forms['add'].elements['opetype'].selectedIndex].value;

            if (val == 5) {
                document.getElementById("opesecid").style.display="";

            } else  {
                document.getElementById("opesecid").style.display="none";
            }
        }

        function addaa() {
            var stdver = document.forms["add"].elements["stdver"].value;
            var chidver = document.forms["add"].elements["chidver"].value;
            var fileid=document.forms["add"].elements["fileid"].value;
            var filemd5=document.forms["add"].elements["filemd5"].value;
            var opesec=document.forms["add"].elements["opesec"].value;
            var opetype=document.forms["add"].elements["opetype"].value;
            var filetmppath=document.forms["add"].elements["filetmppath"].value;
            var opeworkpath=document.forms["add"].elements["opeworkpath"].value;
            var opetargetpath=document.forms["add"].elements["opetargetpath"].value;

            var filetype = document.forms["add"].elements["filetype"].value;
            var accessid = document.forms["add"].elements["accessid"].value;
            var osid=document.forms["add"].elements["osid"].value;
            var opecmd=document.forms["add"].elements["opecmd"].value;
            if (stdver == "") {
                    alert("��׼�汾�Ų���Ϊ�գ�");
                    return false;
                }

           if (chidver == "") {
                    alert("�Ӱ汾�Ų���Ϊ�գ�");
                    document.forms["add"].elements["chidver"].focus();
                    return false;
                }
            if (fileid == "") {
                alert("��ѡ���ϴ���װ���ļ���");
                return false;
            }
            if (filemd5 == "") {
                alert("�ϴ���װ����Md5ժҪ����Ϊ�գ�");
                return false;
            }

                if (opetype == 5) {
                    if (opesec == "") {
                        alert("�ӳ�ʱ�䲻��Ϊ�գ�");
                        document.forms["add"].elements["opesec"].focus();
                        return false;
                    }
                    if (opesec != "") {
                        var myreg = /^\d+$/;
                        if (!myreg.test(trim(opesec))) {
                            alert("�ӳ�ʱ��ֻ������һ��������");
                            return false;
                        }
                    }
                }
           /* if (filetmppath == "") {
                alert("�ͻ��������ļ�·������Ϊ�գ�");
                return false;
            }
            if (opeworkpath == "") {
                alert("ִ�а�װ������·������Ϊ�գ�");
                return false;
            }
            if (opetargetpath == "") {
                alert("ִ�а�װ��Ŀ��·������Ϊ�գ�");
                return false;
            }
            if (opecmd == "") {
                alert("ִ�а�װ�������Ϊ�գ�");
                return false;
            }*/
            // if (confirm("��ȷ�������汾������")) {
            document.forms["add"].action = "Version_cfg_add_save.jsp?fileid="+fileid+"&osid="+osid+"&accessid="+accessid+"&stdver="+stdver+"&chidver="+chidver+"&filemd5="+filemd5+"&opesec="+opesec+"&opetype="+opetype+"&filetmppath="+filetmppath+"&opeworkpath="+opeworkpath+"&opetargetpath="+opetargetpath+"&opecmd="+opecmd+"&filetype="+filetype;
            document.forms["add"].submit();
            //}
            return true;
        }
        function trim(str) {
            return  str.replace(/^\s*(.*?)[\s\n]*$/g, '$1');

        }
    </script>
    <style type="text/css">
        .blue_24_b {
            color:#005dc6;
            font-weight:bold;
            font-size:24px;
            font:'Microsoft YaHei','����ϸ��','����',sans-serif;
            line-height:160%;
        }
        .center {
            text-align:center;
        }
    </style>
</head>

<body  style="padding-top: 10px" onload="ok();">
<form  target="actions" name="add"  method="post" enctype="multipart/form-data">
<table width="80%" align="center"  border="0" cellpadding="0" cellspacing="1" class="tableform">
    
   
    <tr>

        <td class="title" width="220">ϵͳ�汾</td>
        <td    class="block">
            <select name="osid"  class="table_normal" style="border:1;font-size: 12px;width:220px">
                <%
                    for(int j=0;j<osvserion.size();j++){
                        Hashtable ht2=(Hashtable)osvserion.elementAt(j);
                        int osId=Integer.parseInt((String)ht2.get("osid"));
                        String osName=(String)ht2.get("osname");
                        String sel="";
                        if (osId==Integer.parseInt(osid)){
                            sel="selected";
                        }else{
                            sel="";
                        }
                        out.println("<option class='b9' value="+osId+" "+sel+">"+osName);
                    }
                %>
            </select></td>  </tr>
    <tr>
        <td class="title">�ͻ�������</td>

        <td  class="block" >
            <select name="accessid"  class="table_normal" style="border:1;font-size: 12px;width:220px" >
                <%
                    for(int j=0;j<access.size();j++){
                        Hashtable ht2=(Hashtable)access.elementAt(j);
                        int accessids=Integer.parseInt((String)ht2.get("accessid"));
                        String accessnames=(String)ht2.get("accessname");
                        String sel="";
                        if (accessids==Integer.parseInt(accessid)){
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
        <td class="title">��׼�汾��</td>
        <td  class="block" >
           <input type="text" name="stdver" class="b9"    style="width: 215px" value="<%=stdver%>">
        </td>
    </tr>
    <tr>
        <td class="title">�Ӱ汾��</td>
        <td  class="block" >
            <input type="text" name="chidver" class="b9"    style="width: 215px">
        </td>
    </tr>
    <tr>
        <td class="title">�ϴ���װ��</td>
        <td  class="block" >
            <input type="file" name="fileid"  class="b9"   style="width: 215px">
        </td>
    </tr>
    <tr>
        <td class="title">�ϴ���װ����Md5ժҪ</td>
        <td  class="block" >
            <input type="text" name="filemd5" class="b9"   style="width: 215px" >
        </td>
    </tr>
    <tr>
        <td class="title">�ϴ���װ������</td>
        <td  class="block" >
            <select name="filetype" class="table_normal" style="border:1;font-size: 12px;width:220px">
                <option value="0">exe-0</option>
                <option value="1">zip-1</option>
                <option value="2">file-2</option>
            </select>
        </td>
    </tr>
    <tr>
        <td class="title">����ִ�з�ʽ</td>
        <td  class="block" > <%--�����Ƿ�����ִ������ѡ�0\����ִ�У�1\����ʱִ�У�2\������ִ�У�3\�˳�ʱִ�У�4\�����滻��5\�ӳ�ִ�С�ѡ��5��ʱ�򣬿�����д���ӳ�ִ��ʱ�䡱�����ֶ�ֻ����д���֣������롣--%>
            <select name="opetype" class="table_normal" onchange="ok();" style="border:1;font-size: 12px;width:220px">
                <option value="0">����ִ��-0</option>
                <option value="1">����ʱִ��-1</option>
                <option value="2">������ִ��-2</option>
                <option value="3">�˳�ʱִ��-3</option>
                <option value="4">�����滻-4</option>
                <option value="5">�ӳ�ִ��-5</option>
            </select>
        </td>
    </tr>
    <tr id="opesecid">
        <td class="title">�ӳ�ʱ��</td>
        <td  class="block" >
            <input type="text" name="opesec" class="b9" style="width: 215px"   >
        </td>
    </tr>
    <tr>
        <td class="title">�ͻ��������ļ�·��</td>  <%--���·��--%>
        <td  class="block" >
            <input type="text" name="filetmppath" class="b9"    style="width: 215px">
        </td>
    </tr>
    <tr>
        <td class="title">ִ�а�װ������·��</td>
        <td  class="block" >
            <input type="text" name="opeworkpath" class="b9"    style="width: 215px">
        </td>
    </tr>
    <tr>
        <td class="title">ִ�а�װ��Ŀ��·��</td>
        <td  class="block" >
            <input type="text" name="opetargetpath" class="b9"    style="width: 215px">
        </td>
    </tr>
    <tr>
        <td class="title">ִ�а�װ������</td>
        <td  class="block" >
            <input type="text" name="opecmd" class="b9"    style="width: 215px">
        </td>
    </tr>
    <tr>
        <td align="center" colspan="2">
            <table width="100%">
                <tr>
                    <td  align="center">
                        <a onclick="addaa();" id="edit" icon="icon-edit"  class="easyui-linkbutton" href="#">����</a>
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
