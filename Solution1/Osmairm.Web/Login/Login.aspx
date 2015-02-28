<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login"
    Title="Osmairm - Pannello di Amministrazione" %>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="HeadLogin" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <meta name="robots" content="index,follow" />
    <meta name="Author" content="osmairm" />
    <meta http-equiv="imagetoolbar" content="no" />
    <title>Osmairm Pannello di Amministrazione</title>
    <!-- **********   CSS   ********** -->
   <link href="assets/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
  <link href="assets/css/metro.css" rel="stylesheet" />
  <link href="assets/font-awesome/css/font-awesome.css" rel="stylesheet" />
  <link href="assets/css/style.css" rel="stylesheet" />
  <link href="assets/css/style_responsive.css" rel="stylesheet" />
  <link href="assets/css/style_default.css" rel="stylesheet" id="style_color" />
  <link rel="stylesheet" type="text/css" href="assets/uniform/css/uniform.default.css" />
  <link rel="shortcut icon" href="favicon.ico" />
</head>
<body class="login">
    <form id="LoginPage" runat="server">
    <div class="logo">
        <img src="../images/logo.png" alt="" />
    </div>
     <div class="content">
         <div class="form-vertical login-form" action="index.html">
            <h3 class="form-title">
                Area Riservata</h3>
            <asp:Login ID="Login1" runat="server" DestinationPageUrl="~/Admin/Default.aspx" OnLoginError="LoginError"
                  OnLoggedIn="btnLogin_Click">
                <LayoutTemplate>
                    <div class="control-group">
                        <div class="controls">
                            <div class="input-icon left">
                                <i class="icon-user"></i>
                                <asp:TextBox ID="UserName" placeholder="Utente" runat="server" CssClass="m-wrap"></asp:TextBox>
                             <span class="info">
                              </div> <asp:RequiredFieldValidator ForeColor="white"  CssClass="label label-important" ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                    ErrorMessage="Verifica Utente" ToolTip="Verifica Utente" ValidationGroup="Login1"></asp:RequiredFieldValidator>
                            </span>
                        </div>
                    </div>
                    <div class="control-group">
                        <div class="controls">
                            <div class="input-icon left">
                                <i class="icon-lock"></i>
                                <asp:TextBox ID="Password" placeholder="Password" CssClass="m-wrap" runat="server"
                                    TextMode="Password"></asp:TextBox>
                              </div>
 									 <asp:RequiredFieldValidator ID="PasswordRequired" ForeColor="white" CssClass="label label-important" runat="server" ControlToValidate="Password"
                                    ErrorMessage="Inserire password" ToolTip="Inserire password" ValidationGroup="Login1"></asp:RequiredFieldValidator>
                            </div>
                    </div>
                    <div class="form-actions">
                        <asp:LinkButton CssClass="btn yellow pull-right" ID="LoginButton" runat="server" CommandName="Login"
                            Text="Login"  >
                                    <i class="m-icon-swapright m-icon-white"></i> Login
                        </asp:LinkButton>
                    </div>
                </LayoutTemplate>
            </asp:Login>
            <div class="forget-password">
               <div class="login-footer clear">
                     <div id="DivError" runat="server" visible="false" class="alert alert-error" >
                        <div>
                            <asp:Label runat="server" ID="ContattilblNotificationErr" Visible="false" Text="Errore: Controlla Username e Password"></asp:Label>
                        </div>
                    </div>
                </div>
               </div>
        </div>
      </div>
     <div class="copyright">
        2013 &copy; Osmairm.
    </div>
      <script src="js/jquery-1.8.3.min.js"></script>
  <script src="js/bootstrap.min.js"></script>  
  <script src="js/jquery.uniform.min.js"></script> 
  <script src="js/jquery.blockui.js"></script>
  <script src="js/app.js"></script>
  <script>
    jQuery(document).ready(function() {     
      App.initLogin();
    });
  </script>
    </form>
</body>
</html>
