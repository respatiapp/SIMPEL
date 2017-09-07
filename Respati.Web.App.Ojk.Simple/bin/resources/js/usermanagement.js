$.extend({
    postJSON: function(url, data) {
        if (data === undefined)
            data = {};
        return $.ajax({
            type: "POST",
            contentType: 'application/json',
            url: url,
            data: data,
            dataType: 'json'

        });
    },
    showOverlay: function () {
        $('#loader').fadeIn('slow');
    },
    hideOverlay: function () {
        $('#loader').fadeOut('slow');
    }

});

$.fn.extend({
    addOption: function (list, displayText, value) {
        var option = "";
        var text = '';
        var val = '';
        $.each(list, function (row, data) {
            if (displayText == undefined) {
                text = data;
                val = data;
            } else {
                text = data[displayText.toString()];
                val = data[value.toString()];
            }

            option += '<option value="' + val + '">' + text + '</option>';
        });
        $(this).find('option').remove();
        this.append(option);
    }
});
