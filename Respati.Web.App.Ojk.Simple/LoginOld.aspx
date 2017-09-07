<%@ Page Title="" Language="C#" MasterPageFile="~/Simple.Master" AutoEventWireup="true"
    CodeBehind="LoginOld.aspx.cs" Inherits="Respati.Web.App.Ojk.Simple.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Login</title>
    <style type="text/css">
        .alert-dismissable .close, .alert-dismissible .close { top: -10px; }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-lg-12">
            <div class="form login-form-2" >
                <div class="alert-danger" id="form-alert" style="display: none;">
                </div>

                <form id="frmLogin">
                    <h6>Masukkan Username dan password</h6>

                    <div class="form-group top bottom">
                        <input class="form-control" type="text" name="txtUsername" id="txtUsername">
                    </div>

                    <div class="form-group bottom">
                        <input class="form-control" type="password" name="txtPassword" id="txtPassword">
                    </div>

                    <footer class="form-wrap-2">
                        <button type="submit" class="btn btn-danger btn-lg btn-block">Login</button>
                        <img id="imgloader" src="<%=Page.ResolveUrl("~/resources/images/ajax-loader.gif") %>"
                            style="display: none" />
                    </footer>

                </form>
            </div>
        </div>
    </div>
    
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FootContent" runat="server">
    <script>
        var previousUrl = '<%= PreviousUrl %>';
        var data = {};
        var validate = function (param) {

            var message = '';
            if (param != undefined)
                message += '<li>' + param + '</li>';
            if ($('#txtUsername').val() == '')
                message += '<li>nama pengguna tidak boleh kosong</li>';
            if ($('#txtPassword').val() == '')
                message += '<li>kata sandi tidak boleh kosong</li>';

            if (message == '') {
                $('#form-alert').hide();
                $('#form-alert').html('');
                return true;
            } else {
                $('#form-alert').html('<ul>' + message + '</ul>');
                $('#form-alert').show();
                return false;

            }
        }

        $('#frmLogin').on('submit', function (e) {
            e.preventDefault();
            if (validate()) {
                $('#imgloader').show();
                $('button').prop('disabled', true);
                $.postJSON('Login.aspx/LoginMethod', JSON.stringify({ username: $('#txtUsername').val(), password: $('#txtPassword').val() }))
                    .done(function (data) {
                        var result = data.d;
                        if (result == '') {
                            alert("Anda telah berhasil login");
                            location.href = previousUrl;
                        } else {
                            validate("Nama pengguna atau kata sandi salah, silahkan coba lagi");
                        }
                    }).fail(function (xhr, status, error) {
                        console.log(xhr);
                        var err = $.parseJSON(xhr.responseText);
                        alert("Login gagal\r\n" + err.Message + '\n' + err.StackTrace);
                    }).always(function () {
                        $('button').prop('disabled', false);
                        $('#imgloader').hide();
                    });
            }
        });
    </script>
</asp:Content>
