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
 * FEATURE 2: Terminates the game when appropriate
 */


package c4.ext;
import c4.base.*;
import java.awt.*;
import c4.model.*;
import java.awt.Color;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import c4.base.ColorPlayer;
import c4.model.Player;
import c4.base.C4Dialog;

public privileged aspect EndGame {
	ColorPlayer player_color = new ColorPlayer("Black",Color.BLACK);	//TODO: Change asthetic to white if appearance is ruined
		
	/**
	 * POINTCUT game_over(c4_dialog)
	 * This section allows us to check the progress of the game
	 * @param c4_dialog
	 */
	pointcut game_over(C4Dialog c4_dialog):this(c4_dialog) && (call(void C4Dialog.makeMove(int)) || call(int Board.dropInSlot(int, Player)));
	after(C4Dialog c4_dialog):game_over(c4_dialog){
		
		
}