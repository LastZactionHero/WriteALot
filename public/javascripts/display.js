/**
 * Display Controls
 */

/**
 * Get Browser Window Width
 * 
 * @return {int} Window Width
 */
function getWindowWidth()
{
	return window.innerWidth;
}

/**
 * Get Browser Window Height
 * @return {int} Window Height
 */
function getWindowHeight()
{
	height = 500;
	if( window.innerHeight )
		height = window.innerHeight;
	else if( document.documentElement.clientHeight )
		height = document.documentElement.clientHeight;
	
	return height;
}