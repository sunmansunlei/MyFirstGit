function m_in(name,imgName){
	with (document.all[name].style) {
		borderLeft   = "1px solid buttonhighlight";
		borderRight  = "1px solid buttonshadow";
		borderTop    = "1px solid buttonhighlight";
		borderBottom = "1px solid buttonshadow";
		padding      = "1px";
	}
	document.all[imgName].style.filter="";
}
function m_out(name,imgName){
	with (document.all[name].style) {
		borderLeft   = "0px solid buttonshadow";
		borderRight  = "0px solid buttonhighlight";
		borderTop    = "0px solid buttonshadow";
		borderBottom = "0px solid buttonhighlight";
		padding      = "0px";
	}
	document.all[imgName].style.filter="gray()";
}
function m_down(name,imgName){
	with (document.all[name].style) {
		borderLeft   = "1px solid buttonshadow";
		borderRight  = "1px solid buttonhighlight";
		borderTop    = "1px solid buttonshadow";
		borderBottom = "1px solid buttonhighlight";
		paddingTop    = "3px";
		paddingLeft   = "3px";
	}
}

function mod(i){
	document.forms["mod"+i].action="operator_mod.jsp";
	document.forms["mod"+i].submit();
}

function search(){
	
	login1=document.forms["sear"].elements["login"].value;
	
	
	return true;
}

function modcity(i){
	document.forms["mod"+i].action="city_passwdeidt.jsp";
	document.forms["mod"+i].submit();
}

function del(i,name){
	if(!confirm("ȷʵҪɾ������Ա"+name+"�𣿸ò������ɻָ���")){
		return;
	}
	document.forms["mod"+i].action="operator_del.jsp";
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

function checkAdd(){
	
	name1=document.forms["add"].elements["name"].value;
	login1=document.forms["add"].elements["login"].value;
	password1=document.forms["add"].elements["password"].value;
	
	if (name1==""){
		alert("���������Ա���ƣ�");
		document.forms["add"].elements["name"].focus();
		return false;
	}	
	if (!checkTxt(login1,true)){
		alert("������Ϸ��ĵ�½����");
		document.forms["add"].elements["login"].focus();
		return false;
	}
	
	if (confirm("��ȷ����������Ա��")) {
	    document.forms["add"].action="operator_add_ok.jsp";
	    document.forms["add"].submit();		
	}
	return true;
}

function changepwd(i){
	if (document.forms["mod"+i].elements["cpwd"].checked){
		document.forms["mod"+i].elements["password"].disabled=false;
	}else{
		document.forms["mod"+i].elements["password"].disabled=true;
	}
}

function checkModPwd(){
	password_1=document.forms["pwd"].elements["password"].value;
	password_2=document.forms["pwd"].elements["password1"].value;
	if(password_1!=password_2){
		alert("��ȷ���������������һ�£�");
		document.forms["pwd"].elements["password1"].focus();
		return false;
	}
          document.forms["pwd"].action="password_save.jsp";
          document.forms["pwd"].submit();
	return true;

}

function newGrp(){
	document.frames["info"].document.location="operator_group_new.jsp";
}

function editGrp(){
	grps=document.forms["group"].elements["grp"].selectedIndex;
	if (grps<1){
		alert("��ѡ��һ������Ա�飡");
		return;
	}
	document.forms["group"].action="operator_group_edit.jsp";
	document.forms["group"].submit();
}

function delGrp(){
	
	grps=document.forms["group"].elements["grp"].selectedIndex;
	if (grps<1){
		alert("��ѡ��Ҫɾ�����飡");
		return;
	}
	name=document.forms["group"].elements["grp"][grps].text;
	if(!confirm("ȷʵҪɾ��"+name+"�𣿸ò������ɻָ������һ�ɾ�������������û���")){
		return;
	}
	document.forms["group"].action="operator_group_del.jsp";
	document.forms["group"].elements["grpname"].value=document.forms["group"].elements["grp"][grps].text;
	document.forms["group"].submit();
}

function selectAll(){
	for(i=0;i<=document.forms["group"].elements["acl"].length-1;i++){
		document.forms["group"].elements["acl"][i].checked=true;

	}

}

function reverse(){
	for(i=0;i<=document.forms["group"].elements["acl"].length-1;i++){
		if (document.forms["group"].elements["acl"][i].checked){
			document.forms["group"].elements["acl"][i].checked=false;
		}else{
			document.forms["group"].elements["acl"][i].checked=true;
		}
	}
    
}

function checkGrp(){
	names=""+document.forms["group"].elements["name"].value;
	names=names.replace(/ /g,"");
	if(names==""){
		alert("������������");
		document.forms["group"].elements["name"].focus();
		return false;
	}
    document.forms["group"].action="operator_group_new_save.jsp";
       document.forms["group"].submit();
	return true;
}

function checkGrp1()
{
     document.forms["group"].reset();
    
}
function ediGrp()
{
    names=""+document.forms["group"].elements["name"].value;
	names=names.replace(/ /g,"");
	if(names==""){
		alert("������������");
		document.forms["group"].elements["name"].focus();
		return false;
	}
    document.forms["group"].action="operator_group_edit_save.jsp";
       document.forms["group"].submit();
	return true;
}
function changeGrp(){
	grps=document.forms["group"].elements["grp"].selectedIndex;
	document.forms["group"].action="operator_group_edit.jsp";
	document.forms["group"].elements["grpname"].value=document.forms["group"].elements["grp"][grps].text;
	document.forms["group"].submit();
}


function aclChecked(inputElement){
	for(i=0;i<=document.forms["group"].elements["acl"].length-1;i++){
		if (document.forms["group"].elements["acl"][i].value==inputElement.value){
			document.forms["group"].elements["acl"][i].checked=inputElement.checked;
		}
	}
}


function doNull(){
	return false;
}
document.ondragstart=doNull;
