    <%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Simple.Master" CodeBehind="Setting.aspx.cs"
    Inherits="Respati.Web.App.Ojk.Simple.Setting" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Setting</title>
    <style>
        .sky-form .col .col
        {
            padding: 0px;
            margin: 0px;
            height: 39px;
        }
        .sky-form .row
        {
            height: 45px;
        }
        .sky-form input[type='checkbox']
        {
            padding-top: 10px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form runat="server">
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
    <div>
        <h3>
            Setting notifikasi</h3>
    </div>
    <div style="margin-bottom: 37px">
        <div style="float: right">
            <button type="button" style="line-height: 1.3" class="btn btn-info btn-sm " id="btnAdd">
                Add setting</button>
        </div>
    </div>
    <telerik:RadGrid ClientIDMode="Static" ID="RadGrid1" runat="server" CellSpacing="-1" Skin="Outlook"
        AutoGenerateColumns="False" GridLines="Both" GroupPanelPosition="Top" resolvedrendermode="Classic">
        <MasterTableView>
            <RowIndicatorColumn Visible="False">
            </RowIndicatorColumn>
            <Columns>
                <telerik:GridBoundColumn DataField="ID_SETTING" HeaderText="ID">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="NM_SETTING" HeaderText="Judul setting">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="NILAI_RKP" HeaderText="Nilai RKP">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="INTERVAL" HeaderText="Interval">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="TARGET_NOTIFIKASI" HeaderText="Target notifikasi">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="LAST_RUN" HeaderText="Terakhir dijalankan">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="CREATED_BY" HeaderText="Dibuat Oleh">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="CREATED_DATE" HeaderText="Tanggal buat">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="UPDATED_BY" HeaderText="Diubah oleh">
                </telerik:GridBoundColumn>
                
                <telerik:GridBoundColumn DataField="UPDATED_DATE" HeaderText="Tanggal update">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn DataField="IS_AKTIF" HeaderText="Status">
                </telerik:GridBoundColumn>
                
                
                <telerik:GridTemplateColumn HeaderText="Action">
                    <ItemTemplate>
                        <asp:LinkButton ClientIDMode="Static" runat="server" Text="Edit" ID="btnEdit" CssClass=".btnEdit"
                            OnClientClick='<%# String.Format("fnedit(\"{0}\");return false;", Eval("ID_SETTING"))%>' />
                        <asp:LinkButton ClientIDMode="Static" runat="server" Text="Hapus" ID="btnDelete"
                            CssClass=".btnDelete" OnClientClick='<%# String.Format("fndelete(\"{0}\");return false;", Eval("ID_SETTING"))%>' />
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
            </Columns>
        </MasterTableView>
    </telerik:RadGrid>
    </form>
    <form name="frmSetting" id="frmSetting" class="sky-form">
    <div id="myModal" class="modal fade " tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header .header">
                    <button type="button" class="close" data-dismiss="modal">
                        &times;</button>
                    <h4 class="modal-title">
                        <i class="fa fa-lg fa-calendar  "></i>&nbsp;<span id="header-title">Tambah setting</span>
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="alert alert-danger alert-dismissable" id="modal-alert" style="display: none;">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <fieldset>
                        <div class="row">
                            <label class="label col col-4">
                                Judul setting:
                            </label>
                            <div class="input col col-8">
                                <input type="text" class="form-control" autocomplete="off" id="txtJudul" maxlength="255" />
                            </div>
                        </div>
                        <div class="row ">
                            <label class="label col col-4">
                                Waktu pengiriman:</label>
                            <div class="input col col-8">
                                <div class="col col-6" style="display: inline">
                                    <input type="text" id="txtWaktuPengiriman" style="display: inline;" />
                                </div>
                                <div class="col col-6 " style="display: inline">
                                    <select id="cmbSatuanWaktu" class="form-control" style="display: inline; height: 39px;
                                        border-radius: 0px; -webkit-appearance: none;">
                                        <option value="1">Hari</option>
                                        <option value="2">Bulan</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <label class="label col col-4">
                                Batas minimal RKP(%):</label>
                            <div class="input col col-8">
                                <input type="text" class="form-control" id="txtNilaiRKP" style="padding-left: 5px;">
                            </div>
                        </div>
                        <div class="row">
                            <label class="label col col-4">
                                Level target pemberitahuan</label>
                            <div class="col col-8 .checkbox-inline">
                                <input type="checkbox" class="chk-notif-level" id="chkKepalaDept" />
                                Kepala Departement
                                <br />
                                <input type="checkbox" class="chk-notif-level" id="chkDirektur" />
                                Direktur
                                <br />
                                <input type="checkbox" class="chk-notif-level" id="chkDeputyDirektur" />
                                Deputi Direktur
                                <br />
                                <input type="checkbox" class="chk-notif-level" id="chkKabag" />
                                Kepala Bagian
                                <br />
                            </div>
                        </div>
                        <div class="row">
                            <label class="label col col-4" style="padding-top:0px">
                                Status scheduler</label>
                            <div class="col col-8">
                                <input type="checkbox" id="chkActive" />
                                Aktif
                            </div>
                        </div>
                    </fieldset>
                </div>
                <div class="modal-footer">
                    <div class="fright">
                        <button type="button" class="button" id="btnSave">
                            Simpan</button>
                        <img id="imgloader" src="<%=Page.ResolveUrl("~/resources/images/ajax-loader.gif") %>"
                            style="display: none" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FootContent" runat="server">
    <script type="text/javascript">
        var SettingList = <%= ListSetting %>;
        var Setting = <%= Scheduler %> || [];

        if (Setting.length > 0) {
            $('#txtJudul').val(Setting[0].NM_SETTING);
            $('#txtWaktuPengiriman').val(Setting[0].INTERVAL);
            $('#cmbSatuanWaktu').val(Setting[0].INTERVAL_TYPE);
            $('#txtNilaiRKP').val(Setting[0].NILAI_RKP);
            $('#chkActive').prop('checked', Setting[0].IS_AKTIF);
            $('#chkKepalaDept').prop('checked', Setting[0].IS_KEPALA_DEPARTEMENT);
            $('#chkDirektur').prop('checked', Setting[0].IS_DIREKTUR);
            $('#chkDeputyDirektur').prop('checked', Setting[0].IS_DEPUTY_DIREKTUR);
            $('#chkKabag').prop('checked', Setting[0].IS_KEPALA_BAGIAN);
        }
        $('#txtWaktuPengiriman').on('keydown', function(e) {
            if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110]) !== -1 ||
                // Allow: Ctrl+A, Command+A
                (e.keyCode == 65 && (e.ctrlKey === true || e.metaKey === true)) ||
                // Allow: home, end, left, right, down, up
                (e.keyCode >= 35 && e.keyCode <= 40)) {
                // let it happen, don't do anything
                return;
            }
            // Ensure that it is a number and stop the keypress
            if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                e.preventDefault();
            }
        });
        $('#txtNilaiRKP').on('keydown', function(e) {
            if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 190, 110, 188]) !== -1 ||
                // Allow: Ctrl+A, Command+A
                (e.keyCode == 65 && (e.ctrlKey === true || e.metaKey === true)) ||
                // Allow: home, end, left, right, down, up
                (e.keyCode >= 35 && e.keyCode <= 40)) {
                // let it happen, don't do anything
                return;
            }
            // Ensure that it is a number and stop the keypress
            if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                e.preventDefault();
            }
        });

        var data = {};
        var notif_level = function() {
            var selected = [];
            $('.chk-notif-level').each(function(row, data) {
                var obj = {};
                obj.name = 'test' + row;
                obj.val = $('#' + $(data).attr('id')).prop('checked');
                selected.push(obj);
            });
            return selected;
        }
        var Validate = function() {
            var message = '';

            if (data.NamaSetting == '') message += '<li>' + 'Judul setting tidak boleh kosong' + '</li>'; 
            if (data.Interval <= 0) message += '<li>' + 'Waktu pengiriman tidak boleh kosong' + '</li>'; 
            if (data.MinimalRKP < 0 || data.MinimalRKP > 100 || data.MinimalRKP == '')
                message += '<li>' + 'Batas minimal RKP tidak boleh kurang dari nol atau melebihi seratus persen' + '</li>';
            if (!checkTarget())
                message += '<li>' + 'Pilih satu atau lebih, target pemberitahuan ' + '</li>';

            if (message == '') {
                $('#modal-alert').hide();
                $('#modal-alert').html('');
                return true;
            } else {
                $('#modal-alert').html('<ul>' + message + '</ul>');
                $('#modal-alert').show();
                return false;

            }

        };

        var checkTarget = function() {
            var result = false;
            $('.chk-notif-level').each(function(row, data) {
                if ($(data).prop('checked')) {
                    result = true;
                }
            });
            return result;
        };
        $('#btnAdd').on('click', function(e) {
            showModalForm('');
            $('#myModal').modal('show');
        });
        function showModalForm(id) {
            if (id == '') {
                $('#header-title').text('Tambah setting');
                bindingModal({});
            } else {
                $('#header-title').text('Edit setting');
                $.postJSON('Setting.aspx/GetSetting', JSON.stringify({ 'id': id })).success(function (msg) {
                    Setting = $.parseJSON(msg.d);
                    bindingModal(Setting[0]);
                });
            }
 

        }

        function bindingModal(data) {
            $('#txtJudul').val(data.NM_SETTING || '');
            $('#txtWaktuPengiriman').val(data.INTERVAL || '');
            $('#cmbSatuanWaktu').val(data.INTERVAL_TYPE || '');
            $('#txtNilaiRKP').val(data.NILAI_RKP || '');
            $('#chkActive').prop('checked',data.IS_AKTIF || '');
            $('#chkKepalaDept').prop('checked', data.IS_KEPALA_DEPARTEMENT || false);
            $('#chkDirektur').prop('checked', data.IS_DIREKTUR || false);
            $('#chkDeputyDirektur').prop('checked', data.IS_DEPUTRY_DIREKTUR || false);
            $('#chkKabag').prop('checked', data.IS_KEPALA_BAGIAN || false);

        }

        function fndelete(id) {
            $.postJSON('Setting.aspx/Remove', JSON.stringify({ 'id': id }))
            .success(function (data) {
                var result = $.parseJSON( data.d);
                if (result.message == '') {
                    alert('Setting telah berhasil dihapus.');
                    location.href = '';
                } else {
                    alert(result);
                }

            });
        }

        function fnedit(id) {
            showModalForm(id);
            $('#myModal').modal('show');            
        }
        $('#btnSave').on('click', function(e) {
           
            data = {};
            data.SettingID = Setting.length > 0 ? Setting[0].ID_SETTING : 0;
            data.NamaSetting = $('#txtJudul').val();
            data.Interval = $('#txtWaktuPengiriman').val();
            data.IntervalType = $('#cmbSatuanWaktu').val();
            data.MinimalRKP = $('#txtNilaiRKP').val();
            data.IsActive = $('#chkActive').prop('checked');
            data.IsKepalaDepartement = $('#chkKepalaDept').prop('checked');
            data.IsDirektur = $('#chkDirektur').prop('checked');
            data.IsDeputyDirektur = $('#chkDeputyDirektur').prop('checked');
            data.IsKaBag = $('#chkKabag').prop('checked');


            if (Validate()) {
                var url = 'Setting.aspx/Save';
                $.postJSON(url, JSON.stringify({ "data": JSON.stringify(data) }))
                    .done(function(msg) {
                        var result = $.parseJSON(msg.d);
                        if (result.isSuccess) {
                            alert('Success menyimpan data');
                            location.href = '';
                        } else {
                            alert(result.message);
                        }
                    }).fail(function(xhr, status, error) {
                        console.log(xhr);
                        var err = $.parseJSON(xhr.responseText);
                        alert("Login gagal\r\n" + err.Message + '\n' + err.StackTrace);
                    }).always(function() {
                        $('button').prop('disabled', false);
                        $('#imgloader').hide();
                    });

            }

        });


    </script>
</asp:Content>
