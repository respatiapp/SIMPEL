<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Staff.aspx.cs" Inherits="Respati.Web.App.Ojk.Simple.Helper.Staff" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Detail Pegawai</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap -->
    <link href="<%=Page.ResolveUrl("~/resources/css/bootstrap.min.css") %>" rel="stylesheet" type="text/css" />
    <link href="<%=Page.ResolveUrl("~/resources/css/jquery.dataTables.min.css") %>" rel="stylesheet" type="text/css" />
	
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    
    <!-- add font awesome -->
    <link href="<%=Page.ResolveUrl("~/resources/css/font-awesome/css/font-awesome.min.css") %>" rel="stylesheet" type="text/css" />

    <style>
        body { font-size:12px }
        .panel { margin: 15px; }
        .media-left { padding-right: 20px; }
        .table td { font-size: 12px; }
        address { margin-bottom: 0px !important; }
    </style>
</head>
<body>
    <div class="panel panel-primary">
        <div class="panel-heading"></div>
        <div class="panel-body">
            <div class="media">
                <div class="media-left">
                    <asp:Image ID="Image1" ClientIDMode="Inherit" runat="server" />
                </div>
                <div class="media-body">
                    <h4 class="media-heading">
                        <asp:Label ID="lblNama" runat="server" CssClass="form-control-static"></asp:Label>
                    </h4>
                </div>
            </div>
        </div>
    </div>
    <div class="panel panel-primary">
        <table class="table table-bordered table-striped" id="tblData" style="border-bottom:1px solid #ddd;">
            <thead>
                <tr>
                    <th><%=VIEW_MODE %></th>
                </tr>
            </thead>
            <tbody>
                <%
                    foreach (System.Data.DataRow dr in DATANYA.Rows)
                    {
                        bool show = true;
                        if (VIEW_MODE == "IKI")
                        {
                            show = (dr["ID_IKU"].ToString().Trim() == Request.QueryString["ID"].ToString().Trim());
                        }
                            
                        string data = "";
                        string data2 = "";
                        string label2 = "";
                        if (VIEW_MODE == "IKU")
                        {
                            data = dr["IKU_DESC"].ToString();
                            data2 = dr["DESKRIPSI_IKI"].ToString();
                            label2 = "IKI: ";
                        }
                        else
                        {
                            data = dr["DESKRIPSI_IKI"].ToString();
                            data2 = dr["IKU_DESC"].ToString();
                            label2 = "IKU: ";
                        }
                        
                        if (show)
                        {
                %>
                <tr>
                    <td><%= data%>
                    <br /><br />
                    <address>
                        <strong><%=label2%></strong>
                        <%= data2%><br />
                        <strong>Target: </strong>
                        <%= dr["TARGET"].ToString()%><br />
                        <strong>Nilai capaian: </strong>
                        <%= dr["NILAI_CAPAIAN"].ToString()%><br />
                        <strong>Range capaian: </strong><br />
                        <%= dr["RANGE_CAPAIAN"].ToString()%>
                    </address>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
    <div style="display:none">
        <asp:Label ID="lblNip" runat="server" CssClass="form-control-static"></asp:Label>
    </div>

    <script src="<%=Page.ResolveUrl("~/resources/js/jquery-1.11.2.min.js") %>" type="text/javascript"></script>
    <script src="<%=Page.ResolveUrl("~/resources/js/bootstrap.min.js") %>" type="text/javascript"></script>
    <script src="<%=Page.ResolveUrl("~/resources/js/jquery.dataTables.min.js") %>" type="text/javascript"></script>
    <script type="text/javascript">
        $( document ).ready(function() {
            $('#tblUsers').dataTable({
                //"data": arr,
                "searching": false,
                "bLengthChange": false,
            });
        });
    </script>
</body>
</html>
