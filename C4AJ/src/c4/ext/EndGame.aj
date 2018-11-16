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
import java.awt.event.MouseEvent;
import java.awt.event.MouseMotionAdapter;

public privileged aspect EndGame{
	
	/** feature enable: TRUE = Disabled, FALSE = Enabled */
	private static final boolean DISABLED = false;
	
	
	void around(C4Dialog c4Dialog): execution(* C4Dialog.makeMove(int)) && this(c4Dialog){
		/** Check if Game is Over, or feature is disabled */
		if(c4Dialog.board.isGameOver() || DISABLED) {
			return;
		}
		else
			proceed(c4Dialog);
	}
	
	/** Display Message if Game is over. If board is full = tie. */
	after(C4Dialog dialogMove): this(dialogMove) && execution(void C4Dialog.makeMove(..)) {
		if (dialogMove.board.isGameOver()) {
			if(dialogMove.board.isFull()) {	
				dialogMove.showMessage("Game is over, is a tie");
			}
			else {
				dialogMove.showMessage("Game is over, winner is :"+ dialogMove.player.name() );
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