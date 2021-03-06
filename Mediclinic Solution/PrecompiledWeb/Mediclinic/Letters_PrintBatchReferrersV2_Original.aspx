﻿<%@ page title="Mass Marketing To Referrers (Bulk Letters, Emails, SMS)" language="C#" masterpagefile="~/SiteV2.master" autoeventwireup="true" inherits="Letters_PrintBatchReferrersV2_Original, App_Web_g1nxmnfz" validaterequest="false" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <script type="text/javascript">

        function select_all(chkBox, selectBox) {

            // have we been passed an ID
            if (typeof selectBox == "string") {
                selectBox = document.getElementById(selectBox);
            }

            // is the select box a multiple select box?
            if (selectBox.type == "select-multiple") {
                for (var i = 0; i < selectBox.options.length; i++) {
                    selectBox.options[i].selected = chkBox.checked;
                }
            }
        }

        function clear_error_message() {
            document.getElementById('lblErrorMessage').value = '';
        }



        function get_referrer() {
            var retVal = window.showModalDialog("ReferrerListMultiplePopupV2.aspx", 'Show Popup Window', "dialogHeight:800px;dialogWidth:1275px;resizable:yes;center:yes;");

            if (typeof retVal === "undefined")
                return;

            if (retVal.length == 0)
                return;


            var ids = retVal.split("_");
            for (var i = 0; i < ids.length; i++) {
                var id = ids[i];

                // dont add if alread in there
                var alreadyAdded = false;
                var alreadyAddedList = document.getElementById('hiddenReferrerIDsList').value.split(',');
                for (var j = 0; j < alreadyAddedList.length; j++) {
                    if (alreadyAddedList[j] == id) {
                        alreadyAdded = true;
                        break;
                    }
                }

                if (!alreadyAdded) {
                    var itemNew = document.createElement('option');
                    itemNew.value = id;
                    itemNew.text = "";
                    try {
                        lstReferrers.add(itemNew, null); // standards compliant; doesn't work in IE
                    }
                    catch (ex) {
                        lstReferrers.add(itemNew); // IE only
                    }
                }
            }

            updateHiddenReferrerIDs();
            document.getElementById('btnUpdateReferrers').click();
        }


        function get_organisation() {
            var retVal = window.showModalDialog("OrganisationListPopupV2.aspx", 'Show Popup Window', "dialogHeight:800px;dialogWidth:1275px;resizable:yes;center:yes;");

            if (typeof retVal === "undefined")
                return;
            if (retVal.length == 0)
                return;

            var seperatorPos = retVal.indexOf(":");
            if (seperatorPos == -1)
                return;

            var org_id = retVal.substring(0, seperatorPos);
            var org_name = retVal.substring(seperatorPos + 1);

            // alert(retVal + "\r\n--" + org_id + "--\r\n--"+ org_name + "--")

            document.getElementById('hiddenUpdateReferrersFromClinic_OrgID').value = org_id;
            document.getElementById('btnUpdateReferrersFromClinic').click();
        }


        function remove_selected_referrer() {
            var lstReferrers = document.getElementById('lstReferrers');
            for (var i = lstReferrers.length - 1; i >= 0; i--) {
                if (lstReferrers.options[i].selected)
                    lstReferrers.remove(i);
            }
            updateHiddenReferrerIDs();
            document.getElementById('btnUpdateReferrers').click();
        }
        function updateHiddenReferrerIDs() {
            var items = "";
            var lstReferrers = document.getElementById('lstReferrers');
            for (var i = 0; i < lstReferrers.length; i++) {
                items = items + (items.length > 0 ? "," : "") + lstReferrers.options[i].value;
            }
            document.getElementById('hiddenReferrerIDsList').value = items;
        }

    </script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <div class="clearfix">
        <div class="page_title"><asp:Label ID="lblHeading" runat="server">Mass Marketing To Referrers (Bulk Letters, Emails, SMS)</asp:Label> &nbsp; <asp:HyperLink ID="lnkToEntity" runat="server"/></div>
        <div class="main_content" style="padding:20px 5px;">

            <div class="block_center">
                <asp:ValidationSummary ID="ValidationSummary" runat="server" CssClass="failureNotification" ValidationGroup="ValidationSummary"/>
                <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" CssClass="failureNotification"></asp:Label>
            </div>

            <center>


                <table>
                    <tr style="vertical-align:top;">
                        <td>

                            <table id="tbl_select_ref_and_patient" runat="server">
                                <tr>
                                    <th style="text-align:left;">Select Referrer</th>
                                    <th></th>
                                    <td style="text-align:left">
                                        <table style="width:100%;">
                                            <tr>
                                                <th style="text-align:left">Select Letter</th>
                                                <td style="text-align:right">
                                                    <table>
                                                        <tr>
                                                            <td><asp:CheckBox ID="chkKeepInHistory" runat="server" Text="Keep In History" Checked="false" /></td>
                                                            <td style="width:10px"></td>
                                                            <td><asp:Button ID="btnPrint" runat="server" Text="&nbsp;&nbsp;&nbsp;Print&nbsp;&nbsp;&nbsp;" OnClick="btnPrint_Click" OnClientClick="javascript:clear_error_message();" /></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>

                                <tr id="tr_regs_search_row_space_below" runat="server" height="15">
                                    <td colspan="5"></td>
                                </tr>

                                <tr>
                                    <td>
                                        <asp:Button ID="btnAddReferrer" runat="server" Text="Add" OnClientClick="javascript:get_referrer(); return false;"/>
                                        <asp:Button ID="btnAddReferrerFromClinic" runat="server" Text="Add From Clinic" OnClientClick="javascript:get_organisation(); return false;"/>
                                        <asp:Button ID="btnAddAllReferrers" runat="server" Text="Add All" OnClick="btnAddAllReferrers_Click" />
                                        <asp:Button ID="btnDeleteSelected" runat="server" Text="Delete Selected" OnClientClick="javascript:remove_selected_referrer(); return false;" />
                                        <asp:Button ID="btnUpdateReferrers" runat="server" CssClass="hiddencol" OnClick="btnUpdateReferrers_Click" />
                                        <asp:HiddenField ID="hiddenReferrerIDsList" runat="server" />

                                        <asp:Button ID="btnUpdateReferrersFromClinic" runat="server" CssClass="hiddencol" OnClick="btnUpdateReferrersFromClinic_Click" />
                                        <asp:HiddenField ID="hiddenUpdateReferrersFromClinic_OrgID" runat="server" />

                                    </td>
                                    <td style="width:60px"></td>
                                    <td style="text-align:right;">

                                    </td>
                                </tr>

                                <tr>
                                    <td><asp:ListBox ID="lstReferrers" runat="server" rows="32" SelectionMode="Multiple" Width="100%" style="min-width:350px;"></asp:ListBox></td>
                                    <td></td>
                                    <td><asp:ListBox ID="lstLetters" runat="server" rows="32" SelectionMode="Single" style="min-width:350px;"></asp:ListBox></td>
                                </tr>

                                <tr>
                                    <td style="text-align:right;">All/None<input id="chkSelectAllReferrers" onclick="select_all(this, 'lstReferrers')" type="checkbox" value="Accept Form" name="chkSelectAllReferrers" runat="server" /></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                            </table>
 
                        </td>
                    </tr>
                </table>

            </center>

            <div id="autodivheight" class="divautoheight" style="height:500px;">
            </div>


        </div>
    </div>


</asp:Content>



