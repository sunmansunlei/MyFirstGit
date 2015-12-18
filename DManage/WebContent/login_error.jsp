<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<%@page contentType="text/html;charset=GBK" session="true"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <title><s:text name="newbims"/></title>
</head>

<body>

<script type="text/javascript">
    alert("<s:text name='msg'/>");
</script>
<%@include file="login.jsp"%>
</body>
</html>