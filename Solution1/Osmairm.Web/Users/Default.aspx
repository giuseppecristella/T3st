﻿<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="Users.Default" %>

<asp:Content ID="ContentMenu" runat="server" ContentPlaceHolderID="cphAdminMenu">
    <li class="active"><a href="Default.aspx">Link Utili</a></li>
    <li><a href="Downloads.aspx">Downloads</a></li>
</asp:Content>
<asp:Content ID="ContentBody" runat="server" ContentPlaceHolderID="cphAdminBody">
    <div class="page-content">
        <!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
        <div id="portlet-config" class="modal hide">
            <div class="modal-header">
                <button data-dismiss="modal" class="close" type="button">
                </button>
                <h3></h3>
            </div>
            <div class="modal-body">
                <p>
                </p>
            </div>
        </div>
        <div class="container-fluid">
            <div class="row-fluid">
                <div class="span12">
                    <h3 class="page-title">Link utili
                    </h3>
                </div>
            </div>
            <div class="row-fluid">
                <div class="span12">
                    <div class="portlet box red">
                        <div class="portlet-title">
                            <h4>
                                <i class="icon-reorder"></i></h4>
                        </div>
                        <div class="portlet-body">
                            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                            <ul style="list-style: none">
                                <li>
                                    <a href="https://www.artera.it/webmail">Accedi alla Web Mail</a>
                                </li>
                                <li>
                                    <a href="http://www.google.it">Esempio di link, questo punta a Google</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
