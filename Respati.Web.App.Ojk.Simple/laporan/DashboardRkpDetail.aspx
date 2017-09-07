<%@ Page Title="" Language="C#" MasterPageFile="~/Simple.Master" AutoEventWireup="true"
    CodeBehind="DashboardRkpDetail.aspx.cs" Inherits="Respati.Web.App.Ojk.Simple.laporan.DashboardRkpDetail" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Dashboard Cascading IKU - Pegawai yang belum mengambil RKP</title>
    <style>
        .btn-danger
        {
            background-color: #ab1a18;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js">
            </asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js">
            </asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js">
            </asp:ScriptReference>
        </Scripts>
    </telerik:RadScriptManager>
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">
                Dashboard Cascading IKU
                <div>
                    <h4>
                        Pegawai yang belum mengambil RKP</h4>
                </div>
            </h1>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div style="margin-bottom: 37px">
                <div style="display: none">
                    <label>
                        Pilih periode:
                    </label>
                    <telerik:RadComboBox ID="rdPeriode" EmptyMessage="[Pilih periode]" runat="server"
                        Width="300px" AutoPostBack="true" OnSelectedIndexChanged="rdPeriode_SelectedIndexChanged">
                    </telerik:RadComboBox>
                </div>
                <div style="float: right">
                    <button type="button" style="line-height: 1.3" class="btn btn-danger btn-sm " id="btnPDF"
                        value="PDF" runat="server" onserverclick="Export">
                        <i class="fa fa-file-pdf-o"></i>&nbsp;PDF
                    </button>
                    <button type="button" style="line-height: 1.3" class="btn btn-danger btn-sm " id="btnExcel"
                        value="Excel" runat="server" onserverclick="Export">
                        <i class="fa fa-file-excel-o"></i>&nbsp;Excel
                    </button>
                    <button type="button" style="line-height: 1.3" class="btn btn-danger btn-sm " id="btnDoc"
                        value="Doc" runat="server" onserverclick="Export">
                        <i class="fa fa-file-word-o"></i>&nbsp;Doc
                    </button>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="frame">
                <telerik:RadGrid ID="RadGrid1" runat="server" ResolvedRenderMode="Classic" Skin="Sunset"
                    AllowSorting="True" ShowHeader="True" MasterTableView-AllowMultiColumnSorting="True"
                    OnNeedDataSource="grid_binding" AllowFilteringByColumn="True" OnColumnCreated="on_binding"
                    AllowPaging="True" OnItemCreated="on_itemcreated" >
                    <MasterTableView AllowMultiColumnSorting="True">
                    </MasterTableView>
                    <SortingSettings></SortingSettings>
                    <ClientSettings>
                        <ClientEvents OnColumnClick="OnColumnClick"></ClientEvents>
                    </ClientSettings>
                    <ExportSettings ExportOnlyData="True">
                    </ExportSettings>
                </telerik:RadGrid>
            </div>
        </div>
    </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FootContent" runat="server">
    <script type="text/javascript">

        function OnColumnClick(sender, args) {
            var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
            masterTable.sort(args.get_gridColumn().get_uniqueName());
        }

    </script>
</asp:Content>
