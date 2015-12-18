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

function focusInput(i,name){
	document.forms[i].elements[name].style.border="1px solid #000000";
}

function blurInput(i,name){
	document.forms[i].elements[name].style.border="none";
}


function focusInputs(i){
	document.forms[0].elements["fee"][i].style.border="1px solid #000000";
}

function blurInputs(i){
	document.forms[0].elements["fee"][i].style.border="none";
}


function doNull(){
	return false;
}
document.ondragstart=doNull;