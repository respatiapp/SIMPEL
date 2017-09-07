<%@ Page Title="" Language="C#" MasterPageFile="~/Simple.Master" AutoEventWireup="true" CodeBehind="SessionExpired.aspx.cs" Inherits="Respati.Web.App.Ojk.Simple.SessionExpired" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Sesi sudah berakhir</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-lg-12">
            <div class="form login-form-2" >
                <form id="frmLogin">
                    <h6>Sesi anda sudah berakhir. Silahkan <a href='<%=Page.ResolveUrl("~/Login.aspx") %>'>login</a> ulang</h6>
                </form>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FootContent" runat="server">
</asp:Content>
