<%@ Page Title="" Language="C#" MasterPageFile="~/Simple.Master" AutoEventWireup="true" CodeBehind="HomeLama.aspx.cs" Inherits="Respati.Web.App.Ojk.Simple.rkp.Home" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>RKP - Pilih direktorat</title>
    <style>
        .rgMasterTable { border: none; } 
        .rgMasterTable .rgAltRow { background-color:#fcf8e3 !important; }
        .rgMasterTable td.rgGroupCol { background: transparent !important; }
        .rgMasterTable .rgGroupHeader { background-image: none !important; }
        /* .rgMasterTable td:first-child,.rgMasterTable th:first-child { display:none !important; } */  
        .rgMasterTable td:first-child+td,.rgMasterTable th:first-child+th { width:30px !important; }
        .rgMasterTable td:first-child+td+td,.rgMasterTable th:first-child+th+th { width:30px !important; }
        .rgCollapse { display:none !important; }
        .W40 { width:40px !important; }
        .W65 { width:65px !important; }
        
        .item-level1 { color:#31708f !important;background-color:#d9edf7 !important;border-color:#bce8f1 !important;font-size:1.2em !important; }
        .item-level2 { color:#3c763d !important;background-color:#dff0d8 !important;border-color:#d6e9c6 !important; }
        .item-level3 { color:#8a6d3b !important;background-color:#fcf8e3 !important;border-color:#faebcc !important; }
        
        .head-level1 { color:#fff !important;background-color:#337ab7 !important;border-color:#2e6da4 !important; }
        .head-level2 { color:#fff !important;background-color:#5cb85c !important;border-color:#4cae4c !important; }
        .head-level3 { color:#fff !important;background-color:#f0ad4e !important;border-color:#eea236 !important; }
        
        tr[class*="item-level"] { border:none !important; font-weight:bold; }
        tr[class*="item-level"] td { border-color: #fff #fff #fff #ededed !important; padding:4px 8px 3px !important; }
        
        .btn { background-color: transparent !important; border-color: transparent !important }
        .btn:hover { border-color: #ccc !important; }

        div.RadProgressBar .rpbLabelWrapper { text-align: center !important; }
        div.RadProgressBar_Default { float:right; }
        div.RadProgressBar .rpbStateSelected:hover { background-color: #fff; }
        
        div.ProgressBar80 .rpbStateSelected
        ,div.ProgressBar80 .rpbStateSelected:hover { background-color: #337ab7 !important; border:none;}
        div.ProgressBar60 .rpbStateSelected
        ,div.ProgressBar60 .rpbStateSelected:hover { background-color: #5bc0de !important; border:none;}
        div.ProgressBar40 .rpbStateSelected
        ,div.ProgressBar40 .rpbStateSelected:hover { background-color: #5cb85c !important; border:none;}
        div.ProgressBar20 .rpbStateSelected
        ,div.ProgressBar20 .rpbStateSelected:hover { background-color: #f0ad4e !important; border:none;}
        div.ProgressBar0 .rpbStateSelected
        ,div.ProgressBar0 .rpbStateSelected:hover { background-color: #d9534f !important; border:none;}
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
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

        <div><h3>Status RKP</h3></div> 
        <label>Pilih bidang: </label>

        <telerik:RadComboBox ID="RadComboBox1" runat="server" AutoPostBack="true"
            DataValueField="KD_UNIT_ORG" DataTextField="NM_UNIT_ORG" Width="250px" 
            onselectedindexchanged="RadComboBox1_SelectedIndexChanged">
        </telerik:RadComboBox>

        <telerik:RadGrid ID="RadGrid1" runat="server" AutoGenerateColumns="False" skin="Vista"
            GridLines="Both" GroupPanelPosition="Top" ResolvedRenderMode="Classic" 
            onitemdatabound="RadGrid1_ItemDataBound" 
            onitemcreated="RadGrid1_ItemCreated">
            <MasterTableView CssClass="table rgMasterTable">
                <RowIndicatorColumn Visible="False">
                </RowIndicatorColumn>
                <Columns>
                    <telerik:GridBoundColumn DataField="NM_ROOT2" HeaderText=" ">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="NM_ROOT3" HeaderText=" ">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="NM_ROOT4" HeaderText=" ">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TOTAL_RKP" HeaderText="Jumlah RKP">
                        <HeaderStyle CssClass="W40" HorizontalAlign="Center" VerticalAlign="Middle" />
                        <ItemStyle HorizontalAlign="Center" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="TOTAL_EMPLOYEE" HeaderText="Jumlah Karyawan">
                        <HeaderStyle CssClass="W65" HorizontalAlign="Center" VerticalAlign="Middle" />
                        <ItemStyle HorizontalAlign="Center" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PERSENTASE" HeaderText="Progress" DataFormatString="{0:0}">
                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        <ItemStyle HorizontalAlign="Center" />
                    </telerik:GridBoundColumn>
                    <telerik:GridHyperLinkColumn AllowSorting="False" 
                        FilterControlAltText="Filter column column" NavigateUrl="Chart.aspx"
                        Text="Detil" UniqueName="column" DataNavigateUrlFields="MAIN_ROOT,KD_MAIN_ROOT" 
                        DataNavigateUrlFormatString="Chart.aspx?kd={0}&src={1}" Visible="false">
                    </telerik:GridHyperLinkColumn>
                    <telerik:GridHyperLinkColumn AllowSorting="False" 
                        FilterControlAltText="Filter column column" NavigateUrl="../SendEmail.aspx"
                        Text="Email" UniqueName="column" DataNavigateUrlFields="MAIN_ROOT,KD_MAIN_ROOT" 
                        DataNavigateUrlFormatString="../SendEmail.aspx" Visible="false">
                    </telerik:GridHyperLinkColumn>
                    <telerik:GridTemplateColumn AllowFiltering="False" ItemStyle-Width="30px"
                        FilterControlAltText="Filter TemplateColumn column" UniqueName="TemplateColumn">
                        <ItemTemplate>
                            <button type="button" data-root='<%# Eval("KD_UNIT") %>' data-kd-root='<%# Eval("LVL_UNIT") %>'
                                class="btnviewchart btn btn-default" data-toggle="tooltip" data-placement="top" title="Lihat hirarki">
                                <span class="glyphicon glyphicon-zoom-in" aria-hidden="true"></span>
                            </button>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                </Columns>
                <GroupByExpressions>
                    <telerik:GridGroupByExpression>
                        <SelectFields>
                            <telerik:GridGroupByField FieldName="NM_ROOT2" HeaderText="" FieldAlias="Unit" />
                            <telerik:GridGroupByField FieldName="TOTAL_RKP" HeaderText="" FieldAlias="RKP" Aggregate="Sum" />
                            <telerik:GridGroupByField FieldName="TOTAL_EMPLOYEE" HeaderText="" FieldAlias="PEG" Aggregate="Sum" />
                            <telerik:GridGroupByField FieldName="KD_ROOT2" HeaderText="" FieldAlias="RootUnit" />
                        </SelectFields>
                        <GroupByFields>
                            <telerik:GridGroupByField FieldName="NM_ROOT2" SortOrder="Ascending"></telerik:GridGroupByField>
                        </GroupByFields>
                    </telerik:GridGroupByExpression>
                    <telerik:GridGroupByExpression>
                        <SelectFields>
                            <telerik:GridGroupByField FieldName="NM_ROOT3" HeaderText="" FieldAlias="Subunit" />
                            <telerik:GridGroupByField FieldName="TOTAL_RKP" HeaderText="" FieldAlias="RKP" Aggregate="Sum" />
                            <telerik:GridGroupByField FieldName="TOTAL_EMPLOYEE" HeaderText="" FieldAlias="PEG" Aggregate="Sum" />
                            <telerik:GridGroupByField FieldName="KD_ROOT3" HeaderText="" FieldAlias="RootSubUnit" />
                        </SelectFields>
                        <GroupByFields>
                            <telerik:GridGroupByField FieldName="NM_ROOT3" SortOrder="Ascending"></telerik:GridGroupByField>
                        </GroupByFields>
                    </telerik:GridGroupByExpression>
                </GroupByExpressions>
            </MasterTableView>
        </telerik:RadGrid>
    </form>

    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header" style="display:none">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exampleModalLabel">Kirim pemberitahuan</h4>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
            <label for="recipient-name" class="control-label">Recipient:</label>
            <input type="text" class="form-control" id="recipient-name">
          </div>
          <div class="form-group">
            <label for="recipient-name" class="control-label">Subject:</label>
            <input type="text" class="form-control" id="subject-text">
          </div>
          <div class="form-group">
            <label for="message-text" class="control-label">Message:</label>
            <textarea class="form-control" id="message-text" rows=10></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Batal</button>
        <button type="button" class="btn btn-primary" id="btnSendEmail" disabled>Kirim</button>
        <img id="imgloader" src="<%=Page.ResolveUrl("~/resources/images/ajax-loader.gif") %>" style="display:none" />
      </div>
    </div>
  </div>
</div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FootContent" runat="server">
    <script>
        $('.btnviewchart').on('click', function () {
            location.href = "Chart.aspx?kd=" + $(this).attr("data-root") + "&src=" + $(this).attr("data-kd-root");
        });

        $('#exampleModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget); // Button that triggered the modal
            var recipient = button.data("email"); // Extract info from data-* attributes
            var namaunit = button.data("nama");
            var textbody = "Dengan hormat,\r\n\r\nDengan ini sampaikan status pengisian RKP di " + namaunit + " sebagai berikut:\r\n\r\nTerima kasih.";

            $('#btnSendEmail').prop('disabled', false);
            $('button').prop('disabled', false);
            $('#imgloader').hide();

            var modal = $(this)
            modal.find('.modal-body input#recipient-name').val(recipient);
            modal.find('.modal-body input#subject-text').val("Status pengisian RKP " + namaunit);
            modal.find('.modal-body textarea').val(textbody);
        });

        var data = {};
        $('#btnSendEmail').on('click', function (e) {
            $('#btnSendEmail').prop('disabled', true);
            $('button').prop('disabled', true);
            $('#imgloader').show();
            e.preventDefault();

            data.to = $('#recipient-name').val();
            data.subject = $('#subject-text').val();
            data.message = $('#message-text').val();

            var url = '<%=Page.ResolveUrl("~/SendEmail.aspx/SendEmailMethod") %>';
            $('#txtMessage').val();
            $.postJSON(url, JSON.stringify(data))
                .done(function (data) {
                    var result = data.d;
                    alert(result);
                    $('#exampleModal').modal('hide');
                }).fail(function (xhr, status, error) {
                    var err = eval("(" + xhr.responseText + ")");
                    alert("Gagal mengirimkan email\r\n" + err);
                }).always(function () {
                    $('#btnSendEmail').prop('disabled', false);
                    $('button').prop('disabled', false);
                    $('#imgloader').hide();
                });
            });

            $(document).ready(function () {
                //console.log("ready!");
                $("p").each(function (index) {
                    $(this).html($(this).html().replace("XHIDEMEX", ""));
                });
            });
    </script>
</asp:Content>
