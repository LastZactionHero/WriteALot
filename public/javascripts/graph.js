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
		var data = getDataString().split( ',' );
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
									"&chco=A2C180" +
									"&chds=0," + chartMax + 
									"&chd=t:" + getDataString() + 
									"&chtt=Words+this+Week\"" +
									" width=\"400\"" +
									" height=\"225\"" +
									" alt=\"Words this Week\" />";

	}
}