﻿<%@ page title="Invoice Line - Area Treated" language="C#" masterpagefile="~/SiteV2.master" autoeventwireup="true" inherits="Invoice_UpdateAreaTreatedV2, App_Web_nvct1tre" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <div class="clearfix">
        <div class="page_title"><span id="lblHeading">Invoice Line - Area Treated</span></div>
        <div class="main_content" style="padding:20px 5px;">

             <center>

                <asp:ValidationSummary ID="ValidationSummary" runat="server" CssClass="failureNotification" ValidationGroup="ValidationSummary"/>
                <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" CssClass="failureNotification"></asp:Label>

                <div style="height:10px;"></div>

                    <table id="maintable" runat="server">
                        <tr>
                            <td>Area Treated</td>
                            <td style="width:8px;"></td>
                            <td><asp:TextBox ID="txtFlashingText" runat="server" Columns="50" /></td>
                            <td style="width:8px;"></td>
                            <td><asp:Button ID="btnClear" runat="server" Text="Clear" OnClientClick="document.getElementById('txtFlashingText').value='';return false;" /></td>
                        </tr>
                        <tr>
                            <td colspan="5" style="text-align:center;">
                                <div style="height:20px;"></div>
                                <asp:Button ID="btnSubmit" runat="server" Text="Submit" onclick="btnSubmit_Click" CausesValidation="True" ValidationGroup="ValidationSummary" />
                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" onclick="btnCancel_Click"  OnClientClick="window.returnValue=false;self.close();" />
                                <div style="height:10px;"></div>
                            </td>
                        </tr>

                    </table>

            </center>

        </div>
    </div>


</asp:Content>



