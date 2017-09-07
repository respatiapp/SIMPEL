<%@ Page Title="" Language="C#" MasterPageFile="~/Simple.Master" AutoEventWireup="true" CodeBehind="Chart2.aspx.cs" Inherits="Respati.Web.App.Ojk.Simple.iku.Chart2" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Pemantauan turunan IKU</title>
    <style>
        .RadOrgChart .rocImageWrap { width: 32px !important ;height: 32px !important; margin-left:-42px !important }
        .RadOrgChart .rocImageWrap img { width: 32px !important; }
        .RadOrgChart .rocItemContent  
        {
            background-color:transparent !important; 
            background-image:none !important;
            border-color:transparent !important;
        }
        .RadOrgChart .rocItemWrap { width: 140px; }
        .RadOrgChart .rocItem { height: 60px !important;width: 140px !important;border: 1px solid white; }
        .RadOrgChart .rocItemContent { height: 40px; padding-left:52px !important; }
        .RadOrgChart .rocItemList .rocItemWrap + .rocItemWrap { margin-left: -130px; }
        .RadOrgChart .rocNode .rocGroup {
            background-color: #ffffff;
            border-color: #337ab7; /*#cccccc;*/
            border-style: solid;
            border-width: 1px;
            padding-bottom: 5px;
        }
        .RadOrgChart .rocFirstInRow { margin-left: 0px !important; }
        .RadOrgChart .rocItemText { font-size: 10px; }
        .RadOrgChart .rocEmptyItem { height: 0px !important; }
        .RadOrgChart .rocNodeFields { padding:5px; background-color: #337ab7; color: #fff; }
        
        .RadOrgChart .rocLineUp { background-color: #337ab7 !important;background-image: initial !important }
        .RadOrgChart .rocLineDown { background-color: #337ab7 !important;background-image: initial !important }
        .RadOrgChart .rocLineHorizontal { background-color: #337ab7 !important;background-image: initial !important }
        
        .rocItem .rocItemContent .rocItemField { display: none; }
        .AnggotaNode .rocGroup .rocNodeFields { background-color:grey; }
        .frame {
            overflow-x: scroll;
            height: 440px;
        }
    </style>
    <script src="<%=Page.ResolveUrl("~/resources/js/overlapchart.js") %>" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div><h3>Turunan IKU</h3></div> 
    <div><h4><%=iku_label%></h4></div>
    <form id="form1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" 
                Name="Telerik.Web.UI.Common.Core.js">
            </asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" 
                Name="Telerik.Web.UI.Common.jQuery.js">
            </asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" 
                Name="Telerik.Web.UI.Common.jQueryInclude.js">
            </asp:ScriptReference>
        </Scripts>
    </telerik:RadScriptManager>
    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
    <div class="frame">
    <telerik:RadOrgChart ID="orgChartStatus" runat="server" 
        ongroupitemdatabound="orgChartStatus_GroupItemDataBound" 
        onnodedatabound="orgChartStatus_NodeDataBound">
    </telerik:RadOrgChart>
    </div>
    <!--<p>&nbsp;</p>-->
    <p align="center">
    <div class="panel panel-default" style="float:left;margin-top:1em;width:60%">
        <div class="panel-heading" style="text-align:center"><strong>Keterangan</strong></div>
        <div class="panel-body" style="padding:10px">
            <div class="col-sm-6">
                <p class="btn-success" style="padding: 5px;font-weight: bold;text-align:center;margin-bottom:0px;">Mengambil</p>
            </div>
            <div class="col-sm-6">
                <p class="btn-danger" style="padding: 5px;font-weight: bold;text-align:center;margin-bottom:0px;">Tidak mengambil</p>
            </div>
        </div>
    </div>
    </p>
    <telerik:RadWindow ID="RadWindow1" runat="server" VisibleStatusbar="false" Behaviors="Close">
    </telerik:RadWindow>
    <telerik:RadScriptBlock ID="RadScriptBlock1" runat="server">
        <script type="text/javascript">
            // <![CDATA[
            Sys.Application.add_load(function () {
                window.orgChart = $find("<%= orgChartStatus.ClientID %>");
                demo.initialize();
            });
            // ]]>
        </script>
    </telerik:RadScriptBlock>
    </form>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FootContent" runat="server">
    <script>
        $(".rocItem").on("click", function () {
            var nd = $(this).find("div.rocItemField");
            var url = '<%=Page.ResolveUrl("~/Helper/Staff.aspx") %>';
            var fullUrl = url + "?NIP=" + nd.text().trim() + "&VW=IKI";
            var oWnd = $find("<%=RadWindow1.ClientID%>");
            oWnd.setUrl(fullUrl);
            oWnd.setSize(400, 400);
            oWnd.moveTo(0, 0);
            oWnd.show();
        });
    </script>
</asp:Content>
