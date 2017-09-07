<%@ Page Title="" Language="C#" MasterPageFile="~/Simple.Master" AutoEventWireup="true"
    CodeBehind="ImportQpr.aspx.cs" Inherits="Respati.Web.App.Ojk.Simple.ImportQpr" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Import QPR Data</title>
    <style>
        #loader
        {
            background: #FFF url("<%= Page.ResolveUrl("~/resources/images/ajax-loader.gif") %>") no-repeat scroll center center;
            height: 100%;
            width: 100%;
            position: fixed;
            z-index: 2147483647;
            left: 0%;
            top: 0%;
            margin: 0px;
        }
        
        .btn-sm
        {
            padding: 0px 10px;
        }
        h4
        {
            padding-bottom: 5px;
            border-bottom: 1px solid #eee;
        }
        .form-row
        {
            background-color: #fff;
            border: 1px solid #eee;
            padding-top: 15px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server" class="form-horizontal">
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
    <div id="loader" style="display: none;">
    </div>
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">
                Import QPR Data</h1>
        </div>
    </div>
    <div class="row form-row">
        <div class="col-lg-12">
            <div class="alert alert-danger alert-dismissable" id="modal-alert" style="display: none;">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">
                    QPR Model:</label>
                <div class="col-sm-10">
                    <telerik:RadComboBox ID="radComboModel" CssClass="form-control" runat="server" ResolvedRenderMode="Classic"
                        Width="50%" AutoPostBack="True" OnSelectedIndexChanged="radComboModel_SelectedIndexChanged">
                    </telerik:RadComboBox>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">
                    QPR Periode:</label>
                <div class="col-sm-10">
                    <telerik:RadComboBox ID="radComboPeriod" CssClass="form-control" runat="server" ResolvedRenderMode="Classic"
                        Width="50%" AutoPostBack="true" OnSelectedIndexChanged="radComboPeriod_SelectedIndexChanged">
                    </telerik:RadComboBox>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">
                    HRIS Periode:</label>
                <div class="col-sm-10">
                    <telerik:RadComboBox ID="radComboHrisPeriod" CssClass="form-control" runat="server"
                        ResolvedRenderMode="Classic" Width="50%" AutoPostBack="true" OnSelectedIndexChanged="radComboHrisPeriod_SelectedIndexChanged">
                    </telerik:RadComboBox>
                </div>
            </div>
            <div class="form-group">
                <label class="col-sm-2 control-label">
                </label>
                <div class="col-sm-10">
                    <telerik:RadButton ID="btnReload" runat="server" Text="Reset" ClientIDMode="Static"
                        OnClick="btnReload_Click">
                    </telerik:RadButton>
                    <telerik:RadButton ID="RadButton1" runat="server" Text="Tampilkan" ClientIDMode="Static"
                        OnClientClicking="Clicking" OnClick="RadButton1_Click">
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnImport" runat="server" Text="Impor data" ClientIDMode="Static"
                        OnClientClicking="ClickingImport" OnClick="btnImport_Click">
                    </telerik:RadButton>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            &nbsp;</div>
    </div>
    <div class="row form-row">
        <div class="form-group">
            <label class="col-sm-2 control-label" style="padding-top:0px">QPR Model:</label>
            <div class="col-sm-10"><asp:Label ID="lblModelName" runat="server" Text=""></asp:Label></div>
        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label" style="padding-top:0px">QPR Periode:</label>
            <div class="col-sm-10"><asp:Label ID="lblPeriodeName" runat="server" Text=""></asp:Label></div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            &nbsp;</div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <h4>
                Pemetaan Satuan Kerja</h4>
            <asp:CheckBox ID="chkShowEmpty" runat="server" AutoPostBack="True" OnCheckedChanged="chkShowEmpty_CheckedChanged"
                Text="Tampilkan hanya yang belum dipetakan" />
            <div class="frame">
                <telerik:RadGrid ID="RadGrid2" runat="server" Skin="Sunset" AutoGenerateColumns="false"
                    AllowPaging="true" OnNeedDataSource="RadGrid2_NeedDataSource">
                    <MasterTableView AllowMultiColumnSorting="True" >
                        <Columns>
                            <telerik:GridBoundColumn DataField="MEA_ID" HeaderText="SATKER QPR ID" ShowFilterIcon="False"
                                FilterControlWidth="100%" AutoPostBackOnFilter="True">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="NAMA_SATKER" HeaderText="NAMA SATKER QPR" ShowFilterIcon="False"
                                FilterControlWidth="100%" AutoPostBackOnFilter="True">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="KODE_SATKER" HeaderText="KODE UNIT HRIS" ShowFilterIcon="False"
                                FilterControlWidth="100%" AutoPostBackOnFilter="True">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="NAMA_UNIT" HeaderText="NAMA UNIT HRIS" ShowFilterIcon="False"
                                FilterControlWidth="100%" AutoPostBackOnFilter="True">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn>
                                <ItemTemplate>
                                    <button type="button" data-mid='<%# Eval("MEA_ID") %>' data-mname='<%# Eval("NAMA_SATKER") %>'
                                        data-kdunit='<%# Eval("KODE_SATKER") %>' data-toggle="modal" data-target="#modalUpdateUnit"
                                        class="btn btn-sm btn-danger" id="btnUpdate">
                                    Update</a>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                    <ClientSettings>
                        <ClientEvents OnColumnClick="OnRadGrid2ColumnClick"></ClientEvents>
                    </ClientSettings>
                </telerik:RadGrid>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            &nbsp;</div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <h4>
                QPR Data</h4>
            <div class="frame">
                <telerik:RadGrid ID="RadGrid1" runat="server" Skin="Sunset" AutoGenerateColumns="False"
                    GroupPanelPosition="Top" ResolvedRenderMode="Classic" AllowPaging="True" OnNeedDataSource="RadGrid1_NeedDataSource">
                    <MasterTableView AllowMultiColumnSorting="True" >
                        <Columns>
                            <telerik:GridBoundColumn DataField="MEA_ID" HeaderText="SATKER QPR ID" ShowFilterIcon="False"
                                FilterControlWidth="100%" AutoPostBackOnFilter="True">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="NAMA_SATKER" HeaderText="NAMA SATKER QPR" ShowFilterIcon="False"
                                FilterControlWidth="100%" AutoPostBackOnFilter="True">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="KODE_SATKER" HeaderText="KODE UNIT HRIS" ShowFilterIcon="False"
                                FilterControlWidth="100%" AutoPostBackOnFilter="True">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="NAMA_UNIT" HeaderText="NAMA UNIT HRIS" ShowFilterIcon="False"
                                FilterControlWidth="100%" AutoPostBackOnFilter="True">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="DESKRIPSI IKU" HeaderText="DESKRIPSI IKU" ShowFilterIcon="False"
                                FilterControlWidth="100%" AutoPostBackOnFilter="True">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="ID_IKU" HeaderText="ID IKU" ShowFilterIcon="False"
                                FilterControlWidth="100%" AutoPostBackOnFilter="True">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PERSPEKTIF" HeaderText="PERSPEKTIF" ShowFilterIcon="False"
                                FilterControlWidth="100%">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="SASARAN" HeaderText="SASARAN" ShowFilterIcon="False"
                                FilterControlWidth="100%" AutoPostBackOnFilter="True">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="TARGET" HeaderText="TARGET" ShowFilterIcon="False"
                                FilterControlWidth="100%" AutoPostBackOnFilter="True">
                            </telerik:GridBoundColumn>
                            <telerik:GridTemplateColumn Display="false">
                                <ItemTemplate>
                                    <button type="button" data-mid='<%# Eval("MEA_ID") %>' data-mname='<%# Eval("NAMA_SATKER") %>'
                                        data-kdunit='<%# Eval("KODE_SATKER") %>' data-toggle="modal" data-target="#modalUpdateUnit"
                                        class="btn btn-sm btn-danger" id="btnUpdate">
                                    Update</a>
                                </ItemTemplate>
                            </telerik:GridTemplateColumn>
                        </Columns>
                    </MasterTableView>
                    <ClientSettings>
                        <ClientEvents OnColumnClick="OnRadGrid1ColumnClick"></ClientEvents>
                    </ClientSettings>
                </telerik:RadGrid>
            </div>
        </div>
    </div>
    <input type="hidden" id="hPrevKdUnit" runat="server" clientidmode="Static" />
    <input type="hidden" id="hKode" runat="server" clientidmode="Static" />
    <div class="modal fade" id="modalUpdateUnit" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="display: none">
                        <span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="exampleModalLabel">
                        Update pemetaan unit</h4>
                </div>
                <div class="modal-body">
                    <div id="frmUpdateUnit" role="form" style="padding: 0px 15px">
                        <div class="form-group">
                            <label for="recipient-name" class="control-label">
                                ID SATKER QPR:</label>
                            <input type="text" class="form-control" id="mea_id">
                        </div>
                        <div class="form-group">
                            <label for="recipient-name" class="control-label">
                                NAMA SATKER QPR:</label>
                            <input type="text" class="form-control" id="mea_name">
                        </div>
                        <div class="form-group">
                            <label for="message-text" class="control-label">
                                HRIS UNIT:</label>
                            <telerik:RadComboBox ID="radComboUnit" runat="server" CssClass="form-control" Width="100%"
                                ClientIDMode="Static">
                            </telerik:RadComboBox>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" id="btnTutupModal">
                        Batal</button>
                    <button type="button" class="btn btn-primary" id="btnUpdateData" disabled>
                        Update</button>
                    <img id="imgloader" src="<%=Page.ResolveUrl("~/resources/images/ajax-loader.gif") %>"
                        style="display: none" />
                </div>
            </div>
        </div>
    </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FootContent" runat="server">
    <script>
        function Clicking(sender, args) {
            args.set_cancel(!window.confirm("Anda yakin mau melihat data QPR sesuai model dan periode terpilih?"));
        }

        function ClickingImport(sender, args) {
            args.set_cancel(!window.confirm("Anda yakin mau mengimpor data QPR?"));
        }

        $('#modalUpdateUnit').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget); // Button that triggered the modal
            var mea_id = button.data("mid"); // Extract info from data-* attributes
            var mea_name = button.data("mname");
            var kd_unit = button.data("kdunit");

            $('#btnUpdateData').prop('disabled', false);
            $('button').prop('disabled', false);
            $('#imgloader').hide();

            var modal = $(this)
            modal.find('.modal-body input#mea_id').val(mea_id);
            modal.find('.modal-body input#mea_name').val(mea_name);
            $('#hPrevKdUnit').val(kd_unit);
            $('#hKode').val(mea_id);

            if (kd_unit != null && kd_unit != "") {
                var dropdownlist = $find("<%= radComboUnit.ClientID %>");
                var item = dropdownlist.findItemByValue(kd_unit);
                item.select();
            }
        });

        $('#btnUpdateData').on('click', function (e) {
            __doPostBack('');
        });

        $('#btnTutupModal').on('click', function (e) {
            $("#hPrevKdUnit").val("");
            $('#hKode').val("");
            $("#modalUpdateUnit").modal("hide");
        });
        function OnRadGrid1ColumnClick(sender, args) {
            var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
            masterTable.sort(args.get_gridColumn().get_uniqueName());
        }
        function OnRadGrid2ColumnClick(sender, args) {
            var masterTable = $find("<%= RadGrid2.ClientID %>").get_masterTableView();
            masterTable.sort(args.get_gridColumn().get_uniqueName());
        }

    </script>
</asp:Content>
