<%@ Page Title="" Language="C#" MasterPageFile="~/Simple.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="Respati.Web.App.Ojk.Simple.laporan.dashboard" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Dashboard Cascading IKU</title>
    <style>
        #RadRadialGauge1, #RadRadialGauge2 { cursor: pointer; }
    </style>
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
            <h1 class="page-header">Dashboard Cascading IKU</h1>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-6">
            <div class="panel panel-primary">
                <div class="panel-heading"><h4>Pegawai yang sudah mengambil RKP</h4></div>
                <div class="panel-body">
                    <telerik:RadRadialGauge ID="RadRadialGauge1" runat="server" ClientIDMode="Static"
                        ResolvedRenderMode="Classic" Skin="Sunset" Height="300px">
                    </telerik:RadRadialGauge>
                </div>
                <div class="panel-footer"><p class="text-center">Persentase: 
                    <asp:Label ID="lblGaugeRkp" runat="server" Text=""></asp:Label>%</p></div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="panel panel-primary">
                <div class="panel-heading"><h4>IKU yang sudah diturunkan</h4></div>
                <div class="panel-body">
                    <telerik:RadRadialGauge ID="RadRadialGauge2" runat="server" ClientIDMode="Static"
                        ResolvedRenderMode="Classic" Skin="Sunset" Height="300px">
                    </telerik:RadRadialGauge>
                </div>
                <div class="panel-footer"><p class="text-center">Persentase: 
                    <asp:Label ID="lblGaugeIku" runat="server" Text=""></asp:Label>%</p></div>
            </div>
        </div>
    </div>
    </form>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FootContent" runat="server">
<script>
    $('#RadRadialGauge1').on('click', function (e) {
        location.href = "DashboardRkpDetail.aspx";
    });
    $('#RadRadialGauge2').on('click', function (e) {
        location.href = "DashboardIkuDetail.aspx";
    });
    Sys.Application.add_load(function () {
        telerikDemo.rkpGauge = $find("<%=RadRadialGauge1.ClientID %>");
    });
</script>
</asp:Content>
