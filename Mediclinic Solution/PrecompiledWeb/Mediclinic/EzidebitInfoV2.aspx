<%@ page title="Welcome" language="C#" masterpagefile="~/SiteV2.master" autoeventwireup="true" inherits="EzidebitInfoV2, App_Web_nvct1tre" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
<script>

    addLoadEvent(function () { show_all(false); });

    function show_all(do_show) {

        var ncols = document.getElementById("tbl_output").rows[0].cells.length;
        for (var i = 6; i < ncols; i++) {
            show_hide_column(i, do_show);
        }
    }

    function show_hide_column(col_no, do_show) {
        var stl = (do_show) ? '' : 'none';
        var table = document.getElementById("tbl_output");
        for (var i = 0, row; row = table.rows[i]; i++) {
            row.cells[col_no].style.display = stl;
        }
    }

</script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <div class="clearfix">
        <div class="page_title"><asp:Label ID="lblHeading" runat="server">Ezidebit Info</asp:Label></div>
        <div class="main_content" style="padding:10px 5px;">

            <br />

            <center>
                <a href="#" onclick="show_all(true);return false;">Show</a> / <a href="#" onclick="show_all(false);return false;">Hide</a>
            </center>
            

            <center>
                <asp:Label ID="lblOutput" runat="server"></asp:Label>
            </center>

            <br />
            <br />

    
        </div>
    </div>

</asp:Content>



