<%@ Page Title="" Language="C#" MasterPageFile="~/Simple.Master" AutoEventWireup="true" CodeBehind="HomeHie.aspx.cs" Inherits="Respati.Web.App.Ojk.Simple.rkp.Home_hie" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>RKP - Pilih direktorat</title>
    <style>
        tbody > tr > td { padding:10px; }
        .rgDetailTable { border-right: 1px solid !important; }
        .rgHeader { background:initial !important; }
        
        .item-level1 { color:#31708f !important;background-color:#d9edf7 !important;border-color:#bce8f1 !important; }
        .item-level2 { color:#3c763d !important;background-color:#dff0d8 !important;border-color:#d6e9c6 !important; }
        .item-level3 { color:#8a6d3b !important;background-color:#fcf8e3 !important;border-color:#faebcc !important; }
        
        .head-level1 { color:#fff !important;background-color:#337ab7 !important;border-color:#2e6da4 !important; }
        .head-level2 { color:#fff !important;background-color:#5cb85c !important;border-color:#4cae4c !important; }
        .head-level3 { color:#fff !important;background-color:#f0ad4e !important;border-color:#eea236 !important; }

        div.RadProgressBar .rpbLabelWrapper { text-align: center !important; }
        div.RadProgressBar_Default { float:right; }
        div.RadProgressBar .rpbStateSelected:hover { background-color: #fff; }
        
        div.ProgressBar80 .rpbStateSelected
        ,div.ProgressBar80 .rpbStateSelected:hover { background-color: #337ab7 !important; border:none;}
        div.ProgressBar60 .rpbStateSelected
        ,div.ProgressBar60 .rpbStateSelected:hover { background-color: #5bc0de !important; border:none;}
        div.ProgressBar40 .rpbStateSelected
        ,div.ProgressBar40 .rpbStateSelected:hover { background-color: #5cb85c !important; border:none;}
        div.ProgressBar20 .rpbStateSelected
        ,div.ProgressBar20 .rpbStateSelected:hover { background-color: #f0ad4e !important; border:none;}
        div.ProgressBar0 .rpbStateSelected
        ,div.ProgressBar0 .rpbStateSelected:hover { background-color: #d9534f !important; border:none;}
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
    <asp:Label ID="mytrace" runat="server"></asp:Label>
        <div><h3>Status RKP</h3></div> 
        <label>Pilih bidang: </label>
        <telerik:RadComboBox ID="RadComboBox1" runat="server" Width="300px"
            DataValueField="KD_UNIT_ORG" DataTextField="NM_UNIT_ORG" 
            AutoPostBack="true" onselectedindexchanged="RadComboBox1_SelectedIndexChanged" >
        </telerik:RadComboBox>

        <telerik:RadGrid ID="RadGrid1" runat="server" AutoGenerateColumns="False" 
        onneeddatasource="RadGrid1_NeedDataSource" 
        OnDetailTableDataBind="RadGrid1_DetailTableDataBind" 
        GroupPanelPosition="Top" onitemdatabound="RadGrid1_ItemDataBound" 
        ResolvedRenderMode="Classic" >
            <MasterTableView DataKeyNames="KD_UNIT">
                <DetailTables>
                    <telerik:GridTableView AutoGenerateColumns="false" Name="Level3" DataKeyNames="KD_UNIT">
                        <DetailTables>
                            <telerik:GridTableView AutoGenerateColumns="false" Name="Level4" DataKeyNames="KD_UNIT">
                                <HeaderStyle CssClass="head-level3" />
                                <AlternatingItemStyle CssClass="item-level3" />
                                <Columns>
                                    <telerik:GridBoundColumn HeaderText=" " DataField="NM_UNIT"></telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Jumlah RKP" DataField="TOTAL_RKP">
                                        <HeaderStyle Width="40px" VerticalAlign="Middle" HorizontalAlign="Center" />
                                        <ItemStyle Width="40px" HorizontalAlign="Center" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Jumlah karyawan" DataField="TOTAL_EMPLOYEE">
                                        <HeaderStyle Width="65px" VerticalAlign="Middle" HorizontalAlign="Center" />
                                        <ItemStyle Width="65px" HorizontalAlign="Center" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn HeaderText="Persentase" DataField="PERSENTASE" DataFormatString="{0:0}" Display="false"></telerik:GridBoundColumn>
                                    <telerik:GridTemplateColumn AllowFiltering="False" ItemStyle-Width="170px" HeaderStyle-Width="170px" HeaderText="Progress">
                                        <HeaderStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                        <ItemTemplate>
                                            <telerik:RadProgressBar runat="server" ID="ProgressBar1" Width="160px">
                                            </telerik:RadProgressBar>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                    <telerik:GridTemplateColumn AllowFiltering="False" ItemStyle-Width="50px" HeaderStyle-Width="50px"
                                        FilterControlAltText="Filter TemplateColumn column" UniqueName="TemplateColumn">
                                        <ItemTemplate>
                                            <button type="button" data-root='<%# Eval("KD_UNIT") %>' data-kd-root='<%# Eval("LVL_UNIT") %>'
                                                class="btnviewchart btn btn-default" data-toggle="tooltip" data-placement="top" title="Lihat hirarki">
                                                <span class="glyphicon glyphicon-zoom-in" aria-hidden="true"></span>
                                            </button>
                                        </ItemTemplate>
                                    </telerik:GridTemplateColumn>
                                </Columns>
                            </telerik:GridTableView>
                        </DetailTables>
                        <HeaderStyle CssClass="head-level2" />
                        <AlternatingItemStyle CssClass="item-level2" />
                        <Columns>
                            <telerik:GridBoundColumn HeaderText=" " DataField="NM_UNIT"></telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Jumlah RKP" DataField="TOTAL_RKP">
                                <HeaderStyle Width="40px" VerticalAlign="Middle" HorizontalAlign="Center" />
                                <ItemStyle Width="40px" HorizontalAlign="Center" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Jumlah karyawan" DataField="TOTAL_EMPLOYEE">
                                <HeaderStyle Width="65px" VerticalAlign="Middle" HorizontalAlign="Center" />
                                <ItemStyle Width="65px" HorizontalAlign="Center" />
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Persentase" DataField="PERSENTASE" DataFormatString="{0:0}" Display="false"></telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn AllowFiltering="False" ItemStyle-Width="170px" HeaderStyle-Width="170px" HeaderText="Progress">
                                <HeaderStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                                <ItemTemplate>
                                    <telerik:RadProgressBar runat="server" ID="ProgressBar1" Width="160px">
                                    </telerik:RadProgressBar>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                            <telerik:GridTemplateColumn AllowFiltering="False" ItemStyle-Width="50px" HeaderStyle-Width="50px"
                                FilterControlAltText="Filter TemplateColumn column" UniqueName="TemplateColumn">
                                <ItemTemplate>
                                    <button type="button" data-root='<%# Eval("KD_UNIT") %>' data-kd-root='<%# Eval("LVL_UNIT") %>'
                                        class="btnviewchart btn btn-default" data-toggle="tooltip" data-placement="top" title="Lihat hirarki">
                                        <span class="glyphicon glyphicon-zoom-in" aria-hidden="true"></span>
                                    </button>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </telerik:GridTableView>
                </DetailTables>
                <HeaderStyle CssClass="head-level1" />
                <AlternatingItemStyle CssClass="item-level1" />
                <Columns>
                    <telerik:GridBoundColumn HeaderText=" " DataField="NM_UNIT"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Jumlah RKP" DataField="TOTAL_RKP">
                        <HeaderStyle Width="40px" VerticalAlign="Middle" HorizontalAlign="Center" />
                        <ItemStyle Width="40px" HorizontalAlign="Center" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Jumlah karyawan" DataField="TOTAL_EMPLOYEE">
                        <HeaderStyle Width="65px" VerticalAlign="Middle" HorizontalAlign="Center" />
                        <ItemStyle Width="65px" HorizontalAlign="Center" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Persentase" DataField="PERSENTASE" DataFormatString="{0:0}" Display="false"></telerik:GridBoundColumn>
                    <telerik:GridTemplateColumn AllowFiltering="False" ItemStyle-Width="170px" HeaderStyle-Width="170px" HeaderText="Progress">
                        <HeaderStyle VerticalAlign="Middle" HorizontalAlign="Center" />
                        <ItemTemplate>
                            <telerik:RadProgressBar runat="server" ID="ProgressBar1" Width="160px">
                            </telerik:RadProgressBar>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridTemplateColumn AllowFiltering="False" ItemStyle-Width="50px" HeaderStyle-Width="50px"
                        FilterControlAltText="Filter TemplateColumn column" UniqueName="TemplateColumn">
                        <ItemTemplate>
                            <button type="button" data-root='<%# Eval("KD_UNIT") %>' data-kd-root='<%# Eval("LVL_UNIT") %>'
                                class="btnviewchart btn btn-default" data-toggle="tooltip" data-placement="top" title="Lihat hirarki">
                                <span class="glyphicon glyphicon-zoom-in" aria-hidden="true"></span>
                            </button>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </form>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FootContent" runat="server">
    <script>
        $('.btnviewchart').on('click', function () {
            location.href = "Chart.aspx?kd=" + $(this).attr("data-root") + "&src=" + $(this).attr("data-kd-root");
        });
    </script>
</asp:Content>
