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
<title>版本配置---编辑</title>
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
        //得到一个SmartUpload对象
        SmartUpload su = new SmartUpload();
        //上传下载前的初始化方法
        su.initialize(pageContext);
        //设置不可以上传的文件后缀列表,没有后缀名的文件也不能上传，用,,来表示
//        String denieddList = "exe,msi,bat,jpeg,png,bmp,chm,,";
//        su.setDeniedFilesList(denieddList);
        //设置可以上传的文件
//        String allowedList = "doc,txt,rar,pdf,zip,xls,docx";
//        su.setAllowedFilesList(allowedList);
        //设定单个文件的最大值不超过10兆
        su.setMaxFileSize(1024 * 1024 * 30);
        su.upload();
        Files files = su.getFiles();
        for (int i = 0; i < files.getCount(); ++i) {
            File file = files.getFile(i);
            //判断有没有上传文件
            if (file.isMissing()) {
                continue;
            }
            filename = file.getFileName();
            String ext = file.getFileExt();
            String filepathname = file.getFilePathName();
            String size = file.getSize() + "";
            String filedname = file.getFieldName();
           /* System.out.println("文件信息：");
            System.out.println("文件全路径名：" + filepathname.getBytes() + "<br>");
            System.out.println("文件名" + filename + "<br>");
            System.out.println("字段名：" + filedname + "<br>");
            System.out.println("文件后缀名：" + ext + "<br>");
            System.out.println("文件大小:" + size + "<br>");*/

           pah = request.getSession().getServletContext().getRealPath("/2/upload/"+filename);
            java.io.File myFile = new java.io.File(pah);
            if(myFile.exists()){
                myFile.delete();
            }else {
                myFile.createNewFile();
            }
         /*   System.out.println("文件名" + pah + "   ok:" + request.getParameter("productid"));
            System.out.println("文件名:" + filename+"."+ext + ",文件大小:" + size);*/
            file.saveAs(pah, File.SAVEAS_PHYSICAL);
            msg = "上传文件成功！";
            String path = request.getSession().getServletContext().getRealPath("/httpurl.ini");
            //httpurl.ini
            String pathstr=VersionGrep.readFileByLines(path);
            ppath=pathstr+"/2/upload/"+filename;
           ii=66;
        }

    } catch (Exception e) {
        msg = "上传文件出错，请查看文件夹是否存在！";
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
		msg = "编辑成功！";
	}else if(ii==-6){
		msg="文件MD5加密与操作员手输入的MD5不一致！";
	}else if(ii==-88){
        msg="标准版本号与子版本号合并起来，在系统中不可重复！";
    }else if(ii==-99){
        msg="文件上传失败，请重新上传！";
    }else{
		msg="发生错误，请稍后再试！";
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