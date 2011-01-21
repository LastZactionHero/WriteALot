/**
 * Graphing with Google Graph API
 */

function generateGraphWordsThisWeek
	(
	in_div_graph		
	)
{
	div_graph = document.getElementById( in_div_graph );
	if( div_graph )
	{
		var chartMax = 0;
		var data = getDataString( "words_this_week" ).split( ',' );
		for( var i = 0; i < data.length; i++ )
		{
			if( parseInt( data[i] ) > chartMax )
				chartMax = parseInt( data[i] );
		}
		
		div_graph.innerHTML = "<img src=\"http://chart.apis.google.com/chart" +
									"?chxl=1:|Sun|Mon|Tues|Wed|Thur|Fri|Sat" +
									"&chxr=0,0," + chartMax + "|1,0,6" +
									"&chxt=y,x" +
									"&chbh=a" +
									"&chs=250x225" +
									"&cht=bvg" +
									"&chco=003DF5" +
									"&chds=0," + chartMax + 
									"&chd=t:" + getDataString( "words_this_week" ) +  
									"&chtt=Words+this+Week\"" +
									" width=\"250\"" +
									" height=\"225\"" +
									" alt=\"Words this Week\" />";

	}
}


function generateGraphWordsEveryWeek
	(
	in_div_graph		
	)
{
	div_graph = document.getElementById( in_div_graph );
	if( div_graph )
	{
		var chartMax = 0;
		var data = getDataString( "words_every_week" ).split( ',' );
		for( var i = 0; i < data.length; i++ )
		{
			if( parseInt( data[i] ) > chartMax )
				chartMax = parseInt( data[i] );
		}
		
		div_graph.innerHTML = "<img src=\"http://chart.apis.google.com/chart" +
									"?chxl=1:|Sun|Mon|Tues|Wed|Thur|Fri|Sat" +
									"&chxr=0,0," + chartMax + "|1,0,6" +
									"&chxt=y,x" +
									"&chbh=a" +
									"&chs=250x225" +
									"&cht=bvg" +
									"&chco=003DF5" +
									"&chds=0," + chartMax + 
									"&chd=t:" + getDataString( "words_every_week" ) + 
									"&chtt=Words/Weekday+(60+Days)\"" +
									" width=\"250\"" +
									" height=\"225\"" +
									" alt=\"Words this Week\" />";

	}
}

function generateGraphWordsEachWeek
(
in_div_graph		
)
{
div_graph = document.getElementById( in_div_graph );
if( div_graph )
{
	var chartMax = 0;
	var data = getDataString( "words_each_week" ).split( ',' );
	for( var i = 0; i < data.length; i++ )
	{
		if( parseInt( data[i] ) > chartMax )
			chartMax = parseInt( data[i] );
	}
	
	div_graph.innerHTML = "<img src=\"http://chart.apis.google.com/chart" +
								"?chxr=0,0," + chartMax + "|1,1,52" +
								"&chxs=1,676767,9,0,l,676767" +
								"&chxt=y,x" +
								"&chbh=a" +
								"&chs=575x225" +
								"&cht=bvg" +
								"&chco=003DF5" +
								"&chds=0," + chartMax +
								"&chd=t:" + getDataString( "words_each_week" ) +
								"&chtt=Words+Each+Week+this+Year\"" + 
								" width=\"575\"" +
								" height=\"225\"" +
								" alt=\"Words Each Week\" />";
	}
}


function generateGraphSocialWordsThisWeek
(
in_div_graph,
in_size
)
{
div_graph = document.getElementById( in_div_graph );
if( div_graph )
{
	var chartMax = 0;
	var data_sets = getDataString( "social_words_this_week" ).split( '|' );
	
	for( var setIdx = 0; setIdx < data_sets.length; setIdx++ )
	{
		if( data_sets[setIdx] != "-1" )
		{
			data = data_sets[setIdx].split( ',' );
			
			for( var dayIdx = 0; dayIdx < data.length; dayIdx++ )
			{
				if( parseInt( data[dayIdx] ) > chartMax ) 
				{
					chartMax = parseInt( data[dayIdx] );
				}
			}
			
		}
	}
	
	var userList = getUserString().split( '|' );
	
	colorString = "";
	for( var colorIdx = 0; colorIdx < userList.length; colorIdx++ )
	{
		colorString = colorString + getColor( colorIdx );
		if( colorIdx != userList.length -1 )
		{
			colorString = colorString + ",";
		}
	}
	
	var chartDim = getDimensions( in_size );
	
	div_graph.innerHTML = "<img src=\"http://chart.apis.google.com/chart" +
								"?chxl=1:|Sun|Mon|Tues|Wed|Thurs|Fri|Sat" +
								"&chxr=0,0," + chartMax + "|1,0,7" +
								"&chxt=y,x" +
								"&chs=" + 550 + "x" + 300 +
								"&cht=lxy" +
								"&chco=" + colorString +
								"&chds=0," + chartMax +
								"&curveType=function"+								
								"&chd=t:" + getDataString( "social_words_this_week" ) +
								"&chdl=" + getUserString() +
								"&chdlp=b" +
								"&chma=5,5,5,25" +
								"&chtt=Words+this+Week\" " + 
								"width=\"" + chartDim[0] + "\" " +
								"height=\"" + chartDim[1] + "\" " +
								"alt=\"Words this Week\" />";
	if( in_size == "thumbnail" )
		div_graph.innerHTML += "<br>Words this Week"
	}
}


function generateGraphSocialWordsEveryWeek
(
in_div_graph,
in_size		
)
{
div_graph = document.getElementById( in_div_graph );
if( div_graph )
{
	var chartMax = 0;
	var data_sets = getDataString( "social_words_every_week" ).split( '|' );
	
	for( var setIdx = 0; setIdx < data_sets.length; setIdx++ )
	{
		if( data_sets[setIdx] != "-1" )
		{
			data = data_sets[setIdx].split( ',' );
			
			for( var dayIdx = 0; dayIdx < data.length; dayIdx++ )
			{
				if( parseInt( data[dayIdx] ) > chartMax ) 
				{
					chartMax = parseInt( data[dayIdx] );
				}
			}
			
		}
	}
	
	var userList = getUserString().split( '|' );
	
	colorString = "";
	for( var colorIdx = 0; colorIdx < userList.length; colorIdx++ )
	{
		colorString = colorString + getColor( colorIdx );
		if( colorIdx != userList.length -1 )
		{
			colorString = colorString + ",";
		}
	}
	
	var chartDim = getDimensions( in_size );
	
	div_graph.innerHTML = "<img src=\"http://chart.apis.google.com/chart" +
								"?chxl=1:|Sun|Mon|Tues|Wed|Thurs|Fri|Sat" +
								"&chxr=0,0," + chartMax + "|1,0,7" +
								"&chxt=y,x" +
								"&chs=" + 550 + "x" + 300 +
								"&cht=lxy" +
								"&chco=" + colorString +
								"&chds=0," + chartMax +
								"&chd=t:" + getDataString( "social_words_every_week" ) +
								"&chdl=" + getUserString() +
								"&chdlp=b" +
								"&chma=5,5,5,25" +
								"&chtt=Cumulative+Words+per+Weekday+(60+Days)\" " + 
								"width=\"" + chartDim[0] + "\" " +
								"height=\"" + chartDim[1] + "\" " +
								"alt=\"Cumulative Words per Weekday\" />";
	if( in_size == "thumbnail" )
		div_graph.innerHTML += "<br>Words/Weekday"
	}
}


function generateGraphSocialMinutesEveryWeek
(
in_div_graph,
in_size		
)
{
div_graph = document.getElementById( in_div_graph );
if( div_graph )
{
	var chartMax = 0;
	var data_sets = getDataString( "social_minutes_every_week" ).split( '|' );
	
	for( var setIdx = 0; setIdx < data_sets.length; setIdx++ )
	{
		if( data_sets[setIdx] != "-1" )
		{
			data = data_sets[setIdx].split( ',' );
			
			for( var dayIdx = 0; dayIdx < data.length; dayIdx++ )
			{
				if( parseInt( data[dayIdx] ) > chartMax ) 
				{
					chartMax = parseInt( data[dayIdx] );
				}
			}
			
		}
	}
	
	var userList = getUserString().split( '|' );
	
	colorString = "";
	for( var colorIdx = 0; colorIdx < userList.length; colorIdx++ )
	{
		colorString = colorString + getColor( colorIdx );
		if( colorIdx != userList.length -1 )
		{
			colorString = colorString + ",";
		}
	}
	
	var chartDim = getDimensions( in_size );
	
	div_graph.innerHTML = "<img src=\"http://chart.apis.google.com/chart" +
								"?chxl=1:|Sun|Mon|Tues|Wed|Thurs|Fri|Sat" +
								"&chxr=0,0," + chartMax + "|1,0,7" +
								"&chxt=y,x" +
								"&chs=" + 550 + "x" + 300 +
								"&cht=lxy" +
								"&chco=" + colorString +
								"&chds=0," + chartMax +
								"&chd=t:" + getDataString( "social_minutes_every_week" ) +
								"&chdl=" + getUserString() +
								"&chdlp=b" +
								"&chma=5,5,5,25" +
								"&chtt=Cumulative+Minutes+per+Weekday+(60+Days)\" " + 
								"width=\"" + chartDim[0] + "\" " +
								"height=\"" + chartDim[1] + "\" " +
								"alt=\"Cumulative Minutes per Weekday\" />";
	
	if( in_size == "thumbnail" )
		div_graph.innerHTML += "<br>Time/Weekday"
	}
}


/**
 * Social Words Each Week
 */
function generateGraphSocialWordsEachWeek
(
in_div_graph,
in_size		
)
{
div_graph = document.getElementById( in_div_graph );
if( div_graph )
{
	var chartMax = 0;
	var data_sets = getDataString( "social_words_each_week" ).split( '|' );
	for( var setIdx = 0; setIdx < data_sets.length; setIdx++ )
	{
		if( data_sets[setIdx] != "-1" )
		{
			data = data_sets[setIdx].split( ',' );
			
			for( var dayIdx = 0; dayIdx < data.length; dayIdx++ )
			{
				if( parseInt( data[dayIdx] ) > chartMax ) 
				{
					chartMax = parseInt( data[dayIdx] );
				}
			}
			
		}
	}
	
	var userList = getUserString().split( '|' );
	
	colorString = "";
	for( var colorIdx = 0; colorIdx < userList.length; colorIdx++ )
	{
		colorString = colorString + getColor( colorIdx );
		if( colorIdx != userList.length -1 )
		{
			colorString = colorString + ",";
		}
	}
	
	var chartDim = getDimensions( in_size );
	
	div_graph.innerHTML = "<img src=\"http://chart.apis.google.com/chart" +
								"?chxr=0,1,52|1,0," + chartMax +
								"&chxt=x,y" +
								"&chs=" + 550 + "x" + 300 +
								"&cht=lxy" +
								"&chco=" + colorString +
								"&chds=0," + chartMax +
								"&chd=t:" + getDataString( "social_words_each_week" ) + 
								"&chdl=" + getUserString() +
								"&chdlp=b" +
								"&chma=5,5,5,25" +
								"&chtt=Words+Each+Week+this+Year\" " + 
								"width=\"" + chartDim[0] + "\" " +
								"height=\"" + chartDim[1] + "\" " +
								"alt=\"Words Each Week this Year\" />";
	if( in_size == "thumbnail" )
		div_graph.innerHTML += "<br>Words Each Week"
	}
}


function generateGraphSocialMinutesThisWeek
(
in_div_graph,
in_size		
)
{
div_graph = document.getElementById( in_div_graph );
if( div_graph )
{	
	var chartMax = 0;
	var data_sets = getDataString( "social_minutes_this_week" ).split( '|' );
	
	for( var setIdx = 0; setIdx < data_sets.length; setIdx++ )
	{
		if( data_sets[setIdx] != "-1" )
		{
			data = data_sets[setIdx].split( ',' );
			
			for( var dayIdx = 0; dayIdx < data.length; dayIdx++ )
			{
				if( parseInt( data[dayIdx] ) > chartMax ) 
				{
					chartMax = parseInt( data[dayIdx] );
				}
			}
			
		}
	}
	
	var userList = getUserString().split( '|' );
	
	colorString = "";
	for( var colorIdx = 0; colorIdx < userList.length; colorIdx++ )
	{
		colorString = colorString + getColor( colorIdx );
		if( colorIdx != userList.length -1 )
		{
			colorString = colorString + ",";
		}
	}
	
	var chartDim = getDimensions( in_size );
	
	div_graph.innerHTML = "<img src=\"http://chart.apis.google.com/chart" +
								"?chxl=1:|Sun|Mon|Tues|Wed|Thurs|Fri|Sat" +
								"&chxr=0,0," + chartMax + "|1,0,7" +
								"&chxt=y,x" +
								"&chs=" + 550 + "x" + 300 +
								"&cht=lxy" +
								"&chco=" + colorString +
								"&chds=0," + chartMax +
								"&curveType=function"+								
								"&chd=t:" + getDataString( "social_minutes_this_week" ) +
								"&chdl=" + getUserString() +
								"&chdlp=b" +
								"&chma=5,5,5,25" +
								"&chtt=Minutes+this+Week\" " + 
								"width=\"" + chartDim[0] + "\" " +
								"height=\"" + chartDim[1] + "\" " +
								"alt=\"Minutes this Week\" />";
	if( in_size == "thumbnail" )
		div_graph.innerHTML += "<br>Time This Week"
	}
}


/**
 * Get Chart Dimensions
 */
function getDimensions
	(
	in_type
	)
{
	var size = new Array;

	if( in_type == "full" )
	{
		size[0] = 550;
		size[1] = 300;
	}
	else if( in_type == "thumbnail" )
	{
		size[0] = 100;
		size[1] = 75;
	}
	else
	{
		size[0] = 0;
		size[1] = 0;
	}
	
	return size;
}

/**
 * Get Color for Index
 */
function getColor
	(
	inIdx
	)
{
	colors = [ "4E00EB", "44FF00", "FF7029", "FFFF33", "5CB800", "33FFFF", "666600", "660033", "000066" ];
	return colors[inIdx];
}


