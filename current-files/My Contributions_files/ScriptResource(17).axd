$(function()
{
    var hideDelay = 500;
    var currentID;
    var hideTimer = null;
    var ajax = null;
    var hideFunction = function()
    {
        if (hideTimer)
            clearTimeout(hideTimer);
        hideTimer = setTimeout(function()
        {
            currentPosition = { left: '0px', top: '0px' };
            container.css('display', 'none');
        }, hideDelay);
    };

    var currentPosition = { left: '0px', top: '0px' };

    // One instance that's reused to show info for the current person
    var container = $('<div id="personPopupContainer">'
        + '<table width="" border="0" cellspacing="0" cellpadding="0" align="center" class="personPopupPopup">'
        + '<tr>'
	    + '   <td class="corner topLeft"></td>'
	    + '   <td class="top"></td>'
	    + '   <td class="corner topRight"></td>'
        + '</tr>'
        + '<tr>'
	    + '   <td class="left">&nbsp;</td>'
	    + '   <td><div id="personPopupContent"></div></td>'
	    + '   <td class="right">&nbsp;</td>'
        + '</tr>'
        + '<tr>'
        + '   <td class="corner bottomLeft">&nbsp;</td>'
        + '   <td class="bottom">&nbsp;</td>'
        + '   <td class="corner bottomRight"></td>'
        + '</tr>'
        + '</table>'
        + '</div>');

    $('body').append(container);

    $(document).on('mouseover', '.personPopupWrap .trigger', function ()
    {
        if (!$(this).data('hoverIntentAttached'))
        {
            $(this).data('hoverIntentAttached', true);
            $(this).hoverIntent
            (
                // hoverIntent mouseOver
                function()
                {
                    if (hideTimer)
                        clearTimeout(hideTimer);

                    // format of 'rel' tag: pageid,personguid
                    var settings = $(this).attr('rel').split(',');
                    var pageID = settings[0];
                    currentID = settings[1];

                    // If no guid in url rel tag, don't popup blank
                    // If not a valid page, don't popup blank
                    if (currentID == '' || pageID == '-1')
                        return;

                    var pos = $(this).offset();
                    var width = $(this).width();
                    var reposition = { left: (pos.left + width) + 'px', top: pos.top - 5 + 'px' };

                    // If the same popup is already shown, then don't requery
                    if (currentPosition.left == reposition.left &&
                        currentPosition.top == reposition.top)
                        return;

                    container.css({
                        left: reposition.left,
                        top: reposition.top
                    });

                    currentPosition = reposition;

                    $('#personPopupContent').html('&nbsp;');

                    if (ajax)
                    {
                        ajax.abort();
                        ajax = null;
                    }

                    ajax = $.ajax({
                        type: 'GET',
                        url: 'mobile.aspx',
                        data: 'page=' + pageID + '&guid=' + currentID,
                        success: function(data)
                        {
                            // Verify that we're pointed to a page that returned the expected results.
                            if (data.indexOf('personPopupResult') < 0)
                            {
                                $('#personPopupContent').html('<span style="color:red" class="smallText">Page ' + pageID + ' did not return a valid result for person ' + currentID + '.<br />Please have your administrator check the error log.</span>');
                            }

                            // Verify requested person is this person since we could have multiple ajax
                            // requests out if the server is taking a while.
                            if (data.indexOf(currentID) > 0)
                            {
                                var text = $(data).find('.personPopupResult').html();
                                $('#personPopupContent').html(text);
                            }
                        }
                    });

                    container.css('display', 'block');
                },
                // hoverIntent mouseOut
                hideFunction
            );
            // Fire mouseover so hoverIntent can start doing its magic
            $(this).trigger('mouseover');
        }
    });

    // Allow mouse over of details without hiding details
    $('#personPopupContainer').mouseover(function()
    {
        if (hideTimer)
            clearTimeout(hideTimer);
    });

    // Hide after mouseout
    $('#personPopupContainer').mouseout(hideFunction);
});