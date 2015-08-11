<%@ page title="Home Page" language="C#" masterpagefile="~/Site.master" autoeventwireup="true" inherits="_Default2, App_Web_q34p1rur" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <script type="text/javascript" src="Scripts/jquery-1.4.1.min.js"></script>
    <script type="text/javascript" src="ScriptsV2/jscolor.js"></script>
    <script type="text/javascript">
        
    </script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <h2>
        Welcome <asp:Label ID="lblStaffName" runat="server"/>!
    </h2>

    <br />
    <br />

    <asp:Label ID="lblOutput" runat="server"></asp:Label>

    <br />
    <input class="color" id="colorPicker" runat="server" maxlength="6" readonly="readonly" />
    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />


    <br />
    <br />

    <b>Conditions</b>
    <div style="line-height:7px;">&nbsp;</div>
    <asp:CheckBoxList ID="chkBoxListConditions" runat="server" CellPadding="0" CellSpacing="5"></asp:CheckBoxList>

    <br />
    <br />


    <div id="autodivheight" class="divautoheight" style="height:500px;">
    </div>

</asp:Content>

