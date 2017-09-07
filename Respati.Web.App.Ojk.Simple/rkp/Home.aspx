<%@ Page Title="" Language="C#" MasterPageFile="~/Simple.Master" AutoEventWireup="true"
    CodeBehind="Home.aspx.cs" Inherits="Respati.Web.App.Ojk.Simple.rkp.HomeTree" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Pemantauan status RKP</title>
    <style>
        .btn
        {
            background-color: transparent !important;
            border-color: transparent !important;
        }
        .btn:hover
        {
            border-color: #ccc !important;
            color: #000;
        }
        
        div.RadProgressBar .rpbLabelWrapper
        {
            text-align: center !important;
        }
        div.RadProgressBar_Default
        {
            float: right;
        }
        div.RadProgressBar .rpbStateSelected:hover
        {
            background-color: #fff;
        }
        
        div.ProgressBar80 .rpbStateSelected, div.ProgressBar80 .rpbStateSelected:hover
        {
            background-color: #337ab7 !important;
            border: none;
        }
        div.ProgressBar60 .rpbStateSelected, div.ProgressBar60 .rpbStateSelected:hover
        {
            background-color: #5bc0de !important;
            border: none;
        }
        div.ProgressBar40 .rpbStateSelected, div.ProgressBar40 .rpbStateSelected:hover
        {
            background-color: #5cb85c !important;
            border: none;
        }
        div.ProgressBar20 .rpbStateSelected, div.ProgressBar20 .rpbStateSelected:hover
        {
            background-color: #f0ad4e !important;
            border: none;
        }
        div.ProgressBar0 .rpbStateSelected, div.ProgressBar0 .rpbStateSelected:hover
        {
            background-color: #d9534f !important;
            border: none;
        }
        
        .rtlTable td
        {
            padding: 1px 5px !important;
            vertical-align: middle !important;
        }
        .rtlTable td button
        {
            color: #000;
            padding: 6px 12px;
        }
        
        .item-level1
        {
            color: #31708f !important;
            background-color: #d9edf7 !important;
            border-color: #bce8f1 !important;
            font-family: "Segoe UI" ,Arial,Helvetica,sans-serif;
            font-size: 16px;
            font-weight: bold;
        }
        .item-level2
        {
            color: #3c763d !important;
            background-color: #dff0d8 !important;
            border-color: #d6e9c6 !important;
            font-family: "Segoe UI" ,Arial,Helvetica,sans-serif;
            font-size: 14px;
        }
        .rtlA
        {
            color: #8a6d3b !important;
            background-color: #fcf8e3 !important;
            border-color: #faebcc !important;
        }
        
        /* tr[class^="item-level"] td  { border-bottom: 1px solid #fff !important; } */
        tr[class^="item-level"] td
        {
            border-left: 1px solid;
            border-bottom: 1px solid;
            border-color: #fff;
        }
        /*#ededed*/
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
                Pemantauan status RKP</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div style="display: none;">
                <label>
                    Pilih periode:
                </label>
                <telerik:RadComboBox ID="rdPeriode" EmptyMessage="[Pilih periode]" runat="server"
                    Width="300px" AutoPostBack="true" OnSelectedIndexChanged="rdPeriode_SelectedIndexChanged">
                </telerik:RadComboBox>
            </div>
            <label>
                Pilih bidang:
            </label>
            <telerik:RadComboBox ID="RadComboBox1" runat="server" AutoPostBack="true" DataValueField="KD_UNIT_ORG"
                DataTextField="NM_UNIT_ORG" Width="250px" ResolvedRenderMode="Classic" OnSelectedIndexChanged="RadComboBox1_SelectedIndexChanged">
            </telerik:RadComboBox>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <telerik:RadTreeList ID="RadTreeList1" runat="server" ShowTreeLines="false" AutoGenerateColumns="false"
                Skin="Sunset" DataKeyNames="KD_UNIT" ParentDataKeyNames="KD_PARENT" OnItemDataBound="RadTreeList1_ItemDataBound"
                OnNeedDataSource="RadTreeList1_NeedDataSource" AllowPaging="True" >
                <Columns>
                    <telerik:TreeListBoundColumn DataField="NM_UNIT" UniqueName="NM_UNIT_ORG" HeaderText="">
                    </telerik:TreeListBoundColumn>
                    <telerik:TreeListBoundColumn DataField="TOTAL_RKP" UniqueName="TOTAL_RKP" HeaderText="Jumlah RKP">
                        <HeaderStyle Width="65px" VerticalAlign="Middle" HorizontalAlign="Center" />
                        <ItemStyle Width="65px" HorizontalAlign="Center" />
                    </telerik:TreeListBoundColumn>
                    <telerik:TreeListBoundColumn DataField="TOTAL_EMPLOYEE" UniqueName="TOTAL_EMPLOYEE"
                        HeaderText="Jumlah Karyawan">
                        <HeaderStyle Width="65px" VerticalAlign="Middle" HorizontalAlign="Center" />
                        <ItemStyle Width="65px" HorizontalAlign="Center" />
                    </telerik:TreeListBoundColumn>
                    <telerik:TreeListTemplateColumn ItemStyle-Width="210px" HeaderStyle-Width="210px"
                        UniqueName="PROGRESSBAR">
                        <HeaderStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                        <ItemTemplate>
                            <telerik:RadProgressBar runat="server" ID="ProgressBar1" Width="160px" Height="22px">
                            </telerik:RadProgressBar>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                    <telerik:TreeListTemplateColumn>
                        <HeaderStyle Width="55px" />
                        <ItemStyle Width="55px" />
                        <ItemTemplate>
                            <button type="button" data-root='<%# Eval("KD_UNIT") %>' data-kd-root='<%# Eval("LVL_UNIT") %>'
                                class="btnviewchart btn btn-default" data-toggle="tooltip" data-placement="top"
                                title="Lihat hirarki">
                                <span class="glyphicon glyphicon-zoom-in" aria-hidden="true"></span>
                            </button>
                        </ItemTemplate>
                    </telerik:TreeListTemplateColumn>
                </Columns>
            </telerik:RadTreeList>
        </div>
    </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FootContent" runat="server">
    <script>
        $('.btnviewchart').on('click', function () {
            location.href = "Chart.aspx?kd=" + $(this).attr("data-root") + "&src=" + $(this).attr("data-kd-root");
        });
    </script>
</asp:Content>
