<%@ Page Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true"
    CodeFile="ManageUser.aspx.cs" Inherits="Admin_ManageUser" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphAdminMenu" runat="Server">
    <li><a href="Default.aspx">NEWS</a></li>
    <li><a href="ManagePartners.aspx">PARTNERS</a></li>
 <li>
        <asp:LinkButton CausesValidation="false" OnClick="gotosliderPage" runat="server"
            ID="lnkbtnSlider">SLIDER HOME</asp:LinkButton></li>
    <li><a href="Albums.aspx">GALLERY</a></li>
    <li><a href="Newsletter.aspx">NEWSLETTER</a></li>
      <li><asp:LinkButton CausesValidation="false" OnClick="gotoSpecial" runat="server"
            ID="lnkbtnSpecial">SPECIAL CONTENT</asp:LinkButton></li>
    <li class="active"><a href="#">MANAGE USER</a></li>
</asp:Content>
<asp:Content ID="ContentBody" runat="server" ContentPlaceHolderID="cphAdminBody">

    <script type="text/javascript">
        function DeleteConfirmation() {
            if (!window.confirm("Confirm Delete?")) return false;
        }
    </script>

    <script type="text/javascript">
        function pageLoad() {
            InitBoxSlide();
            InitFancybox();
        }
    </script>

    <div class="content-box">
        <div class="box-body">
            <div class="box-header clear">
                <ul class="tabs clear">
                    <li>
                        <asp:Button ID="Nuovo" runat="server" Text="Add New User" CssClass="button green size-120"
                            OnClick="Nuovo_Click" CausesValidation="false" /></li>
                            <li>
                        <asp:Button ID="btnNewAdmin" runat="server" Text="Add New Admin" CssClass="button green size-120"
                            OnClick="Nuovo_Admin_Click" CausesValidation="false" /></li>
                </ul>
                <h2>
                    :: Manage Users</h2>
            </div>
            <!-- box-header -->
            <div class="box-wrap clear">
                <asp:UpdatePanel runat="server" ID="updpnlListNews" UpdateMode="Conditional">
                    <ContentTemplate>
                        <asp:ListView ID="lvUtenti" runat="server" DataKeyNames="UserName" DataSourceID="objUtenti" OnItemCreated="_OnCreated"
                            OnItemCommand="_OnItemCommand" >
                            <EmptyDataTemplate>
                                <div class="notification note-info">
                                    <p>
                                        <strong>Warning:</strong>No user.</p>
                                </div>
                            </EmptyDataTemplate>
                            <LayoutTemplate>
                                <table class="style1">
                                    <thead>
                                        <tr>
                                            <th>
                                                Photo
                                            </th>
                                            <th>
                                                Info
                                            </th>
                                            <th>
                                            </th>
                                            <th class="center">
                                                Details
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr runat="server" id="itemPlaceholder" />
                                    </tbody>
                                </table>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <asp:Panel ID="pnlUtente" runat="server">
                                    <tr class="box-slide-head">
                                        <td>
                                            <a href="#" title="Anteprima">
                                                <img src="images/user.gif" alt="" class="thumb size64 clickable" />
                                            </a>
                                        </td>
                                        <td style="width: 700px; padding-top: 15px; font-size: 13px;">
                                            <p style="margin-bottom: 5px;">
                                                <img src="images/ico_active_16.png" class="fl-space2" title="active" alt="" />Username:
                                                <span style="color: Red">
                                                    <%# Eval("UserName") %></span></p>
                                            <p>
                                                <img src="images/ico_active_16.png" class="fl-space2" title="active" alt="" />E-mail:
                                                <span style="color: Red">
                                                    <%# Eval("Email")%></span>
                                            </p>
                                        </td>
                                        <td class="vcenter">
                                            <ul style="margin: 5px;">
                                                <li class="bt-space5">
                                                    <asp:LinkButton ID="lnkButtonModifica" runat="server" CssClass="button green size-120"
                                                        Text="Modifica Album" CommandName="modifica" Visible="false"></asp:LinkButton></li>
                                                <li class="bt-space5">
                                                    <asp:LinkButton OnClientClick="return DeleteConfirmation();" CommandName="cancella"
                                                        ID="lnkButtonDelete" runat="server" CssClass="button red size-120" Text="Delete User"></asp:LinkButton>
                                                </li>
                                        </td>
                                        <td class="vcenter slide-but" style="width: 30px;">
                                            <span>more</span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" class="box-slide-body ln-normal hidden">
                                            <h5>
                                                More Info</h5>
                                            <div class="clear mark bt-space10">
                                                <div class="trio fl">
                                                    <ul class="bt-space10" style="width: 470px;">
                                                        <li class="clear bt-space5">
                                                            <img src="images/ball_blue_16.png" class="fl-space" alt="" /><span class="fl" style="width: 65px;">Username:</span>
                                                            <span class="fl value">
                                                                <%# Eval("UserName")%></span></li>
                                                        <li class="clear bt-space5">
                                                            <img src="images/ball_blue_16.png" class="fl-space" alt="" /><span class="fl" style="width: 65px;">Password:</span>
                                                            <span class="fl value">
                                                                <asp:Label runat="server" ID="lblPassword"></asp:Label></span></li>
                                                        <li class="clear bt-space0">
                                                            <img src="images/ball_blue_16.png" class="fl-space" alt="" /><span class="fl" style="width: 65px;">User
                                                                Id:</span> <span class="fl value">
                                                                    <asp:Label runat="server" ID="lblUserId"></asp:Label></span> </li>
                                                    </ul>
                                                </div>
                                                <div class="fr">
                                                </div>
                                                <div class="trio fl" style="margin-left: 20px;">
                                                    <ul class="bt-space10">
                                                        <li class="clear bt-space5">
                                                            <img src="images/ball_blue_16.png" class="fl-space" alt="" />
                                                            <span class="fl" style="width: 130px;">Createt On:</span> <span class="fl value">
                                                                <%# Eval("CreationDate")%></span> </li>
                                                        <li class="clear bt-space5">
                                                            <img src="images/ball_blue_16.png" class="fl-space" alt="" />
                                                            <span class="fl" style="width: 130px;">Last Login:</span> <span class="fl value">
                                                                <%# Eval("LastLoginDate")%></span> </li>
                                                        <li class="clear bt-space5" runat="server" visible="false">
                                                            <img src="images/ball_blue_16.png" class="fl-space" alt="" /><span class="fl" style="width: 130px;">Numero
                                                                di foto nell'Album:</span> <span class="fl value">
                                                                    <asp:Label runat="server" ID="lblFotoCount"></asp:Label></span></li>
                                                        <li class="clear bt-space0">
                                                            <img src="images/ball_blue_16.png" class="fl-space" alt="" /><span class="fl" style="width: 130px;">Numero
                                                                di Accessi:</span> <span class="fl value">
                                                                    <asp:Label runat="server" ID="lblAccessi"></asp:Label></span></li>
                                                    </ul>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </asp:Panel>
                            </ItemTemplate>
                        </asp:ListView>
                        <div class="tab-footer clear">
                            <asp:DataPager ID="DataPagerlvAlbume" runat="server" PagedControlID="lvUtenti" PageSize="6">
                                <Fields>
                                    <peppPager:FollowingPagerField ButtonCount="5" />
                                </Fields>
                            </asp:DataPager>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
             <div class="box-wrap clear">
               <asp:ListView ID="ListViewAdmin" runat="server" DataKeyNames="UserName" DataSourceID="objUtenti"
                    OnItemCommand="_OnItemCommandAdmin" OnItemCreated="_OnCreatedAdmin" >
                    <EmptyDataTemplate>
                        <table class="style1">
                            <tbody>
                                <tr>
                                    <td>
                                    </td>
                                    <td>
                                        <br />
                                        <div class="notification note-info">
                                            <p>
                                                <strong>Warning:</strong> No users in archive.
                                            </p>
                                        </div>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </EmptyDataTemplate>
                    <LayoutTemplate>
                        <table class="style1">
                            <thead>
                                <tr>
                                    <th>
                                    </th>
                                    <th>
                                        User
                                    </th>
                                    <th>
                                        e-mail
                                    </th>
                                    <th>
                                    </th>
                                    <th>
                                    </th>
                                    <th>
                                    </th>
                                    <th>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr runat="server" id="itemPlaceholder" />
                            </tbody>
                        </table>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <tr runat="server" visible="false" id="pnlAdmin">
                            <td>
                                <asp:Label runat="server" ID="lblRiga" Text=""></asp:Label>
                            </td>
                            <td>
                                <%# Eval("UserName") %>
                            </td>
                            <td>
                                <%# Eval("Email")%>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td style="margin-right: 12px; margin-top: 10px;">
                                <asp:LinkButton OnClientClick="return DeleteConfirmation();" CausesValidation="false"
                                    CommandName="cancella" ID="LinkButton2" runat="server" CssClass="button red"
                                    Style="float: right;" Text="Delete"></asp:LinkButton>
                                
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:ListView>
             </div>
        </div>
    </div>
      
    <asp:ObjectDataSource ID="objUtenti" runat="server" SelectMethod="GetAllUsers" TypeName="System.Web.Security.Membership">
        
    </asp:ObjectDataSource>
</asp:Content>
