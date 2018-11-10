/**
 * CS 3360
 * Project 2: AspectJ
 * @author Matthew Montoya
 * @author Jaime Sanchez
 * @author Samuel Tinevra
 * Purpose:
 * Last Modified: 18 November 2018
 * 
 * 
 * FEATURE 1: Makes Disks Larger When Clicked By User
 */


package c4.ext;
import c4.base.*;
import java.awt.event.MouseAdapter;
import java.awt.*;
import java.awt.event.MouseEvent;

public privileged aspect PressDisc {
	
	pointcut press_disc(BoardPanel panel):(call(int BoardPanel.locateSlot(int,int))) && target(panel) &&! within(PressDisc);
	after(BoardPanel panel):press_disc(panel){
		
		//Add listener for when mouse is clicked
		panel.addMouseListener(new MouseAdapter(){
			//TODO verify that @Override is still necessary after code merge
			//@Override

}