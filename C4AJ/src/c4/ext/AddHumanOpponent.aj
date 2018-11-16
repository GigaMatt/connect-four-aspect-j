/**
 * CS 3360
 * Project 2: AspectJ
 * @author Matthew Montoya
 * @author Jaime Sanchez
 * @author Samuel Tinevra
 * Purpose:
 * Last Modified: 15 November 2018
 * 
 * 
 * FEATURE 4:
 * - Add new player "Red"
 * - Colors alternate and display players turn
 */

package c4.ext;

import java.awt.Color;
import c4.base.ColorPlayer;
import c4.base.C4Dialog;
import c4.base.BoardPanel;

public privileged aspect AddHumanOpponent{
	
	private BoardPanel C4Dialog.smith;
	
	/** Player 1: Blue */
	ColorPlayer B1 = new ColorPlayer("Blue", Color.BLUE );
	/** Player 2: Red */
	ColorPlayer R2 = new ColorPlayer("Red", Color.RED );
	
	/**  */
	after(C4Dialog c4Dialog) returning(BoardPanel panel):
	this(c4Dialog) && call(BoardPanel.new(..)){
		c4Dialog.smith = panel;
	}
	
	//The advice is declared checking for makeMove execution
	after(C4Dialog c4Dialog): this(c4Dialog) && execution(void C4Dialog.makeMove(..)) 
	{
		//if player is blue change to red
		if (c4Dialog.player.name().equals("Blue")) {
			c4Dialog.player = R2;
			c4Dialog.showMessage("Red turn");
		//if player is red change to blue
		} else if (c4Dialog.player.name().equals("Red")) {
			c4Dialog.player = B1;
			c4Dialog.showMessage("Blue turn");
		}
		c4Dialog.smith.setDropColor(c4Dialog.player.color());
	}
	
}

