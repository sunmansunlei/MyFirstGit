<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page errorPage="error.jsp"%>
<%
	int menuId=12;
%>
<%@ include file="checkauth.jsp"%>
        <%
    int iPageSize = 20;
    int iPageNum = 1;
    String para = null;
    try{
        VersionCfg userStates=new VersionCfg();
        iPageNum=Integer.parseInt(request.getParameter("page")==null?"1":request.getParameter("page"));
        para = request.getParameter("para");
        String osid = request.getParameter("osid");
        String accessid=request.getParameter("accessid");
        String stdver = request.getParameter("stdver")==null?"":request.getParameter("stdver");//group_type
        Vector users =userStates.getVersionCfgInfo(osid,accessid,stdver);
        Vector user = Tools.splitVector(users,iPageSize,iPageNum);
       para="osid="+osid+"&accessid="+accessid+"&stdver="+stdver;
%>
    <html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
        <title>�汾����</title>
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bims.css">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/default/easyui.css">
        <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/themes/icon.css">
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.min.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-easyui-1.2.1/plugins/jquery.linkbutton.js"></script>
        <script type="text/javascript">
            $(document).ready(function() {
                $('.easyui-linkbutton').linkbutton();
            });

            function del(i,id,osid,accessid,stdver){
                if(!confirm("ȷʵҪɾ���汾����"+stdver+"�𣿸ò������ɻָ���")){
                    return;
                }
                document.forms["mod"+i].action="Version_cfg_del.jsp?accessid="+accessid+"&osid="+osid+"&stdver="+stdver+"&id="+id;
                document.forms["mod"+i].submit();
            }
            function checkTxt(txt,checkLength){
                if ((txt=="")&&(checkLength)) return false;
                txt=txt.toLowerCase();
                for(i=0;i<txt.length;i++){
                    chars=txt.charAt(i);
                    if (!(((chars>='a')&&(chars<='z'))||((chars>='0')&&(chars<='9'))||(chars=='@')||chars=='_')){
                        return false;
                    }
                }
                return true;
            }


            function modadvancesearch(id,osid,accessid,stdver)
            {
                parent.frames['main'].location="version_cfg_edit.jsp?osid="+osid+"&accessid="+accessid+"&stdver="+stdver+"&id="+id;

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

    <body style="padding-top: 10px;padding-left: 5px;padding-right: 5px">

    <table width="100%"  align="center" border="0" cellpadding="0" cellspacing="1" class="tableform">
<tr>
            <td class="title">ϵͳ�汾</td>
            <td class="title">�ͻ�������</td>
            <td class="title">��׼�汾��</td>
            <td class="title">�Ӱ汾��</td>
            <td class="title">�ϴ���װ����Md5ժҪ</td>
            <td class="title">�ϴ���װ������</td>
            <td class="title">����ִ�з�ʽ</td>
            <td class="title">�ӳ�ʱ��</td>
            <td class="title">�ͻ��������ļ�·��</td>
            <td class="title">ִ�а�װ������·��</td>
            <td class="title">ִ�а�װ��Ŀ��·��</td>
            <td class="title">ִ�а�װ������</td>
            <td class="title">����</td>
        </tr>


        <%
            for (int i=0;i<user.size();i++){
                Hashtable ht=(Hashtable)user.elementAt(i);
                String stdvers=(String)ht.get("stdver");
                String chidver=(String)ht.get("childver");
                String osids=(String)ht.get("osid");
                String fileid=(String)ht.get("fileid");
                String accessname=(String)ht.get("accessname");
                String osname=(String)ht.get("osname");
                int accessids=Integer.parseInt((String)ht.get("accessid"));
                String filemd5=(String)ht.get("filemd5");
                String filetmppath=(String)ht.get("filetmppath");
                String opetype=(String)ht.get("opetype");
                String filetype=(String)ht.get("filetype");
                if(filetype.equals("0")){filetype="exe";}
                if(filetype.equals("1")){filetype="zip";}
                if(filetype.equals("2")){filetype="file";}
                //0\����ִ�У�1\����ʱִ�У�2\������ִ�У�3\�˳�ʱִ�У�4\�����滻��5\�ӳ�ִ�С�ѡ��5��ʱ�򣬿�����д���ӳ�ִ��ʱ�䡱�����ֶ�ֻ����д���֣������롣
                if(opetype.equals("0")){opetype="����ִ��";}
                if(opetype.equals("1")){opetype="����ʱִ��";}
                if(opetype.equals("2")){opetype="������ִ��";}
                if(opetype.equals("3")){opetype="�˳�ʱִ��";}
                if(opetype.equals("4")){opetype="�����滻";}
                if(opetype.equals("5")){opetype="�ӳ�ִ��";}
                String opesec=(String)ht.get("opesec");
                String opeworkpath=(String)ht.get("opeworkpath");
                String opetargetpath=(String)ht.get("opetargetpath");
                String opecmd=(String)ht.get("opecmd");
                String posttime=(String)ht.get("posttime");

        %>
        <form  method="post" target="actions" name="mod<%=i%>">
            <input type="hidden" name="id" value="<%=ht.get("id")%>">
            <tr bgcolor="#ffffff" >
                <td align="center" class="block" height="30"><%=osname%></td>
                <td align="center" class="block" height="30"><%=accessname%></td>
                <td align="center" class="block" height="30"><%=stdvers%></td>
                <td align="center" class="block" height="30"><%=chidver%></td>
                <td align="center" class="block" height="30"><%=filemd5%></td>
                <td align="center" class="block" height="30"><%=filetype%></td>
                <td align="center" class="block" height="30"><%=opetype%></td>
                <td align="center" class="block" height="30"><%=opesec%></td>
                <td align="center" class="block" height="30"><%=filetmppath%></td>
                <td align="center" class="block" height="30"><%=opeworkpath%></td>
                <td align="center" class="block" height="30"><%=opetargetpath%></td>
                <td align="center" class="block" height="30"><%=opecmd%></td>
                <td align="center" width="180">
                    <table width="100%">
                        <tr>
                            <td onclick="modadvancesearch('<%=ht.get("id")%>','<%=osid%>','<%=accessid%>','<%=stdver%>')" align="center">
                                <a id="edit" icon="icon-edit"  class="easyui-linkbutton" href="#">�༭</a>
                            </td>
                            <td onclick="del('<%=i%>','<%=ht.get("id")%>','<%=osid%>','<%=accessid%>','<%=stdvers%>')" align="center">
                                <a id="del" icon="icon-remove"  class="easyui-linkbutton" href="#">ɾ��</a>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </form>
        <%
            }
        %>
        <tr bgcolor="#CCCCCC">
            <td  class="b9" colspan="13" height="20">
                <table width="100%" height="12">
                    <tr>
                        <td class="b9" align="left" valign="middle" >�ܼ�¼:<%= users.size()%> ��</td>
                        <td class="b9" align="right"  valign="middle"><%=Tools.getPageString(users.size(),iPageSize, iPageNum,"version_cfg.jsp"+"?"+para+"&")%></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <iframe name="actions" width="0" height="0" src="../blank.htm" frameborder="0"></iframe>
    </body>
    </html>
        <%
    }finally{
    }
%>

