﻿<%@ page title="Sites" language="C#" masterpagefile="~/SiteV2.master" autoeventwireup="true" inherits="SiteListV2, App_Web_nvct1tre" %>
<%@ Register TagPrefix="UC" TagName="DuplicatePersonModalElementControl" Src="~/Controls/DuplicatePersonModalElementControlV2.ascx" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <div class="clearfix">
        <div class="page_title"><asp:Label ID="lblHeading" runat="server">Sites</asp:Label></div>
        <div class="main_content_with_header">

            <div class="user_login_form">

            </div>

            <div class="text-center">
                <asp:ValidationSummary ID="ValidationSummary" runat="server" CssClass="failureNotification" ValidationGroup="ValidationSummary"/>
                <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" CssClass="failureNotification"></asp:Label>
            </div>


            <center>
                <div id="autodivheight" class="divautoheight" style="height:500px;">

                    <asp:GridView ID="GrdSite" runat="server" 
                         AutoGenerateColumns="False" DataKeyNames="site_id" 
                         OnRowCancelingEdit="GrdSite_RowCancelingEdit" 
                         OnRowDataBound="GrdSite_RowDataBound" 
                         OnRowEditing="GrdSite_RowEditing" 
                         OnRowUpdating="GrdSite_RowUpdating" ShowFooter="True" 
                         OnRowCommand="GrdSite_RowCommand" 
                         OnRowCreated="GrdSite_RowCreated"
                         AllowSorting="True" 
                         OnSorting="GridView_Sorting"
                         RowStyle-VerticalAlign="top"
                         ClientIDMode="Predictable"
                         CssClass="table table-bordered table-striped table-grid table-grid-top-bottum-padding-normal auto_width block_center">

                        <Columns> 

                            <asp:TemplateField HeaderText="ID"  HeaderStyle-HorizontalAlign="Left" SortExpression="site_id"> 
                                <EditItemTemplate> 
                                    <asp:Label ID="lblId" runat="server" Text='<%# Bind("site_id") %>'></asp:Label>
                                </EditItemTemplate> 
                                <ItemTemplate> 
                                    <asp:Label ID="lblId" runat="server" Text='<%# Bind("site_id") %>'></asp:Label> 
                                </ItemTemplate> 
                            </asp:TemplateField> 

                            <asp:TemplateField HeaderText="Name" HeaderStyle-HorizontalAlign="Left" FooterStyle-VerticalAlign="Top" SortExpression="name"> 
                                <EditItemTemplate> 
                                    <asp:TextBox Width="75%" ID="txtName" runat="server" Text='<%# Bind("name") %>'></asp:TextBox> 
                                    <asp:RequiredFieldValidator ID="txtValidateNameRequired" runat="server" CssClass="failureNotification"  
                                        ControlToValidate="txtName" 
                                        ErrorMessage="Name is required."
                                        Display="Dynamic"
                                        ValidationGroup="EditSiteValidationSummary">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="txtValidateNameRegex" runat="server" CssClass="failureNotification" 
                                        ControlToValidate="txtName"
                                        ValidationExpression="^[a-zA-Z\-\s'\(\)\.]+$"
                                        ErrorMessage="Name contains invalid characters"
                                        Display="Dynamic"
                                        ValidationGroup="EditSiteValidationSummary">*</asp:RegularExpressionValidator>
                                </EditItemTemplate> 
                                <FooterTemplate>
                                    <asp:TextBox Width="75%" ID="txtNewName" runat="server" ></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="txtValidateNewNameRequired" runat="server" CssClass="failureNotification"  
                                        ControlToValidate="txtNewName" 
                                        ErrorMessage="Name is required."
                                        Display="Dynamic"
                                        ValidationGroup="AddSiteValidationGroup">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="txtValidateNewNameRegex" runat="server" CssClass="failureNotification" 
                                        ControlToValidate="txtNewName"
                                        ValidationExpression="^[a-zA-Z\-\s'\(\)\.]+$"
                                        ErrorMessage="Name contains invalid characters"
                                        Display="Dynamic"
                                        ValidationGroup="AddSiteValidationGroup">*</asp:RegularExpressionValidator>
                                </FooterTemplate> 
                                <ItemTemplate> 
                                    <asp:HyperLink ID="lnkName" runat="server" Text='<%# Eval("name") %>' NavigateUrl='<%#  String.Format("~/SiteDetailV2.aspx?type=view&id={0}",Eval("site_id")) %>' ToolTip="Full Edit"  />
                                </ItemTemplate> 
                            </asp:TemplateField> 

                            <asp:TemplateField HeaderText="Type" HeaderStyle-HorizontalAlign="Left" SortExpression="site_type_id" FooterStyle-VerticalAlign="Top"> 
                                <EditItemTemplate> 
                                    <asp:DropDownList ID="ddlClinic" runat="server" ></asp:DropDownList> 
                                </EditItemTemplate> 
                                <ItemTemplate> 
                                    <asp:Label ID="lblClinic" runat="server" Text='<%# Eval("site_type_descr") %>'></asp:Label> 
                                </ItemTemplate> 
                                <FooterTemplate> 
                                    <asp:DropDownList ID="ddlNewClinic" runat="server"></asp:DropDownList>
                                </FooterTemplate> 
                            </asp:TemplateField> 

                            <asp:TemplateField HeaderText="ABN" HeaderStyle-HorizontalAlign="Left" FooterStyle-VerticalAlign="Top" SortExpression="abn"> 
                                <EditItemTemplate> 
                                    <asp:TextBox Width="75%" ID="txtABN" runat="server" Text='<%# Bind("abn") %>'></asp:TextBox> 
                                    <asp:RegularExpressionValidator ID="txtValidateABNRegex" runat="server" CssClass="failureNotification" 
                                        ControlToValidate="txtABN"
                                        ValidationExpression="^[0-9\-\s]+$"
                                        ErrorMessage="ABN can only be numbers and dashes."
                                        Display="Dynamic"
                                        ValidationGroup="EditSiteValidationSummary">*</asp:RegularExpressionValidator>
                                </EditItemTemplate> 
                                <FooterTemplate>
                                    <asp:TextBox Width="75%" ID="txtNewABN" runat="server" ></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="txtValidateNewABNRegex" runat="server" CssClass="failureNotification" 
                                        ControlToValidate="txtNewABN"
                                        ValidationExpression="^[0-9\-\s]+$"
                                        ErrorMessage="ABN can only be numbers and dashes."
                                        Display="Dynamic"
                                        ValidationGroup="AddSiteValidationGroup">*</asp:RegularExpressionValidator>
                                </FooterTemplate> 
                                <ItemTemplate> 
                                    <asp:Label ID="lblABN" runat="server" Text='<%# Bind("abn") %>'></asp:Label> 
                                </ItemTemplate> 
                            </asp:TemplateField> 

                            <asp:TemplateField HeaderText="ACN" HeaderStyle-HorizontalAlign="Left" FooterStyle-VerticalAlign="Top" SortExpression="acn"> 
                                <EditItemTemplate> 
                                    <asp:TextBox Width="75%" ID="txtACN" runat="server" Text='<%# Bind("acn") %>'></asp:TextBox> 
                                    <asp:RegularExpressionValidator ID="txtValidateACNRegex" runat="server" CssClass="failureNotification" 
                                        ControlToValidate="txtACN"
                                        ValidationExpression="^[0-9\-\s]+$"
                                        ErrorMessage="ACN can only be numbers and dashes."
                                        Display="Dynamic"
                                        ValidationGroup="EditSiteValidationSummary">*</asp:RegularExpressionValidator>
                                </EditItemTemplate> 
                                <FooterTemplate>
                                    <asp:TextBox Width="75%" ID="txtNewACN" runat="server" ></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="txtValidateNewACNRegex" runat="server" CssClass="failureNotification" 
                                        ControlToValidate="txtNewACN"
                                        ValidationExpression="^[0-9\-\s]+$"
                                        ErrorMessage="ACN can only be numbers and dashes."
                                        Display="Dynamic"
                                        ValidationGroup="AddSiteValidationGroup">*</asp:RegularExpressionValidator>
                                </FooterTemplate> 
                                <ItemTemplate> 
                                    <asp:Label ID="lblACN" runat="server" Text='<%# Bind("acn") %>'></asp:Label> 
                                </ItemTemplate> 
                            </asp:TemplateField> 

                            <asp:TemplateField HeaderText="TFN" HeaderStyle-HorizontalAlign="Left" FooterStyle-VerticalAlign="Top" SortExpression="tfn"> 
                                <EditItemTemplate> 
                                    <asp:TextBox Width="75%" ID="txtTFN" runat="server" Text='<%# Bind("tfn") %>'></asp:TextBox> 
                                    <asp:RegularExpressionValidator ID="txtValidateTFNRegex" runat="server" CssClass="failureNotification" 
                                        ControlToValidate="txtTFN"
                                        ValidationExpression="^[0-9\-]+$"
                                        ErrorMessage="TFN can only be numbers and dashes."
                                        Display="Dynamic"
                                        ValidationGroup="EditSiteValidationSummary">*</asp:RegularExpressionValidator>
                                </EditItemTemplate> 
                                <FooterTemplate>
                                    <asp:TextBox Width="75%" ID="txtNewTFN" runat="server" ></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="txtValidateNewTFNRegex" runat="server" CssClass="failureNotification" 
                                        ControlToValidate="txtNewTFN"
                                        ValidationExpression="^[0-9\-]+$"
                                        ErrorMessage="TFN can only be numbers and dashes."
                                        Display="Dynamic"
                                        ValidationGroup="AddSiteValidationGroup">*</asp:RegularExpressionValidator>
                                </FooterTemplate> 
                                <ItemTemplate> 
                                    <asp:Label ID="lblTFN" runat="server" Text='<%# Bind("tfn") %>'></asp:Label> 
                                </ItemTemplate> 
                            </asp:TemplateField> 

                            <asp:TemplateField HeaderText="ASIC" HeaderStyle-HorizontalAlign="Left" FooterStyle-VerticalAlign="Top" SortExpression="asic"> 
                                <EditItemTemplate> 
                                    <asp:TextBox Width="75%" ID="txtASIC" runat="server" Text='<%# Bind("asic") %>'></asp:TextBox> 
                                    <asp:RegularExpressionValidator ID="txtValidateASICRegex" runat="server" CssClass="failureNotification" 
                                        ControlToValidate="txtASIC"
                                        ValidationExpression="^[0-9\-]+$"
                                        ErrorMessage="ASIC can only be numbers and dashes."
                                        Display="Dynamic"
                                        ValidationGroup="EditSiteValidationSummary">*</asp:RegularExpressionValidator>
                                </EditItemTemplate> 
                                <FooterTemplate>
                                    <asp:TextBox Width="75%" ID="txtNewASIC" runat="server" ></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="txtValidateNewASICRegex" runat="server" CssClass="failureNotification" 
                                        ControlToValidate="txtNewASIC"
                                        ValidationExpression="^[0-9\-]+$"
                                        ErrorMessage="ASIC can only be numbers and dashes."
                                        Display="Dynamic"
                                        ValidationGroup="AddSiteValidationGroup">*</asp:RegularExpressionValidator>
                                </FooterTemplate> 
                                <ItemTemplate> 
                                    <asp:Label ID="lblASIC" runat="server" Text='<%# Bind("asic") %>'></asp:Label> 
                                </ItemTemplate> 
                            </asp:TemplateField> 

                            <asp:TemplateField HeaderText="Provider" FooterStyle-VerticalAlign="Top" SortExpression="is_provider"> 
                                <EditItemTemplate> 
                                    <asp:CheckBox ID="chkIsProvider" runat="server" Checked='<%#Eval("is_provider").ToString()=="True"?true:false %>' />
                                </EditItemTemplate> 
                                <ItemTemplate> 
                                    <asp:Label ID="lblIsProvider" runat="server" Text='<%# Eval("is_provider").ToString()=="True"?"Yes":"No" %>'></asp:Label> 
                                </ItemTemplate> 
                                <FooterTemplate> 
                                    <asp:CheckBox ID="chkNewIsProvider" runat="server" />
                                </FooterTemplate> 
                            </asp:TemplateField> 

                            <asp:TemplateField HeaderText="BPay" HeaderStyle-HorizontalAlign="Left" FooterStyle-VerticalAlign="Top" SortExpression="bank_bpay"> 
                                <EditItemTemplate> 
                                    <asp:TextBox Width="75%" ID="txtBPay" runat="server" Text='<%# Bind("bank_bpay") %>'></asp:TextBox> 
                                    <asp:RequiredFieldValidator ID="txtValidateBPayRequired" runat="server" CssClass="failureNotification"  
                                        ControlToValidate="txtBPay" 
                                        Display="Dynamic"
                                        ErrorMessage="BPay is required."
                                        ValidationGroup="EditSiteValidationSummary">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="txtValidateBPayRegex" runat="server" CssClass="failureNotification" 
                                        ControlToValidate="txtBPay"
                                        ValidationExpression="^[0-9\-]+$"
                                        ErrorMessage="BPay can only be numbers and dashes."
                                        Display="Dynamic"
                                        ValidationGroup="EditSiteValidationSummary">*</asp:RegularExpressionValidator>
                                </EditItemTemplate> 
                                <FooterTemplate>
                                    <asp:TextBox Width="75%" ID="txtNewBPay" runat="server" ></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="txtValidateNewBPayRequired" runat="server" CssClass="failureNotification"  
                                        ControlToValidate="txtNewBPay" 
                                        ErrorMessage="BPay is required."
                                        Display="Dynamic"
                                        ValidationGroup="AddSiteValidationGroup">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="txtValidateNewBPayRegex" runat="server" CssClass="failureNotification" 
                                        ControlToValidate="txtNewBPay"
                                        ValidationExpression="^[0-9\-]+$"
                                        ErrorMessage="BPay can only be numbers and dashes."
                                        Display="Dynamic"
                                        ValidationGroup="AddSiteValidationGroup">*</asp:RegularExpressionValidator>
                                </FooterTemplate> 
                                <ItemTemplate> 
                                    <asp:Label ID="lblBPay" runat="server" Text='<%# Bind("bank_bpay") %>'></asp:Label> 
                                </ItemTemplate> 
                            </asp:TemplateField> 

                            <asp:TemplateField HeaderText="BSB" HeaderStyle-HorizontalAlign="Left" FooterStyle-VerticalAlign="Top" SortExpression="bank_bsb"> 
                                <EditItemTemplate> 
                                    <asp:TextBox Width="75%" ID="txtBSB" runat="server" Text='<%# Bind("bank_bsb") %>'></asp:TextBox> 
                                    <asp:RequiredFieldValidator ID="txtValidateBSBRequired" runat="server" CssClass="failureNotification"  
                                        ControlToValidate="txtBSB" 
                                        ErrorMessage="BSB is required."
                                        Display="Dynamic"
                                        ValidationGroup="EditSiteValidationSummary">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="txtValidateBSBRegex" runat="server" CssClass="failureNotification" 
                                        ControlToValidate="txtBSB"
                                        ValidationExpression="^[0-9\-]+$"
                                        ErrorMessage="BSB can only be numbers and dashes."
                                        Display="Dynamic"
                                        ValidationGroup="EditSiteValidationSummary">*</asp:RegularExpressionValidator>
                                </EditItemTemplate> 
                                <FooterTemplate>
                                    <asp:TextBox Width="75%" ID="txtNewBSB" runat="server" ></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="txtValidateNewBSBRequired" runat="server" CssClass="failureNotification"  
                                        ControlToValidate="txtNewBSB" 
                                        ErrorMessage="BSB is required."
                                        Display="Dynamic"
                                        ValidationGroup="AddSiteValidationGroup">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="txtValidateNewBSBRegex" runat="server" CssClass="failureNotification" 
                                        ControlToValidate="txtNewBSB"
                                        ValidationExpression="^[0-9\-]+$"
                                        ErrorMessage="BSB can only be numbers and dashes."
                                        Display="Dynamic"
                                        ValidationGroup="AddSiteValidationGroup">*</asp:RegularExpressionValidator>
                                </FooterTemplate> 
                                <ItemTemplate> 
                                    <asp:Label ID="lblBSB" runat="server" Text='<%# Bind("bank_bsb") %>'></asp:Label> 
                                </ItemTemplate> 
                            </asp:TemplateField> 

                            <asp:TemplateField HeaderText="Bank Acct" HeaderStyle-HorizontalAlign="Left" FooterStyle-VerticalAlign="Top" SortExpression="bank_account"> 
                                <EditItemTemplate> 
                                    <asp:TextBox Width="75%" ID="txtBankAccount" runat="server" Text='<%# Bind("bank_account") %>'></asp:TextBox> 
                                    <asp:RequiredFieldValidator ID="txtValidateBankAccountRequired" runat="server" CssClass="failureNotification"  
                                        ControlToValidate="txtBankAccount" 
                                        Display="Dynamic"
                                        ErrorMessage="Bank Account is required."
                                        ValidationGroup="EditSiteValidationSummary">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="txtValidateBankAccountRegex" runat="server" CssClass="failureNotification" 
                                        ControlToValidate="txtBankAccount"
                                        ValidationExpression="^[0-9\-]+$"
                                        ErrorMessage="Bank Account can only be numbers and dashes."
                                        Display="Dynamic"
                                        ValidationGroup="EditSiteValidationSummary">*</asp:RegularExpressionValidator>
                                </EditItemTemplate> 
                                <FooterTemplate>
                                    <asp:TextBox Width="75%" ID="txtNewBankAccount" runat="server" ></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="txtValidateNewBankAccountRequired" runat="server" CssClass="failureNotification"  
                                        ControlToValidate="txtNewBankAccount" 
                                        ErrorMessage="Bank Account is required."
                                        Display="Dynamic"
                                        ValidationGroup="AddSiteValidationGroup">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="txtValidateNewBankAccountRegex" runat="server" CssClass="failureNotification" 
                                        ControlToValidate="txtNewBankAccount"
                                        ValidationExpression="^[0-9\-]+$"
                                        ErrorMessage="Bank Account can only be numbers and dashes."
                                        Display="Dynamic"
                                        ValidationGroup="AddSiteValidationGroup">*</asp:RegularExpressionValidator>
                                </FooterTemplate> 
                                <ItemTemplate> 
                                    <asp:Label ID="lblBankAccount" runat="server" Text='<%# Bind("bank_account") %>'></asp:Label> 
                                </ItemTemplate> 
                            </asp:TemplateField> 

                            <asp:TemplateField HeaderText="Bank Dir. Debit UserID" HeaderStyle-HorizontalAlign="Left" FooterStyle-VerticalAlign="Top" SortExpression="bank_direct_debit_userid"> 
                                <EditItemTemplate> 
                                    <asp:TextBox Width="75%" ID="txtBankDirectDebitUserID" runat="server" Text='<%# Bind("bank_direct_debit_userid") %>'></asp:TextBox> 
                                    <asp:RequiredFieldValidator ID="txtValidateBankDirectDebitUserIDRequired" runat="server" CssClass="failureNotification"  
                                        ControlToValidate="txtBankDirectDebitUserID" 
                                        ErrorMessage="Bank Dir. Debit UserID is required."
                                        Display="Dynamic"
                                        ValidationGroup="EditSiteValidationSummary">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="txtValidateBankDirectDebitUserIDRegex" runat="server" CssClass="failureNotification" 
                                        ControlToValidate="txtBankDirectDebitUserID"
                                        ValidationExpression="^[a-zA-Z0-9\-]+$"
                                        ErrorMessage="Bank Dir. Debit UserID can only be letters, numbers, and dashes."
                                        Display="Dynamic"
                                        ValidationGroup="EditSiteValidationSummary">*</asp:RegularExpressionValidator>
                                </EditItemTemplate> 
                                <FooterTemplate>
                                    <asp:TextBox Width="75%" ID="txtNewBankDirectDebitUserID" runat="server" ></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="txtValidateNewBankDirectDebitUserIDRequired" runat="server" CssClass="failureNotification"  
                                        ControlToValidate="txtNewBankDirectDebitUserID" 
                                        ErrorMessage="Bank Dir. Debit UserID is required."
                                        Display="Dynamic"
                                        ValidationGroup="AddSiteValidationGroup">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="txtValidateNewBankDirectDebitUserIDRegex" runat="server" CssClass="failureNotification" 
                                        ControlToValidate="txtNewBankDirectDebitUserID"
                                        ValidationExpression="^[a-zA-Z0-9\-]+$"
                                        ErrorMessage="Bank Dir. Debit UserID can only be letters, numbers, and dashes."
                                        Display="Dynamic"
                                        ValidationGroup="AddSiteValidationGroup">*</asp:RegularExpressionValidator>
                                </FooterTemplate> 
                                <ItemTemplate> 
                                    <asp:Label ID="lblBankDirectDebitUserID" runat="server" Text='<%# Bind("bank_direct_debit_userid") %>'></asp:Label> 
                                </ItemTemplate> 
                            </asp:TemplateField> 

                            <asp:TemplateField HeaderText="Bank Username" HeaderStyle-HorizontalAlign="Left" FooterStyle-VerticalAlign="Top" SortExpression="bank_username"> 
                                <EditItemTemplate> 
                                    <asp:TextBox Width="75%" ID="txtBankUsername" runat="server" Text='<%# Bind("bank_username") %>'></asp:TextBox> 
                                    <asp:RequiredFieldValidator ID="txtValidateBankUsernameRequired" runat="server" CssClass="failureNotification"  
                                        ControlToValidate="txtBankUsername" 
                                        ErrorMessage="Bank Username is required."
                                        Display="Dynamic"
                                        ValidationGroup="EditSiteValidationSummary">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="txtValidateBankUsernameRegex" runat="server" CssClass="failureNotification" 
                                        ControlToValidate="txtBankUsername"
                                        ValidationExpression="^[a-zA-Z0-9\-\s]+$"
                                        ErrorMessage="Bank Username can only be letters, numbers, and dashes."
                                        Display="Dynamic"
                                        ValidationGroup="EditSiteValidationSummary">*</asp:RegularExpressionValidator>
                                </EditItemTemplate> 
                                <FooterTemplate>
                                    <asp:TextBox Width="75%" ID="txtNewBankUsername" runat="server" ></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="txtValidateNewBankUsernameRequired" runat="server" CssClass="failureNotification"  
                                        ControlToValidate="txtNewBankUsername" 
                                        ErrorMessage="Bank Username is required."
                                        Display="Dynamic"
                                        ValidationGroup="AddSiteValidationGroup">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="txtValidateNewBankUsernameRegex" runat="server" CssClass="failureNotification" 
                                        ControlToValidate="txtNewBankUsername"
                                        ValidationExpression="^[a-zA-Z0-9\-\s]+$"
                                        ErrorMessage="Bank Username can only be letters, numbers, and dashes."
                                        Display="Dynamic"
                                        ValidationGroup="AddSiteValidationGroup">*</asp:RegularExpressionValidator>
                                </FooterTemplate> 
                                <ItemTemplate> 
                                    <asp:Label ID="lblBankUsername" runat="server" Text='<%# Bind("bank_username") %>'></asp:Label> 
                                </ItemTemplate> 
                            </asp:TemplateField> 

                            <asp:TemplateField HeaderText="Oustanding Balance Warning" HeaderStyle-HorizontalAlign="Left" FooterStyle-VerticalAlign="Top" SortExpression="oustanding_balance_warning"> 
                                <EditItemTemplate> 
                                    <asp:TextBox Width="75%" ID="txtOustandingBalanceWarning" runat="server" Text='<%# Bind("oustanding_balance_warning") %>'></asp:TextBox> 
                                    <asp:RequiredFieldValidator ID="txtValidateOustandingBalanceWarningRequired" runat="server" CssClass="failureNotification"  
                                        ControlToValidate="txtOustandingBalanceWarning" 
                                        ErrorMessage="Oustanding Balance Warning is required."
                                        Display="Dynamic"
                                        ValidationGroup="EditSiteValidationSummary">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="txtValidateOustandingBalanceWarningRegex" runat="server" CssClass="failureNotification" 
                                        ControlToValidate="txtOustandingBalanceWarning"
                                        ValidationExpression="^\d+(\.\d{1,2})?$"
                                        ErrorMessage="Oustanding Balance Warning can only be numbers and option decimal place with 1 or 2 digits following."
                                        Display="Dynamic"
                                        ValidationGroup="EditSiteValidationSummary">*</asp:RegularExpressionValidator>
                                </EditItemTemplate> 
                                <FooterTemplate>
                                    <asp:TextBox Width="75%" ID="txtNewOustandingBalanceWarning" runat="server" Text='0.00'></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="txtValidateNewOustandingBalanceWarningRequired" runat="server" CssClass="failureNotification"  
                                        ControlToValidate="txtNewOustandingBalanceWarning" 
                                        ErrorMessage="Oustanding Balance Warning is required."
                                        Display="Dynamic"
                                        ValidationGroup="AddSiteValidationGroup">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="txtValidateNewOustandingBalanceWarningRegex" runat="server" CssClass="failureNotification" 
                                        ControlToValidate="txtNewOustandingBalanceWarning"
                                        ValidationExpression="^\d+(\.\d{1,2})?$"
                                        ErrorMessage="Oustanding Balance Warning can only be numbers and option decimal place with 1 or 2 digits following."
                                        Display="Dynamic"
                                        ValidationGroup="AddSiteValidationGroup">*</asp:RegularExpressionValidator>
                                </FooterTemplate> 
                                <ItemTemplate> 
                                    <asp:Label ID="lblOustandingBalanceWarning" runat="server" Text='<%# Bind("oustanding_balance_warning") %>'></asp:Label> 
                                </ItemTemplate> 
                            </asp:TemplateField> 

                            <asp:TemplateField HeaderText="PrintEPC" FooterStyle-VerticalAlign="Top"  
                            SortExpression="print_epc"> 
                                <EditItemTemplate> 
                                    <asp:CheckBox ID="chkIsPrintEPC" runat="server" Checked='<%# Eval("print_epc").ToString()=="True"?true:false %>' />
                                </EditItemTemplate> 
                                <ItemTemplate> 
                                    <asp:Label ID="lblIsPrintEPC" runat="server" Text='<%# Eval("print_epc").ToString()=="True"?"Yes":"No" %>'></asp:Label> 
                                </ItemTemplate> 
                                <FooterTemplate> 
                                    <asp:CheckBox ID="chkNewIsPrintEPC" runat="server" />
                                </FooterTemplate> 
                            </asp:TemplateField> 


                            <asp:TemplateField HeaderText="Retrieve Booking Months" HeaderStyle-HorizontalAlign="Left" SortExpression="num_booking_months_to_get" FooterStyle-VerticalAlign="Top"> 
                                <EditItemTemplate> 
                                    <asp:DropDownList ID="ddlNumBookingMonthsToGet" runat="server" DataTextField="num_booking_months_to_get" DataValueField="num_booking_months_to_get"> </asp:DropDownList> 
                                </EditItemTemplate> 
                                <ItemTemplate> 
                                    <asp:Label ID="lblNumBookingMonthsToGet" runat="server" Text='<%# Eval("num_booking_months_to_get") %>'></asp:Label> 
                                </ItemTemplate> 
                                <FooterTemplate> 
                                    <asp:DropDownList ID="ddlNewNumBookingMonthsToGet" runat="server" DataTextField="num_booking_months_to_get" DataValueField="num_booking_months_to_get"> </asp:DropDownList>
                                </FooterTemplate> 
                            </asp:TemplateField> 

                            <asp:TemplateField HeaderText="Fiscal Yr End" HeaderStyle-HorizontalAlign="Left" SortExpression="fiscal_yr_end" FooterStyle-VerticalAlign="Top"> 
                                <EditItemTemplate> 
                                    <asp:TextBox Width="90%" ID="txtFiscalYrEnd" runat="server" Text='<%# Bind("fiscal_yr_end", "{0:dd-MM-yyyy}") %>'></asp:TextBox> 
                                    <asp:RequiredFieldValidator ID="txtValidateFiscalYrEndRequired" runat="server" CssClass="failureNotification"  
                                        ControlToValidate="txtFiscalYrEnd" 
                                        ErrorMessage="Fiscal Yr End is required."
                                        Display="Dynamic"
                                        ValidationGroup="EditSiteValidationSummary">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="txtValidateFiscalYrEndRegex" runat="server" CssClass="failureNotification" 
                                        ControlToValidate="txtFiscalYrEnd"
                                        ValidationExpression="^\d{2}\-\d{2}\-\d{4}$"
                                        ErrorMessage="Fiscal Yr End format must be dd-mm-yyyy"
                                        Display="Dynamic"
                                        ValidationGroup="EditSiteValidationSummary">*</asp:RegularExpressionValidator>
                                    <asp:CustomValidator ID="txtValidateFiscalYrEnd" runat="server"  CssClass="failureNotification"  
                                        ControlToValidate="txtFiscalYrEnd"
                                        OnServerValidate="ValidDateCheck"
                                        ErrorMessage="Invalid Fiscal Yr End"
                                        Display="Dynamic"
                                        ValidationGroup="EditSiteValidationSummary">*</asp:CustomValidator>
                                </EditItemTemplate> 
                                <FooterTemplate> 
                                    <asp:TextBox Width="90%" ID="txtNewFiscalYrEnd" runat="server"></asp:TextBox> 
                                    <asp:RequiredFieldValidator ID="txtValidateNewFiscalYrEndRequired" runat="server" CssClass="failureNotification"  
                                        ControlToValidate="txtNewFiscalYrEnd" 
                                        ErrorMessage="Fiscal Yr End is required."
                                        Display="Dynamic"
                                        ValidationGroup="AddSiteValidationGroup">*</asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="txtValidateNewFiscalYrEndRegex" runat="server" CssClass="failureNotification" 
                                        ControlToValidate="txtNewFiscalYrEnd"
                                        ValidationExpression="^\d{2}\-\d{2}\-\d{4}$"
                                        ErrorMessage="Fiscal Yr End format must be dd-mm-yyyy"
                                        Display="Dynamic"
                                        ValidationGroup="AddSiteValidationGroup">*</asp:RegularExpressionValidator>
                                    <asp:CustomValidator ID="txtValidateNewFiscalYrEnd" runat="server"  CssClass="failureNotification"
                                        ControlToValidate="txtNewFiscalYrEnd"
                                        OnServerValidate="ValidDateCheck"
                                        ErrorMessage="Invalid Fiscal Yr End"
                                        Display="Dynamic"
                                        ValidationGroup="AddSiteValidationGroup">*</asp:CustomValidator>
                                </FooterTemplate> 
                                <ItemTemplate> 
                                    <asp:Label ID="lblFiscalYrEnd" runat="server" Text='<%# Bind("fiscal_yr_end", "{0:dd-MM-yyyy}") %>'></asp:Label> 
                                </ItemTemplate> 
                            </asp:TemplateField> 

                            <asp:TemplateField HeaderText="Open Days"  HeaderStyle-HorizontalAlign="Left"> 
                                <EditItemTemplate> 
                                    <asp:Label ID="lblOpenDays" runat="server" Text='<%# (Eval("excl_sun").ToString()=="False"?"Sun<br/>":"") + (Eval("excl_mon").ToString()=="False"?"Mon<br/>":"") + (Eval("excl_tue").ToString()=="False"?"Tue<br/>":"") + (Eval("excl_wed").ToString()=="False"?"Wed<br/>":"") + (Eval("excl_thu").ToString()=="False"?"Thurs<br/>":"") + (Eval("excl_fri").ToString()=="False"?"Fri<br/>":"") + (Eval("excl_sat").ToString()=="False"?"Sat<br/>":"") %>'></asp:Label>
                                </EditItemTemplate> 
                                <ItemTemplate> 
                                    <asp:Label ID="lblOpenDays" runat="server" Text='<%# (Eval("excl_sun").ToString()=="False"?"Sun<br/>":"") + (Eval("excl_mon").ToString()=="False"?"Mon<br/>":"") + (Eval("excl_tue").ToString()=="False"?"Tue<br/>":"") + (Eval("excl_wed").ToString()=="False"?"Wed<br/>":"") + (Eval("excl_thu").ToString()=="False"?"Thurs<br/>":"") + (Eval("excl_fri").ToString()=="False"?"Fri<br/>":"") + (Eval("excl_sat").ToString()=="False"?"Sat<br/>":"") %>'></asp:Label> 
                                </ItemTemplate> 
                            </asp:TemplateField> 

                            <asp:TemplateField HeaderText="Hours"  HeaderStyle-HorizontalAlign="Left"> 
                                <EditItemTemplate> 
                                    <asp:Label ID="lblOpenHours" runat="server" Text='<%# "Hrs:<br/>" + string.Format("{0:hh\\:mm}", Eval("day_start_time")) + "-" + string.Format("{0:hh\\:mm}", Eval("day_end_time")) + "<br/><br/>" + "Lunch:<br/>" + string.Format("{0:hh\\:mm}", Eval("lunch_start_time")) + "-" + string.Format("{0:hh\\:mm}", Eval("lunch_end_time"))   %>'></asp:Label>
                                </EditItemTemplate> 
                                <ItemTemplate> 
                                    <asp:Label ID="lblOpenHours" runat="server" Text='<%# "Hrs:<br/>" + string.Format("{0:hh\\:mm}", Eval("day_start_time")) + "-" + string.Format("{0:hh\\:mm}", Eval("day_end_time")) + "<br/><br/>" + "Lunch:<br/>" + string.Format("{0:hh\\:mm}", Eval("lunch_start_time")) + "-" + string.Format("{0:hh\\:mm}", Eval("lunch_end_time"))   %>'></asp:Label>
                                </ItemTemplate> 
                            </asp:TemplateField> 




                            <asp:TemplateField HeaderText="" ShowHeader="False" HeaderStyle-HorizontalAlign="Left" FooterStyle-VerticalAlign="Top"> 
                                <EditItemTemplate> 
                                    <asp:LinkButton ID="lnkUpdate" runat="server" CausesValidation="True" CommandName="Update" Text="Update" ValidationGroup="EditSiteValidationSummary"></asp:LinkButton> 
                                    <asp:LinkButton ID="lnkCancel" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton> 
                                </EditItemTemplate> 
                                <FooterTemplate> 
                                    <asp:LinkButton ID="lnkAdd" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" ValidationGroup="AddSiteValidationGroup"></asp:LinkButton> 
                                </FooterTemplate> 
                                <ItemTemplate> 
                                   <asp:ImageButton ID="lnkEdit" runat="server" CommandName="Edit" ImageUrl="~/images/Inline-edit-icon-24.png"  AlternateText="Inline Edit" ToolTip="Inline Edit"/>
                                </ItemTemplate> 
                            </asp:TemplateField> 

                        </Columns> 

                    </asp:GridView>

                </div>
            </center>

            <br id="br_before_add_site_btn_1" runat="server" />
            <br id="br_before_add_site_btn_2" runat="server" />

            <asp:Button ID="btnAddSite" runat="server" Text="Add New Site" PostBackUrl="~/SiteDetailV2.aspx?type=add" />

            <br />

        </div>
    </div>

</asp:Content>



