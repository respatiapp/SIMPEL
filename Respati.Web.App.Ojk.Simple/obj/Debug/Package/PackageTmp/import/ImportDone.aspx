<%@ Page Title="" Language="C#" MasterPageFile="~/Simple.Master" AutoEventWireup="true" CodeBehind="ImportDone.aspx.cs" Inherits="Respati.Web.App.Ojk.Simple.import.ImportDone" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Import QPR Data</title>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" 
                Name="Telerik.Web.UI.Common.Core.js">
            </asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" 
                Name="Telerik.Web.UI.Common.jQuery.js">
            </asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" 
                Name="Telerik.Web.UI.Common.jQueryInclude.js">
            </asp:ScriptReference>
        </Scripts>
    </telerik:RadScriptManager>
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Import QPR Data</h1>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header" style="border-bottom:0">
                <small>Import data sukses dijalankan!</small>
            </h1>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <h4>
                Email terkirim ke pegawai-pegawai dibawah ini karena menggunakan IKU yang sudah tidak aktif lagi akibat dari proses import</h4>
            <telerik:RadGrid ID="RadGrid1" runat="server" Skin="Sunset" AutoGenerateColumns="false">
                <MasterTableView>
                    <Columns>
                        <telerik:GridBoundColumn DataField="NIP" HeaderText="NIP"></telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NM_PEG" HeaderText="Pegawai"></telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="EMAIL" HeaderText="Email"></telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="DESKRIPSI_IKU" HeaderText="IKU"></telerik:GridBoundColumn>
                    </Columns>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
    </div>

    </form>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FootContent" runat="server">
</asp:Content>
