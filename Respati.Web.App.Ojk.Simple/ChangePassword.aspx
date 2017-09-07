<%@ Page Title="" Language="C#" MasterPageFile="~/Simple.Master" AutoEventWireup="true"
    CodeBehind="ChangePassword.aspx.cs" Inherits="Respati.Web.App.Ojk.Simple.ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Ubah Kata Sandi</title>
    <style>
        .form
        {
            margin: 20px auto 0px;
            padding: 20px 35px 13px;
            background-color: #F9F9F9;
        }
        .sky-form button
        {
            padding: 0px 10px;
            margin: 0px;
            background: #994C19 none repeat scroll 0% 0%;
            border-bottom: 1px solid #909090;
            font: 14px/1.55 "Open Sans" ,Helvetica,Arial,sans-serif;
        }
        .sky-form .row
        {
            margin-bottom: 20px;
        }
        .sky-form .header
        {
            display: block;
            padding: 0px 0px 9px;
            margin-bottom: 13px;
            font-size: 22px;
            font-weight: normal;
            color: #272727;
            border-bottom: 1px solid #E3E3E3;
            font-family: "Raleway" ,sans-serif;
        }
        .sky-form .footer
        {
            display: block;
            padding: 15px 0px 25px;
            margin-bottom: 20px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="form">
        <form class="sky-form" name="frmChangePassword" id="frmChangePassword" action=""
        method="POST">
        <div class="header">
            Ubah Kata sandi</div>
        <fieldset>
            <div class="alert alert-danger" id="form-alert"></div>
            <div class="row">
                <label class="label col col-2">
                    Kata sandi saat ini:</label>
                <div class="input col col-4">
                    <input type="password" class="form-control " name="oldPassword" id="txtOldPassword" />
                </div>
            </div>
            <div class="row">
                <label class="label col col-2">
                    Kata sandi baru:</label>
                <div class="input col col-4">
                    <input type="password" class="form-control " name="Password" id="txtNewPassword" />
                </div>
            </div>
            <div class="row">
                <label class="label col col-2">
                    Ulangi:</label>
                <div class="input col col-4">
                    <input type="password" class="form-control " name="Password" id="txtRePassword" />
                </div>
            </div>
        </fieldset>
        <div class="footer">
            <div class="fright">
                <button type="submit" class="button">
                    Simpan</button>
            </div>
        </div>
        </form>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FootContent" runat="server">
    <script>
        var data = {};
        var user = {};
        var Validate = function (param) {
            var message = '';
            if (param != '') message += '<li>' + param + '</li>';
            if (user.oldpassword == '') message += '<li>kata sandi lama tidak boleh kosong</li>';
            if (user.newpassword == '') message += '<li>kata sandi baru tidak boleh kosong</li>';
            if (user.repassword == '') message += '<li>kata sandi baru tidak sama</li>';
            //if (CheckPasswordValid()) message += 'kata sandi lama salah\n';

            if (message == '') {
                $('#form-alert').html('<ul>' + message + '</ul>');
                $('#form-alert').show();
                return true;
            } else {
                $('#form-alert').html('');
                $('#form-alert').hide;

                return false;
            }

        }
        var CheckPasswordValid = function () {
            $.postJSON('usermanagement.aspx/CheckPassword', JSON.stringify(user)).success(function (data) {
                var result = data.d;
                if (result == '')
                    return true;
                else
                    return false;
            });
        }
        $('#frmChangePassword').on('submit', function (e) {
            e.preventDefault();
            $('button').prop('disabled', false);
            $('#imgloader').hide();

            if (Validate()) {
                user.oldpassword = $('#txtOldPassword').val();
                user.newpassword = $('#txtNewPassword').val();
                user.repassword = $('#txtRePassword').val();
                $.postJSON('Usermanagement.aspx/ChangePassword', JSON.stringify(user))
                    .success(function (data) {
                        alert(data.d);
                        location.href = '';
                    }).fail(function (xhr, status, error) {
                        console.log(xhr);
                        var err = $.parseJSON(xhr.responseText);
                        alert("Ganti kata sandi gagal\r\n" + err.Message + '\n' + err.StackTrace);
                    }).always(function () {
                        $('button').prop('disabled', false);
                        $('#imgloader').hide();
                    });
            }
        });
    </script>
</asp:Content>
