<%@ page title="Patient Details" language="C#" masterpagefile="~/SiteV2.master" autoeventwireup="true" inherits="PatientDetailV2, App_Web_nvct1tre" %>
<%@ Register TagPrefix="UC" TagName="DuplicatePersonModalElementControl" Src="~/Controls/DuplicatePersonModalElementControlV2.ascx" %>
<%@ Register TagPrefix="UC" TagName="AddressControl" Src="~/Controls/AddressControl.ascx" %>
<%@ Register TagPrefix="UC" TagName="AddressAusControl" Src="~/Controls/AddressAusControlV2.ascx" %>
<%@ Register TagPrefix="UC" TagName="PatientReferrerControl" Src="~/Controls/PatientReferrerControlV2.ascx" %>
<%@ Register TagPrefix="UC" TagName="HealthCardInfoControl" Src="~/Controls/HealthCardInfoControlV2.ascx" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <link href="Styles/duplicate_person_modal_boxV2.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="Scripts/update_epcV2.js"></script>
    <script type="text/javascript" src="Scripts/provider_nbr_check.js"></script>
    <script type="text/javascript" src="Scripts/check_duplicate_persons.js"></script>

    <script type="text/javascript">


        // to make the flashing text.  every 1000ms : turn on for 700ms - then turn off 
        window.addEventListener("load", function () {
            setInterval(function () {

                document.getElementById('lblFlashingText').style.visibility = 'visible';

                setTimeout(function () {
                    document.getElementById('lblFlashingText').style.visibility = 'hidden';
                }, 700);

            }, 1000);
        }, false);

        addLoadEvent(function () {
            resize_booking_list_panel_width();
        });
        
        
        // ---------------------------------------------------------------------------


        function resize_booking_list_panel_width() {
            var panel = document.getElementById('pnlBookingsList');
            if (panel != null) {
                var width_difference = parseInt(panel.offsetWidth) - parseInt(panel.clientWidth);
                panel.style.width += String(parseInt(panel.offsetWidth) + width_difference) + "px";
            }
        }


        // ---------------------------------------------------------------------------


        function update_referrers() {
            window.showModalDialog('ReferrerAddV2.aspx', '', 'dialogWidth:1250px;dialogHeight:800px;center:yes;resizable:no; scroll:no');
            document.getElementById('btnUpdateReferrersList').click();
        }
        function get_register_referrer() {

            var retVal = window.showModalDialog("ReferrerListPopupV2.aspx", 'Show Popup Window', "dialogHeight:800px;dialogWidth:1150px;resizable:yes;center:yes;");
            if (typeof retVal === "undefined")
                return;

            var index = retVal.indexOf(":");
            document.getElementById('txtUpdateRegisterReferrerID').value = retVal.substring(0, index); // set value so can get from code behind
            document.getElementById('btnRegisterReferrerUpdate').click();  // call button press to let the code behind use this id and update accordingly
        }
        function clear_register_referrer() {
            document.getElementById('txtUpdateRegisterReferrerID').value = '';
        }


        // ---------------------------------------------------------------------------



        function duplicate_person_check(obj) {

            var firstname = document.getElementById('txtFirstname').value.trim();
            var surname = document.getElementById('txtSurname').value.trim();

            var result = ajax_duplicate_persons("patient", firstname, surname);

            if (result.length == 0) {
                alert("Error retreiving records for duplicate person check.");
            }
            else if (result == "NONE") {
                return;
            }
            else {
                var result_list = create_result_array(result);
                create_table(result_list, "ctable", "PatientDetailV2.aspx?add_to_this_org=1&type=view&id=");
                reveal_modal('modalPopupDupicatePerson');
            }
        }
        String.prototype.trim = function () {
            return this.replace(/^\s+|\s+$/g, "");
        }

        function show_hide(id) {
            obj = document.getElementById(id);
            obj.style.display = (obj.style.display == "none") ? "" : "none";
        }

        function capitalize_first(txtbox) {
            txtbox.value = txtbox.value.replace(/\w\S*/g, function (txt) { return txt.charAt(0).toUpperCase() + txt.substr(1); });
            //txtbox.value = txtbox.value.charAt(0).toUpperCase() + txtbox.value.slice(1);
        }

        function title_changed_reset_gender() {
            var selValue = ddlTitle.options[ddlTitle.selectedIndex].value
            if (selValue == 6 || selValue == 265 || selValue == 266)
                setSelectedValue(document.getElementById("ddlGender"), "M");
            if (selValue == 7 || selValue == 26)
                setSelectedValue(document.getElementById("ddlGender"), "F");
        }
        function setSelectedValue(selectObj, valueToSet) {
            for (var i = 0; i < selectObj.options.length; i++) {
                if (selectObj.options[i].value == valueToSet) {
                    selectObj.options[i].selected = true;
                    return;
                }
            }
        }

        function SetCursorToTextEnd(textControlID) {
            var text = document.getElementById(textControlID);
            if (text != null) {
                text.focus(); //sets focus to element
                if (text.value.length > 0) {
                    var val = text.value; //store the value of the element
                    text.value = ''; //clear the value of the element
                    text.value = val; //set that value back.  
                }
            }
        }

     </script>

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <asp:Panel ID="pnlDefaultButton" runat="server" DefaultButton="btnDefaultButton_NoSubmit">

        <div class="clearfix">
            <div class="page_title">
                <h3>

                    <table style="max-width:92%" class="block_center">
                        <tr>
                            <td class="nowrap">
                                <asp:Label ID="lblHeading" runat="server" Text="Add Patient" />
                                <span style="font-size:70%;color:#aaaaaa;"> &nbsp;&nbsp;&nbsp;<asp:Label ID="lblPatientID" runat="server"></asp:Label></span> 
                            </td>
                            <td>
                                <span style="font-size:100%;"> &nbsp;&nbsp;&nbsp            
                                    <b><asp:Label ID="lblFlashingText" runat="server" ForeColor="Red" /></b>
                                </span>                            
                            </td>
                            <td style="vertical-align:middle;" class="nowrap">
                                &nbsp;
                                <asp:ImageButton ID="lnkFlashingText" runat="server" AlternateText="Edit Flashing Text" ToolTip="Edit Flashing Text" />
                                <asp:Button ID="btnUpdateFlashingTextIcon" runat="server" CssClass="hiddencol" onclick="btnUpdateFlashingTextIcon_Click" />
                            </td>
                        </tr>
                    </table>

                </h3>
            </div>
            <div class="main_content">

                <UC:DuplicatePersonModalElementControl ID="duplicatePersonModalElementControl" runat="server" />

                <div class="text-center">
                    <asp:ValidationSummary ID="ValidationSummary" runat="server" CssClass="failureNotification" ValidationGroup="ValidationSummary"/>
                    <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" CssClass="failureNotification"></asp:Label>
                </div>


                <div class="text-center">
                    <asp:Label ID="lblInvoiceOwingMessage" runat="server"></asp:Label>
                </div>


                <table id="maintable" runat="server" style="margin: 0 auto; width:1100px;" border="0">
                    <tr style="vertical-align:top;">
                        <td colspan="9">

                            <b>Personal Information</b>
                            <div style="line-height:7px;">&nbsp;</div>

                        </td>
                    </tr>
                    <tr style="vertical-align:top;">
                        <td style="vertical-align:top;">

                            <table border="0">
                                <tr id="idRow" runat="server">
                                    <td class="nowrap">ID</td>
                                    <td style="min-width:15px"></td>
                                    <td class="nowrap"><asp:Label ID="lblId" runat="server"></asp:Label></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="nowrap">Title</td>
                                    <td style="min-width:12px"></td>
                                    <td class="nowrap"><asp:DropDownList ID="ddlTitle" runat="server" DataTextField="descr" DataValueField="title_id" onchange='title_changed_reset_gender();' ></asp:DropDownList><asp:Label ID="lblTitle" runat="server" Font-Bold="True"/></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="nowrap">First Name</td>
                                    <td></td>
                                    <td class="nowrap"><asp:TextBox ID="txtFirstname" runat="server" onkeyup="capitalize_first(this);" /><asp:Label ID="lblFirstname" runat="server" Font-Bold="True" /></td>
                                    <td class="nowrap"><asp:RequiredFieldValidator ID="txtValidateFirstnameRequired" runat="server" CssClass="failureNotification"  
                                                ControlToValidate="txtFirstname" 
                                                ErrorMessage="Firstname is required."
                                                Display="Dynamic"
                                                ValidationGroup="ValidationSummary">*</asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="txtValidateFirstnameRegex" runat="server" CssClass="failureNotification" 
                                                ControlToValidate="txtFirstname"
                                                ValidationExpression="^[a-zA-Z\-\.\s']+$"
                                                ErrorMessage="Firstname can only be letters, hyphens, or fullstops."
                                                Display="Dynamic"
                                                ValidationGroup="ValidationSummary">*</asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="nowrap">Middle Name</td>
                                    <td></td>
                                    <td class="nowrap"><asp:TextBox ID="txtMiddlename" runat="server" onkeyup="capitalize_first(this);" /><asp:Label ID="lblMiddlename" runat="server" Font-Bold="True"></asp:Label></td>
                                    <td><asp:RegularExpressionValidator ID="txtValidateMiddlenameRegex" runat="server" CssClass="failureNotification" 
                                                ControlToValidate="txtMiddlename"
                                                ValidationExpression="^[a-zA-Z\-\.\s']+$"
                                                ErrorMessage="Middlename can only be letters, hyphens, or fullstops."
                                                Display="Dynamic"
                                                ValidationGroup="ValidationSummary">*</asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="nowrap">Surname</td>
                                    <td></td>
                                    <td class="nowrap"><asp:TextBox ID="txtSurname" runat="server" onkeyup="capitalize_first(this);"/><asp:Label ID="lblSurname" runat="server" Font-Bold="True"></asp:Label></td>
                                    <td><asp:RequiredFieldValidator ID="txtValidateSurnameRequired" runat="server" CssClass="failureNotification"  
                                                ControlToValidate="txtSurname" 
                                                ErrorMessage="Surname is required."
                                                Display="Dynamic"
                                                ValidationGroup="ValidationSummary">*</asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="txtValidateSurnameNameRegex" runat="server" CssClass="failureNotification" 
                                                ControlToValidate="txtSurname"
                                                ValidationExpression="^[a-zA-Z\-\.\s'\(\)]+$"
                                                ErrorMessage="Surname can only be letters, hyphens, or fullstops."
                                                Display="Dynamic"
                                                ValidationGroup="ValidationSummary">*</asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="nowrap">Nickname</td>
                                    <td></td>
                                    <td class="nowrap"><asp:TextBox ID="txtNickname" runat="server"  onkeyup="capitalize_first(this);" /><asp:Label ID="lblNickname" runat="server" Font-Bold="True"></asp:Label></td>
                                    <td><asp:RegularExpressionValidator ID="txtValidateNicknameRegex" runat="server" CssClass="failureNotification" 
                                                ControlToValidate="txtNickname"
                                                ValidationExpression="^[a-zA-Z\-\s']+$"
                                                ErrorMessage="Nickname can only be letters or hyphens."
                                                Display="Dynamic"
                                                ValidationGroup="ValidationSummary">*</asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="nowrap">Gender</td>
                                    <td></td>
                                    <td class="nowrap"><asp:DropDownList ID="ddlGender" runat="server"> 
                                            <asp:ListItem Value="M" Text="Male"></asp:ListItem>
                                            <asp:ListItem Value="F" Text="Female"></asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:Label ID="lblGender" runat="server" Font-Bold="True"></asp:Label>
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="nowrap">D.O.B.</td>
                                    <td></td>
                                    <td class="nowrap">
                                        <asp:DropDownList ID="ddlDOB_Day" runat="server"></asp:DropDownList>
                                        <asp:DropDownList ID="ddlDOB_Month" runat="server"></asp:DropDownList>
                                        <asp:DropDownList ID="ddlDOB_Year" runat="server"></asp:DropDownList>
                                        <asp:Label ID="lblDOB" runat="server" Font-Bold="True"></asp:Label>
                                    </td>
                                    <td><asp:CustomValidator ID="ddlDOBValidateAllOrNoneSet" runat="server"  CssClass="failureNotification"  
                                            ControlToValidate="ddlDOB_Day"
                                            OnServerValidate="DOBAllOrNoneCheck"
                                            ErrorMessage="DOB must have each of day/month/year selected, or all set to '--'"
                                            Display="Dynamic"
                                            ValidationGroup="ValidationSummary">*</asp:CustomValidator>
                                    </td>
                                 </tr>
                                <tr id="is_clinic_patient_row" runat="server" visible="False">
                                    <td class="nowrap">Clinic Patient</td>
                                    <td></td>
                                    <td class="nowrap"><asp:CheckBox ID="chkIsClinicPatient" runat="server" /><asp:Label ID="lblIsClinicPatient" runat="server" Font-Bold="True"></asp:Label></td>
                                    <td></td>
                                </tr>
                                <tr id="is_gp_patient_row" runat="server" visible="False">
                                    <td class="nowrap">GP Patient</td>
                                    <td></td>
                                    <td class="nowrap"><asp:CheckBox ID="chkIsGPPatient" runat="server" /><asp:Label ID="lblIsGPPatient" runat="server" Font-Bold="True"></asp:Label></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="nowrap">Deceased</td>
                                    <td></td>
                                    <td class="nowrap"><asp:CheckBox ID="chkIsDeceased" runat="server" /><asp:Label ID="lblIsDeceased" runat="server" Font-Bold="True"></asp:Label></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="nowrap"><asp:Label ID="lblIsDiabeticText" runat="server">Diabetic</asp:Label></td>
                                    <td style="min-width:12px"></td>
                                    <td class="nowrap"><asp:CheckBox ID="chkIsDiabetic" runat="server" /><asp:Label ID="lblIsDiabetic" runat="server" Font-Bold="True"></asp:Label></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="nowrap">Member Diabetes Aus.</td>
                                    <td style="min-width:12px"></td>
                                    <td class="nowrap"><asp:CheckBox ID="chkIsMemberDiabetesAustralia" runat="server" /><asp:Label ID="lblIsMemberDiabetesAustralia" runat="server" Font-Bold="True"></asp:Label></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="nowrap">DA Review Date</td>
                                    <td style="min-width:12px"></td>
                                    <td class="nowrap">
                                        <asp:DropDownList ID="ddlDARev_Day" runat="server"></asp:DropDownList>
                                        <asp:DropDownList ID="ddlDARev_Month" runat="server"></asp:DropDownList>
                                        <asp:DropDownList ID="ddlDARev_Year" runat="server"></asp:DropDownList>
                                        <asp:Label ID="lblDARev" runat="server" Font-Bold="True"></asp:Label>
                                    </td>
                                    <td><asp:CustomValidator ID="ddlDARevValidateAllOrNoneSet" runat="server"  CssClass="failureNotification"  
                                            ControlToValidate="ddlDARev_Day"
                                            OnServerValidate="DARevAllOrNoneCheck"
                                            ErrorMessage="DA Review Date must have each of day/month/year selected and be a valid date, or all set to '--'"
                                            Display="Dynamic"
                                            ValidationGroup="ValidationSummary">*</asp:CustomValidator>
                                    </td>
                                </tr>
                            </table>

                        </td>
                        <td style="width:100px;min-width:25px;"></td>
                        <td style="width:1px;;min-width:1px; background-color:grey"></td>
                        <td style="width:100px;min-width:25px;"></td>
                        <td style="vertical-align:top;">

                            <table border="0">
                                <tr>
                                    <td>Priv Health Fund</td>
                                    <td style="min-width:15px"></td>
                                    <td><asp:TextBox ID="txtPrivateHealthFund" runat="server"></asp:TextBox><asp:Label ID="lblPrivateHealthFund" runat="server" Font-Bold="True"></asp:Label></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="nowrap">Concession Card Nbr</td>
                                    <td style="min-width:12px"></td>
                                    <td><asp:TextBox ID="txtConcessionCardNbr" runat="server"></asp:TextBox><asp:Label ID="lblConcessionCardNbr" runat="server" Font-Bold="True"></asp:Label></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="nowrap">Concession Card Exp</td>
                                    <td style="min-width:12px"></td>
                                    <td>
                                        <asp:DropDownList ID="ddlConcessionCardExpiry_Month" runat="server" />
                                        <asp:DropDownList ID="ddlConcessionCardExpiry_Year" runat="server" />
                                        <asp:Label ID="lblConcessionCardExpiry" runat="server" Font-Bold="True" />
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="nowrap">Web Login Username</td>
                                    <td></td>
                                    <td class="nowrap"><asp:TextBox ID="txtLogin" runat="server" TabIndex="9"></asp:TextBox><asp:Label ID="lblLogin" runat="server" Font-Bold="True"/></td>
                                    <td><asp:RegularExpressionValidator ID="txtValidateLoginRegex" runat="server" CssClass="failureNotification" 
                                            ControlToValidate="txtLogin"
                                            ValidationExpression="^[0-9a-zA-Z\-_]+$"
                                            ErrorMessage="Login can only be letters and numbers."
                                            Display="Dynamic"
                                            ValidationGroup="ValidationSummary">*</asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="nowrap">Web Login Password</td>
                                    <td></td>
                                    <td class="nowrap"><asp:TextBox ID="txtPwd" runat="server" TabIndex="10"></asp:TextBox><asp:Label ID="lblPwd" runat="server" Font-Bold="True"/></td>
                                    <td>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" CssClass="failureNotification" 
                                            ControlToValidate="txtPwd"
                                            ValidationExpression="^[0-9a-zA-Z\-_]+$"
                                            ErrorMessage="Password can only be letters, numbers, and underscore."
                                            Display="Dynamic"
                                            ValidationGroup="ValidationSummary">*</asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="nowrap">Is A Company</td>
                                    <td></td>
                                    <td class="nowrap">
                                        <asp:CheckBox ID="chkIsCompany" runat="server" />
                                        <asp:Label ID="lblIsCompany" runat="server" Font-Bold="True" />
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td class="nowrap">ABN</td>
                                    <td></td>
                                    <td>
                                        <asp:TextBox ID="txtABN" runat="server"></asp:TextBox>
                                        <asp:Label ID="lblABN" runat="server" Font-Bold="True" />
                                    </td>
                                    <td></td>
                                </tr>
                                <tr id="acTypeRow" runat="server">
                                    <td class="nowrap">PT Type</td>
                                    <td style="width:12px"></td>
                                    <td class="nowrap"><asp:DropDownList ID="ddlACInvOffering" runat="server" DataTextField="o_name" DataValueField="o_offering_id"></asp:DropDownList><asp:Label ID="lblACInvOffering" runat="server" Font-Bold="True"/></td>
                                    <td></td>
                                </tr>
                                <tr id="addbyRow" runat="server">
                                    <td class="nowrap">Added By</td>
                                    <td style="min-width:12px"></td>
                                    <td class="nowrap"><asp:Label ID="lblAddedBy" runat="server"></asp:Label></td>
                                    <td></td>
                                </tr>
                                <tr id="patientDateAddedRow" runat="server">
                                    <td class="nowrap">Date Added</td>
                                    <td style="min-width:12px"></td>
                                    <td class="nowrap"><asp:Label ID="lblPatientDateAdded" runat="server"></asp:Label></td>
                                    <td></td>
                                </tr>
                                <tr id="changeHistoryLinknRow" runat="server">
                                    <td>View Edit History</td>
                                    <td style="min-width:12px"></td>
                                    <td><asp:LinkButton ID="btnHistory" runat="server" Text="View" /></td>
                                    <td></td>
                                </tr>
                                <tr  id="deleteUndeletePatientRow" runat="server">
                                    <td><asp:Label ID="lblDeleteUndeletePatientText" runat="server" Text="Delete Patient"/></td>
                                    <td style="min-width:12px"></td>
                                    <td><asp:linkbutton ID="btnDeleteUndeletePatient" runat="server" Text="Delete Patient" OnCommand="btnDeleteUndeletePatient_Command" /></td>
                                    <td></td>
                                </tr>
                            </table>

                        </td>
                        <td style="width:100px;min-width:25px;"></td>
                        <td style="width:1px;;min-width:1px; background-color:grey"></td>
                        <td style="width:100px;min-width:25px;"></td>
                        <td rowspan="3" style="vertical-align:top;">

                            <table>
                                <tr id="addressListRow" runat="server">
                                    <td colspan="3">
                                        <UC:AddressControl ID="addressControl" runat="server" ViewStateMode="Enabled" Visible="false" />
                                        <UC:AddressAusControl ID="addressAusControl" runat="server" ViewStateMode="Enabled" Visible="false" />
                                    </td>
                                    <td style="font-family:'Microsoft Sans Serif';"></td>
                                </tr>
                            </table>

                        </td>
                    </tr>
                    <tr>
                        <td colspan="9">
                            <div style="height:15px;"></div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="9">
                            <table class="block_center">
                                <tr>
                                    <td align="center">
                                        <asp:Button ID="btnSubmit" runat="server" Text="Button" onclick="btnSubmit_Click" CausesValidation="True" ValidationGroup="ValidationSummary" CssClass="thin_button" />
                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" onclick="btnCancel_Click" Visible="False" CssClass="thin_button" />
                                        <asp:Button ID="btnDefaultButton_NoSubmit" runat="server" CssClass="hiddencol" OnClientClick="javascript:return false;" />
                                    </td>
                                </tr>
                            </table>

                        </td>
                    </tr>
                    <tr>
                        <td colspan="9" style="min-height:35px;">
                            <div style="width:80%; height:1px; margin:35px auto; background:#999;"></div>
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align:top;">
                                          
                            <b>Conditions</b> &nbsp; <a href="#" onclick="return false;" title="Add/Edit From Menu:  Patients → Conditions" style="text-decoration:none;font-size:small;">[?]</a>
                            <div style="line-height:7px;">&nbsp;</div>

                                      
                            <table>
                                <tr>
                                    <td>

                                        <asp:GridView ID="GrdCondition" runat="server" 
                                                AutoGenerateColumns="False" DataKeyNames="condition_condition_id" 
                                                OnRowCancelingEdit="GrdCondition_RowCancelingEdit" 
                                                OnRowDataBound="GrdCondition_RowDataBound" 
                                                OnRowEditing="GrdCondition_RowEditing" 
                                                OnRowUpdating="GrdCondition_RowUpdating" ShowHeader="False" ShowFooter="False" 
                                                OnRowCommand="GrdCondition_RowCommand" 
                                                OnRowCreated="GrdCondition_RowCreated"
                                                AllowSorting="True" 
                                                OnSorting="GrdCondition_Sorting"
                                                ClientIDMode="Predictable"
                                                GridLines="None"
                                                CssClass="table table-grid-top-bottum-padding-normal auto_width block_center">

                                            <Columns> 

                                                <asp:TemplateField HeaderText="ID"  HeaderStyle-HorizontalAlign="Left" SortExpression="condition_condition_id" Visible="false"> 
                                                    <ItemTemplate> 
                                                        <asp:Label ID="lblId" runat="server" Text='<%# Bind("condition_condition_id") %>'></asp:Label> 
                                                    </ItemTemplate> 
                                                </asp:TemplateField> 

                                                <asp:TemplateField HeaderText="Checkbox" HeaderStyle-HorizontalAlign="Left" SortExpression="condition_descr" ItemStyle-VerticalAlign="Top"> 
                                                    <ItemTemplate> 
                                                        <asp:CheckBox ID="chkSelect" runat="server" />
                                                        &nbsp;
                                                    </ItemTemplate> 
                                                </asp:TemplateField> 

                                                <asp:TemplateField HeaderText="Descr" HeaderStyle-HorizontalAlign="Left" SortExpression="condition_descr" ItemStyle-CssClass="text_left"> 
                                                    <ItemTemplate> 

                                                        <asp:Label ID="lblDescr" runat="server" Text='<%# Bind("condition_descr") %>'></asp:Label> 

                                                        <div id="br_date" runat="server" style="height:5px;"></div>
                                                        <asp:DropDownList ID="ddlDate_Day" runat="server"></asp:DropDownList>
                                                        <asp:DropDownList ID="ddlDate_Month" runat="server"></asp:DropDownList>
                                                        <asp:DropDownList ID="ddlDate_Year" runat="server"></asp:DropDownList>

                                                        <div id="br_nweeksdue" runat="server" style="height:5px;"></div>
                                                        <asp:Label ID="lblNextDue" runat="server" Text="Next Due: "></asp:Label>
                                                        <asp:DropDownList ID="ddlNbrWeeksDue" runat="server"></asp:DropDownList> 
                                                        <asp:Label ID="lblWeeksLater" runat="server" Text="Weeks Later "></asp:Label>

                                                        <div id="br_text" runat="server" style="height:5px;"></div>
                                                        <asp:Label ID="lblAdditionalInfo" runat="server" Text="<u>Additional Info</u>:<br />"></asp:Label>
                                                        <asp:TextBox ID="txtText" runat="server" TextMode="MultiLine" Rows="3" Columns="30"></asp:TextBox>

                                                    </ItemTemplate> 
                                                </asp:TemplateField> 

                                            </Columns> 

                                        </asp:GridView>

                                        <asp:GridView ID="GrdConditionView" runat="server" 
                                                AutoGenerateColumns="False" DataKeyNames="condition_condition_id" 
                                                OnRowCancelingEdit="GrdConditionView_RowCancelingEdit" 
                                                OnRowDataBound="GrdConditionView_RowDataBound" 
                                                OnRowEditing="GrdConditionView_RowEditing" 
                                                OnRowUpdating="GrdConditionView_RowUpdating" ShowHeader="False" ShowFooter="False" 
                                                OnRowCommand="GrdConditionView_RowCommand" 
                                                OnRowCreated="GrdConditionView_RowCreated"
                                                AllowSorting="True" 
                                                OnSorting="GrdConditionView_Sorting"
                                                ClientIDMode="Predictable"
                                                GridLines="None"
                                                CssClass="table table-grid-top-bottum-padding-normal auto_width block_center">

                                            <Columns> 

                                                <asp:TemplateField HeaderText="ID"  HeaderStyle-HorizontalAlign="Left" SortExpression="condition_condition_id" Visible="false"> 
                                                    <ItemTemplate> 
                                                        <asp:Label ID="lblId" runat="server" Text='<%# Eval("condition_condition_id") %>'></asp:Label> 
                                                    </ItemTemplate> 
                                                </asp:TemplateField> 

                                                <asp:TemplateField HeaderText="Checkbox" HeaderStyle-HorizontalAlign="Left" SortExpression="condition_descr" ItemStyle-VerticalAlign="Top"> 
                                                    <ItemTemplate> 
                                                        •
                                                    </ItemTemplate> 
                                                </asp:TemplateField> 

                                                <asp:TemplateField HeaderText="Descr" HeaderStyle-HorizontalAlign="Left" SortExpression="condition_descr" ItemStyle-CssClass="text_left"> 
                                                    <ItemTemplate> 

                                                        <asp:Label ID="lblDescr" runat="server" Text='<%# Eval("condition_descr") %>'></asp:Label> 

                                                        <div id="br_date" runat="server" style="height:1px;"></div>
                                                        <asp:Label ID="lblDate" runat="server"></asp:Label> 

                                                        <div id="br_nweeksdue" runat="server" style="height:1px;"></div>
                                                        <asp:Label ID="lblNextDue" runat="server" Text="Next Due: "></asp:Label>
                                                        <asp:Label ID="lblDateDue" runat="server"></asp:Label> 

                                                        <div id="br_text" runat="server" style="height:1px;"></div>
                                                        <asp:Label ID="lblAdditionalInfo" runat="server" Text="<u>Additional Info</u>:<br />"></asp:Label>
                                                        <asp:Label ID="lblText" runat="server"></asp:Label> 

                                                    </ItemTemplate> 
                                                </asp:TemplateField> 

                                            </Columns> 

                                        </asp:GridView>

                                    </td>
                                </tr>
                            </table>

                        </td>
                        <td style="width:100px;min-width:25px;"></td>
                        <td style="width:1px;;min-width:1px; background-color:grey"></td>
                        <td style="width:100px;min-width:25px;"></td>
                        <td colspan="5" style="vertical-align:top;">

                            <a name="notelist"></a>

                            <table>
                                <tr>
                                    <td>
                                        <b>Notes</b>&nbsp;<asp:Label ID="lblNotesListCount" runat="server"></asp:Label>
                                    </td>
                                    <td style="min-width:20px;"></td>
                                    <td>
                                        <asp:HyperLink ID="lnkNotes" runat="server" ToolTip="Notes" Text="Add/Edit Notes" NavigateUrl="#" />
                                        &nbsp;&nbsp;
                                        <asp:HyperLink ID="lnkNotesBodyChart" runat="server" ToolTip="Notes" Text="Add/Edit Body Chart Notes" NavigateUrl="#" />
                                        <asp:Button ID="btnUpdateNotesIcon" runat="server" CssClass="hiddencol" onclick="btnUpdateNotesIcon_Click" />
                                    </td>
                                </tr>
                            </table>
                            <div style="line-height:7px;">&nbsp;</div>

                            <asp:Label ID="lblNotesList_NoRowsMessage" runat="server" Text="No notes exist for this patient."></asp:Label>

                            <asp:Panel ID="pnlNotesList" runat="server" ScrollBars="Auto" style="max-height:325px;">
                                <table id="tblNotesList" border="1" style="border-collapse:collapse; width:100%;" class="table table-bordered table-striped table-grid table-grid-top-bottum-padding-normal auto_width block_center">
                                <asp:Repeater id="lstNoteList" runat="server">
                                    <HeaderTemplate>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr style="vertical-align:top;">
                                            <td class="nowrap hiddencol">
                                                <asp:Label ID="lblNoteID"   Text='<%#  Eval("note_id") %>' runat="server"/>
                                            </td>
                                            <td class="nowrap hiddencol">
                                                <asp:Label ID="lblNoteEntityID" Text='<%#  Eval("entity_id") %>' runat="server"/>
                                            </td>
                                            <td class="nowrap" style="text-align:left;">
                                                <asp:Label ID="lblNoteDateAdded" runat="server" Text='<%# Bind("date_added", "{0:dd-MM-yyyy}") %>' ></asp:Label> 
                                            </td>
                                            <td style="width:130px;text-align:left;">
                                                <asp:Label ID="lblNoteType" runat="server" Text='<%# Eval("note_type_descr") %>' ></asp:Label> 
                                            </td>
                                            <td style="text-align:left;">
                                                <asp:Label ID="lblText" runat="server" Font-Bold="True" Text='<%#  (Eval("body_part_descr") == DBNull.Value || Eval("body_part_descr").ToString().Length == 0 ? "" : @"<u>" + Eval("body_part_descr") + "</u> : ")   +   (Eval("text") == DBNull.Value ? "" : ((string)Eval("text")).Replace("\n", "<br/>")) %>'></asp:Label> 
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                    </FooterTemplate>
                                </asp:Repeater>
                                </table>
                            </asp:Panel>

                        </td>
                    </tr>
                    <tr>
                        <td colspan="9" style="min-height:35px;">
                            <div style="width:80%; height:1px; margin:35px auto; background:#999;"></div>
                        </td>
                    </tr>
                    <tr style="vertical-align:top;">
                        <td colspan="9">

                            <table class="block_center" style="width:100%;">
                                <tr style="vertical-align:top;">
                                    <td>

                                        <table>
                                            <tr>
                                                <td>
                                                    <UC:PatientReferrerControl ID="patientReferrer" runat="server" />
                                                    <asp:Button ID="btnUpdateReferrersList" runat="server" CssClass="hiddencol" onclick="btnUpdateReferrersList_Click" />
                                                </td>
                                            </tr>
                                            <tr style="height:12px">
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <UC:HealthCardInfoControl ID="healthCardInfoControl" runat="server" />
                                                </td>
                                            </tr>
                                        </table>

                                    </td>

                                    <td style="width:100px;min-width:25px;"></td>
                                    <td style="width:1px;;min-width:1px; background-color:grey"></td>
                                    <td style="width:100px;min-width:25px;"></td>

                                    <td>

                                        <b>Registered To:</b> &nbsp;&nbsp;&nbsp; <asp:LinkButton ID="showHideOrgsList" runat="server" OnClientClick="javascript:show_hide('div_orgs_list'); return false;">Add</asp:LinkButton>
                                        <div style="line-height:4px;">&nbsp;</div>

                                        <asp:GridView ID="GrdRegistration" runat="server" 
                                                AutoGenerateColumns="False" DataKeyNames="register_patient_id" 
                                                OnRowCancelingEdit="GrdRegistration_RowCancelingEdit" 
                                                OnRowDataBound="GrdRegistration_RowDataBound" 
                                                OnRowEditing="GrdRegistration_RowEditing" 
                                                OnRowUpdating="GrdRegistration_RowUpdating" ShowFooter="False" ShowHeader="False" GridLines="None"
                                                OnRowCommand="GrdRegistration_RowCommand" 
                                                OnRowDeleting="GrdRegistration_RowDeleting" 
                                                OnRowCreated="GrdRegistration_RowCreated"
                                                AllowSorting="True" 
                                                OnSorting="GridView_Sorting"
                                                ClientIDMode="Predictable">

                                            <Columns> 

                                                <asp:TemplateField HeaderText="ID"  HeaderStyle-HorizontalAlign="Left" SortExpression="register_patient_id"> 
                                                    <EditItemTemplate> 
                                                        <asp:Label ID="lblId" runat="server" Text='<%# Bind("register_patient_id") %>'></asp:Label>
                                                    </EditItemTemplate> 
                                                    <ItemTemplate> 
                                                        <asp:Label ID="lblId" runat="server" Text='<%# Bind("register_patient_id") %>'></asp:Label> 
                                                    </ItemTemplate> 
                                                </asp:TemplateField> 

                                                <asp:TemplateField HeaderText="Organisation" HeaderStyle-HorizontalAlign="Left" SortExpression="name" FooterStyle-VerticalAlign="Top" ItemStyle-Wrap="false"> 
                                                    <EditItemTemplate> 
                                                        <asp:DropDownList ID="ddlOrganisation" runat="server" DataTextField="name" DataValueField="organisation_id"> </asp:DropDownList> 
                                                    </EditItemTemplate> 
                                                    <ItemTemplate> 
                                                        <asp:Label ID="lblOrganisation" runat="server" Text='<%# Eval("name") %>'></asp:Label> 
                                                    </ItemTemplate> 
                                                    <FooterTemplate> 
                                                        <asp:DropDownList ID="ddlNewOrganisation" runat="server" DataTextField="name" DataValueField="organisation_id"> </asp:DropDownList>
                                                    </FooterTemplate> 
                                                </asp:TemplateField> 

                                                <asp:TemplateField>
                                                    <EditItemTemplate> 
                                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    </EditItemTemplate> 
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Booking" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Center" SortExpression="num_registered_orgs" ItemStyle-Wrap="false"> 
                                                    <EditItemTemplate> 
                                                    </EditItemTemplate> 
                                                    <ItemTemplate> 
                                                        <asp:HyperLink ID="lnkBookings" runat="server" NavigateUrl='<%#  String.Format("~/BookingScreenGetPatientOrgsV2.aspx?patient_id={0}",Eval("patient_id")) %>' Text="Make Booking" AlternateText="Bookings" ToolTip="Bookings" />
                                                    </ItemTemplate> 
                                                </asp:TemplateField> 

                                                <asp:TemplateField>
                                                    <EditItemTemplate> 
                                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                    </EditItemTemplate> 
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="" ShowHeader="True" HeaderStyle-HorizontalAlign="Left" FooterStyle-VerticalAlign="Top">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="btnDelete" runat="server"  CommandName="_Delete" CommandArgument='<%# Bind("register_patient_id") %>' Text="Del" AlternateText="Delete" ToolTip="Delete" />
                                                    </ItemTemplate>
                                                    <FooterTemplate> 
                                                        <asp:LinkButton ID="lnkAdd" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" ValidationGroup="AddRegistrationValidationGroup"></asp:LinkButton> 
                                                    </FooterTemplate> 
                                                </asp:TemplateField>


                                            </Columns> 

                                        </asp:GridView>

                                        <div id="div_orgs_list" runat="server" style="display:none;" class="nowrap">
                                            <asp:DropDownList ID="ddlOrganisation" runat="server" DataTextField="name" DataValueField="organisation_id" /><asp:LinkButton ID="lnkRegisterPatient" runat="server" CausesValidation="True" OnClick="lnkRegisterPatient_Click" Text="Insert" ></asp:LinkButton> 
                                        </div>


                                        <div style="height:20px;"></div>


                                        <table>
                                            <tr>
                                                <td id="makeBookingRow" runat="server" class="nowrap"><asp:HyperLink ID="lnkMakeBooking" runat="server" >Make Booking List</asp:HyperLink></td>
                                            </tr>
                                            <tr>
                                                <td id="bookingListRow" runat="server" class="nowrap"><asp:HyperLink ID="lnkBookingList" runat="server" NavigateUrl="~/BookingsListV2.aspx?id=">Booking List</asp:HyperLink></td>
                                            </tr>
                                            <tr style="height:15px">
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td>

                                                    <table>
                                                        <tr>
                                                            <td id="lastBookingTextRow" runat="server" class="nowrap"><asp:Label ID="lblLastBookingText" runat="server">Last Appointment:</asp:Label></td>
                                                            <td style="min-width:15px;"></td>
                                                            <td class="nowrap"><asp:HyperLink ID="lnkLastBooking" runat="server"></asp:HyperLink><asp:Label ID="lblLastBooking" runat="server"></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td id="nextBookingTextRow" runat="server" class="nowrap"><asp:Label ID="lblNextBookingText" runat="server">Next Appointment:</asp:Label></td>
                                                            <td style="min-width:15px;"></td>
                                                            <td class="nowrap"><asp:HyperLink ID="lnkNextBooking" runat="server"></asp:HyperLink><asp:Label ID="lblNextBooking" runat="server"></asp:Label></td>
                                                        </tr>
                                                    </table>

                                                </td>
                                            </tr>
                                            <tr style="height:15px">
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td id="invoicesRow" runat="server" class="nowrap"><asp:HyperLink ID="lnkInvoices" runat="server" NavigateUrl="~/InvoiceListV2.aspx?id=">View Invoices</asp:HyperLink></td>
                                            </tr>
                                            <tr>
                                                <td id="ordersRow" runat="server" class="nowrap"><asp:HyperLink ID="lnkOrders" runat="server" NavigateUrl="~/OfferingOrderListV2.aspx?id=">View Orders</asp:HyperLink></td>
                                            </tr>
                                            <tr>
                                                <td id="scannedDocumentsRow" runat="server" class="nowrap">
                                                    <asp:Label ID="lnkScannedDocuments" runat="server"/>: <asp:Label ID="lnkScannedDocumentsCount" runat="server"/>
                                                    <asp:Button ID="btnUpdateScannedDocumentsCount" runat="server" CssClass="hiddencol" OnClick="btnUpdateScannedDocumentsCount_Click"/>
                                                    &nbsp;&nbsp;<span id="spanHoverForQuickViewTip" runat="server">&#8592; hover for quick view</span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="nowrap">
                                                    Letters : <asp:HyperLink ID="lnkPrintLetter" runat="server" NavigateUrl="~/Letters_PrintV2.aspx?org=">Print</asp:HyperLink>
                                                    |
                                                    <asp:HyperLink ID="lnkLetterPrintHistory" runat="server" NavigateUrl="~/Letters_SentHistoryV2.aspx?org=">View History</asp:HyperLink>
                                                    <asp:Label ID="lblLetterBestPrintHistorySeperator" runat="server"> | </asp:Label>
                                                    <asp:HyperLink ID="lnkLetterBestPrintHistory" runat="server" NavigateUrl="~/LettersBest_SentHistoryV2.aspx?org=">View History (From BEST)</asp:HyperLink>
                                                </td>
                                            </tr>
                                        </table>


                                    </td>
                                </tr>
                            </table>

                        </td>
                    </tr>
                    <tr>
                        <td colspan="9" style="min-height:35px;">
                            <div style="width:80%; height:1px; margin:35px auto; background:#999;"></div>
                        </td>
                    </tr>
                    <tr style="vertical-align:top;">
                        <td colspan="9">

                            <a name="bookinglist"></a>

                            <table class="block_center">
                                <tr style="vertical-align:top;">
                                    <td colspan="3" class="block_center">

                                        <center>

                                        <asp:Button ID="btnUpdateBookingList" runat="server" CssClass="hiddencol" onclick="btnUpdateBookingList_Click" />
                                        <asp:Panel ID="pnlDefaultButton_SearchBookingList" runat="server" DefaultButton="btnSearchBookingList">
                                            <table>
                                                <tr>
                                                    <td><b>Bookings</b>&nbsp;<asp:Label ID="lblBookingListCount" runat="server"></asp:Label></td>

                                                    <td style="width:25px;min-width:10px;"></td>

                                                    <td class="nowrap"><asp:Label ID="lblSearchDate" runat="server">From: </asp:Label></td>
                                                    <td class="nowrap"><asp:TextBox ID="txtStartDate" runat="server" Columns="10"/></td>
                                                    <td class="nowrap"><asp:ImageButton ID="txtStartDate_Picker" runat="server" ImageUrl="~/images/Calendar-icon-24px.png" /></td>
                                                    <td class="nowrap"><button type="button" onclick="javascript:document.getElementById('txtStartDate').value = '';return false;">Clear</button></td>

                                                    <td style="width:10px;min-width:10px;"></td>

                                                    <td class="nowrap"><asp:Label ID="lblEndDate" runat="server">To: </asp:Label></td>
                                                    <td class="nowrap"><asp:TextBox ID="txtEndDate" runat="server" Columns="10"></asp:TextBox></td>
                                                    <td class="nowrap"><asp:ImageButton ID="txtEndDate_Picker" runat="server" ImageUrl="~/images/Calendar-icon-24px.png" /></td>
                                                    <td class="nowrap"><button type="button" onclick="javascript:document.getElementById('txtEndDate').value = '';return false;">Clear</button></td>

                                                    <td style="width:25px;min-width:15px;"></td>

                                                    <td class="nowrap">
                                                        <table style="line-height:8px;">
                                                            <tr>
                                                                <td><asp:CheckBox ID="chkIncDeleted" runat="server" Text="&nbsp;Inc. Deleted" Checked="True" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td><asp:CheckBox ID="chkIncCancelled" runat="server" Text="&nbsp;Inc. Cancelled" Checked="True" /></td>
                                                            </tr>
                                                        </table>
                                                        <div style="height:8px;"></div>
                                                    </td>

                                                    <td style="width:25px;min-width:15px;"></td>
                        
                                                    <td><asp:Button ID="btnSearchBookingList" runat="server" Text="Refresh" OnClick="btnSearchBookingList_Click" /></td>
                                                    <td style="width:8px;min-width:8px;"></td>
                                                    <td><asp:Button ID="btnPrintBookingList" runat="server" Text="Print" OnClick="btnPrintBookingList_Click" /></td>

                                                </tr>
                                            </table>
                                        </asp:Panel>

                                        <span style="height:10px;display:block"></span>
                                        <asp:Label ID="lblBookingsList_NoRowsMessage" runat="server" Text="No bookings exist for this patient."></asp:Label>
                                        <asp:Panel ID="pnlBookingsList" runat="server" ScrollBars="Auto" style="max-height:5000px; overflow: auto; display:inline-block;">
                                            <table id="tblBookingsList" border="1" style="border-collapse:collapse;text-align:center;" class="table table-bordered table-striped table-grid table-grid-top-bottum-padding-normal auto_width block_center" >
                                            <asp:Repeater id="lstBookingList" runat="server">
                                                <HeaderTemplate>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td id="Td1" class="nowrap" runat="server" Visible='<%# Eval("show_outstanding_row").ToString()=="1"?true:false %>'><asp:Label ID="lblOutstanding" runat="server" Text='<%#  Eval("inv_outstanding_text") %>'></asp:Label></td>
                                                        <td class="nowrap">
                                                            <asp:Label ID="lblBookingDate"   Text='<%#  Eval("booking_date_start", "{0:dd-MM-yyyy}") + "<br />" + Eval("booking_date_start", "{0:HH:mm}") %>' runat="server" ForeColor='<%# (Eval("booking_deleted_by") != DBNull.Value || Eval("booking_date_deleted") != DBNull.Value) ? System.Drawing.ColorTranslator.FromHtml("#777777") : System.Drawing.ColorTranslator.FromHtml("#333333") %>' />
                                                        </td>
                                                        <td class="nowrap">
                                                            <asp:Label ID="lblOfferingDescr" Text='<%#  Eval("offering_name") %>' runat="server" ForeColor='<%# (Eval("booking_deleted_by") != DBNull.Value || Eval("booking_date_deleted") != DBNull.Value) ? System.Drawing.ColorTranslator.FromHtml("#777777") : System.Drawing.ColorTranslator.FromHtml("#333333") %>' />
                                                            <br />
                                                            <asp:Label ID="lblProviderAndOrg" Text='<%#  Eval("person_provider_firstname") + " " + Eval("person_provider_surname") + " @ " + Eval("organisation_name") %>' runat="server" ForeColor='<%# (Eval("booking_deleted_by") != DBNull.Value || Eval("booking_date_deleted") != DBNull.Value) ? System.Drawing.ColorTranslator.FromHtml("#777777") : System.Drawing.ColorTranslator.FromHtml("#a52a2a") %>' />
                                                        </td>
                                                        <td class="nowrap">
                                                            <a id="A1" runat="server" href="#" onclick="javascript:return false;" title='<%#  Eval("added_by_deleted_by_row") %>' style="text-decoration: none"><b>&nbsp;*&nbsp;</b></a><asp:Label ID="lblBookingStatus" Text='<%# Eval("booking_status_descr").ToString() + "&nbsp;" + (Eval("inv_type_text").ToString().Length == 0 ? "" : "<br /><font color=\"#000080\">" + Eval("inv_type_text") + "</font>" ) %>' ForeColor='<%# (Eval("booking_deleted_by") != DBNull.Value || Eval("booking_date_deleted") != DBNull.Value) ? System.Drawing.ColorTranslator.FromHtml("#777777") : System.Drawing.ColorTranslator.FromHtml("#333333") %>' runat="server"/>
                                                        </td>

                                                        <td class="nowrap" style="text-align:left !important; white-space:normal;">
                                                            <asp:Label ID="lblBookingNotes" runat="server" Text='<%#  Eval("booking_notes_text") %>' ></asp:Label>
                                                        </td>

                                                        <td id="Td2" class="nowrap" runat="server" Visible='<%# Eval("show_notes_row").ToString()=="1"?true:false %>'><asp:Label ID="lblNotes" runat="server" Text='<%#  Eval("notes_text") %>' Visible='<%# (Eval("booking_deleted_by") != DBNull.Value || Eval("booking_date_deleted") != DBNull.Value) ? false : true %>' /></td>
                                                        <td id="Td3" class="nowrap" runat="server" Visible='<%# Eval("show_change_history_row").ToString()=="1"?true:false %>'><asp:Label ID="lblBookingHistory" Text='<%# Eval("booking_change_history_link").ToString() %>' runat="server"  Visible='<%# (bool)Eval("hide_change_history_link") ? false : true %>' ></asp:Label></td>
                                                        <td id="Td4" class="nowrap" runat="server" Visible='<%# Eval("show_printletter_row").ToString()=="1"?true:false %>'><asp:HyperLink ID="lnkPrintLetter" runat="server" NavigateUrl='<%#  String.Format("~/Letters_PrintV2.aspx?booking={0}",Eval("booking_booking_id")) %>' ImageUrl="~/images/printer_green-24.png" AlternateText="Letters" ToolTip="Letters" Visible='<%# (Eval("booking_deleted_by") != DBNull.Value || Eval("booking_date_deleted") != DBNull.Value) ? false : true %>' /></td>
                                                        <td id="Td5" class="nowrap" runat="server" Visible='<%# Eval("show_invoice_row").ToString()=="1"?true:false %>'><asp:Label ID="lblViewInvoice" runat="server" Text='<%#  Eval("invoice_text") %>' ToolTip= "View Invoice" Visible='<%# (Eval("booking_deleted_by") != DBNull.Value || Eval("booking_date_deleted") != DBNull.Value) ? false : true %>'></asp:Label></td>
                                                        <td id="Td6" class="nowrap" runat="server" Visible='<%# Eval("show_bookingsheet_row").ToString()=="1"?true:false %>'><asp:HyperLink ID="lnkBookingSheetForPatient" runat="server" NavigateUrl='<%#  Eval("booking_url") %>' ImageUrl="~/images/Calendar-icon-24px.png" AlternateText="Booking Sheet" ToolTip="Booking Sheet" Visible='<%# (Eval("booking_deleted_by") != DBNull.Value || Eval("booking_date_deleted") != DBNull.Value || (bool)Eval("hide_booking_link")) ? false : true %>' /></td>
                                                    </tr>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                </FooterTemplate>
                                            </asp:Repeater>
                                            </table>
                                        </asp:Panel>

                                        </center>

                                    </td>
                                </tr>
                            </table>

                        </td>
                    </tr>

                </table>

                <div style="height:15px;"></div>

                <div id="autodivheight" class="divautoheight" style="height:500px;">
                </div>
  
            </div>
        </div>

    </asp:Panel>

</asp:Content>



