/**
 * CS 3360
 * Project 2: AspectJ
 * @author Matthew Montoya
 * @author Jaime Sanchez
 * @author Samuel Tinevra
 * Purpose:
 * Last Modified: 6 November 2018
 * 
 * 
 * FEATURE 1: Makes Disks Larger When Clicked By User
 */

package c4.ext;
import c4.base.*;
import c4.model.*;
@SuppressWarnings("unused")

public privileged aspect PressDisc{
	
	//feature enable
//	private static final boolean DISABLED = false;
	
	pointcut mouseClick():
		execution(void mouseClicked(..));
	
	before(): mouseClick(){
		mouseAdapter.
	}
	
	
	
}