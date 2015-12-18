<%!
private String getHTML(Vector menus,String acl,int row){
	return getHTML(menus,acl,row,false);
}
private String getHTML(Vector menus,String acl,int row,boolean disabled){
	String html="<tr>";
	int menuSize=menus.size();
	int count=(menuSize%row==0)?menuSize:(menuSize+(row-menuSize%row));
	String sel="";
	String dis=disabled?"disabled":"";
	for(int j=0;j<count;j++){
		if (j<menuSize){
			Hashtable ht=(Hashtable)menus.elementAt(j);
			String id=(String)ht.get("id");
			if(id.equals("706")){
				menuSize--;
				count=(menuSize%row==0)?menuSize:(menuSize+(row-menuSize%row));
				menus.remove(j);
				j--;
				continue;
			}
			String name=(String)ht.get("name");
			if (acl!=null) sel=(acl.indexOf("#"+id+"#")==-1)?"":"checked";
			html+="<td bgcolor=\"#ffffff\" align=\"left\" class=\"block\" height=\"30\" width=\"175\"><input onClick=\"aclChecked(this)\" name=\"acl\" type=\"checkbox\" value=\""+id+"\" class=\"b9\" "+sel+" "+dis+">"+name+"</td>";
		}else{
			html+="<td bgcolor=\"#ffffff\" align=\"left\" class=\"block\" height=\"30\" width=\"175\">&nbsp;</td>";
		}
		if (((j+1)%row==0)&&(j<count-1)) html+="</tr><tr>";
	}
	return html;
}
%>