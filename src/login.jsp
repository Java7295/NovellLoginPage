<%@ page language="java" %>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.novell.nidp.*" %>
<%@ page import="com.novell.nidp.servlets.*" %>
<%@ page import="com.novell.nidp.resource.*" %>
<%@ page import="com.novell.nidp.resource.jsp.*" %>
<%@ page import="com.novell.nidp.ui.*" %>
<%@ page import="org.apache.commons.lang.StringEscapeUtils" %>


<%
    ContentHandler handler = new ContentHandler(request,response);
    String target = (String) request.getAttribute("target");
    String uname = (String)request.getAttribute("username");
    if ( uname == null )
        uname = "";
    uname = StringEscapeUtils.escapeHtml(uname);
    if ( target != null )
        target = StringEscapeUtils.escapeHtml(target);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//<%=handler.getLanguageCode()%>">
<html lang="<%=handler.getLanguageCode()%>">
	<head>
  	  	<META HTTP-EQUIV="Content-Language" CONTENT="<%=handler.getLanguageCode()%>">
	  	<meta http-equiv="content-type" content="text/html;charset=utf-8">

		<style type="text/css" media="screen">		
			td label   		{ font-size: 0.85em ; padding-right: 0.2em; }
			label 		{ font-size: 0.77em; padding-right: 0.2em; }
   			input { font-family: sans-serif; }
			.instructions 	{ color: #4d6d8b; font-size: 0.8em; margin: 0 10px 10px 0 }
		</style>

 	  	<script type="text/javascript" src="<%= handler.getImage("showhide_2.js",false)%>"></script>
	  	<script language="JavaScript">
			var i = 0;
			function imageSubmit()
			{
  			    if (i == 0)
  			    {	
     				 i = 1;
     				 document.IDPLogin.submit();
  			    }
  
  			    return false;
			}
		</script>
    	</head>
	<body style="background-color: <%=handler.getBGColor()%>" marginwidth="0" marginheight="0" leftmargin="0" topmargin="0" rightmargin="0" onLoad="document.IDPLogin.Ecom_User_ID.focus();" >
      	<form name="IDPLogin" enctype="application/x-www-form-urlencoded" method="POST" action="<%= (String) request.getAttribute("url") %>" AUTOCOMPLETE="off">
			<input type="hidden" name="option" value="credential">
<% if (target != null) { %>
			<input type="hidden" name="target" value="<%=target%>">
<% } %>
	      	<table border=0 style="margin-top: 1em" width="100%" cellspacing="0" cellpadding="0">
		    		<tr>
			  		<td style="padding: 0px">
						<table border=0>
							<tr>
								<td align=left>
									<label><%=handler.getResource(JSPResDesc.USERNAME)%></label>
								</td>
								<td align=left>
									<input type="text" class="smalltext" name="Ecom_User_ID" size="30" value="<%=uname%>">
								</td>
							</tr>
							<tr>
								<td align=left>
									<label><%=handler.getResource(JSPResDesc.PASSWORD)%></label>						
								</td>							
								<td align=left>
									<input type="password" class="smalltext" name="Ecom_Password" size="30">
								</td>							
							</tr>
							<tr>
								<td align=right colspan=2 style="white-space: nowrap">
									<input alt="<%=handler.getResource(JSPResDesc.LOGIN)%>" border="0" name="loginButton2" src="<%= handler.getImage("btnlogin.gif",true)%>" type="image" value="Login" onClick="return imageSubmit()">
								</td>							
							</tr>
						</table>
					</td>
				</tr>
<%
    String err = (String) request.getAttribute(NIDPConstants.ATTR_LOGIN_ERROR);
    if (err != null)
    {
%>
			  		<td style="padding: 10px">
						<div class="instructions"><%=err%></div>
			  		</td>
                		</tr>
<%  } %>
<%
	if (NIDPCripple.isCripple())
	{
%>		    
		    		<tr>
   		        		<td width="100%" align="center"><%=NIDPCripple.getCrippleAdvertisement(request.getLocale())%></td>
		    		</tr>
<%
	}
%>	    
	      	</table>
        	</form>
    	</body>
</html>
