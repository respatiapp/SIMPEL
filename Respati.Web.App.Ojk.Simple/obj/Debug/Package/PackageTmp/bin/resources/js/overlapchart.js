(function () {
    var $;
    var demo = window.demo = window.demo || {};
    var orgChart;

    demo.initialize = function () {
        $ = $telerik.$;
        orgChart = window.orgChart;
        setup();
    };

    function setup() {
        if ($telerik.isIE6 || $telerik.isIE7)
            return;

        var orgElement = orgChart.get_element();

        $(orgElement).delegate(".rocItemWrap", "mouseenter", function (e) {
            var currentItem = $(this);
            currentItem.css("z-index", 1000);
            var nextItems = currentItem.nextAll();
            for (var i = nextItems.length - 1; i >= 0; i--) {
                $(nextItems[i]).css("z-index", 200 - i);
            }

            var previousItems = currentItem.prevAll();

            for (var prevIndex = previousItems.length - 1; prevIndex >= 0; prevIndex--) {
                $(previousItems[prevIndex]).css("z-index", 200 - prevIndex);
            }

        });

        $(orgElement).delegate(".rocItemWrap", "mouseleave", function (e) {
            $(this).css("z-index", 10);
            $(this).nextAll().css("z-index", 10);
            $(this).prevAll().css("z-index", 10);
        });
    }


})();