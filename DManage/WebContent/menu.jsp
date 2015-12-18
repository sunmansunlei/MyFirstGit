<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<html>
<head>
    <title>四川电信校园网拨号器管理平台</title>
</head>
<frameset rows="93,*" cols="*" frameborder="no" border="0" framespacing="0">
    <frame src="<%=request.getContextPath()%>/menu_top.jsp" name="topFrame" scrolling="No" noresize="noresize" id="topFrame" title="topFrame" />
    <frameset name="toolbar" cols="178,11,*" frameborder="no" border="0" framespacing="0">
        <frame src="<%=request.getContextPath()%>/menu_left.jsp" name="leftFrame" scrolling="No" noresize="noresize" id="leftFrame" title="leftFrame" />
        <frame src="<%=request.getContextPath()%>/menu_middle.jsp" name="middleFrame" scrolling="No" noresize="noresize" id="middleFrame" title="middleFrame" />
        <frame src="<%=request.getContextPath()%>/new_main.jsp" name="mainFrame" id="mainFrame" title="mainFrame" />
    </frameset>
</frameset>
<body>
</body>
</html>