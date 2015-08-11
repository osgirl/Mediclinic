<%@ page title="TestDB" language="C#" masterpagefile="~/Site.master" autoeventwireup="true" inherits="TestDB, App_Web_bex5gmz1" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        About
    </h2>
        
    <asp:Label ID="lblError" runat="server" ForeColor="Red" ></asp:Label><br />

    <p>

        SMSTech Msg ID: <asp:TextBox ID="txtMsgId" runat="server">4923518</asp:TextBox>
        <br />
                <asp:Button ID="btnTesty" runat="server" Text="SMS DB Test Add" OnClick="btnTesty_Click" />
                <asp:Button ID="btnTesty2" runat="server" Text="SMS DB Test Update" OnClick="btnTesty2_Click" />

        <br />

        <asp:Label ID="lblSMSes" runat="server"></asp:Label>

    </p>

</asp:Content>
