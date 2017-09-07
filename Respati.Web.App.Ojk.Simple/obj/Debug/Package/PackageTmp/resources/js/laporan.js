//function OnColumnClick(sender, args) {
//    var masterTable = $.find("<%= RadGrid1.ClientID %>").get_masterTableView();
//    masterTable.sort(args.get_gridColumn().get_uniqueName());
//}

//$('.rgFilterRow').on('keypress', function (e) {
//    console.log($(this));
//});
function doFilter(sender, e) {
    if (e.keyCode == 13) {
        e.cancelBubble = true;
        e.returnValue = false;
        if (e.stopPropagation) {
            e.stopPropagation();
            e.preventDefault();
        }
        var masterTable = $find("<%= RadGrid1.ClientID %>").get_masterTableView();

        masterTable.filter("column_name", sender.value, Telerik.Web.UI.GridFilterFunction.Contains);
    }
}