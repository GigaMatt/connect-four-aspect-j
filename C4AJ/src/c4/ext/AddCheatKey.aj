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
 * FEATURE 5 EC: Adds a Cheat Key To Aid User in Solving Game
 */

package c4.ext;
import java.awt.Color;
import c4.base.*;

public privileged aspect AddCheatKey{
		//feature enable
		private static final boolean DISABLED = false;
		
		//color for hint
		private static final Color HINT_COLOR = Color.GREEN;
		//color for warning
		private static final Color Warning_Color = Color.YELLOW;
		//flag to indicate cheat
		private boolean cheatEnabled;
		
		private C4Dialog dialog;
		
		//link board panel to c4dialog
		
		after (C4Dialog dialog) returning (BoardPanel panel):
			this(dialog) && call(BoardPanel.new(..)) {
			//if feature diabled dont do anything
			if (DISABLED) {
					return;
			}
			panel.dialog = dialog;
		}
		
		//enable or disable cheating
		private void toggleCheat(){
			cheatEnabled = !cheatEnabled;
		}
}