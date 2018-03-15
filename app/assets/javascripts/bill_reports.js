
/***
 * toggleDivsWithCheckbox - toggle between two divs using a checkbox.
 * I used this to toggle between regular and skinny classes in reports.
 * 
 *	cb - the checkbox must be the first param
 *	checkDiv - the CSS class name present when checkbox is on
 *	uncheckDiv - the CSS class name present when checkbox is off
 *	
 * Example call: 
 *		<input type="checkbox" id="toggleCheckbox" 
 *					checkDiv="skinny-report-div" uncheckDiv="regular-report-div"
 *					onclick="toggleDivsWithCheckbox(this)">
 ***/
function toggleDivsWithCheckbox( cb) {
	var checkDivName = cb.getAttribute( "checkDiv");
	var uncheckDivName = cb.getAttribute( "uncheckDiv");

	var divList;
	if( cb.checked == true) {
		divList = document.querySelectorAll("." + uncheckDivName);
	}
	else {
		divList = document.querySelectorAll("." + checkDivName);
	}

	for( var i = 0; i < divList.length; i++) {
		divList[i].classList.toggle( checkDivName);
		divList[i].classList.toggle( uncheckDivName);
	}
}

/***
 * toggleDivDisplay - toggles the display of a div using a checkbox.
 * The display of all divs with a CSS class name are controlled by the checkbox.
 * 
 *	cb - the checkbox must be the first param
 *	theDiv - the CSS class name of the div(s) to be toggled
 * 
 * Example: divs named report-page-break are controlled
 * 
 *		<input type="checkbox" id="pagebreakCheckbox" 
 *					theDiv="report-page-break" onclick="toggleDivDisplay(this)">
 ***/
function toggleDivDisplay( cb) {
	// get all divs with the CSS class name specified
	var divName = cb.getAttribute( "theDiv");
	var divs = document.querySelectorAll("." + divName);

	// based on the checkbox value, display or hide all these divs
	for( var i = 0; i < divs.length; i++) {
		if( cb.checked == true) {
			divs[i].style.display = "block"; 
		}
		else {
			divs[i].style.display = "none"; 
		}
	}
}  // toggleDivDisplay()

/***
 * swapDivs - swaps the display of two divs using a checkbox.
 * The display of all divs with a CSS class name are controlled by the checkbox.
 * 
 *	cb - the checkbox must be the first param
 *	theCheckedDiv - the CSS class name of the div visible when checked
 *	theNotCheckedDiv - the CSS class name of the div visible when NOT checked
 * 
 * Example: two divs show-on-skinny-only and show-on-regular-only are swapped
 * 
 *		<input type="checkbox" id="skinnyCheckbox" class="pull-left" 
 *					theCheckedDiv="show-on-skinny-only"
 *					theNotCheckedDiv="show-on-regular-only" 
 *					onclick="swapDivs(this)">
 ***/
function swapDivs(cb) {
	// get the div names, they're attrs of the checkbox
	var checkedDivName = cb.getAttribute( "theCheckedDiv");
	var notcheckedDivName = cb.getAttribute( "theNotCheckedDiv");

	// get the divs
	var checkedDivs = document.querySelectorAll("." + checkedDivName);
	var notcheckedDivs = document.querySelectorAll("." + notcheckedDivName);

	// if checked, make checked divs visible... and vise versa
	if( cb.checked == true) {
		for( var i = 0; i < checkedDivs.length; i++) {
			checkedDivs[i].style.display = "block";		// checked is visible
		}
		for( var i = 0; i < notcheckedDivs.length; i++) {
			notcheckedDivs[i].style.display = "none";		// NOT checked is hidden
		}
	}
	else {
		for( var i = 0; i < checkedDivs.length; i++) {
			checkedDivs[i].style.display = "none";		// checked is hidden
		}
		for( var i = 0; i < notcheckedDivs.length; i++) {
			notcheckedDivs[i].style.display = "block";		// NOT checked is visible
		}
	}
}   // swapDivs()
