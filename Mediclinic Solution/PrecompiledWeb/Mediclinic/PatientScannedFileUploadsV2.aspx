﻿<%@ page title="Scanned Files" language="C#" masterpagefile="~/SiteV2.master" autoeventwireup="true" inherits="PatientScannedFileUploadsV2, App_Web_nvct1tre" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <!--// plugin-specific resources //-->
    <script src="Scripts/jquery-1.4.1.js" type="text/javascript"></script>
    <script src="Scripts/jquery.form.js" type="text/javascript"></script>
    <script src="Scripts/jquery.MetaData.js" type="text/javascript"></script>
    <script src="Scripts/jquery.MultiFile.js" type="text/javascript"></script>
    <script src="Scripts/jquery.blockUI.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <div class="clearfix">
        <div class="page_title"><asp:Label ID="lblHeading" runat="server">EPC Info</asp:Label> &nbsp; <asp:HyperLink ID="lnkToEntity" runat="server"></asp:HyperLink></div>
        <div class="main_content" style="padding:20px 5px;">

             <center>

                <asp:ValidationSummary ID="ValidationSummary" runat="server" CssClass="failureNotification" ValidationGroup="ValidationSummary"/>
                <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" CssClass="failureNotification"></asp:Label>

                <div style="height:12px;"></div>

                <table id="spn_manage_files" runat="server" border="0" cellpadding="0" cellspacing="0">
                    <tr style="vertical-align:top;">

                        <td>
                            <strong>Current Files</strong>
                            <div style="line-height:7px;">&nbsp;</div>
                            <asp:Repeater id="lstCurrentFiles" runat="server" OnItemDataBound="lstCurrentFiles_ItemDataBound">
                                <HeaderTemplate>
                                    <table style="width:100%;">
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <asp:LinkButton ID="btnDelFile" runat="server" ToolTip="Delete" CommandArgument='<%# Bind("filepath") %>' OnClick="btnDeleteFie_Click" Text='<%# Bind("text") %>'
                                                            OnClientClick="javascript:if (!confirm('Are you sure you want to permanently delete this file?')) return false;" />
                                            <asp:Label ID="lblFileName" Text='<%# Bind("filename") %>' runat="server"></asp:Label> 
                                            (<asp:LinkButton ID="lnkFileName" runat="server" CommandArgument='<%# Bind("filepath") %>' OnClick="btnDownload_Click" Text='download' />)
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <FooterTemplate>
                                        <tr>
                                            <td><asp:Label ID="lblNoScannedDocsText" runat="server" Text="No Scanned Documents."/></td>
                                        </tr>
                                    </table>
                                </FooterTemplate>
                            </asp:Repeater>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <div style="height:18px;"></div>
                            <strong>Upload Files</strong>
                            <div style="line-height:7px;">&nbsp;</div>
                            <table>
                                <tr>
                                    <td>
                                        <asp:FileUpload ID="FileUpload1" runat="server" class="multi" accept="dot|doc|docx|txt|pdf|jpg|jpeg|png|gif|tiff"  />
                                        <br />
                                        <asp:CheckBox ID="chkAllowOverwrite" runat="server" Font-Size="Small" ForeColor="GrayText" Text="Allow File Overwrite" />
                                        <div style="line-height:7px;">&nbsp;</div>

                                        <center>
                                            <asp:Button ID="btnUpload" runat="server" Text="Upload All" onclick="btnUpload_Click" />&nbsp;
                                            <asp:Button ID="btnClose" runat="server" Text="Close" OnClientClick="javascript:window.close();return false;" />
                                        </center>
                                        <div style="height:15px;"></div>
                                        <asp:Label ID="lblUploadMessage" runat="server"></asp:Label>
                                    </td>
                                </tr>
                            </table>

                        </td>
                    </tr>

                </table>


            </center>

        </div>
    </div>


</asp:Content>



