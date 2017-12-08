<%@ page language="java" %><%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%><%@ page import="com.novell.nidp.common.provider.*" %><%@ page import="java.util.*" %><%@ page import="com.novell.nidp.*" %><%@ page import="com.novell.nidp.servlets.*" %><%@ page import="com.novell.nidp.resource.*" %><%@ page import="com.novell.nidp.resource.jsp.*" %><%@ page import="com.novell.nidp.ui.*" %>
<% ContentHandler handler = new ContentHandler(request,response);
// check for hostname
String version = "3.1.2"; String hostname = ""; String location = ""; try {java.net.InetAddress localMachine = java.net.InetAddress.getLocalHost();	hostname = localMachine.getHostName().toLowerCase(); if (hostname.length() > 4) location = hostname.substring(1,4); if (hostname.indexOf("ip") > 0) hostname = hostname.substring(hostname.indexOf("ip")); if (hostname.indexOf("am") > 0) hostname = hostname.substring(hostname.indexOf("am")); if (hostname.indexOf("ag") > 0) hostname = hostname.substring(hostname.indexOf("ag"));} catch(java.net.UnknownHostException uhe) {} String errURL = (String) request.getParameter("e"); if (errURL == null) errURL = ""; String err = (String) request.getAttribute(NIDPConstants.ATTR_LOGIN_ERROR); if (err == null) err = ""; if (errURL.equals("401")) err = "Employee ID / Password Failed.";if (err.indexOf("Login failed") > -1) err = "Employee ID / Password Failed."; String userAgent = request.getHeader("user-agent"); if (userAgent == null) userAgent = ""; userAgent = userAgent.toLowerCase(); if (userAgent.indexOf("blackberry") > -1 || userAgent.indexOf("iphone") > -1 || userAgent.indexOf("android") > -1 || userAgent.indexOf("windows phone") > -1) { %>

<!-- Novell Login Page Mobile -->

<html>

<head>
<title>Company Login</title>
<!-- <%=version%>.<%=hostname%>.<%=location%> -->
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<meta content="true" name="HandheldFriendly">
<meta charset="utf-8">
<link type="text/css" href="<%=request.getContextPath()%>/images/mobile/mainMobile.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script src="https://ajax.aspnetcdn.com/ajax/jquery.mobile/1.1.0/jquery.mobile-1.1.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/modernizr/2.6.2/modernizr.min.js"></script>
<script>
// Username and password check
var resetURL = "https://idmadmin.company.com/idm/user/questionLogin.jsp?lang=en&cntry=US&nextPage=user%2FchangePassword.jsp&accountId=";
function checkUser() { var f = document.LoginForm; var user = f.Ecom_User_ID.value; var password = f.Ecom_Password.value; if ((user.length > 0) && (password.length > 0)) { if (alphaCheck(user)) { if (Check(user)) return true; else { f.action = "<%=request.getContextPath()%>/images/loginESC.jsp"; return true; } } else alert("Please check the format of the Employee ID field"); } else alert("You need to fill in the Employee ID and Password fields to continue"); return false; }
function alphaCheck(user) { var length = user.length; var allowedAlphas = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"; for (i=0; i<length; i++) { testChar = user.substr(i,1); if ((allowedAlphas.indexOf(testChar) < 0) && (isNaN(testChar))) return false; } return true; }
function EmpCheck(user) { var length = user.length; if (user.length != 7) return false; var allowedAlphas = "egnrstuvEGNRSTUV"; testChar = user.substr(0,1); if ((allowedAlphas.indexOf(testChar) < 0) && (isNaN(testChar))) return false; testChar = user.substr(3,4); if (testChar == 'chek') return true; for (i=1; i<length; i++) { testChar = user.substr(i,1); if (isNaN(testChar)) return false; } return true; }
function sendReset() { var f = document.LoginForm; var user = f.Ecom_User_ID.value; var password = f.Ecom_Password.value; if (user.length > 0) { if (alphaCheck(user)) { if (EmpCheck(user)) { document.location.href = resetURL + f.Ecom_User_ID.value; } else { document.location.href = "http://companyArchived/profiles/verify_reset.aspx" } } else { alert("Please check the format of the Employee ID field"); } } else { alert("You need to fill in the Employee ID to continue to the reset function"); } f.Ecom_User_ID.focus(); }
// Placeholder text for password
$(document).ready(function(){$('#password-clear').show();$('#password-password').hide();$('#password-clear').focus(function(){$('#password-clear').hide();$('#password-password').show();$('#password-password').focus()});$('#password-password').blur(function(){if($('#password-password').val()==''){$('#password-clear').show();$('#password-password').hide()}});$('.default-value').each(function(){var default_value=this.value;$(this).focus(function(){if(this.value==default_value){this.value=''}});$(this).blur(function(){if(this.value==''){this.value=default_value}})})});
</script>
</head>

<body style="margin:0px; background-color:#003399;" onLoad="document.LoginForm.Ecom_User_ID.focus()" data-url="loginPage">

<% if (!err.equals("")){ %><script>alert("<%=err%>");</script><% }%>

<div id="loginPage" data-role="page" data-theme="f" tabindex="0" style=" min-height:620px;">
	<div class="ui-content" data-role="content">
		<div style="background-image:url('<%=request.getContextPath()%>/images/mobile/clouds.jpg')">	
			<div class="container">	
				<div class="mobileLogo"><img alt="Company Logo" src="<%=request.getContextPath()%>/images/mobile/companyLogo.gif"></div>
				<div class="imageLogin"><img src="<%=request.getContextPath()%>/images/mobile/imageLogin.gif"></div>    
				
				<div class="form">
					<form method="post" name="LoginForm" id="LoginForm" onSubmit="return checkUser()" action="<%= (String) request.getAttribute("url") %>">
						<% String target = (String) request.getAttribute("target"); if (target != null) { %><input type="hidden" name="target" value="<%=target%>"> <% } %>
						<% String urlStr = (String) request.getAttribute("url"); if (urlStr != null) { %><input type="hidden" name="url" value="<%=urlStr%>"><% }else {%><input type="hidden" name="url" value="loginESC.jsp"><%} %>						
						
						<input style=" margin-top:12px; color:#333;" id="userName" autocomplete="on" class="textInput ui-input-text ui-body-c ui-corner-all ui-shadow-inset login" type="text" placeholder="Employee ID" value="" name="Ecom_User_ID">						
						<div style="text-align:center; padding-top:5px;"><input class="textInput ui-input-text ui-body-c ui-corner-all ui-shadow-inset login inputIdent" autocomplete="on" id="password-clear" type="text" value="Password" /><input class="textInput ui-input-text ui-body-c ui-corner-all ui-shadow-inset login inputIdent" autocomplete="on" id="password-password" type="password" name="Ecom_Password" value="" /></div>							
						<div class="button"><input id="loginButton" type="submit" value="Sign-On" onclick="if (checkUser()) document.LoginForm.submit();"/></div>	
						
					</form>
				</div>
					
				<div class="forgotPassword"><a href="javascript:sendReset();" class="links"><span style="color:ffffff;">Forgot your password?</span></a></div>
							
				<div class="footerLinks">
					<a class="links" href="<%=request.getContextPath()%>/images/popup/importantInformationMobile.html" rel="external"><span class="links">Notice</span></a><span data-role="content" class="links"  >&nbsp;|</span>
					<a  class="links" href="javascript:sendReset();" data-theme="c" rel="external"><span class="links">Password reset</span></a><span class="links"  data-role="content">&nbsp;|</span>
					<a  class="links" href="<%=request.getContextPath()%>/images/popup/signinIssuesMobile.html" rel="external"><span class="links">Help</span></a><span class="links" data-role="content"></span>
				</div>
					
				<div data-role="content" data-theme="f" class="copywrite"><span class="links" style="font-size:10px">&copy; CompanyName All rights reserved.</span></div>		
			</div>
		</div>	
	</div>
</div>
</body>
</html>

<% }else{ %>

<!-- Desktop Version Novell Login Page -->

<html>

<head>
<title>Company Login</title>
<!-- <%=version%>.<%=hostname%>.<%=location%> -->
<link type="text/css" href="<%=request.getContextPath()%>/images/mobile/customMobile.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/images/mobile/jquery-1.7.2.js"></script>
<script src="<%=request.getContextPath()%>/images/mobile/modernizr.js"></script>
<script>
//Username and password check 
var resetURL = "https://idmadmin.company.com/idm/user/questionLogin.jsp?lang=en&cntry=US&nextPage=user%2FchangePassword.jsp&accountId=";
function checkUser() { var f = document.LoginForm; var user = f.Ecom_User_ID.value; var password = f.Ecom_Password.value; if ((user.length > 0) && (password.length > 0)) { if (alphaCheck(user)) { if (EmpCheck(user)) return true; else { f.action = "<%=request.getContextPath()%>/images/loginESC.jsp"; return true; } } else alert("Please check the format of the Employee ID field"); } else alert("You need to fill in the Employee ID and Password fields to continue"); return false; }
function alphaCheck(user) { var length = user.length; var allowedAlphas = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"; for (i=0; i<length; i++) { testChar = user.substr(i,1); if ((allowedAlphas.indexOf(testChar) < 0) && (isNaN(testChar))) return false; } return true; }
function EmpCheck(user) { var length = user.length; if (user.length != 7) return false; var allowedAlphas = "egnrstuvEGNRSTUV"; testChar = user.substr(0,1); if ((allowedAlphas.indexOf(testChar) < 0) && (isNaN(testChar))) return false; testChar = user.substr(3,4); if (testChar == 'chek') return true; for (i=1; i<length; i++) { testChar = user.substr(i,1); if (isNaN(testChar)) return false; } return true; }
function sendReset() { var f = document.EmpLoginForm; var user = f.Ecom_User_ID.value; var password = f.Ecom_Password.value; if (user.length > 0) { if (alphaCheck(user)) { if (EmpCheck(user)) { document.location.href = resetURL + f.Ecom_User_ID.value; } else { document.location.href = "http://companyArchived/profiles/verify_reset.aspx" } } else { alert("Please check the format of the Employee ID field"); } } else { alert("You need to fill in the Employee ID to continue to the reset function"); } f.Ecom_User_ID.focus(); }			
// Placeholder text for password
$(document).ready(function(){$('#password-clear').show();$('#password-password').hide();$('#password-clear').focus(function(){$('#password-clear').hide();$('#password-password').show();$('#password-password').focus()});$('#password-password').blur(function(){if($('#password-password').val()==''){$('#password-clear').show();$('#password-password').hide()}});$('.default-value').each(function(){var default_value=this.value;$(this).focus(function(){if(this.value==default_value){this.value=''}});$(this).blur(function(){if(this.value==''){this.value=default_value}})})});$(document).ready(function(){if(!Modernizr.input.placeholder){$('[placeholder]').focus(function(){var input=$(this);if(input.val()==input.attr('placeholder')){input.val('');input.removeClass('placeholder')}}).blur(function(){var input=$(this);if(input.val()==''||input.val()==input.attr('placeholder')){input.addClass('placeholder');input.val(input.attr('placeholder'))}}).blur();$('[placeholder]').parents('form').submit(function(){$(this).find('[placeholder]').each(function(){var input=$(this);if(input.val()==input.attr('placeholder')){input.val('')}})})}});
</script>
<!-- Placeholder color fix for IE -->
<!--[if IE]><style>#password-clear {color:#000000;}</style><![endif]-->
<script>
// Placeholder color fix for Safari/Chrome 
$.browser.chrome = /chrome/.test(navigator.userAgent.toLowerCase()); 
if($.browser.chrome){document.write('<style>#password-clear {color:#b3b3b3;}</style>');}
// User Acceptance Testing Ribbon Hide/Show
$(document).ready(function () {var whois=location+" "; if (whois.indexOf("amstage") != -1) { $(".ribbonStage").removeAttr('style').css("display","block"); }	});
</script>
</head>

<body id="background" onLoad="document.LoginForm.Ecom_User_ID.focus()">

<div class="outerContainer"> 
	<div class="ribbonPadding">

	<div class="ribbonStage"><span class="ribbonFont">User Acceptance Testing!</span></div>	

	<div class="logo"><img class="companyLogo" src="<%=request.getContextPath()%>/images/mobile/mobileLogo.gif" alt="Company Logo"/></div>

		<div class="container">
			<div class="whiteBox">
				<div class="innerContainer">	  
					<div class="themedImage" style="background-image:url('<%=request.getContextPath()%>/images/background.jpg');">
						<div class="formPosition">
							<form action="<%= (String) request.getAttribute("url") %>" method="post" name="LoginForm" id="LoginForm" onSubmit="return checkUser()">
								
								<% String target = (String) request.getAttribute("target");				if (target != null) { %><input type="hidden" name="target" value="<%=target%>"> <% } %>
								<% String urlStr = (String) request.getAttribute("url"); if (urlStr != null) { %><input type="hidden" name="url" value="<%=urlStr%>"><% }else {%><input type="hidden" name="url" value="loginESC.jsp"><%} %>
								
								<div class="loginTitle">Please log in.</div>
								<div class="errorMessage" id="err"><%=err%></div>
								
								<div class="idPadding"><input type="text" class="inputIdent" placeholder="Employee ID" name="Ecom_User_ID"></div>
								<div class="passwordPadding"><input class="inputPassword inputIdent" id="password-clear" type="text" value="Password" autocomplete="off" /><input class="inputPassword inputIdent" id="password-password" type="password" name="Ecom_Password" value="" autocomplete="off" /></div>
								
								<div class="align">
									<div class="forgotLink"><a href="#" class="forgotPassword" onClick="sendReset();">Forgot password?</a></div>
									<div class="button"><input id="loginButton" type="submit" value="Log in" onclick="if (checkUser()) document.LoginForm.submit();"/></div>
								</div>	
								
							</form>
						</div>
					</div>			
					<div class="footerTable">
						<table class="footerLinks">
							<tbody class="linkPosition">
								<tr>
									<td width="90" class="padding"><a class="footerFont" href="#" onClick="window.open('<%=request.getContextPath()%>/images/popup/importantInformation.html', 'important', 'width=605,height=420,scrollbars=no');">Important notice</a></td>
									<td class="padding"><span class="footerFont">&nbsp;|&nbsp;</span></td>
									<td width="85" class="padding"><a class="footerFont" href="javascript:sendReset();">Password reset</a></td>
									<td class="padding"><span class="footerFont" >&nbsp;|&nbsp;</span></td>
									<td width="80" class="padding"><a class="footerFont" href="#" onClick="window.open('<%=request.getContextPath()%>/images/popup/signinIssues.html', 'important', 'width=605,height=305,scrollbars=no,location=no');">Log-in issues</a></td>
									<td width="470"></td>
									<td width="70" class="padding"><a class="footerFont" href="http://company.com/">company.com</a></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

	<div class="affiliateLogo"><img src="<%=request.getContextPath()%>/images/mobile/affiliateLogo.gif" alt="Affiliate Logo" /></div>

	</div>
</div>
</body>
</html>

<% } %>