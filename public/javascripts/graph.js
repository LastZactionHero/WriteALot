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
									"&chs=400x225" +
									"&cht=bvg" +
									"&chco=003DF5" +
									"&chds=0," + chartMax + 
									"&chd=t:" + getDataString( "words_this_week" ) + 
									"&chtt=Words+this+Week\"" +
									" width=\"400\"" +
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
									"&chs=400x225" +
									"&cht=bvg" +
									"&chco=003DF5" +
									"&chds=0," + chartMax + 
									"&chd=t:" + getDataString( "words_every_week" ) + 
									"&chtt=Cumulative+Words+per+Weekday\"" +
									" width=\"400\"" +
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
								"&chs=700x225" +
								"&cht=bvg" +
								"&chco=003DF5" +
								"&chds=0," + chartMax +
								"&chd=t:" + getDataString( "words_each_week" ) +
								"&chtt=Words+Each+Week+this+Year\"" + 
								" width=\"700\"" +
								" height=\"225\"" +
								" alt=\"Words Each Week\" />";
	}
}