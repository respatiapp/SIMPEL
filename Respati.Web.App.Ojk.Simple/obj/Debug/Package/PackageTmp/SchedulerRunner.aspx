<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Simple.Master" CodeBehind="SchedulerRunner.aspx.cs"
    Inherits="Respati.Web.App.Ojk.Simple.SchedulerRunner" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Setting</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form>
        <!--
    <div class="form-group">
        <label>
            Setting tersedia:</label>
        <div>
            <table id="tblAvailabelSetting">
                <thead>
                    <td>
                    </td>
                    <td>
                        Nama setting
                    </td>
                </thead>
            </table>
        </div>
    </div>
    -->
    <div class="form-group">
        <label>
            Hasil:</label>
        <div>
            <label id="lblHasil"></label>
        </div>
    </div>
    <div>
        <button id="btnRun">
            Jalankan</button>
    </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FootContent" runat="server">
    <script>
        $('#btnRun').on('click', function (e) {
            e.preventDefault();
            $.postJSON("SchedulerRunner.aspx/Run").done(function(result) {
                $('#lblHasil').text(result.d);
            });
        });
    </script>
</asp:Content>
