<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AccessDenied.aspx.cs" Inherits="Respati.Web.App.Ojk.Simple.AccessDenied" MasterPageFile="~/Simple.Master" %>

<asp:content id="Content1" contentplaceholderid="HeadContent" runat="server">

    <title>Access Denied</title>
    <style>
        .error_pagenotfound
        {
            padding: 50px 30px 58px;
            margin: 0px auto;
            background-color: #FFF;
            border-width: 1px 1px 5px;
            border-style: solid;
            border-color: #EEE;
            -moz-border-top-colors: none;
            -moz-border-right-colors: none;
            -moz-border-bottom-colors: none;
            -moz-border-left-colors: none;
            border-image: none;
            text-align: center;
            font-family: "Open Sans" ,sans-serif;
        }
    </style>
</asp:content>
<asp:content id="Content2" contentplaceholderid="MainContent" runat="server">
	<div class="error_pagenotfound">
    	
        <strong>401</strong>
        <br />
    	<b>Access Denied!</b>
        
        <em>Sorry.</em>

        <p>Try using the button below to go to main page of the site</p>
        
        <div class="clearfix margin_top3"></div>
    	
        <a href="<%= Page.ResolveUrl("~/Default.aspx") %>" class="but_goback"><i class="fa fa-arrow-circle-left fa-lg"></i>&nbsp;Kembali</a>
    </div>
</asp:content>
<asp:content id="Content3" contentplaceholderid="FootContent" runat="server">
</asp:content>
