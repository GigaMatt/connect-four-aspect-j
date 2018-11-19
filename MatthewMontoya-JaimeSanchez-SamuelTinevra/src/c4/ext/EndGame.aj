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
 * FEATURE 2: 
 * - Display the game outcome (win or draw) in the message bar.
 * - Highlight the winning sequence of discs in the board panel.
 * - Change the behavior of the "new" button to not prompt the user when the game is over.
 */


package c4.ext;

import java.awt.Color;
import java.awt.Graphics;
import java.util.List;
import c4.model.Board;
import c4.model.Board.Place;
import c4.base.BoardPanel;
import c4.base.C4Dialog;
import c4.base.ColorPlayer;

import java.awt.event.MouseEvent;
import java.awt.event.MouseMotionAdapter;

public privileged aspect EndGame{

	/** feature enable: TRUE = Disabled, FALSE = Enabled */
	//private static final boolean DISABLED = false;

	ColorPlayer player_color = new ColorPlayer("Black",Color.BLACK);	//TODO: Change asthetic to white if appearance is ruined

	pointcut game_over(C4Dialog c4_dialog):this(c4_dialog) && (call(void C4Dialog.makeMove(int)) || call(int Board.dropInSlot(int, Player)));
	after(C4Dialog c4_dialog):game_over(c4_dialog){

		//PLAYER WON GAME
		if(c4_dialog.board.isWonBy(c4_dialog.player)){			//Verify player won game
			c4_dialog.showMessage("Game is over, winner is :"+ c4_dialog.player.name() );
			AddSound.playAudio("vergecast.wav");
		}

		//GAME IS A DRAW
		else {
			if(c4_dialog.board.isFull()){						//Verify game is a draw
				c4_dialog.showMessage("Tie Game!");
				AddSound.playAudio("nazgul.wav");
			}
		}	
	}


	/** Change button */
	void around(C4Dialog dialogEnd): this(dialogEnd) && execution(void C4Dialog.newButtonClicked(..)) {
		if (dialogEnd.board.isGameOver()) {
			dialogEnd.startNewGame();
		}
		else {
			proceed(dialogEnd);
		}
	}


	/** Show winning line */
	pointcut VisualCueEnd(BoardPanel CueEnd): execution(BoardPanel.new(Board)) && target(CueEnd);

	after(BoardPanel CueEnd): VisualCueEnd(CueEnd) {
		CueEnd.addMouseMotionListener(new MouseMotionAdapter() {
			public void mouseMoved(MouseEvent e){
				List<Place> winningRow = CueEnd.board.winningRow;
				for(Place P : winningRow) {
					Graphics gt = CueEnd.getGraphics();
					gt.setColor(Color.BLUE);
					int x = CueEnd.placeSize + P.x * CueEnd.placeSize; 
					int y = CueEnd.placeSize + P.y * CueEnd.placeSize; 
					int r = CueEnd.placeSize / 2;              
					gt.fillOval(x - r, y - r, r * 2+1, r * 2+1);
				}
			}
		});
	}

}

/**
 * HERE IS MATT'S CODE: IMPLEMENT PIECES AS YOU NEED TO VERIFY IT WORKS
 * 

package c4.ext;
>>>>>>> jaime
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

	pointcut game_over(C4Dialog c4_dialog):this(c4_dialog) && (call(void C4Dialog.makeMove(int)) || call(int Board.dropInSlot(int, Player)));
	after(C4Dialog c4_dialog):game_over(c4_dialog){

		//PLAYER WON GAME
		if(c4_dialog.board.isWonBy(c4_dialog.player)){			//Verify player won game
			dialogMove.showMessage("Game is over, winner is :"+ dialogMove.player.name() );
			AddSound.playAudio("vergecast.wav");
		}

		//GAME IS A DRAW
		else {
			if(c4_dialog.board.isFull()){						//Verify game is a draw
				dialogMove.showMessage("Tie Game!");
				AddSound.playAudio("nazgul.wav");
			}
		}	
	}

	pointcut end_game(C4Dialog c4_dialog):execution(* makeMove(int)) && target(c4_dialog);



	pointcut end_game(C4Dialog c4_dialog):execution(* makeMove(int)) && target(c4_dialog);

	void around(C4Dialog c4_dialog):end_game(c4_dialog){
		//GAME OVER
		//TODO: Figure this part out
		if(c4_dialog.board.isGameOver())
			System.out.println("FIXME");
		//GAME NOT OVER
		else
			proceed(c4_dialog);//
	}
}
}

 */

