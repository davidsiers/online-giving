	function popup(msg)
	{			
		var divPanel = document.getElementById('popOver');
		if (divPanel != null)
		{
			var content="<table><tr><td>"+msg+"</td></tr></table>";

			divPanel.innerHTML=content;			
			divPanel.style.display = 'block';
			divPanel.style.visibility = 'visible';								
		}
	}
	
    function popupBlob(msg)
	{
		popup("<img border='0' src='CachedBlob.aspx?width=120&height=120&guid=" + msg + "'>");
	}

	function popupImg(msg)
	{			
		popup("<img border='0' src='" + msg + "'>");
	}

	function popupImgFile(msg)
	{			
		popup("<img border='0' src='picview.aspx?size=small&file=" + msg + "'>");
	}

	function popupDetails(msg)
	{				
		var divPanel = document.getElementById('popOver');;
		if (divPanel != null)
		{
			var content="<div class='list' style='border:1px #B1B1B1 ridge;background-color:#FFFFFF;width:100px'><div id='posPanel'></div>" + msg + "</div>";
		
			divPanel.innerHTML=content;			
			divPanel.style.display = 'block';
			divPanel.style.visibility = 'visible';								
		}
	}
	
	function get_mouse(myEvent)
	{
		var divPanel = document.getElementById('popOver');


		if (divPanel != null)
		{
			
		// New script - 6/18/07
		var divName = 'popOver'; // div that is to follow the mouse
		var offX = 15;          // X offset from mouse position
		var offY = 15;          // Y offset from mouse position

		function mouseX(evt) {
			if (!evt) evt = window.event; 
			if (evt.pageX) return evt.pageX; 
			else if (evt.clientX) return evt.clientX + (document.documentElement.scrollLeft ?  document.documentElement.scrollLeft : document.body.scrollLeft); 
			else return 0;
		}
		function mouseY(evt) {
			if (!evt) evt = window.event; 
			if (evt.pageY) return evt.pageY; 
			else if (evt.clientY) return evt.clientY + (document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop); 
			else return 0;
		}

		function follow(evt) {
			if (document.getElementById) {
			
				var obj = document.getElementById(divName); 
				obj.style.visibility = 'hidden';
				
                var ScrollLeft = (document.documentElement.scrollLeft ?  document.documentElement.scrollLeft : document.body.scrollLeft)
                var windowWidth = (document.all ? document.body.offsetWidth : window.innerWidth);
				if ( parseInt(mouseX(evt))+offX >= ScrollLeft + windowWidth - obj.offsetWidth) 
					obj.style.left = ScrollLeft + (parseInt(mouseX(evt))-offX) - obj.offsetWidth + 'px';
				else
					obj.style.left = (parseInt(mouseX(evt))+offX) + 'px';
				
                var ScrollTop = (document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop); 
                var windowHeight = (document.all ? document.documentElement.offsetHeight : window.innerHeight);
				if ( parseInt(mouseY(evt))+offY >= ScrollTop + windowHeight - obj.offsetHeight) 
					obj.style.top = ScrollTop + windowHeight - obj.offsetHeight + 'px';
				else 
					obj.style.top = (parseInt(mouseY(evt))+offY) + 'px';

				obj.style.visibility = 'visible';
			}
		}
        
        document.onmousemove = follow;

		}
	}
	
	function kill()
	{		
		var divPanel = document.getElementById('popOver');;
		if (divPanel != null)
		{
			divPanel.style.display = 'none';
			divPanel.style.visibility = 'hidden';
		}				
	}
