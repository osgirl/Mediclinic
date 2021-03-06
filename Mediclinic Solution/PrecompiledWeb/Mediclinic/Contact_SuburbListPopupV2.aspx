﻿<%@ page title="Select Suburb" language="C#" masterpagefile="~/SiteV2.master" autoeventwireup="true" inherits="Contact_SuburbListPopupV2, App_Web_nvct1tre" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <script src="Scripts/get_details_of_person.js" type="text/javascript"></script>
    <script type="text/javascript">

        function select_suburb(val) {

            window.returnValue = val;
            self.close();
        }

        function live_search(str) {
            if (str.length == 0) {
                document.getElementById("div_livesearch").innerHTML = "";
                document.getElementById("div_livesearch").style.border = "0px";
                document.getElementById("div_livesearch").style.display = "none";
                return;
            }
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    var response = String(xmlhttp.responseText);
                    if (response == "SessionTimedOutException")
                        window.location.href = window.location.href;  // reload page
                    document.getElementById("div_livesearch").innerHTML = response;
                    document.getElementById("div_livesearch").style.border = "1px solid #A5ACB2";
                    document.getElementById("div_livesearch").style.display = "";

                    if (document.getElementById("txtSearchFullName").value.length == 0) {
                        document.getElementById("div_livesearch").innerHTML = "";
                        document.getElementById("div_livesearch").style.border = "0px";
                        document.getElementById("div_livesearch").style.display = "none";
                        return;
                    }
                }
            }

            var ddlState = document.getElementById("ddlState");
            var stateSelected = ddlState.options[ddlState.selectedIndex].value;
            var stateSearch = stateSelected == "All" ? "" : "&state=" + stateSelected;

            xmlhttp.open("GET", "/AJAX/AjaxLiveSuburbSearch.aspx?q=" + str + stateSearch + "&max_results=150&link_href=" + encodeURIComponent("javascript:void(0);") + "&link_onclick=" + encodeURIComponent("select_suburb('[suburb_id]:[name], [postcode] ([state])');"), true);
            xmlhttp.send();
        }
        function clear_live_search() {
            document.getElementById("div_livesearch").innerHTML = "";
            document.getElementById("div_livesearch").style.border = "0px";
            document.getElementById("div_livesearch").style.display = "none";
            document.getElementById("txtSearchName").value = "";
        }


    </script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <div class="clearfix">
        <div class="page_title"><asp:Label ID="lblHeading" runat="server">Select Suburb</asp:Label></div>
        <div class="main_content_with_header">

             <center>

                <div class="user_login_form_no_width" style="width:650px;">

                    <div class="border_top_bottom user_login_form_no_width_div">

                        <table class="block_center text_left" style="margin:6px auto;">
                            <tr>
                                <td><asp:Label ID="lblState" runat="server">State</asp:Label></td>
                                <td>&nbsp;
                                    <asp:DropDownList ID="ddlState" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlState_SelectedIndexChanged" />
                                </td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td><asp:Label ID="lblNameSearch" runat="server">Search Suburb Name </asp:Label></td>
                                <td>&nbsp;
                                    <asp:TextBox ID="txtSearchName" runat="server" placeholder="Enter Suburb Name"  onkeyup="live_search(this.value)" autocomplete="off" onkeydown="return (event.keyCode!=13);"></asp:TextBox>
                                    <button type="button" name="btnClearNameSearch" onclick="clear_live_search(); return false;">Clear</button>
                                    <div id="div_livesearch" style="display:none;position:absolute;background:#FFFFFF;"></div>
                                </td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td><asp:Label ID="lblSearchSuburbName" runat="server">Narrow Below List By Suburb Name: </asp:Label></td>
                                <td>&nbsp;
                                    <asp:TextBox ID="txtSearchSuburbName" runat="server"></asp:TextBox>
                                    &nbsp;
                                    <asp:CheckBox ID="chkSuburbNameSearchOnlyStartWith" runat="server" Text="&nbsp;starts with" Checked="true" />
                                </td>
                                <td>&nbsp;&nbsp;<asp:Button ID="btnSearchSuburbName" runat="server" Text="Search" onclick="btnSearchSuburbName_Click" /></td>
                                <td><asp:Button ID="btnClearSuburbName" runat="server" Text="Clear" onclick="btnClearSuburbNameSearch_Click" /></td>
                            </tr>
                        </table>

                    </div>

                </div>

                <div class="text_center">
                    <asp:ValidationSummary ID="ValidationSummary" runat="server" CssClass="failureNotification" ValidationGroup="ValidationSummary"/>
                    <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" CssClass="failureNotification"></asp:Label>
                </div>


                <div style="height:6px;"></div>

                <div id="autodivheight" class="divautoheight" style="height:400px;">

                    <asp:GridView ID="GrdSuburb" runat="server" 
                        AutoGenerateColumns="False" DataKeyNames="suburb_id" 
                        OnRowCancelingEdit="GrdSuburb_RowCancelingEdit" 
                        OnRowDataBound="GrdSuburb_RowDataBound" 
                        OnRowEditing="GrdSuburb_RowEditing" 
                        OnRowUpdating="GrdSuburb_RowUpdating" ShowFooter="False" 
                        OnRowCommand="GrdSuburb_RowCommand" 
                        OnRowDeleting="GrdSuburb_RowDeleting" 
                        OnRowCreated="GrdSuburb_RowCreated"
                        AllowSorting="True" 
                        OnSorting="GrdSuburb_Sorting"
                        RowStyle-VerticalAlign="top"
                        AllowPaging="True"
                        OnPageIndexChanging="GrdSuburb_PageIndexChanging"
                        PageSize="15"
                        ClientIDMode="Predictable"
                        CssClass="table table-bordered table-striped table-grid table-grid-top-bottum-padding-normal auto_width block_center">
                        <PagerSettings Mode="NumericFirstLast" FirstPageText="First" PreviousPageText="Previous" NextPageText="Next" LastPageText="Last" />

                        <Columns> 

                            <asp:TemplateField HeaderText="ID"  HeaderStyle-HorizontalAlign="Left" SortExpression="suburb_id"> 
                                <ItemTemplate> 
                                    <asp:Label ID="lblId" runat="server" Text='<%# Bind("suburb_id") %>'></asp:Label> 
                                </ItemTemplate> 
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Name" HeaderStyle-HorizontalAlign="Left" SortExpression="name" FooterStyle-VerticalAlign="Top"> 
                                <ItemTemplate> 
                                    <asp:Label ID="lblName" runat="server" Text='<%# Bind("name") %>'></asp:Label> 
                                </ItemTemplate> 
                            </asp:TemplateField> 

                            <asp:TemplateField HeaderText="Postcode" HeaderStyle-HorizontalAlign="Left" SortExpression="postcode" FooterStyle-VerticalAlign="Top"> 
                                <ItemTemplate> 
                                    <asp:Label ID="lblPostcode" runat="server" Text='<%# Bind("postcode") %>'></asp:Label> 
                                </ItemTemplate> 
                            </asp:TemplateField> 

                                <asp:TemplateField HeaderText="State" HeaderStyle-HorizontalAlign="Left" SortExpression="state" FooterStyle-VerticalAlign="Top"> 
                                <ItemTemplate> 
                                    <asp:Label ID="lblState" runat="server" Text='<%# Eval("state") %>'></asp:Label> 
                                </ItemTemplate> 
                            </asp:TemplateField> 

                            <asp:TemplateField HeaderText="" HeaderStyle-HorizontalAlign="Left" FooterStyle-VerticalAlign="Top"> 
                                <ItemTemplate> 
                                    <asp:Button ID="btnSelect" runat="server" Text="Select" />
                                </ItemTemplate> 
                            </asp:TemplateField> 

                        </Columns> 
                    </asp:GridView>

                </div>


                <div>
                    <asp:Button ID="btnClose" runat="server" Text="Close" OnClientClick="window.returnValue=false;self.close();" />
                </div>


            </center>

        </div>
    </div>


</asp:Content>



