<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@ page import="com.jspsmart.upload.SmartUpload" %>
<%@ page import="com.jspsmart.upload.*" %>

<%@page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="com.jspsmart.upload.File" %>
<%@page errorPage="error.jsp"%>
<%
int menuId=12;
%>
<%@ include file="checkauth.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language=JavaScript src="operator.js"></script>
<link rel="stylesheet" type="text/css" href="adsl.css">
<title>�汾����---�༭</title>
</head>
<body bgcolor="#ffffff" leftmargin="0" marginwidth="0" topmargin="5" marginheight="5">
<%
VersionCfg user=null;
int ii=0;
String msg = null;
try{
	user=new VersionCfg();
    String filename="";
    String pah="";
    String ppath="";
    String id=request.getParameter("id");
    String fileids=request.getParameter("fileids");
    String osid=request.getParameter("osid");
    String accessid=request.getParameter("accessid");
    String stdver=request.getParameter("stdver");
    String chidver=request.getParameter("chidver");
    String fileid=request.getParameter("fileid")==null?"":request.getParameter("fileid");
    String filemd5=request.getParameter("filemd5");
    String filetype=request.getParameter("filetype");
    String opetype = request.getParameter("opetype");
    String opesec = request.getParameter("opesec");

    String filetmppath=request.getParameter("filetmppath");
    String opeworkpath=request.getParameter("opeworkpath");
    String opetargetpath = request.getParameter("opetargetpath");
    String opecmd = request.getParameter("opecmd");
    if (fileid == null) fileid = "";
    if (fileid.equals("null")) fileid = "";
    if (fileid.trim().length() == 0) {
         filename="";
        pah="";
        ii=77;
} else {
    try {
        //�õ�һ��SmartUpload����
        SmartUpload su = new SmartUpload();
        //�ϴ�����ǰ�ĳ�ʼ������
        su.initialize(pageContext);
        //���ò������ϴ����ļ���׺�б�,û�к�׺�����ļ�Ҳ�����ϴ�����,,����ʾ
//        String denieddList = "exe,msi,bat,jpeg,png,bmp,chm,,";
//        su.setDeniedFilesList(denieddList);
        //���ÿ����ϴ����ļ�
//        String allowedList = "doc,txt,rar,pdf,zip,xls,docx";
//        su.setAllowedFilesList(allowedList);
        //�趨�����ļ������ֵ������10��
        su.setMaxFileSize(1024 * 1024 * 30);
        su.upload();
        Files files = su.getFiles();
        for (int i = 0; i < files.getCount(); ++i) {
            File file = files.getFile(i);
            //�ж���û���ϴ��ļ�
            if (file.isMissing()) {
                continue;
            }
            filename = file.getFileName();
            String ext = file.getFileExt();
            String filepathname = file.getFilePathName();
            String size = file.getSize() + "";
            String filedname = file.getFieldName();
           /* System.out.println("�ļ���Ϣ��");
            System.out.println("�ļ�ȫ·������" + filepathname.getBytes() + "<br>");
            System.out.println("�ļ���" + filename + "<br>");
            System.out.println("�ֶ�����" + filedname + "<br>");
            System.out.println("�ļ���׺����" + ext + "<br>");
            System.out.println("�ļ���С:" + size + "<br>");*/

           pah = request.getSession().getServletContext().getRealPath("/2/upload/"+filename);
            java.io.File myFile = new java.io.File(pah);
            if(myFile.exists()){
                myFile.delete();
            }else {
                myFile.createNewFile();
            }
         /*   System.out.println("�ļ���" + pah + "   ok:" + request.getParameter("productid"));
            System.out.println("�ļ���:" + filename+"."+ext + ",�ļ���С:" + size);*/
            file.saveAs(pah, File.SAVEAS_PHYSICAL);
            msg = "�ϴ��ļ��ɹ���";
            String path = request.getSession().getServletContext().getRealPath("/httpurl.ini");
            //httpurl.ini
            String pathstr=VersionGrep.readFileByLines(path);
            ppath=pathstr+"/2/upload/"+filename;
           ii=66;
        }

    } catch (Exception e) {
        msg = "�ϴ��ļ�������鿴�ļ����Ƿ���ڣ�";
        e.printStackTrace();
        //System.out.println("Exception:" + msg);
%>
<script type="text/javascript">
    alert(" <%=msg%>")
</script>
<%
            return;
        }
    }
    if (ii==66||ii==77){
        ii = user.mod(fileids,id,userInfo.get("login").toString(), osid, accessid, stdver, chidver, filename,pah,ppath, filemd5, filetmppath, filetype, opetype, opesec, opeworkpath, opetargetpath, opecmd);
    }else {
        ii=-99;
    }

	if(ii==1){
		msg = "�༭�ɹ���";
	}else if(ii==-6){
		msg="�ļ�MD5���������Ա�������MD5��һ�£�";
	}else if(ii==-88){
        msg="��׼�汾�����Ӱ汾�źϲ���������ϵͳ�в����ظ���";
    }else if(ii==-99){
        msg="�ļ��ϴ�ʧ�ܣ��������ϴ���";
    }else{
		msg="�����������Ժ����ԣ�";
	}
%>
	<script language="JavaScript">
	alert("<%=msg%>");
    if(1==<%=ii%>){
    window.parent.location="version_cfg.jsp?osid=<%=osid%>"+"&accessid=<%=accessid%>"+"&stdver=<%=stdver%>";
    }
	</script>
<%
    }catch(Exception e){
        e.printStackTrace();
    }finally{
    }
%>
</body>
</html>