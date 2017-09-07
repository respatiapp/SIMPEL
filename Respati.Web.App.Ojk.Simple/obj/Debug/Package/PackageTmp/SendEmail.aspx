<%@ Page Title="" Language="C#" MasterPageFile="~/Simple.Master" AutoEventWireup="true"
    CodeBehind="SendEmail.aspx.cs" Inherits="Respati.Web.App.Ojk.Simple.SendEmail" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Send Email</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <form>
    <div class="form-group">
        <label>
            TO:</label>
        <input type="text" id="txtTO" />
    </div>
    <div class="form-group">
        <label>
            Subject</label>
        <input type="text" id="txtSubject" />
    </div>
    <div class="form-group">
        <label>
            Message</label>
        <textarea id="txtMesssage"></textarea>
    </div>
    <button class="btn btn-default" id="btnSend">
        Send</button>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FootContent" runat="server">
    <script>
        var data = {};
        $('#btnSend').on('click', function (e) {
            e.preventDefault();
            
            data.to = $('#txtTO').val();
            data.subject = $('#txtSubject').val();
            data.message = $('#txtMesssage').val();
            $('#txtMessage').val();
            $.postJSON('SendEmail.aspx/SendEmailMethod',
                    JSON.stringify(data)
                )
                .success(function (data) {
                    var result = data.d;
                    alert(result);
                });
        });
    </script>
</asp:Content>
