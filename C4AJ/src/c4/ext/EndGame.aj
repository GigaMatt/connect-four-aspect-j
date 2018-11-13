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
		
		//PLAYER WON GAME
		if(c4_dialog.board.isWonBy(c4_dialog.player)){			//Verify player won game
			//TODO: VERIFY MP3 IS ACCEPTED
			AddSound.play_audio("vergecast_season2_ost.mp3");	//Call to AddSound.aj to process & play
			
			//Display Win Message
			JOptionPane.showMessageDialog(new JFrame(), c4_dialog.player.name() + " won the game! Congratulations", "Dialog", JOptionPane.INFORMATION_MESSAGE);
		}
		
		
}