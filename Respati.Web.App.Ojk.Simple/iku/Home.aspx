<%@ Page Title="" Language="C#" MasterPageFile="~/Simple.Master" AutoEventWireup="true"
    CodeBehind="Home.aspx.cs" Inherits="Respati.Web.App.Ojk.Simple.iku.home" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Pemantauan turunan IKU</title>
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
        
        .rgHeader
        {
            font-size: 14px;
            font-weight: bold !important;
        }
        .rgExpandCol
        {
            width: 20px !important;
        }
        
        table.rgMasterTable > tbody > tr
        {
            background-color: #f2f3f5;
        }
        table.rgMasterTable > tbody > tr > td
        {
            padding: 10px 20px 10px 0px;
            border: 1px solid #ededed;
        }
        table.rgMasterTable > tbody > tr.rgAltRow
        {
            color: #31708f !important;
            background-color: #d9edf7 !important;
        }
        table.rgMasterTable > tbody > tr.rgRow
        {
            background-color: initial;
        }
        
        table.rgDetailTable
        {
            border-right-width: 1px !important;
            border-color: #fff #fff transparent #fff !important;
        }
        table.rgDetailTable > tbody > tr > td:last-child
        {
            border-right-width: 0 !important;
        }
        table.rgDetailTable > tbody > tr.rgAltRow
        {
            color: #3c763d !important;
            background-color: #dff0d8 !important;
        }
        table.rgDetailTable > tbody > tr.rgRow
        {
            background-color: #fff;
        }
        table.rgDetailTable > thead > tr > th.rgHeader
        {
            color: #fff !important;
            background-color: #5cb85c !important;
            border-color: #4cae4c !important;
            background-image: none !important;
            font-size: 12px !important;
        }
        table.rgMasterTable > tbody > tr > td > button
        {
            color: #000;
            padding: 6px 12px;
        }
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
                Pemantauan turunan IKU</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div style="display: none">
                <label>
                    Pilih periode:
                </label>
                <telerik:RadComboBox ID="rdPeriode" EmptyMessage="[Pilih periode]" DataTextField="PERIODE"
                    runat="server" Width="300px" AutoPostBack="true" OnSelectedIndexChanged="rdPeriode_SelectedIndexChanged">
                </telerik:RadComboBox>
            </div>
            <label>
                Satuan Kerja:
            </label>
            <telerik:RadTextBox ID="rdtextDept" runat="server" LabelWidth="64px" Resize="None"
                ResolvedRenderMode="Classic" Width="160px" Visible="False">
            </telerik:RadTextBox>
            <telerik:RadComboBox ID="rdcmbDept" EmptyMessage="[Pilih departemen]" DataTextField="NAMA_SATKER"
                runat="server" OnClientSelectedIndexChanged="OnClientSelectedIndexChanged" Width="300px">
            </telerik:RadComboBox>
            <label>
                IKU:
            </label>
            <telerik:RadTextBox ID="rdtextIku" runat="server" Visible="False">
            </telerik:RadTextBox>
            <telerik:RadComboBox ID="rdcmbIKU" EmptyMessage="[Pilih IKU]" runat="server" Width="300px">
            </telerik:RadComboBox>
            <telerik:RadButton ID="RadButton1" runat="server" Text="Cari" OnClick="RadButton1_Click" >
            </telerik:RadButton>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <telerik:RadGrid ID="RadGrid1" runat="server" AutoGenerateColumns="false" Skin="Sunset"
                OnDetailTableDataBind="RadGrid1_DetailTableDataBind" OnNeedDataSource="RadGrid1_NeedDataSource"
                ItemStyle-VerticalAlign="Top" AlternatingItemStyle-VerticalAlign="Top" AllowPaging="True" OnColumnCreated="RadGrid1_OnColumnCreated"
                AllowSorting="True" ShowHeader="True" MasterTableView-AllowMultiColumnSorting="True" OnItemCreated="RadGrid1_OnItemCreated">
                <MasterTableView  DataKeyNames="ID_IKU">
                    <DetailTables>
                        <telerik:GridTableView AutoGenerateColumns="false" Name="DETAIL_PEGAWAI" DataKeyNames="NIP"
                            ItemStyle-VerticalAlign="Top">
                            <Columns>
                                <telerik:GridBoundColumn HeaderText="NIP" DataField="NIP" ItemStyle-Width="10%" HeaderStyle-Width="10%"
                                    ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" ShowFilterIcon="False">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Nama Pegawai" DataField="NM_PEG" ItemStyle-Width="15%"
                                    HeaderStyle-Width="15%" ShowFilterIcon="False" FilterControlWidth="100%">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="IKI" DataField="DESKRIPSI_IKI" ItemStyle-Width="30%"
                                    HeaderStyle-Width="30%" ShowFilterIcon="False" FilterControlWidth="100%">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Target" DataField="TARGET" ItemStyle-Width="20%"
                                    HeaderStyle-Width="20%" ShowFilterIcon="False" FilterControlWidth="100%">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Nilai Capaian" DataField="NILAI_CAPAIAN" ItemStyle-Width="5%"
                                    HeaderStyle-Width="5%" ShowFilterIcon="False" FilterControlWidth="100%">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="Range Capaian" DataField="RANGE_CAPAIAN" ItemStyle-Width="20%"
                                    HeaderStyle-Width="20%" ShowFilterIcon="False" FilterControlWidth="100%">
                                </telerik:GridBoundColumn>
                            </Columns>
                        </telerik:GridTableView>
                    </DetailTables>
                    <Columns>
                        <telerik:GridBoundColumn ShowFilterIcon="False" FilterControlWidth="100%" AutoPostBackOnFilter="True" HeaderText="Departemen" DataField="NAMA_SATKER">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn ShowFilterIcon="False" FilterControlWidth="100%" AutoPostBackOnFilter="True"  HeaderText="IKU" DataField="IKU_LENGKAP">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn ShowFilterIcon="False" FilterControlWidth="100%" AutoPostBackOnFilter="True"  HeaderText="Total" DataField="JUMLAH" ItemStyle-HorizontalAlign="Center">
                        </telerik:GridBoundColumn>
                        <telerik:GridTemplateColumn AllowFiltering="False" ItemStyle-Width="40px" HeaderStyle-Width="40px"
                            FilterControlAltText="Filter TemplateColumn column" UniqueName="TemplateColumn">
                            <ItemTemplate>
                                <button type="button" data-root='<%# Eval("KODE_SATKER") %>' data-kd-root='<%# Eval("HLEVEL") %>'
                                    data-idiku='<%# Eval("ID_IKU") %>' class="btnviewchart btn btn-default" data-toggle="tooltip"
                                    data-placement="top" title="Lihat hirarki">
                                    <span class="glyphicon glyphicon-zoom-in" aria-hidden="true"></span>
                                </button>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
                <ClientSettings>
                    <ClientEvents OnColumnClick="OnColumnClick"></ClientEvents>
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FootContent" runat="server">
    <script>
        $('.btnviewchart').on('click', function () {
            location.href = "Chart.aspx?kd=" + $(this).attr("data-root") + "&src=" + $(this).attr("data-kd-root") + "&id=" + $(this).attr("data-idiku")
        });

        function OnColumnClick(sender, args) {
            $(args.get_gridColumn()._element.childNodes[0]).trigger('click');

            /* old code
            var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
            masterTable.sort(args.get_gridColumn().get_uniqueName());
            */

        }
        function OnClientSelectedIndexChanged(sender, eventArgs) {
            var item = eventArgs.get_item();
            var cmb = $find("<%= rdcmbIKU.ClientID %>");
            cmb.set_text('');
            cmb.set_emptyMessage('[Pilih IKU]');

            $.postJSON("Home.aspx/GetIKUJSON", JSON.stringify({ nama_dept: item.get_text() }))
                        .success(function (data) {
                            fillCombo(cmb, data);
                        });
        }


        function pageLoad() {
            var cmbdept = $find("<%= rdcmbDept.ClientID %>");

            var selectedItem = cmbdept.get_text();
            if (selectedItem != '') {
                var cmb = $find("<%= rdcmbIKU.ClientID %>");
                $.postJSON("Home.aspx/GetIKUJSON", JSON.stringify({ nama_dept: selectedItem }))
                .success(function (data) {
                    fillCombo(cmb, data);
                   
                });
            }

        }

        function fillCombo(combo, result) {
            combo.clearItems();

            var items = $.parseJSON(result.d);
            for (var i = 0; i < items.length; i++) {
                var item = items[i];

                var comboItem = new Telerik.Web.UI.RadComboBoxItem();
                comboItem.set_text(item.DESKRIPSI_IKU);
                comboItem.set_value(item.DESKRIPSI_IKU);
                combo.get_items().add(comboItem);
            }
            
//            combo.refresh();
        } 
    </script>
</asp:Content>
