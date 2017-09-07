<%@ Page Title="" Language="C#" MasterPageFile="~/Simple.Master" AutoEventWireup="true"
    CodeBehind="UserManagement.aspx.cs" Inherits="Respati.Web.App.Ojk.Simple.UserManagement" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Pengelolaan Pengguna</title>
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    </telerik:RadCodeBlock>
    <style>
        /*
         .sky-form .modal {
             padding: auto;
             margin: auto;
         }
         */
        .sky-form .modal .row
        {
            margin: 0px -15px 10px;
        }
        .typeahead
        {
            width: 93%;
        }
        .typeahead .dropdown-menu
        {
            width: 95%;
        }
        .alert-dismissable .close, .alert-dismissible .close
        {
            top: -10px;
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
<%--        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js">
            </asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js">
            </asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js">
            </asp:ScriptReference>
        </Scripts>--%>
    </telerik:RadScriptManager>
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">
                Pengelolaan Pengguna</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div style="margin-bottom: 37px">
                <div style="float: left; display: none">
                    <label>
                        Pilih Kelompok Pengguna:
                    </label>
                    <telerik:RadComboBox ID="RadComboBox1" ClientIDMode="Static" runat="server" AutoPostBack="true"
                        Width="250px" OnSelectedIndexChanged="RadComboBox1_SelectedIndexChanged">
                    </telerik:RadComboBox>
                </div>
                <div style="float: right">
                    <button type="button" style="line-height: 1.3" class="btn btn-danger btn-sm " id="btnAdd">
                        Tambah pengguna</button>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <telerik:RadGrid ID="RadGrid1" runat="server" CellSpacing="-1"
                Skin="Sunset" AutoGenerateColumns="False" GridLines="Both" GroupPanelPosition="Top"
                ResolvedRenderMode="Classic" AllowFilteringByColumn="True"  OnNeedDataSource="RadGrid1_NeedDataSource">
                <MasterTableView>
                    <RowIndicatorColumn Visible="False">
                    </RowIndicatorColumn>
                    <Columns>
                        <telerik:GridBoundColumn DataField="NIP" HeaderText="NIP" FilterControlWidth="100%"
                            AutoPostBackOnFilter="True" ShowFilterIcon="False">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NM_PEG" HeaderText="Nama Pegawai" FilterControlWidth="100%"
                            AutoPostBackOnFilter="True" ShowFilterIcon="False">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="Username" HeaderText="Email" FilterControlWidth="100%"
                            AutoPostBackOnFilter="True" ShowFilterIcon="False">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="RoleName" HeaderText="Kelompok Pengguna" FilterControlWidth="100%"
                            AutoPostBackOnFilter="True" ShowFilterIcon="False">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="NM_UNIT_ORG" HeaderText="Penugasan" FilterControlWidth="100%"
                            AutoPostBackOnFilter="True" ShowFilterIcon="False">
                        </telerik:GridBoundColumn>
                        <telerik:GridBoundColumn DataField="CreationDate" HeaderText="Tanggal dibuat" FilterControlWidth="100%"
                            AutoPostBackOnFilter="True" ShowFilterIcon="False">
                        </telerik:GridBoundColumn>
                        <%--                       <telerik:GridTemplateColumn DataField="UserId" HeaderText="Is Online" >
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# (Convert.ToBoolean(Membership.GetUser( Eval("UserId")).IsOnline) ? "Ya" : "Tidak") %>'></asp:Label>
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
\--%>
                        <telerik:GridBoundColumn DataField="LastActivityDate" HeaderText="Terakhir Login"
                            FilterControlWidth="100%" AutoPostBackOnFilter="True" ShowFilterIcon="False">
                        </telerik:GridBoundColumn>
                        <telerik:GridTemplateColumn HeaderText="Action" AllowFiltering="False">
                            <ItemTemplate>
                                <asp:LinkButton ClientIDMode="Static" runat="server" Text="Ubah" ID="btnEdit" CssClass=".btnEdit"
                                    OnClientClick='<%# String.Format("showModalForm(\"{0}\");return false;", Eval("Username"))%>' />
                                <asp:LinkButton ClientIDMode="Static" runat="server" Text="Hapus" ID="btnDelete"
                                    CssClass=".btnDelete" OnClientClick='<%# String.Format("fndelete(\"{0}\",\"{1}\",\"{2}\",\"{3}\",\"{4}\");return false;", Eval("Username"), Eval("UserId"), Eval("NIP"), Eval("RoleId"), Eval("RoleName"))%>' />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
                <ClientSettings>
                    <ClientEvents  OnColumnClick="OnColumnClick"></ClientEvents>
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>
    </form>
    <form name="frmUser" id="frmUser" class="sky-form">
    <div id="myModal" class="modal fade " tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header .header">
                    <button type="button" class="close" data-dismiss="modal">
                        &times;</button>
                    <h4 class="modal-title">
                        <i class="fa fa-lg fa-user"></i>Tambah pengguna
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="alert alert-danger alert-dismissable" id="modal-alert" style="display: none;">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <input type="hidden" id="inputtype" />
                    <div role="form" class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-4 control-label">
                                Pilih pegawai:</label>
                            <div class="col-sm-8">
                                <input type="text" name="txtPegawai" id="txtPegawai" autocomplete="off" class="form-control" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-4 control-label">
                                Kelompok pengguna:</label>
                            <div class="col-sm-8">
                                <select id="cmbRole" class="form-control">
                                </select>
                            </div>
                        </div>
                        <div id="satuan_kerja" class="form-group" style="display: none">
                            <label class="col-sm-4 control-label">
                                Penugasan:</label>
                            <div class="col-sm-8">
                                <select id="cmbDepartement" class="form-control">
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-4 control-label">
                                Email:</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" name="username" id="txtUsername" autocomplete="off" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-4 control-label">
                                Jabatan:</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control disabled" readonly="readonly" disabled="true"
                                    id="txtJabatan" autocomplete="off" />
                            </div>
                        </div>
                    </div>
                    <!--
                    <fieldset>
                        <div class="pwd row" style="display: none;">
                            <label class="label col col-4">
                                Kata sandi:</label>
                            <div class="input col col-8">
                                <input type="password" name="password" id="txtPassword" autocomplete="off" />
                            </div>
                        </div>
                        <div class="pwd row" style="display: none">
                            <label class="label col col-4">
                                Ulangi:</label>
                            <div class="input col col-8">
                                <input type="password" name="repassword" class="form-control" id="txtRePassword"
                                    autocomplete="off" />
                            </div>
                        </div>
                    </fieldset>
                        -->
                </div>
                <div class="modal-footer">
                    <div class="fright">
                        <button type="button" class="btn btn-sm btn-danger" id="btnSave">
                            Simpan</button>
                        <img id="imgloader" src="<%=Page.ResolveUrl("~/resources/images/ajax-loader.gif") %>"
                            style="display: none" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    </form>
    <form class="sky-form">
    <div id="confirm" class="modal fade" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    Konfimasi penghapusan
                </div>
                <div class="modal-body">
                    Anda yakin ingin menghapus pengguna?
                </div>
                <div class="modal-footer">
                    <button type="button" data-dismiss="modal" class="btn btn-danger" id="delete">
                        Ya</button>
                    <button type="button" data-dismiss="modal" class="btn">
                        Batal</button>
                </div>
            </div>
        </div>
    </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FootContent" runat="server">
    <script>
        function OnColumnClick(sender, args) {
            var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
            masterTable.sort(args.get_gridColumn().get_uniqueName());
        }
        
        var user = {};
        var listDepartement = <%= ListDepartement %> || [];
        var listEmployee = <%= ListEmployee %> || [];
        var listRole = <%= ListRole %> || [];
        var selectedUser = {};

       
        function validateEmail(email) {
            var re = /^([0-9a-zA-Z]([-_\\.]*[0-9a-zA-Z]+)*)@([0-9a-zA-Z]([-_\\.]*[0-9a-zA-Z]+)*)[\\.]([a-zA-Z]{2,9})$/;
            return re.test(email);
        }

        var Validate = function () {
            var result = false;
            var message = ''
            var inputtype = $('#inputtype').val();

            if (user.username == '') message += '<li>Email tidak boleh kosong</li>';
            //if (user.password == '' && inputtype == "NEW") message += '<li>Kata sandi tidak boleh kosong</li>';
            //if (user.password != user.repassword && inputtype == "NEW") message += '<li>Kata sandi tidak sama</li>';
            //if (user.emailn == '') message += '<li>email tidak boleh kosong</li>';
            if (message == '') {
                if (!validateEmail($('#txtUsername').val())) message += '<li>Format email salah</li>';
            }
            if (message == '') {
                $('#modal-alert').hide();
                $('#modal-alert').html('');
                
                return true;
            }
           
            else {
                $('#modal-alert').html('<ul>' + message + '</ul>');
                $('#modal-alert').show();
                return false;
            }
        };


        $('#btnAdd').on('click', function(e) {
            showModalForm('');
            $('#myModal').modal('show');
        });
        function showModalForm(username) {
            if (username == '') {
                user = {};
                $('#inputtype').val("NEW");
                $('#txtUsername').val('').prop('disabled', false);
                $('#txtUsername').data('is_edit',false);
                $('#txtEmail').val('');
                $('#txtPassword').val('');
                $('#txtRePassword').val('');
                $('#cmbRole').val('admin');
                $('#cmbDepartement').val('');
                $('#satuan_kerja').hide();
                $('#txtPegawai').val('');
                $('#txtPegawai').attr('data-kd_unit_org','');
                $('#txtPegawai').attr('data-email','');
                $('#txtPegawai').attr('data-nip','');

                $('.pwd').show();
            } else {
                $.postJSON('Usermanagement.aspx/GetUser', JSON.stringify({ 'username': username })).success(function (data) {
                    var result = $.parseJSON(data.d);
                    $('#inputtype').val("EDIT");
                    $('#txtUsername').val(result[0].UserName);
                    $('#txtUsername').data('is_edit',true);
                    $('#txtUsername').data('oldUsername', result[0].UserName);
                    $('.pwd').hide();
                    $('#txtEmail').val(result[0].Email);
                    $('.modal-title').text('Ubah pengguna');
                    $('#cmbDepartement').val(result[0].DEPARTEMENT_ID);
                    $('#cmbRole').val(result[0].RoleName);
                    $('#txtJabatan').val(result[0].NM_JABATAN);
                    $('#txtPegawai').val(result[0].NM_PEG);
                    if (result[0].RoleName == "MIA") {
                        $('#satuan_kerja').show();
                    }else {
                        $('#satuan_kerja').hide();
                    }
                    selectedUser = result[0].NIP;
                    $("#myModal").modal('toggle');
                });
            }
            $('#cmbDepartement').addOption(listDepartement, "NM_UNIT_ORG","KD_UNIT_ORG" );


        }
        function fndelete(username, userid, nip, roleid, role_name) {
            // alert here
            $('#confirm').modal({ backdrop: 'static', keyboard: false })
                .one('click', '#delete', function() {
                    $.postJSON('Usermanagement.aspx/Remove', JSON.stringify({ 'username': username, 'nip': nip, 'user_id': userid, 'roleid': roleid, "role_name": role_name }))
                        .success(function (data) {
                            var result = data.d;
                            if (result == '') {
                                alert('Pengguna telah berhasil di hasil di hapus');
                                location.href = '';
                            } else {
                                alert(result);
                            }

                        });
                });
           
        }

        $('#btnSave').on('click', function (e) {
            user.username = $('#txtUsername').val();
            user.password = 'admin' //$('#txtPassword').val();
            user.email =  $('#txtUsername').val(); //$('#txtPegawai').data('email');
            user.isEdit = $('#txtUsername').data('is_edit');
            user.oldEmail = $('#txtUsername').data('oldUsername') || '';
            user.repassword = 'admin'// $('#txtRePassword').val();
            user.role = $('#cmbRole').val();
            user.departementId = user.role.toLowerCase() == "mia" ? $('#cmbDepartement').val() : "";
            user.nip = selectedUser;
            user.kd_unit_org = user.role.toLowerCase() == "mia" ? $('#cmbDepartement').val() : "";

            if (Validate()) {
                $('button').prop('disabled', true);
                $('#imgloader').show();
                $.postJSON('Usermanagement.aspx/Add', JSON.stringify(user))
                    .success(function (data) {
                        var result = data.d;
                        if (result == '') {
                            if (!user.isEdit)
                                alert('Penambahan pengguna berhasil');
                            else 
                                alert('Perubahan data pengguna berhasil');

                            location.href = '';
                        } else {
                            alert(result);
                        }
                    }).fail(function (xhr, status, error) {
                        console.log(xhr);
                        var err = $.parseJSON(xhr.responseText);
                        alert("Gagal menyimpan data\r\n" + err.Message + '\n' + err.StackTrace);
                    }).always(function () {
                        $('button').prop('disabled', false);
                        $('#imgloader').hide();
                    });

            }
        });
        $('#cmbRole').addOption(listRole);

        $('#txtPegawai').typeahead({
            minLength: 1,
            source: function(query, process) {               
                $('#imgloader').show();
                var kd_unit_org = $('#cmbDepartement').val();
                return $.postJSON("UserManagement.aspx/GetPegawai", JSON.stringify({
                    nama: query, kd_unit_org: kd_unit_org
                })).done(function(data) {
                    listEmployee = $.parseJSON(data.d);
                    arr = [];
                    $.each(listEmployee, function(row, data) {
                        arr.push(data.NM_PEG);
                    });
                    process(arr);
                }).fail(function (xhr, status, error) {
                    console.log(xhr);
                    var err = $.parseJSON(xhr.responseText);
                    alert("Gagal mendapat data pegawai\r\n" + err.Message + '\n' + err.StackTrace);
                }).always(function () {
                    $('#imgloader').hide();
                });;  
            },
            updater: function(item) {                      
                selectedUser = '';
                $.each(listEmployee,function(row,data) {
                    if (data.NM_PEG == item) {
                        selectedUser = data.NIP;
                        $('#txtUsername').val(data.EMAIL);
                        $('#txtPegawai').attr('data-email', data.EMAIL);
                        $('#txtPegawai').attr('data-NIP', data.NIP);
                        $('#txtPegawai').attr('data-KD_UNIT_ORG', data.KD_UNIT_ORG);
                        $('#txtDepartement').val(data.NM_UNIT_ORG);
                        $('#txtJabatan').val(data.NM_JABATAN);

                        checkCurrentEmail();

                        $('#txtUsername').trigger('blur');

                    }
                });
                if (selectedUser != '')
                    return item;
                else 
                    return '';
            }
        });
        $('#txtPegawai').on('focusout', function() {
            if (selectedUser == '')
                $(this).val('');
        });

        function checkCurrentEmail() {
            var text = $('#txtUsername');
            if (text.val().trim() == '') {
                text.prop('disabled', false);
                text.prop('readonly', false);
            } else {
                text.prop('disabled', true);
                text.prop('readonly', true);
            }
        }

        function checkEmailExist(email, nip) {
        }
        $('#cmbRole').on('change', function() {
            var val = $(this).val();
            if (val.toLowerCase() == 'mia') {
                $('#satuan_kerja').show();
            } else {
                $('#satuan_kerja').hide();
            }
        });

        function ValEmail(email) {


        }

        $('#txtUsername').on('blur', function() {
            ValEmail($(this).val());
        });

        $('#txtUsername').on('change', function() {
            //ValEmail($(this).val());
        });
    </script>
</asp:Content>
