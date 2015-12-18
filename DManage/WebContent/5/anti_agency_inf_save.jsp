<%@page contentType="text/html;charset=GBK" session="true"%>
<%@page import="com.adsl.*"%>
<%@page errorPage="error.jsp"%>
<%
	int menuId=41;
%>
<%@ include file="./checkauth.jsp"%>
<%
    String startTime=request.getParameter("startyear")+"-"+request.getParameter("startmonth")+"-"+request.getParameter("startday");
    String endTime=request.getParameter("endyear")+"-"+request.getParameter("endmonth")+"-"+request.getParameter("endday");
    
    out.clear();
    response.setHeader("Content-disposition","attachment;filename=AgentLog.txt");
    for(int i=0;i<512;i++) out.print("  ");
    out.print("\r\n");
    out.flush();	
    
    Query sq = null;
    
    try {
    	
    	sq = new Query(userInfo);
        Vector agentLogs = sq.getAgencyLog(startTime,endTime);   
        out.print("��������|��������|��ǩ|�ϱ�ʱ��\r\n");
        
        for (int i=0;i<agentLogs.size();i++){
        Hashtable ht = (Hashtable)agentLogs.elementAt(i);
        String agenttype = (String)ht.get("agenttype");
		String agentname = (String)ht.get("agentname");
		String agenticon = (String)ht.get("agenticon");
		String opetime = (String)ht.get("opetime");
        String info=agenttype
            +"|"+agentname
            +"|"+agenticon
            +"|"+opetime+"\r\n";
       out.print(info);
       out.flush();                                      
       }
       out.print("\r\n");
       out.close();
       
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		sq.close();
	}
%>