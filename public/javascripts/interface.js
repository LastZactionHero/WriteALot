/**
 * Set Tab Highlight
 */
function setTabHighlight
	(
	aPage		
	)
{
	document.getElementById( "div_tab_log" ).style.backgroundColor = "black";
	document.getElementById( "div_tab_stats" ).style.backgroundColor = "black";
	document.getElementById( "div_tab_social" ).style.backgroundColor = "black";
	
	if( aPage == "log" )
	{
		document.getElementById( "div_tab_log" ).style.backgroundColor = "#00aef0";	
	}
	else if( aPage == "stats" )
	{
		document.getElementById( "div_tab_stats" ).style.backgroundColor = "#00aef0";	
	}
	else if( aPage == "social" )
	{
		document.getElementById( "div_tab_social" ).style.backgroundColor = "#00aef0";	
	}

}