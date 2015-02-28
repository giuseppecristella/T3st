<%@ Page Language="C#" MasterPageFile="AdminMaster.master" CodeFile="Albums.aspx.cs"
    Inherits="Admin_Albums_aspx" ValidateRequest="false" %>

<%@ Register TagPrefix="asp" Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit, Version=3.5.40412.0, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" %>
<asp:Content ID="ContentMenu" runat="server" ContentPlaceHolderID="cphAdminMenu">
    <li><a class="active" href="Default.aspx">AZIENDA</a></li>
    <li><a href="ManagePersonale.aspx">PERSONALE</a></li>
    <li><a href="ManageStrutture.aspx">STRUTTURE</a></li>
    <li><a href="ManageServizi.aspx">SERVIZI</a></li>
    <li><a href="ManageProgetti.aspx">PROGETTI</a></li>
    <li><a href="ManageFormazione.aspx">FORMAZIONE</a></li>
    <li class="active"><a href="Albums.aspx">GALLERY</a></li>
    <li><a href="Newsletter.aspx">NEWSLETTER</a></li>
    <li><a href="ManageData.aspx?idTipo=0">NEWS</a></li>
    <li><a href="ManageMAGAZINE.aspx?idTipo=5">MAGAZINE</a></li>
</asp:Content>
<asp:Content ID="ContentBody" ContentPlaceHolderID="cphAdminBody" runat="Server">
    <script type="text/javascript">
        function DeleteConfirmation() {
            if (!window.confirm('Cancellare album e tutte le foto associate?')) return false;
        }
    </script>
    <script type="text/javascript">
        function pageLoad() {
            InitFancybox();
        }
    </script>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" TypeName="PhotoManager"
        SelectMethod="GetAlbumsNewsLinked" InsertMethod="AddAlbumNewsLinked" UpdateMethod="EditAlbum"
        OldValuesParameterFormatString="original_{0}">
        <InsertParameters>
            <asp:Parameter Name="titolo_news" Type="String" />
            <asp:Parameter Name="titolo_newsEN" Type="String" />
            <asp:Parameter Name="titolo_newsDE" Type="String" />
            <asp:Parameter Name="data_news" Type="DateTime" />
            <asp:Parameter Name="tipo_album" Type="Int32" DefaultValue="0" />
            <asp:Parameter Name="tags" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Caption" Type="String" />
            <asp:Parameter Name="IsPublic" Type="Boolean" />
            <asp:Parameter Name="AlbumID" Type="Int32" />
        </UpdateParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="ddlTipoAlbum" DefaultValue="0" Name="tipo_album"
                PropertyName="SelectedValue" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:HiddenField ID="hdfTagAutoComplete" runat="server" Value="" />
    <div class="page-content">
        <div id="portlet-config" class="modal hide">
            <div class="modal-header">
                <button data-dismiss="modal" class="close" type="button">
                </button>
                <h3>portlet Settings</h3>
            </div>
            <div class="modal-body">
                <p>
                    Here will be a configuration form
                </p>
            </div>
        </div>
        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span12">
                    <h3 class="page-title">Gestione Album <small>Osmairm</small>
                    </h3>
                </div>
            </div>
            <div class="row-fluid">
                <div class="span12">
                    <asp:DropDownList AutoPostBack="true" OnSelectedIndexChanged="ddlAlbum_SelectedIndexChanged"
                        ID="ddlTipoAlbum" runat="server">
                        <asp:ListItem Value="0">Gallery semplice</asp:ListItem>
                        <asp:ListItem Value="1">News</asp:ListItem>
                        <asp:ListItem Value="2">Progetti</asp:ListItem>
                        <asp:ListItem Value="3">Slider Home</asp:ListItem>
                    </asp:DropDownList>
                    <div class="form-actions">
                        <a href="#myModal2" role="button" class="btn blue" data-toggle="modal"><i class="icon-plus"></i>Nuovo Album</a>
                    </div>
                    <div id="myModal2" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1"
                        aria-hidden="true">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            </button>
                            <h3 id="myModalLabel1">Nuovo Album</h3>
                        </div>
                        <asp:FormView ID="FormView1" runat="server" DataSourceID="ObjectDataSource1" DefaultMode="Insert">
                            <InsertItemTemplate>
                                <div class="modal-body">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th></th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <th>Titolo Album
                                                </th>
                                                <td>
                                                    <asp:TextBox Width="400" ID="txtTitoloITA" runat="server" Text='<%# Bind("titolo_news") %>' />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtTitoloITA"
                                                        ErrorMessage="<div style='width:99.6%; margin-top:5px; margin-bottom:3px;' class='notification note-attention'><p><b>Attenzione:</b> campo obbligatorio.</p></div>"
                                                        Display="Dynamic" Style="padding-top: 20px;" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>Date<span class="required">*</span>
                                                </th>
                                                <td>
                                                    <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtData"
                                                        Format="dd/MM/yyyy">
                                                    </asp:CalendarExtender>
                                                    <asp:TextBox Width="400" ID="txtData" Text='<%# Bind("data_news") %>' runat="server"></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtData"
                                                        ErrorMessage="<div style='width:99.6%; margin-top:5px; margin-bottom:3px;' class='notification note-attention'><p><b>Attenzione:</b> campo obbligatorio.</p></div>"
                                                        Display="Dynamic" Style="padding-top: 20px;" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>Descrizione Album
                                                </th>
                                                <td>
                                                    <asp:TextBox Width="400" ID="txtDescBreve" runat="server" Text='<%# Bind("titolo_newsEN") %>' />
                                                </td>
                                            </tr>
                                            <tr>
                                                <th>Tags
                                                </th>
                                                <td>
                                                    <asp:TextBox ID="txtTags1" runat="server" Text='<%# Bind("Tags") %>' CssClass="tags" />
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </InsertItemTemplate>
                            <FooterTemplate>
                                <div class="modal-footer">
                                    <button class="btn" data-dismiss="modal" aria-hidden="true">
                                        Chiudi</button>
                                    <asp:LinkButton ID="ImageButton1" runat="server" Text="Salva" CommandName="Insert"
                                        CssClass="btn yellow" />
                                </div>
                            </FooterTemplate>
                        </asp:FormView>
                    </div>
                    <div class="portlet box red">
                        <div class="portlet-title">
                            <h4>
                                <i class="icon-reorder"></i>Archivio Albums</h4>
                        </div>
                        <div class="portlet-body">
                            <div class="row-fluid">
                                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                                <asp:ListView runat="server" ID="lvAlbums" OnItemCommand="_OnItemCommand" DataSourceID="ObjectDataSource1"
                                    DataKeyNames="AlbumID" OnItemCreated="_OnCreated">
                                    <EmptyDataTemplate>
                                        <div class="notification note-info">
                                            <p>
                                            Nessuna Gallery inserita
                                        </div>
                                    </EmptyDataTemplate>
                                    <LayoutTemplate>
                                        <asp:PlaceHolder runat="server" ID="itemPlaceholder"></asp:PlaceHolder>
                                    </LayoutTemplate>
                                    <ItemTemplate>
                                        <div class="span3">
                                            <div class="item">
                                                <a class="fancybox-button" data-rel="fancybox-button" title="Photo" href="assets/img/gallery/image1.jpg">
                                                    <div class="zoom">
                                                        <img src="Handler.ashx?AlbumID=<%#  Eval("AlbumID") %>&Size=M" alt="" />
                                                        <div class="zoom-icon">
                                                        </div>
                                                    </div>
                                                </a>
                                                <div class="details">
                                                    <%#Eval("Titolo") %>
                                                            &nbsp; <a runat="server" id="aApriEditModal" href="#myModal1" role="button" class="icon" data-toggle="modal"><i title="modifica"
                                                                class="icon-pencil"></i></a>
                                                    <asp:LinkButton ID="Button2" runat="server" Text="Add Photos" CommandName="modifica"
                                                        CssClass="icon" CausesValidation="false"><i class="icon-camera"></i></asp:LinkButton>
                                                    <asp:LinkButton ID="Button3" OnClientClick="return DeleteConfirmation();" runat="server"
                                                        CommandName="cancella" CssClass="icon" CausesValidation="false">
                                                    <i class="icon-remove"></i> 
                                                    </asp:LinkButton>
                                                </div>
                                            </div>
                                            <div runat="server" id="myModal">
                                                <div class="modal-header">
                                                    <h3 id="myModalLabel1">
                                                        <%#Eval( "Titolo") %></h3>
                                                </div>
                                                <div class="modal-body">
                                                    <p>
                                                        <asp:TextBox runat="server" ID="txtTitoloAlb" Text='<%# Server.HtmlEncode(Eval("Titolo").ToString()) %>'></asp:TextBox>
                                                        <asp:TextBox runat="server" ID="txtDescrizioneBreve" value='<%#  Eval("TitoloENG") %>' />
                                                    </p>
                                                    <p>
                                                        <asp:TextBox ID="txtDataAlbum" Text='<%#  Eval("Data").ToString().Substring(0, 10) %>' data-date-format="dd-mm-yyyy" runat="server" size="16" class="m-wrap m-ctrl-medium date-picker"></asp:TextBox>
                                                    </p>
                                                    <p>
                                                        <label>Tags</label>
                                                        <asp:TextBox runat="server" CssClass="tags" ID="txtTags2" value='<%#  Eval("Tags") %>' />
                                                    </p>
                                                </div>
                                                <div class="modal-footer">
                                                    <asp:LinkButton ID="LinkButton" runat="server" Text="Salva" CommandName="modifica_titolo"
                                                        CssClass="btn yellow" CausesValidation="false"></asp:LinkButton>
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:ListView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
