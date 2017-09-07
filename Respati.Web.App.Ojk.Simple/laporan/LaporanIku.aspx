<%@ Page Title="" Language="C#" MasterPageFile="~/Simple.Master" AutoEventWireup="true"
    CodeBehind="LaporanIku.aspx.cs" Inherits="Respati.Web.App.Ojk.Simple.Report.ReportIku" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Laporan Indikator Kinerja Individu</title>
    <style>
        .frame
        {
            overflow-x: scroll;
        }
        .btn-danger {
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
            <h1 class="page-header">Laporan Indikator Kinerja Individu</h1>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-12">
            <div style="margin-bottom: 37px">
                <div style="float:left">
                    Pilih periode:
                    <telerik:RadComboBox ID="rdPeriode" EmptyMessage="[Pilih periode]" DataTextField="PERIODE"
                        runat="server" Width="300px" AutoPostBack="true"
                        onselectedindexchanged="rdPeriode_SelectedIndexChanged">
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
                <telerik:RadGrid ID="RadGrid1" runat="server" Skin="Sunset" GroupPanelPosition="Top"
                    AllowSorting="True" ShowHeader="True" MasterTableView-AllowMultiColumnSorting="True"
                    OnNeedDataSource="grid_binding" AllowFilteringByColumn="True" OnColumnCreated="on_binding"
                    AllowPaging="True" OnItemCreated="on_itemcreated" OnHTMLExporting="RadGrid1_OnHTMLExporting"
                    OnPdfExporting="RadGrid1_OnPdfExporting" OnGridExporting="RadGrid1_OnGridExporting" OnExportCellFormatting="RadGrid1_OnExportCellFormatting">
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

        $('.rgFilterRow').on('keypress', function (e) {
            console.log($(this));
        });
        function doFilter(sender, e) {
            if (e.keyCode == 13) {
                e.cancelBubble = true;
                e.returnValue = false;
                if (e.stopPropagation) {
                    e.stopPropagation();
                    e.preventDefault();
                }
                var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();

                masterTable.filter("column_name", sender.value, Telerik.Web.UI.GridFilterFunction.Contains);
            }
        }
    </script>
</asp:Content>
