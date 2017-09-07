<%@ Page Language="C#" MasterPageFile="~/Simple.Master" AutoEventWireup="true" CodeBehind="RiwayatNotifikasi.aspx.cs"
    Inherits="Respati.Web.App.Ojk.Simple.HistoriNotifikasi" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI, Version=2015.1.401.40, Culture=neutral, PublicKeyToken=121fae78165ba3d4" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Riwayat Notifikasi</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form id="Form1" runat="server" class="sky-form">
    <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" ShowChooser="False" />
    <div>
        <h3>
            Riwayat Notifikasi</h3>
    </div>
    <div class="frame">
        <telerik:RadGrid ID="RadGrid1" runat="server" Skin="Sunset" GroupPanelPosition="Top"
            AllowSorting="True" ShowHeader="True" MasterTableView-AllowMultiColumnSorting="True"
            AllowPaging="True" OnDetailTableDataBind="RadGrid1_DetailTableDataBind" OnNeedDataSource="RadGrid1_NeedDataSource"
            ResolvedRenderMode="Classic" AutoGenerateColumns="False">
            <MasterTableView DataKeyNames="ID">
                <DetailTables>
                    <telerik:GridTableView AutoGenerateColumns="false" Name="DETAIL_PEGAWAI" DataKeyNames="HISTORY_ID"
                        ItemStyle-VerticalAlign="Top">
                        <ParentTableRelation>
                            <telerik:GridRelationFields DetailKeyField="HISTORY_ID" MasterKeyField="ID"></telerik:GridRelationFields>
                        </ParentTableRelation>
                        <Columns>
                            <telerik:GridBoundColumn HeaderText="Organisasi" DataField="NM_SATKER" ShowFilterIcon="False"
                                FilterControlWidth="100%" AutoPostBackOnFilter="True">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Email" DataField="RECIPIENT" ShowFilterIcon="False"
                                FilterControlWidth="100%" AutoPostBackOnFilter="True">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn HeaderText="Status Pengiriman" DataField="STATUS_EMAIL"
                                ShowFilterIcon="False" FilterControlWidth="100%" AutoPostBackOnFilter="True">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </telerik:GridTableView>
                </DetailTables>
                <Columns>
                    <telerik:GridBoundColumn DataField="TANGGAL" HeaderText="Tanggal" ShowFilterIcon="False"
                        FilterControlWidth="100%" AutoPostBackOnFilter="True">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TARGET_LEVEL" HeaderText="Target Level" ShowFilterIcon="False"
                        FilterControlWidth="100%" AutoPostBackOnFilter="True">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PERSENTASE" HeaderText="Persentase" ShowFilterIcon="False"
                        FilterControlWidth="100%" AutoPostBackOnFilter="True">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SEND_BY" HeaderText="Pembuat" ShowFilterIcon="False"
                        FilterControlWidth="100%" AutoPostBackOnFilter="True">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
            <ClientSettings EnableRowHoverStyle="true">
                <ClientEvents OnColumnClick="OnColumnClick"></ClientEvents>
                <Selecting AllowRowSelect="True"></Selecting>
            </ClientSettings>
        </telerik:RadGrid>
    </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FootContent" runat="server">
    <script>
        function OnColumnClick(sender, args) {
            
            $($('#' + sender.ClientID).val()).trigger('click');

//            return false;
//            var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
//            masterTable.sort(args.get_gridColumn().get_uniqueName());
        }
    </script>
</asp:Content>
