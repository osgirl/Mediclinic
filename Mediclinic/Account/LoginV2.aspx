<%@ Page Title="Login" Language="C#" MasterPageFile="~/SiteV2.master" AutoEventWireup="true" CodeFile="LoginV2.aspx.cs" Inherits="LoginV2" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
	body {
		background: #0870ae !important;
		font-family:"Gill Sans MT Regular", "Gill Sans", "Gill Sans MT", "Myriad Pro", "DejaVu Sans Condensed", Helvetica, Arial, sans-serif !important;
	}
	.wrapper{
		width:50%;
		margin: auto;
		position: absolute;
		top: 0; left: 0; bottom: 0; right: 0;
		position:relative;
		margin-top:20px;
	}
	.forms{
		width: 60%;
		margin: 0 auto;
		display: block;
	}
	a {
		color:#ffffff; 
		text-decoration:underline
 	} 
	a:hover {
		color:#212121 !important; 
 	} 
	.btn:hover{
		background-color:#00bdd1!important;
	}
	.vertical-center {
		min-height: 100%;
		min-height: 100vh;
		display: flex;
		align-items: center;
		justify-content: center;
		flex-direction: column;
	}
/* For 980px or less */  
	@media screen and (max-width: 700px){ 
		.wrapper{
			width:100%;
			margin: auto;
			position: absolute;
			top: 0; left: 0; bottom: 0; right: 0;
			position:relative;
		}
		.forms{
			width: 60%;
			margin: 0 auto;
			display: block;
		}
	}
</style>

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

<div class="wrapper">
    <asp:Panel ID="Panel1" runat="server" CssClass="nowrap" style="text-align:center;">
        <asp:Button ID="Button1" runat="server" CommandArgument="Support1" CssClass="btn btn-primary" onclick="btnDevLogin_Click" Text="Support Login" />
    </asp:Panel>
    <p align="center"><img src="..\imagesV2\login-logo.png" alt="Logo" style="width: 70%"></p>
    <div class="forms">
          
  		    <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
          
      <div class="form-group has-feedback">
          <asp:TextBox ID="UserName" runat="server" autocomplete="off" class="form-control" placeholder="USERNAME"></asp:TextBox>
          <i class="glyphicon glyphicon-user form-control-feedback" style="color:#007fb3"></i>
          <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" 
                                            ControlToValidate="UserName" ErrorMessage="Username is required." 
                                            Display="Dynamic"
                                            ToolTip="User Name is required." ValidationGroup="LoginUserValidationGroup" CssClass="failureNotification" ></asp:RequiredFieldValidator>    
      </div>
      <div class="form-group has-feedback">
          <asp:TextBox ID="Password" runat="server" TextMode="Password" autocomplete="off" class="form-control" placeholder="PASSWORD"></asp:TextBox>
          <i class="glyphicon glyphicon-lock form-control-feedback" style="color:#007fb3"></i>
          <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" 
                                            ControlToValidate="Password" ErrorMessage="Password is required." 
                                            Display="Dynamic"
                                            ToolTip="Password is required." ValidationGroup="LoginUserValidationGroup" CssClass="failureNotification" ></asp:RequiredFieldValidator>
      </div>
      <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="LOGIN" onclick="LoginButton_Click" ValidationGroup="LoginUserValidationGroup" CssClass="btn btn-default navbar-btn" style="width:100%; background-color:#ff422e; color:#FFFFFF" />
        <p align="right"><a href="https://portal.mediclinic.com.au/Account/TermsAndConditionsV2.aspx" style="color:#ffffff; text-decoration:underline">Terms & Conditions Of Use Agreement</a></p>
      <p align="right"><asp:LinkButton ID="lnkLostPassword" runat="server" OnClick="lnkLostPassword_Click" style="color:#ffffff; text-decoration:underline">Forgot your password?</asp:LinkButton></p>
    </div>
</div>

</asp:Content>