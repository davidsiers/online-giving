function highlightDataGridRow(datagridid, itemid, itemColor, altItemColor, highlightColor)
{
	var currentElement = $get(datagridid + '_row_' + itemid);
	if (currentElement != null)
	{
		var oldBackground = getDataGridNormalRowColor(currentElement, itemColor, altItemColor);
		currentElement.temp_onmouseover = currentElement.onmouseover;
		currentElement.temp_onmouseout = currentElement.onmouseout;
		currentElement.onmouseover = null;
		currentElement.onmouseout = null;
		
		var animations = new Array();
		var enableScript = "var _curEle = $get('" + currentElement.id + "');"
		enableScript += "_curEle.onmouseover = _curEle.temp_onmouseover;";
		enableScript += "_curEle.onmouseout = _curEle.temp_onmouseout;";
		
		Array.add(animations, new AjaxControlToolkit.Animation.ColorAnimation(currentElement, 0.5, 30, "style", "backgroundColor", highlightColor, highlightColor)); 
		Array.add(animations, new AjaxControlToolkit.Animation.ColorAnimation(currentElement, 0.20, 30, "style", "backgroundColor", highlightColor, oldBackground)); 
		Array.add(animations, new AjaxControlToolkit.Animation.ScriptAction(currentElement, 0, 0, enableScript)); 
		AjaxControlToolkit.Animation.SequenceAnimation.play(currentElement, 0, 0, animations, 1);
	}
}
function getDataGridNormalRowColor(datagridrow, itemColor, altItemColor)
{
	if (datagridrow.className == 'listItem')
		return itemColor;
	else
		return altItemColor;
}
function confirmDGDelete(sender, text, itemColor, altItemColor, highlightColor)
{
	var currentElement = sender;
	while (currentElement != null && currentElement.tagName != "TR")
		currentElement = currentElement.parentNode;
	
	var oldColor = getDataGridNormalRowColor(currentElement, itemColor, altItemColor);
	var oldOnMouseOver = currentElement.onmouseover;
	var oldOnMouseOut = currentElement.onmouseout;
	currentElement.onmouseover = null;
	currentElement.onmouseout = null;

	currentElement.style.backgroundColor = highlightColor;
	var confirmed = confirm(text);
	// Restore old styles and functionality if cancelling delete.  Don't care
	// if deleting since it will be reloaded anyways.
	if (!confirmed)
	{
		currentElement.style.backgroundColor = oldColor;
		currentElement.onmouseover = oldOnMouseOver;
		currentElement.onmouseout = oldOnMouseOut;
	}
	return confirmed;
}

function alertDGDelete(sender, text, itemColor, altItemColor, highlightColor) {
    var currentElement = sender;
    while (currentElement != null && currentElement.tagName != "TR")
        currentElement = currentElement.parentNode;

    var oldColor = getDataGridNormalRowColor(currentElement, itemColor, altItemColor);
    var oldOnMouseOver = currentElement.onmouseover;
    var oldOnMouseOut = currentElement.onmouseout;
    currentElement.onmouseover = null;
    currentElement.onmouseout = null;

    currentElement.style.backgroundColor = highlightColor;
    alert(text);

    currentElement.style.backgroundColor = oldColor;
    currentElement.onmouseover = oldOnMouseOver;
    currentElement.onmouseout = oldOnMouseOut;
    
    return false;
}