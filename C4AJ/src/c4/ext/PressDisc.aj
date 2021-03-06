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
			@Override
			public void mousePressed(MouseEvent e){
				//Verify game is active
				if(!(panel.board.isGameOver())){
					Graphics g = panel.getGraphics();								//Initiate instance of graphics
					int matrix_position = panel.locateSlot(e.getX(), e.getY());		//ID (x,y) position of board slot
					panel.drawChecker(g, panel.dropColor, matrix_position, -1, -1);	//Enlarge disk upon pressing
					panel.drawChecker(g, panel.dropColor, matrix_position, -1, true);
				}
		    }
		});

		//Add listener for when mouse is released
		panel.addMouseListener(new MouseAdapter(){
			//TODO verify that @Override is still necessary after code merge
			@Override
			public void mouseReleased(MouseEvent e){
				//Verify game is still active
				if(!(panel.board.isGameOver())){
					Graphics g = panel.getGraphics();								//Initiate instance of graphics
					int matrix_position = panel.locateSlot(e.getX(), e.getY());		//ID (x,y) position of board slot
					panel.drawChecker(g, panel.dropColor, matrix_position, -1, 0);	//Decrease disk size upon release
				}	
		    }
		});	
	}
}


/**
 * HERE IS MATT'S CODE: IMPLEMENT TO SEE IF IT WORKS

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
			@SuppressWarnings("unused")	//<--- Debugging purposes
			public void mouse_clicked(MouseEvent e){
				//Verify game is active
				if(!(panel.board.isGameOver())){
					Graphics g = panel.getGraphics();								//Initiate instance of graphics
					int matrix_position = panel.locateSlot(e.getX(), e.getY());		//ID (x,y) position of board slot
					panel.drawChecker(g, panel.dropColor, matrix_position, -1, -1);	//Enlarge disk upon pressing	
				}
		    }
		});

		//Add listener for when mouse is released
		panel.addMouseListener(new MouseAdapter(){
			//TODO verify that @Override is still necessary after code merge
			//@Override
			public void mouse_released(MouseEvent e){
				//Verify game is still active
				if(!(panel.board.isGameOver())){
					Graphics g = panel.getGraphics();								//Initiate instance of graphics
					int matrix_position = panel.locateSlot(e.getX(), e.getY());		//ID (x,y) position of board slot
					panel.drawChecker(g, panel.dropColor, matrix_position, -1, 0);	//Decrease disk size upon release
				}	
		    }
		});	
	}
}
}
 * 
 * 
 */