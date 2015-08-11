﻿<%@ Page Title="Create Web Login" Language="C#" MasterPageFile="~/SiteV2.master" AutoEventWireup="true" CodeFile="CreateNewLoginV2.aspx.cs" Inherits="CreateNewLoginV2" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <div class="clearfix">
        <div class="page_title"><span id="lblHeading">Existing Patient - Create Web Login</span></div>
        <div class="main_content" id="main_content" runat="server" style="background: url(../imagesV2/login_bg.png) center top no-repeat #EDEDED;">

            <br />

            <center>

                <asp:Panel ID="pnlDefaultButton" runat="server" DefaultButton="CreateLoginButton" CssClass="login_form">
                <table cellpadding="1" style="border-collapse:collapse;" class="block_center">
                    <tr>
                        <td>
                            <br />
                            <table class="block_center">
                                <tr>
                                    <td >
                                        <asp:Label ID="EmailLabel" runat="server">Email:</asp:Label>
                                    </td>
                                    <td>&nbsp;
                                        <asp:TextBox ID="Email" runat="server" autocomplete="off"></asp:TextBox>
                                    </td>
                                    <td><asp:RequiredFieldValidator ID="txtValidateEmailRequired" runat="server" CssClass="failureNotification"  
                                                ControlToValidate="Email" 
                                                ErrorMessage="Email is required."
                                                Display="Dynamic"
                                                ValidationGroup="ChangeUserPasswordValidationGroup">&nbsp;*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr id="beforeButtonSpace" runat="server" style="height:15px;">
                                    <td colspan="3"></td>
                                </tr>
                                <tr style="height:2px;">
                                    <td colspan="3"></td>
                                </tr>
                                <tr>
                                    <td colspan="3" align="center">
                                        <asp:Button ID="CreateLoginButton" runat="server" CommandName="Retrieve" Text="Create" onclick="CreateLoginButton_Click" ValidationGroup="ChangeUserPasswordValidationGroup" CssClass="btn btn-primary" />
                                    </td>
                                </tr>
                                <tr id="afterButtonSpace" runat="server" style="height:30px;">
                                    <td colspan="3"></td>
                                </tr>

                                <tr>
                                    <td colspan="3" align="center">
                                        <asp:LinkButton ID="lnkLogin" runat="server" OnClick="lnkLogin_Click">Back to login page</asp:LinkButton>
                                    </td>
                                </tr>

                            </table>

                        </td>
                    </tr>
                </table>

                <div class="text-center" style="color:Red;width:90%">

                    <br />
                    <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                    <asp:ValidationSummary ID="ChangeUserPasswordValidationSummary" runat="server" style="color:Red;" ValidationGroup="ChangeUserPasswordValidationGroup"/>

                </div>

            </asp:Panel>
            </center> 

            <br />

            <div id="autodivheight" class="divautoheight" style="height:200px;">
            </div>

        </div>
    </div>

</asp:Content>



