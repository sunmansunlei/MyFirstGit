 



function listenEnter(event,o){

            var keynum;
            if(window.event)
            {
                keynum=event.keyCode;
            }
            else
            {
                keynum=event.which;
            }

            if(keynum==13||keynum==10)
            {
                checkForm();
            }

}



function checkForm() {
		var login = $("#loginName").val();
	
	    var passwd =  $("#password").val();
	
		if(login==""){
			 alert("请输入登录名！！");
			 $("#loginName").focus();
			 return false;
		}else{ 
			$('#formId').attr("action", 'login.do?method=login');   
			$('#formId').submit();
		}
            
}



function rest() {
            document.forms[0].reset();
}
        
        
        