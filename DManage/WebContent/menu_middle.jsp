<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="menu_include.jsp"%>
<html>
<head>
    <link rel="stylesheet" rev="stylesheet" href="./css/css.css" type="text/css" media="all"/>
     <style type="text/css">
         .middle_body {
             background: url(./img/middle_bg.gif);
         }
     </style>
</head>

<script language="JavaScript">
    mid=-1;
    function scroll(){
        switch(mid){
            case 1:
                document.all["flag1"].src="./img/middle_left.gif";
                parent.frames["toolbar"].cols="178,10,*";
                break;
            case -1:
                document.all["flag1"].src="./img/middle_right.gif";
                parent.frames["toolbar"].cols="0,10,*";
                break;
        }
        mid*=-1;
    }
</script>
<body class="middle_body">
<br><br><br><br><br><br><br><br><br>
<div class='left' style="border:1px solid #99C6F2;" tabindex="-1" onmouseover="this.style.borderColor='#076EDE';" onmouseout ="this.style.borderColor='#99C6F2';" onclick="scroll()">
    <br><br><img id="flag1"  src="./img/middle_left.gif" />
    <br><br>
</div>
</body>
</html>