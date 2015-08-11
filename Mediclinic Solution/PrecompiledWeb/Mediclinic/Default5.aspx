<%@ page title="Welcome" language="C#" masterpagefile="~/SiteV2.master" autoeventwireup="true" inherits="_Default5, App_Web_v0sheksw" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

<style type="text/css"> 
    #dialogoverlay{ 
        display: none; 
        opacity: .6; 
        position: fixed; 
        top: 0px; 
        left: 0px; 
        background: #FFF; 
        width: 100%; 
        z-index: 10; 

    } 
    #dialogbox{ 
        display: none; 
        position: fixed; 
        background: #000; 
        /*border-radius:9px; */
        width:550px; 
        z-index: 10; 

    } 
    #dialogbox > div{ background:#FFF; margin: 1px 2px 2px 1px;  } 
    #dialogbox > div > #dialogboxhead{ background: #58aac9; font-size:17px; font-weight:bold; padding:5px; color:black; text-align:center; } 
    #dialogbox > div > #dialogboxbody{ background: #d8f3f3; padding:6px; color:black; } 
    #dialogbox > div > #dialogboxfoot{ background: #58aac9; padding:5px; text-align:right; } 

    #dialogbox > div > #seperator1{ background: #777; height:1px; } 
    #dialogbox > div > #seperator2{ background: #777; height:1px; } 
    


</style>
<script>
    /* http://www.developphp.com/view.php?tid=1384 */
    function CustomAlert(){ 
        this.render = function(heading, dialog){ 
            var winW = window.innerWidth; 
            var winH = window.innerHeight; 
            var dialogoverlay = document.getElementById('dialogoverlay'); 
            var dialogbox = document.getElementById('dialogbox'); 
            dialogoverlay.style.display = "block"; 
            dialogoverlay.style.height = winH+"px"; 
            dialogbox.style.left = (winW/2) - (550 * .5)+"px"; 
            dialogbox.style.top = "100px"; 
            dialogbox.style.display = "block"; 
            document.getElementById('dialogboxhead').innerHTML = heading;
            document.getElementById('dialogboxbodytext').innerHTML = dialog;
            document.getElementById('dialogboxfoot').innerHTML = '<button onclick="Alert.ok()">OK</button>';

            document.getElementById('dialogboxhead').style.display = heading == '' ? "none" : "block";
            document.getElementById('dialogboxhead').style.display = heading == '' ? "none" : "block";

        }
        this.ok = function () {
            document.getElementById('dialogbox').style.display = "none";
            document.getElementById('dialogoverlay').style.display = "none";
        }
    }
    var Alert = new CustomAlert();

</script>


</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <div id="dialogoverlay"></div> 
    <div id="dialogbox"> 
        <div> 
            <div id="dialogboxhead"></div> 
            <div id="seperator1"></div> 
            <div id="dialogboxbody">
                <center>
                    <table>
                        <tr>
                            <td>
                                <span id="dialogboxbodytext"></span>
                            </td>
                        </tr>
                    </table>
                </center>
            </div> 
            <div id="seperator2"></div> 
            <div id="dialogboxfoot"></div> 
        </div> 
    </div>

    <div class="clearfix">
        <div class="page_title"><span id="lblHeading">&nbsp;</span></div>
        <div class="main_content" id="main_content" runat="server" style="background: url(../imagesV2/login_bg.png) center top no-repeat #EDEDED;">
            <div class="text-center">

                <div class="page_title">
                    <h3>Welcome <asp:Label ID="lblStaffName" runat="server"/>!</h3>
                    <div style="height:5px;"></div>
                    <h4>You Are Logged In To  <asp:Label ID="lblSiteName" runat="server"/></h4>
                </div>
                <br />

                <button onclick="alert('You look very pretty today.')">Default Alert</button>
                <button onclick="Alert.render('AA','You look very pretty today.');return false;">Custom Alert</button>
                <button onclick="Alert.render('','And you also smell very nice.<br />And you also smell <b>very nice</b>. And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />And you also smell very nice.<br />');return false;">Custom Alert 2</button>

                <asp:Label ID="lblTest" runat="server"></asp:Label>

                <asp:ValidationSummary ID="ValidationSummary" runat="server" CssClass="failureNotification" ValidationGroup="ValidationSummary"/>
                <asp:Label ID="lblErrorMessage" runat="server" ForeColor="Red" CssClass="failureNotification"></asp:Label>
            </div>

            <div id="autodivheight" class="divautoheight" style="height:200px;">
            </div>

        </div>
    </div>

</asp:Content>



