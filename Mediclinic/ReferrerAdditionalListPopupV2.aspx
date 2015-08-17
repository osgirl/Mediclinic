<%@ Page Title="Referrer List" Language="C#" MasterPageFile="~/SiteV2.master" AutoEventWireup="true" CodeFile="ReferrerAdditionalListPopupV2.aspx.cs" Inherits="ReferrerAdditionalListPopupV2" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <script src="Scripts/get_details_of_person.js" type="text/javascript"></script>
    <script type="text/javascript">

        function select_additional_referrers() {

            var selected = get_selected();

            if (selected.length == 0) {
                alert("Please use the checkboxes to select at least one.");
                return;
            }


            // if opener function has a confirm box, then this will wait for them to confirm/deny before this popup can close
            // to fix this - we make it asynchronous to ensure this closes

            setTimeout(function () {
                window.opener.set_referrer_additional_emails(selected);
            }, 0);

            setTimeout(function () {
                self.close();
            }, 50);           
        }

        function highlight_row(chkBox) {  // doesnt pass in a checkbox -- read first comment below
            // asp:CheckBox control doesn't have a onchange event, and onchange event will be rendered in a <span> tag and not the <input> tag. 
            // so get parent, then get the control

            var gvDrv = document.getElementById("<%= GrdReferrerAdditionalEmails.ClientID %>");

            for (i = 1; i < gvDrv.rows.length; i++) {

                // dont do all the processing if its not the row
                if (chkBox != null && gvDrv.rows[i] != chkBox.parentNode.parentNode)
                    continue;

                    // if it is the row, process than return out of the function
                else {

                    var cells = gvDrv.rows[i].cells;
                    for (j = 0; j < cells.length; j++) {
                        var HTML = cells[j].innerHTML;

                        if (chkBox != null && cells[j] != chkBox.parentNode)
                            continue; // alert("found");

                        if (HTML.indexOf("chkSelect") != -1) {
                            var lblID = cells[0].getElementsByTagName("*")[0];
                            var chkSelect = cells[j].getElementsByTagName("*")[1];  // first item is the onchange event rendered as a div, so get 2nd item

                            var cells2 = gvDrv.rows[i].cells;
                            for (j2 = 0; j2 < cells2.length; j2++)
                                cells2[j2].style.backgroundColor = chkSelect.checked ? '#FAFAD2' : '';  // LightGoldenrodYellow 
                        }
                    }

                    if (chkBox != null)
                        return;
                }
            }
        }

        function get_selected() {

            var selected = "";

            var gvDrv = document.getElementById("<%= GrdReferrerAdditionalEmails.ClientID %>");
            for (i = 1; i < gvDrv.rows.length; i++) {

                var cells = gvDrv.rows[i].cells;
                for (j = 0; j < cells.length; j++) {
                    var HTML = cells[j].innerHTML;

                    if (HTML.indexOf("chkSelect") != -1) {
                        var lblID = cells[0].getElementsByTagName("*")[0];
                        var lblName   = cells[1].getElementsByTagName("*")[0];
                        var lblEmail  = cells[2].getElementsByTagName("*")[0];
                        var chkSelect = cells[j].getElementsByTagName("*")[1];  // first item is the onchange event rendered as a div, so get 2nd item

                        if (chkSelect.checked)
                            selected += (selected.length == 0 ? "" : ",") + lblEmail.innerHTML;
                    }
                }
            }

            return selected;
        }

        function checkAll(AllCheckboxes) {
            var GridVwHeaderChckbox = document.getElementById("<%= GrdReferrerAdditionalEmails.ClientID %>");
            for (i = 1; i < GridVwHeaderChckbox.rows.length; i++) {
                var curChkBox = GridVwHeaderChckbox.rows[i].cells[5].getElementsByTagName("INPUT")[0];
                curChkBox.checked = AllCheckboxes.checked;
                highlight_row(curChkBox.parentNode);
            }
        }

        // ---------------------------------------------------------------------------------------------


    </script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <div class="clearfix">
        <div class="page_title"><asp:Label id="lblHeading" runat="server">Referrer Additional Emails</asp:Label></div>
        <div class="main_content" style="padding:10px 5px;">
            <div class="user_login_form" style="width: 950px;">

                    <center>
                        <table>
                            <tr>
                                <td>
                                    <asp:ValidationSummary ID="ValidationSummary" runat="server" CssClass="failureNotification" ValidationGroup="ValidationSummary"/>
                                    <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" CssClass="failureNotification"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </center>

            </div>

            <br />


            <center>

                <div id="autodivheight" class="divautoheight" style="height:500px;">

                <asp:GridView ID="GrdReferrerAdditionalEmails" runat="server" 
                        AutoGenerateColumns="False" DataKeyNames="rae_referrer_additional_email_id" 
                        OnRowCancelingEdit="GrdReferrerAdditionalEmails_RowCancelingEdit" 
                        OnRowDataBound="GrdReferrerAdditionalEmails_RowDataBound" 
                        OnRowEditing="GrdReferrerAdditionalEmails_RowEditing" 
                        OnRowUpdating="GrdReferrerAdditionalEmails_RowUpdating" ShowFooter="True" ShowHeader="True"
                        OnRowCommand="GrdReferrerAdditionalEmails_RowCommand" 
                        OnRowDeleting="GrdReferrerAdditionalEmails_RowDeleting" 
                        OnRowCreated="GrdReferrerAdditionalEmails_RowCreated"
                        OnSorting="GrdReferrerAdditionalEmails_Sorting" AllowSorting="True" 
                        AllowPaging="False"
                        ClientIDMode="Predictable"
                        CssClass="table table-bordered table-striped table-grid table-grid-top-bottum-padding-normal auto_width block_center">

                        <Columns> 

                            <asp:TemplateField HeaderText="ID"  HeaderStyle-HorizontalAlign="Left" SortExpression="rae_referrer_additional_email_id"> 
                                <ItemTemplate> 
                                    <asp:Label ID="lblId" runat="server" Text='<%# Eval("rae_referrer_additional_email_id") %>'></asp:Label> 
                                </ItemTemplate> 
                                <EditItemTemplate> 
                                    <asp:Label ID="lblId" runat="server" Text='<%# Eval("rae_referrer_additional_email_id") %>'></asp:Label> 
                                </EditItemTemplate> 
                                <FooterTemplate> 
                                </FooterTemplate> 
                            </asp:TemplateField> 

                            <asp:TemplateField HeaderText="Name" HeaderStyle-HorizontalAlign="Left" SortExpression="rae_name" FooterStyle-VerticalAlign="Top" ItemStyle-Wrap="false" ItemStyle-CssClass="text_left nowrap"> 
                                <ItemTemplate> 
                                    <asp:Label ID="lblName" runat="server" Text='<%# Eval("rae_name") %>'></asp:Label> 
                                </ItemTemplate> 
                                <EditItemTemplate> 
                                    <asp:TextBox ID="txtName" runat="server" Text='<%# Eval("rae_name") %>' Columns="14"></asp:TextBox>
                                </EditItemTemplate> 
                                <FooterTemplate> 
                                    <asp:TextBox ID="txtNewName" runat="server" Columns="14"></asp:TextBox>
                                </FooterTemplate> 
                            </asp:TemplateField> 

                            <asp:TemplateField HeaderText="Email" HeaderStyle-HorizontalAlign="Left" SortExpression="rae_email" FooterStyle-VerticalAlign="Top" ItemStyle-Wrap="false" ItemStyle-CssClass="text_left nowrap"> 
                                <ItemTemplate> 
                                    <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("rae_email") %>'></asp:Label> 
                                </ItemTemplate> 
                                <EditItemTemplate> 
                                    <asp:TextBox ID="txtemail" runat="server" Text='<%# Eval("rae_email") %>' Columns="16"></asp:TextBox>
                                </EditItemTemplate> 
                                <FooterTemplate> 
                                    <asp:TextBox ID="txtNewEmail" runat="server" Columns="16"></asp:TextBox>
                                </FooterTemplate> 
                            </asp:TemplateField> 

                            <asp:TemplateField HeaderText="" ShowHeader="False" HeaderStyle-HorizontalAlign="Left" FooterStyle-VerticalAlign="Top"> 
                                <EditItemTemplate> 
                                    <asp:LinkButton ID="lnkUpdate" runat="server" CausesValidation="True" CommandName="Update" Text="Update" ValidationGroup="EditHealthCardEPCRemainingValidationSummary"></asp:LinkButton> 
                                    <asp:LinkButton ID="lnkCancel" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton> 
                                </EditItemTemplate> 
                                <FooterTemplate> 
                                    <asp:LinkButton ID="lnkAdd" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" ValidationGroup="AddHealthCardEPCRemainingValidationGroup"></asp:LinkButton> 
                                </FooterTemplate> 
                                <ItemTemplate> 
                                    <asp:LinkButton ID="lnkEdit" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton> 
                                </ItemTemplate> 
                            </asp:TemplateField> 

                            <asp:TemplateField HeaderText="" ShowHeader="True" HeaderStyle-HorizontalAlign="Left" FooterStyle-VerticalAlign="Top">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnDelete" runat="server"  CommandName="_Delete" CommandArgument='<%# Bind("rae_referrer_additional_email_id") %>' Text="Del" AlternateText="Delete" ToolTip="Delete" />
                                </ItemTemplate>
                                <EditItemTemplate> 
                                </EditItemTemplate> 
                                <FooterTemplate> 
                                </FooterTemplate> 
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Select" HeaderStyle-HorizontalAlign="Left" FooterStyle-VerticalAlign="Top" ItemStyle-HorizontalAlign="Center"> 
                                <HeaderTemplate>
                                    <asp:CheckBox ID="chkSelectAll" runat="server" onclick="checkAll(this);" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelect" runat="server" Text="" onchange="highlight_row(this);" />
                                </ItemTemplate> 
                            </asp:TemplateField> 

                        </Columns> 

                    </asp:GridView>

                </div>
                <br />

                <asp:Button ID="btnAddSelected" runat="server" Text="Add Selected" OnClientClick="javascript: select_additional_referrers();return false;" />
                &nbsp;&nbsp;
                <asp:Button ID="btnClose" runat="server" Text="Close" OnClientClick="window.returnValue=false;self.close();return false;" />


            </center>

        </div>
    </div>


</asp:Content>



