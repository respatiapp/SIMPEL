<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Respati.Web.App.Ojk.Simple.LoginNew" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="<%=Page.ResolveUrl("~/resources/login/bootstrap.css") %>" rel="stylesheet">
    <link href="<%=Page.ResolveUrl("~/resources/login/font-awesome.min.css") %>" rel="stylesheet">
    <style type="text/css">
        .li-breadcrumb {
            color: #fff !important;
            display: inline-block !important;
            padding: 0 4px !important;
        }
    </style>

    <link rel="stylesheet" href="<%=Page.ResolveUrl("~/resources/login/ace-fonts.css") %>">
    <link rel="stylesheet" href="<%=Page.ResolveUrl("~/resources/login/ace.min.css") %>">
    <link rel="stylesheet" href="<%=Page.ResolveUrl("~/resources/login/ace-rtl.css") %>">
    <link rel="stylesheet" href="<%=Page.ResolveUrl("~/resources/login/ace-skins.css") %>">
    <link rel="stylesheet" href="<%=Page.ResolveUrl("~/resources/login/ojk-style1.css") %>">
    <link rel="stylesheet" href="<%=Page.ResolveUrl("~/resources/login/ojk-style2.css") %>">
    <link rel="stylesheet" href="<%=Page.ResolveUrl("~/resources/login/ojk-style3.css") %>">
    <link rel="stylesheet" href="<%=Page.ResolveUrl("~/resources/login/ojk-style5.css") %>">

</head>
<body class="login-layout">
    <div class="main-container">
        <div class="main-content">
            <div class="row">
                <div class="col-sm-10 col-sm-offset-1">
                    <div class="login-container" style="background:#fff">
                        <div class="center" style="margin-top:30px">
                            
                            <img src="<%=Page.ResolveUrl("~/resources/login/OJKLogo2.png") %>" alt="Logo_Desc">
                            <h2>
                                <i class="icon-leaf green"></i>
                                <span class="grey">Sistem Pengelolaan dan Manajemen Kinerja</span>
                            </h2>
                        </div>

                        <div class="space-6"></div>

                        <div class="position-relative">
                            <div id="login-box" class="login-box visible widget-box no-border">
                                <div class="widget-body">
                                    <div class="widget-main">
                                        <h6 class="header red lighter bigger">
                                            <i class="icon-user grey"></i>
                                            <span class="grey">Masukkan Username dan Password</span>
                                        </h6>

                                        <div class="space-6"></div>

                                        <form id="frmLogin">
                                            <fieldset>
                                                <label class="block clearfix">
                                                    <span class="block input-icon input-icon-right">
                                                        <input type="text" value="" class="form-control" placeholder="Username" id="txtUsername" name="txtUsername" required="">
                                                        <i class="icon-user"></i>
                                                    </span>
                                                </label>

                                                <label class="block clearfix">
                                                    <span class="block input-icon input-icon-right">
                                                        <input type="password" value="" class="form-control" placeholder="Password" id="txtPassword" name="txtPassword" required="">
                                                        <i class="icon-lock"></i>
                                                    </span>
                                                </label>

                                                
                                                <div class="space"></div>

                                                <div class="clearfix">
                                                    <label class="inline" style="display:none !important">
                                                        <input type="checkbox" class="ace">
                                                        <span class="lbl">
                                                            Ingat saya <br>
                                                            <a href="http://sinta.ojk.go.id/sinta/User%20Manual%20Aplikasi%20SINTA.pdf" onclick="window.open(&#39;/sinta/User Manual Aplikasi SINTA.pdf&#39;, &#39;newwindow&#39;, &#39;width=800, height=600&#39;); return false;" style="text-decoration: none;" download="User Manual Aplikasi SINTA.pdf">User Guide</a><br>
                                                        </span>
                                                    </label>
                                                    <img id="imgloader" src="<%=Page.ResolveUrl("~/resources/images/ajax-loader.gif") %>" style="display: none" />
                                                    <button type="submit" class="width-15 pull-right btn btn-ojk-red">
                                                        <i class="icon-key"></i>
                                                        Login
                                                    </button>
                                                </div>
                                                <div class="space-4">

                                                </div>
                                                
                                            </fieldset>
                                        </form>
                                    </div>
                                    <!-- /widget-main -->

                                </div>
                                <!-- /widget-body -->
                            </div>
                            <!-- /login-box -->
                        </div>
                        <!-- /position-relative -->
                        <div class="space-32"></div>
                        <div class="space-32"></div>
                        <div class="space-32"></div>
                        <div class="space-32"></div>
                        <div class="space-32"></div>
                        <div class="space-32"></div>
                        <div class="space-32"></div>
                        <div class="space-10"></div>
                        <div class="center">
                            Best View IE 11, Firefox Mozilla 31.0, Google Chrome 36<br>
                            Resolution 1366 x 768
                        </div>

                        <br>

                        

                    </div>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </div>
    </div>
    <!-- /.main-container -->
    <link rel="stylesheet" href="<%=Page.ResolveUrl("~/resources/login/ojk-style3.css") %>">
    <script src="<%=Page.ResolveUrl("~/resources/js/jquery-1.11.2.min.js") %>" type="text/javascript"></script>
    <script src="<%=Page.ResolveUrl("~/resources/js/usermanagement.js") %>" type="text/javascript"></script>

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

</body>
</html>
