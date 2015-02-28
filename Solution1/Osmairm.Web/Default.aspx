<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentMeta" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphHead" runat="Server">
    <!-- Flexslider JavaScript Files -->
    <script type="text/javascript" src="javascript/jquery.flexslider.js"></script>
    <link rel="stylesheet" href="css/flexslider.css" type="text/css" media="screen" />
  <%--  <link href="css/countdown/bootstrap.min.css" rel="stylesheet" />--%>
    <link href="css/countdown/styles.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="cphMain" runat="Server">
    <asp:ObjectDataSource runat="server" ID="objSlider" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetSliderHome" TypeName="DataSetVepAdminTableAdapters.PhotosTableAdapter">
        <SelectParameters>
            <asp:Parameter DefaultValue="3" Name="tipo" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <div id="content-wrapper">
        <div class="fullwidth">
            <div class="flexslider" id="blog-slider">
                <ul class="slides">
                    <asp:Repeater runat="server" DataSourceID="objSlider" ID="rptSliderHome">
                        <ItemTemplate>
                            <li>
                                <img src="<%# "Handler.ashx?PhotoID=" + DataBinder.Eval(Container.DataItem, "PhotoID") %>.jpg"
                                    alt="" />
                            </li>
                        </ItemTemplate>
                    </asp:Repeater>
                </ul>
            </div>
        </div>
        <div style="margin-top: 20px; border: none;" class="content">
            <div id="inner-content" class="centered">
                <div style="display: block;" class="one-third">
                    <div>
                        <span class="dropcap1">
                            <img src="images/logo1home.png" alt="" /></span>
                        <p style="float: none; font-weight: bold; font-style: italic; font-size: 1.5em;">Centri Osmairm</p>
                        <span><b style="font-size: 1.2em">RIABILITAZIONE A 360°</b><br />
                            <asp:Localize meta:resourcekey="Home_Box1_Text" runat="server"></asp:Localize></span>
                        <div style="padding-top: 20px;">
                            <a href="Azienda.aspx">Chi Siamo</a>
                        </div>
                    </div>
                    <div></div>
                </div>
                <!--END TWO-THIRD-->
                <div style="display: block;" class="one-third">
                    <div>
                        <span class="dropcap1">
                            <img src="images/logo2home.png" alt="" />
                        </span>
                        <p style="float: none; font-style: italic; font-weight: bold; font-size: 1.5em;">In Evidenza</p>
                        <span><b style="font-size: 1.2em">SPECIAL OLIMPICS</b><br />
                            <asp:Localize meta:resourcekey="Home_Box2_Text" runat="server"></asp:Localize>
                        </span>
                        <div style="padding-top: 20px;">
                            <a href="R360.aspx">Vai al Blog</a>
                        </div>
                    </div>
                </div>
                <div style="display: block;" class="one-third last">
                    <div>
                        <span class="dropcap1">
                            <img src="images/logo3home.png" /></span>
                        <p style="float: none; font-weight: bold; font-style: italic; font-size: 1.5em;">Linea Diretta</p>

                        <span><b style="font-size: 1.2em">+39 099 821 62 13</b><br />
                            <asp:Localize meta:resourcekey="Home_Box2_Text" runat="server"></asp:Localize>
                        </span>
                        <div style="padding-top: 20px;">
                            <a href="Contatti.aspx">Contatti</a>
                        </div>
                    </div>
                </div>
                <!--END ONE-THIRD LAST-->

            </div>
        </div>
        <div class="fullwidth">
            	<section class="count-down-wrapper fade-down">
			<ul class="row count-down">                       
				<li class="col-md-3 col-sm-6">   
					<input class="knob days" data-readonly=true data-min="0" data-max="365" data-width="260" data-height="260" data-thickness="0.07" data-fgcolor="#34aadc" data-bgColor="#e1e2e6" data-angleOffset="180">
					<span id="days-title">days</span>
				</li>    
				<li class="col-md-3 col-sm-6"> 
					<input class="knob hour" data-readonly=true data-min="0" data-max="24" data-width="260" data-height="260" data-thickness="0.07" data-fgcolor="#4cd964" data-bgColor="#e1e2e6" data-angleOffset="180">
					<span id="hours-title">hours</span>
				</li>    
				<li class="col-md-3 col-sm-6"> 
					<input class="knob minute" data-readonly=true data-min="0" data-max="60" data-width="260" data-height="260" data-thickness="0.07" data-fgcolor="#ff9500" data-bgColor="#e1e2e6" data-angleOffset="180">
					<span id="mins-title">minutes</span>
				</li>    
				<li class="col-md-3 col-sm-6"> 
					<input class="knob second" data-readonly=true data-min="0" data-max="60" data-width="260" data-height="260" data-thickness="0.07" data-fgcolor="#ff3b30" data-bgColor="#e1e2e6" data-angleOffset="180">
					<span id="secs-title">seconds</span>
				</li>                
			</ul>              
		</section>
        </div>
        <script src="Scripts/Countdown/bootstrap.min.js"></script>
        <script src="Scripts/Countdown/jquery.knob.js"></script>
        <script src="Scripts/Countdown/jquery.ccountdown.js"></script>
        <script src="Scripts/Countdown/init.js"></script>
        <script src="Scripts/Countdown/general.js"></script>
    </div>
</asp:Content>

