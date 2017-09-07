<%@ Page Language="C#" MasterPageFile="~/Simple.Master" AutoEventWireup="true" CodeBehind="PengirimanNotifikasi.aspx.cs"
    Inherits="Respati.Web.App.Ojk.Simple.PengirimanNotifikasi" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI, Version=2015.1.401.40, Culture=neutral, PublicKeyToken=121fae78165ba3d4" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Pengiriman Notifikasi</title>
    <style>
        #loader
        {
            background: #FFF url("<%= Page.ResolveUrl("~/resources/images/ajax-loader.gif") %>") no-repeat scroll center center;
            height: 100%;
            width: 100%;
            position: fixed;
            z-index: 2147483647;
            left: 0%;
            top: 0%;
            margin: 0px;
        }
        .alert-dismissable .close, .alert-dismissible .close
        {
            top: -10px;
        }
        .btn-danger
        {
            background-color: #ab1a18;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div id="loader" style="display: none;">
    </div>
    <form runat="server" class="form-horizontal">
    <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" ShowChooser="False" />
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">
                Pengiriman Notifikasi</h1>
        </div>
    </div>
    <div class="alert alert-danger alert-dismissable" id="modal-alert" style="display: none;">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label" for="inputEmail3">
            Minimal RKP(%):</label>
        <div class="col-sm-10">
            <input type="text" class="form-control" id="txtNilaiRKP" style="padding-left: 5px;
                width: 30%">
        </div>
    </div>
    <div class="form-group">
        <label class="col-sm-2 control-label" for="inputEmail3">
            Level target pemberitahuan</label>
        <div class="col-sm-10 .checkbox-inline">
            <input type="checkbox" class="chk-notif-level" value="kepala departemen" />
            Kepala Departemen
            <br />
            <input type="checkbox" class="chk-notif-level" value="direktur" />
            Direktur
            <br />
            <input type="checkbox" class="chk-notif-level" value="deputi direktur" />
            Deputi Direktur
            <br />
            <input type="checkbox" class="chk-notif-level" value="kepala bagian" />
            Kepala Bagian
            <br />
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-12">
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-12">
            <button id="btnGetSchedule" class="btn btn-danger btn-sm">
                Tampilkan penerima notifikasi
            </button>
            <button id="btnSendEmail" value="Send Email" class="btn btn-danger btn-sm">
                Kirimkan email
            </button>
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-12">
        </div>
    </div>
    <div class="form-group">
        <div class="col-sm-12">
            <div class="frame">
                <telerik:RadGrid ID="RadGrid1" runat="server" Skin="Sunset" GroupPanelPosition="Top"
                    AllowPaging="True" PagerStyle="AlwaysVisible" PageSize="10" AllowMultiRowSelection="True"
                    ResolvedRenderMode="Classic" AllowCustomPaging="True" ViewStateMode="Disabled"
                    OnItemCreated="RadGrid1_OnItemCreated">
                    <MasterTableView>
                        <Columns>
                            <telerik:GridClientSelectColumn UniqueName="ClientSelectColumn">
                            </telerik:GridClientSelectColumn>
                            <telerik:GridBoundColumn DataField="NM_UNIT_ORG" HeaderText="Organisasi" ShowFilterIcon="False"
                                FilterControlWidth="100%">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="PERSENTASE" HeaderText="Nilai RKP" ShowFilterIcon="False"
                                FilterControlWidth="100%">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="NM_PEG" HeaderText="Nama Pegawai" ShowFilterIcon="False"
                                FilterControlWidth="100%">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="NM_JABATAN" HeaderText="Jabatan" ShowFilterIcon="False"
                                FilterControlWidth="100%">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="EMAIL" HeaderText="Email" ShowFilterIcon="False"
                                FilterControlWidth="100%">
                            </telerik:GridBoundColumn>
                        </Columns>
                    </MasterTableView>
                    <PagerStyle AlwaysVisible="True"></PagerStyle>
                    <ClientSettings>
                        <ClientEvents OnCommand="RadGrid1_Command" OnColumnClick="OnColumnClick"></ClientEvents>
                    </ClientSettings>
                </telerik:RadGrid>
            </div>
        </div>
    </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="FootContent" runat="server">
    <script src="<%= Page.ResolveUrl("~/resources/js/thenBy.min.js") %>" type="text/javascript"></script>
    <script src="<%= Page.ResolveUrl("~/resources/js/linq.min.js") %>" type="text/javascript"></script>
    <script src="<%= Page.ResolveUrl("~/resources/js/jquery.linq.min.js") %>" type="text/javascript"></script>
    <script>

        var grid = null;
        var data = {};
        data.MinimalRKP = "";
        data.list_recipient = [];
        data.target_level = "";
        data.list_unselected_recipient = [];
        var msg = [];

        var selectedRow = function () {
            var list_recipient = [];
            grid = $find("<%=RadGrid1.ClientID %>");

            $.each(grid.get_masterTableView().get_dataItems(), function (row, data) {
                var cells = data._element.cells;
                var recipient = {};
                recipient.is_selected = $('#' + $(cells[0].innerHTML).attr('id')).prop('checked');
                recipient.departemen = cells[1].innerHTML;
                recipient.nilai_rkp = cells[2].innerHTML;
                recipient.nama_pegawai = cells[3].innerHTML;
                recipient.nama_jabatan = cells[4].innerHTML;
                recipient.email = cells[5].innerHTML;
                list_recipient.push(recipient);
            });
            return list_recipient;
        };
        $('.rgMasterTable input[type=checkbox]:first').unbind('click');

        $('.rgMasterTable input[type=checkbox]:first').on('click', function (e) {
            var state = $(this).prop('checked');
            $('.rgMasterTable tbody:last tr:not(:last)').each(function (row, data) {
                $(data).find('input[type=checkbox]').prop('checked', state);
            });

        });


        function rebindGrid() {
            grid = $find("<%=RadGrid1.ClientID %>");
            $.showOverlay();
            $.postJSON('PengirimanNotifikasi.aspx/GetSchedule', JSON.stringify({ targetLevel: notif_level().join(","), persentase: $('#txtNilaiRKP').val() }))
                .done(function (data) {
                    var response = $.parseJSON(data.d);
                    var tableview = grid.get_masterTableView();
                    msg = response.Data;
                    bindGrid(oldPageSize == 0 ? 10 : oldPageSize, 1);
                    var state = $('.rgMasterTable input[type=checkbox]:first').prop('checked');
                    if (!state) {
                        $('.rgMasterTable input[type=checkbox]:first').trigger('click');
                    } else {
                        $('.rgMasterTable input[type=checkbox]:first').trigger('click');
                        $('.rgMasterTable input[type=checkbox]:first').trigger('click');

                    }
                    $('.rgMasterTable tbody:last tr:not(:last)').each(function (row, data) {
                        $(data).find('input[type=checkbox]').prop('checked', true);
                        $(data).addClass('dataRow');

                    });


                    $('.rgMasterTable input[type=checkbox]:not(:first)').on('change', function (e) {
                        var result = true;
                        $('.rgMasterTable tbody:last tr:not(:last)').each(function (row, data) {
                            if (!$(data).find('input[type=checkbox]').prop('checked'))
                                result = false;
                            if (!result) return;
                        });
                        $('.rgMasterTable input[type=checkbox]:first').prop('checked', result);


                    });

                }).fail(function (xhr, status, error) {
                    console.log(xhr);
                    var err = $.parseJSON(xhr.responseText);
                    alert("Gagal meload data\r\n" + err.Message + '\n' + err.StackTrace);
                })
                .always(function (data) {
                    $.hideOverlay();
                });
        }

        $('.rgMasterTable').on('click', '.dataRow', function (e) {
            if ($(e.target).closest('input[type="checkbox"]').length > 0) {
                //Chechbox clicked
            } else {
                var chk = $(this).find('input[type=checkbox]');
                var state = $(chk).prop('checked');
                $(chk).prop('checked', !state);
                $(chk).trigger('change');
            }
        });
        $('#txtNilaiRKP').on('keydown', function (e) {
            if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 190, 110, 188]) !== -1 ||
            // Allow: Ctrl+A, Command+A
                (e.keyCode == 65 && (e.ctrlKey === true || e.metaKey === true)) ||
            // Allow: home, end, left, right, down, up
                (e.keyCode >= 35 && e.keyCode <= 40)) {
                // let it happen, don't do anything
                return;
            }
            // Ensure that it is a number and stop the keypress
            if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
                e.preventDefault();
            }
        });

        var notif_level = function () {
            var selected = [];
            $('.chk-notif-level').each(function (row, data) {
                if ($(data).prop('checked')) {
                    selected.push($(data).val());
                }
            });
            return selected;
        }


        $('#btnSendEmail').on('click', function (e) {
            e.preventDefault();

            data.MinimalRKP = $('#txtNilaiRKP').val();
            data.target_level = notif_level().join(",");
            data.list_recipient = selectedRow();

            if (Validate("")) {
                $.showOverlay();

                $.postJSON('PengirimanNotifikasi.aspx/SendEmail',
                        JSON.stringify({ data: JSON.stringify(data.list_recipient), target_level: data.target_level, persentase: data.MinimalRKP }))
                    .done(function (data) {
                        var result = $.parseJSON(data.d);
                        if (result.Success)
                            alert("Email telah berhasil dikirim");
                        else {
                            alert(result.Message);
                        }

                    }).fail(function (xhr, status, error) {
                        console.log(xhr);
                        var err = $.parseJSON(xhr.responseText);
                        alert("Gagal menyimpan data\r\n" + err.Message + '\n' + err.StackTrace);
                    }).always(function () {
                        $.hideOverlay();

                    });
            }
        });

        $('#btnGetSchedule').on('click', function (e) {
            e.preventDefault();

            data.MinimalRKP = $('#txtNilaiRKP').val();
            data.target_level = notif_level().join(",");
            if (Validate("getData")) {
                rebindGrid();
            }
        });

        var Validate = function (type) {
            var message = '';

            if (type == "getData") {
                if (data.MinimalRKP < 0 || data.MinimalRKP > 100 || data.MinimalRKP == '')
                    message += '<li>' + 'Batas minimal RKP tidak boleh kurang dari nol atau melebihi seratus persen' + '</li>';
                if (data.target_level == "")
                    message += '<li>' + 'Pilih satu atau lebih, target pemberitahuan ' + '</li>';
            } else {
                if (data.MinimalRKP < 0 || data.MinimalRKP > 100 || data.MinimalRKP == '')
                    message += '<li>' + 'Batas minimal RKP tidak boleh kurang dari nol atau melebihi seratus persen' + '</li>';
                if (data.target_level == "")
                    message += '<li>' + 'Pilih satu atau lebih, target pemberitahuan ' + '</li>';
                if (data.list_recipient.length == 0)
                    message += '<li>' + 'Penerima notifikasi tidak boleh kosong' + '</li>';

            }

            if (message == '') {
                $('#modal-alert').hide();
                $('#modal-alert').html('');
                return true;
            } else {
                $('#modal-alert').html('<ul>' + message + '</ul>');
                $('#modal-alert').show();
                return false;

            }

        }
        function RadGrid1_Command(sender, args) {
            args.set_cancel(true);
            var argument = args.get_commandArgument();
            console.log(argument);
            var grid = sender.get_masterTableView();
            switch (args.get_commandName()) {
                case 'Page':
                    var pageSize = grid.get_pageSize();
                    var pageIndex = argument;
                    bindGrid(pageSize, pageIndex);

                    break;
                case 'PageSize':
                    bindGrid(argument, 1);

                    break;
                case 'Sort':
                    console.log(argument);
                    if (argument != "ClientSelectColumn")
                        sortGrid();
                    break;
            }

        }
        var mtv;
        var oldPageSize = 0;
        function bindGrid(pageSize, pageIndex, list) {
            var grid = $find("<%=RadGrid1.ClientID %>");
            mtv = grid.get_masterTableView();
            if (filteredList == undefined) {
                mtv.set_virtualItemCount(msg.length);
                mtv.set_dataSource(msg);
                console.log('getting from item');
            } else {
                //                mtv.set_virtualItemCount(list.length);
                //                mtv.set_dataSource(list);
                //                console.log('getting from filtered item');
                mtv.set_virtualItemCount(filteredList.length);
                mtv.set_dataSource(filteredList);
            }
            mtv.dataBind();
            oldPageSize = mtv.get_pageSize();
            var startRow = (pageIndex - 1) * pageSize;
            var maxRow = pageIndex * pageSize;
            var trList = $('.rgMasterTable tbody:last tr:not(:last)');
            $.each(trList, function (row, data) {
                if (row < startRow)
                    $(data).hide();
                else if (row >= startRow && row <= maxRow)
                    $(data).show();
                else
                    $(data).hide();

            });

        }

        var _fieldName = '';
        function sortGrid() {
            var grid = $find("<%=RadGrid1.ClientID %>");
            var expr = grid.get_masterTableView().get_sortExpressions().toString();
            _fieldName = expr.split(" ")[0];
            var _order = expr.split(" ")[1];
            var sortParam = sortArray();
            switch (sortParam.length) {
                case 1:
                    msg = msg.sort(firstBy(sortParam[0].field, sortParam[0].order));
                    break;
                case 2:
                    msg = msg.sort(firstBy(sortParam[0].field, sortParam[0].order).
                    thenBy(sortParam[1].field, sortParam[1].order));
                    break;
                case 3:
                    msg = msg.sort(firstBy(sortParam[0].field, sortParam[0].order).
                    thenBy(sortParam[1].field, sortParam[1].order).
                    thenBy(sortParam[2].field, sortParam[2].order));
                    break;
                case 4:
                    msg = msg.sort(firstBy(sortParam[0].field, sortParam[0].order).
                    thenBy(sortParam[1].field, sortParam[1].order).
                    thenBy(sortParam[2].field, sortParam[2].order).
                    thenBy(sortParam[3].field, sortParam[3].order));
                    break;

                default:
                    break;
            }
            bindGrid(oldPageSize, 1);
        }

        $('.rgFilterBox').on('blur', function (e) {
            //            $('.rgFilterBox').trigger(
            //                jQuery.Event('keyup', { keyCode: 13, which: 13 })
            //            );
        });
        $('.rgFilterBox').on('keyup', function (e) {
            var colIndex = $(this).closest('td').index();
            var colName = grid.get_masterTableView().get_columns()[colIndex]._data.UniqueName;
            var searchText = $(this).val();

            var filterObj = [];

            $('.rgFilterBox').each(function (row, data) {
                var obj = {};
                obj._fieldName = grid.get_masterTableView().get_columns()[row + 1]._data.UniqueName;
                obj._value = $(data).val();
                filterObj.push(obj);
            });
            if (e.keyCode == 13) {
                if (searchText != "") {
                    list = Enumerable.From(msg);
                    var result = [];
                    $.each(filterObj, function (row, data) {
                        if (data._value != '') {
                            if (result.length == 0)
                                result = list.Where("$." + data._fieldName + ".toString().toLowerCase().indexOf('" + data._value + "') > -1").ToJSON();
                            else {
                                list = Enumerable.From($.parseJSON(result));
                                result = list.Where("$." + data._fieldName + ".toString().toLowerCase().indexOf('" + data._value + "') > -1").ToJSON();
                            }
                        }
                    });
                    filteredList = $.parseJSON(result);
                    bindGrid(oldPageSize, 1, filteredList);
                } else {
                    filteredList = msg;
                    bindGrid(oldPageSize, 1, filteredList);
                }
            }
        });


        var sortArray = function () {
            var arr = [];
            $.each(grid.get_masterTableView().get_sortExpressions().toString().split(','),
                    function (row, data) {
                        if (data != null && data != undefined && data != '') {
                            var sortObj = {};
                            sortObj.field = data.split(' ')[0];
                            sortObj.order = data.split(' ')[1] == "" ? 0 : data.split(' ')[1] == "ASC" ? 1 : -1;
                            arr.push(sortObj);
                        }
                    });
            return arr;

        };


        function OnColumnClick(sender, args) {
            var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();
            masterTable.sort(args.get_gridColumn().get_uniqueName());
        }

        function AddFilterExpression(grid, columnUniqueName, dataField, filterFunction, filterValue) {
            //            var filterExpression = new Telerik.Web.UI.GridFilterExpression();
            //            var column = grid.get_masterTableView().getColumnByUniqueName(columnUniqueName);
            //            column.set_filterFunction("Contains");
            //            filterExpression.set_fieldName(dataField);
            //            filterExpression.set_fieldValue(filterValue);
            //            filterExpression.set_filterFunction(filterFunction);
            //            filterExpression.set_columnUniqueName(columnUniqueName);
            //            grid.get_masterTableView()._updateFilterControlValue(filterValue, columnUniqueName, filterFunction);
            //            grid.get_masterTableView()._filterExpressions.add(filterExpression);
        }

        var filteredList = undefined;

        var filteredItem = function () {


        }
    </script>
</asp:Content>
