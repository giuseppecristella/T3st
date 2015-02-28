<%@ Page Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true"
    ValidateRequest="false" CodeFile="AddModServizio.aspx.cs" Inherits="AddModServizio" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="ContentMenu" runat="server" ContentPlaceHolderID="cphAdminMenu">
    <li><a href="Default.aspx">AZIENDA</a></li>
    <li><a href="ManagePersonale.aspx">PERSONALE</a></li>
    <li><a href="ManageStrutture.aspx">STRUTTURE</a></li>
    <li class="active"><a href="ManageServizi.aspx">SERVIZI</a></li>
    <li><a href="ManageProgetti.aspx">PROGETTI</a></li>
    <li><a href="ManageData.aspx?idTipo=9">FORMAZIONE</a></li>
    <li><a href="Albums.aspx">GALLERY</a></li>
    <li><a href="Newsletter.aspx">NEWSLETTER</a></li>
    <li><a href="ManageData.aspx?idTipo=0">NEWS</a></li>
</asp:Content>
<asp:Content ID="ContentBody" ContentPlaceHolderID="cphAdminBody" runat="Server">
    <script type="text/javascript">
        function getCleanedWordString(content) {
            var fullStr = content + " ";
            var initial_whitespace_rExp = /^[^A-Za-z0-9]+/gi;
            var left_trimmedStr = fullStr.replace(initial_whitespace_rExp, "");
            var non_alphanumerics_rExp = rExp = /[^A-Za-z0-9]+/gi;
            var cleanedStr = left_trimmedStr.replace(non_alphanumerics_rExp, " ");
            var splitString = cleanedStr.split(" ");
            return splitString;
        }
        function countWord(cleanedWordString) {
            var word_count = cleanedWordString.length - 1;
            return word_count;
        }
        function conta() {
            var words = document.getElementById("peppe").value;
            var num = countWord(words);
        }
        var info;
        $(document).ready(function () {
            var options = {
                'maxCharacterSize': -2,
                'originalStyle': 'originalTextareaInfo',
                'warningStyle': 'warningTextareaInfo',
                'warningNumber': 40
            };
            $('#testTextarea').textareaCount(options);
            var options2 = {
                'maxCharacterSize': 2,
                'originalStyle': 'originalTextareaInfo',
                'warningStyle': 'warningTextareaInfo',
                'warningNumber': 40,
                'displayFormat': '#input/#max | #words words'
            };
            $('#pepp1de').textareaCount(options2);
            var options3 = {
                'maxCharacterSize': 200,
                'originalStyle': 'originalTextareaInfo',
                'warningStyle': 'warningTextareaInfo',
                'warningNumber': 40,
                'displayFormat': '#input/#max'
            };
            $('#ctl00_cphAdminBody_txtDescrizione_').textareaCount(options3, function (data) {
                $('#showData').html(data.input + " char / " + data.left + " rimanenti  |  parole inserite: " + data.words);
            });
        });
    </script>
    <div class="content-box">
        <div class="box-body">
            <div class="box-header clear">
                <ul class="tabs clear">
                    <li><a href="#italiano">ITA</a></li>
                    <li><a href="#inglese">ENG</a></li>
                    <%--                    <li><a href="#tedesco">DEU</a></li>
                    --%>
                </ul>
                <h2>:: Struttura</h2>
            </div>
            <div class="box-wrap clear">
                <!-- ***** START DIV MESSAGGI DI ERRORE ***** -->
                <div id="DivSuccess" runat="server" visible="false" class="notification">
                    <a href="#" class="close" title="Close notification">close</a>
                    <p>
                        <strong>articolo ID:
                            <asp:Label ID="News_ID" runat="server" Text=""> inserito con successo</asp:Label></strong>
                    </p>
                </div>
                <div id="DivError" runat="server" visible="false" class="notification note-attention">
                    <a href="#" class="close" title="Close notification">close</a>
                    <p>
                        <strong>
                            <asp:Label ID="LabelError" runat="server" Text=""></asp:Label>
                        </strong>
                    </p>
                </div>
                <!-- ***** END DIV MESSAGGI DI ERRORE ***** -->
                <div id="italiano">
                    <table class="style1">
                        <thead>
                            <tr>
                                <th>Item
                                </th>
                                <th class="full">Value
                                </th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th>Tipologia
                                </th>
                                <td>
                                    <asp:DropDownList ID="ddlTipo" runat="server" DataSourceID="XmlDataSourceNewsTipo"
                                        DataTextField="text" DataValueField="value">
                                    </asp:DropDownList>
                                    <asp:XmlDataSource ID="XmlDataSourceNewsTipo" runat="server" DataFile="~/Xml/ListaTipStrutture.xml"
                                        TransformFile="~/Xml/ListaTipStrutture.xslt"></asp:XmlDataSource>
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <th>Name <span class="required">*</span>
                                </th>
                                <td class="edit-field long" colspan="2">
                                    <asp:TextBox ID="txtTitoloNews" runat="server" CssClass="text required fl" MaxLength="100"></asp:TextBox>
                                    <div class="clear">
                                    </div>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorTitolo" runat="server" ControlToValidate="txtTitoloNews"
                                        ErrorMessage="<div style='width:99.6%; margin-top:5px; margin-bottom:3px;' class='notification note-attention'><p><b>Warning:</b> required field.</p></div>"
                                        Display="Dynamic">
                                    </asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <th>Website
                                </th>
                                <td class="edit-field long" colspan="2">
                                    <asp:TextBox ID="txtwebsite" runat="server" CssClass="text fl" MaxLength="270"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>E-Mail
                                </th>
                                <td class="edit-field long" colspan="2">
                                    <asp:TextBox ID="txtDescrizione" runat="server" CssClass="text fl" MaxLength="270"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <tr>
                                    <th>Date <span class="required">*</span>
                                    </th>
                                    <td class="edit-field" colspan="2">
                                        <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtData"
                                            Format="dd/MM/yyyy" CssClass="MyCalendar">
                                        </asp:CalendarExtender>
                                        <asp:TextBox ID="txtData" runat="server" CssClass="required text fl"></asp:TextBox>
                                        <div class="clear">
                                        </div>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorData" runat="server" ControlToValidate="txtData"
                                            ErrorMessage="<div style='width:99.6%; margin-top:5px; margin-bottom:3px;' class='notification note-attention'><p><b>Warning:</b> required field.</p></div>"
                                            Display="Dynamic">
                                        </asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                            </tr>
                            <tr runat="server" id="trVideo" visible="false">
                                <th>Video url
                                </th>
                                <td class="edit-field long" colspan="2">
                                    <asp:TextBox runat="server" ID="txtVideo" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <th>Logo
                                </th>
                                <td colspan="2">
                                    <asp:FileUpload ID="FileUploadFoto" runat="server" CssClass="form-file fl-space2" />
                                    <asp:Button CausesValidation="false" ID="ButtonUploadFoto" CssClass="button green"
                                        runat="server" Text="Add Photo" OnClick="ButtonUploadFoto_Click" />
                                    <asp:ImageButton ID="lnkCancFoto" runat="server" ImageUrl="images/ico_delete_16.png"
                                        CausesValidation="false" Visible="false" OnClientClick="window.confirm('Remove Photo?')"
                                        OnClick="CancellaFoto" CssClass="icon16 fr-space2" ToolTip="Elimina la Foto" />
                                    <a href="#" runat="server" id="previewFoto" title="preview" rel="group1" class="fr-space">
                                        <asp:Image ID="imgFotoArticolo" runat="server" Visible="true" ImageUrl="" CssClass="thumb size64 fr-space" />
                                    </a>
                                </td>
                            </tr>
                            <tr>
                                <th>Text <span class="required">*</span>
                                </th>
                                <td class="edit-field long" colspan="2"></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div id="inglese">
                    <table class="style1">
                        <thead>
                            <tr>
                                <th>Item
                                </th>
                                <th class="full">Value
                                </th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th>Text
                                </th>
                                <td class="edit-field long" colspan="2">
                                    <CKEditor:CKEditorControl CssClass="span12 ckeditor m-wrap" ID="FCKeditor1" runat="server"></CKEditor:CKEditorControl>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div id="tedesco">
                    <table class="style1">
                        <thead>
                            <tr>
                                <th>Item
                                </th>
                                <th class="full">Value
                                </th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <th>Text
                                </th>
                                <td class="edit-field long" colspan="2"></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="rule2">
                </div>
                <div class="form-field clear">
                    <asp:Button CausesValidation="false" ID="ButtonAnnulla" CssClass="button red fr"
                        runat="server" Text="ANNULLA" OnClick="ButtonAnnulla_Click" Style="margin-left: 10px;" />
                    <asp:Button ID="ButtonInsert" CssClass="button green fr" runat="server" Text="AGGIUNGI"
                        OnClick="ButtonInsert_Click" />
                    <asp:Button ID="ButtonAgg" CssClass="button blue fr" runat="server" Text="AGGIORNA"
                        OnClick="ButtonAgg_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
