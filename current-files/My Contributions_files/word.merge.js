//page load
//$(function() {
$(window).load(function () {
    var wordMergeMenu = $(".WordMergeMenu");
    var wordMergeImage = $("input[type='image'][id$='ibMerge']");
    if (wordMergeImage.length > 0) {
        wordMergeMenu.dialog({
            autoOpen: false,
            width: 300,
            modal: true,
            title: 'Word Merge',
            resizable: false,
            buttons: {
                "Close": function () {
                    $(this).dialog("close");
                }
            }
        });

        //wrap items with div to allow scrolling
        wordMergeMenu.wrap("<div style='overflow: auto; height:250px;' />");

        //html message inserted at top of dialog
        $("<div style='margin: 5px auto; width: 250px'>Please select a document to merge with:</div>").insertBefore(wordMergeMenu);

        //style
        $(".WordMergeMenu tr").css({
            'height': '20px'
        });

        //word icon click
        $("[id$='_ibMerge']").click(function () {
            if (wordMergeMenu.length > 1) {
                wordMergeMenu.filter('.WordMergeMenu[id*=' + $(this).attr("parent_gridid") + ']')
                    .css({ 'visibility': 'visible' })
                    .dialog('open');
            }
            else {
                wordMergeMenu.css({ 'visibility': 'visible' }).dialog('open');
            }
            return false;
        });
    }
});
   
   