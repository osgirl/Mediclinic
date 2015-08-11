<%@ page title="View Booking Invoice" language="C#" masterpagefile="~/Site.master" autoeventwireup="true" inherits="ViewInvoice, App_Web_q34p1rur" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <h2>File Download</h2>

    <br />
    <asp:Label ID="lblErrorMessage" runat="server" CssClass="failureNotification"></asp:Label>
    <br />


    <asp:Button ID="btnClose" runat="server" Text="Close" OnClientClick="javascript:window.close();return false;" />

    <p>
        <asp:Label ID="Label1" runat="server"></asp:Label>
    </p>
</asp:Content>
