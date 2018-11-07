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
 * FEATURE: WTF IS THIS?
 */
package c4.ext;
import c4.model.*;

public aspect LogMove{

	//feature enable
	private static final boolean DISABLED = false;
	
	pointcut loggingPoint():
		execution(int Board.dropInSlot(..));
	
	before(): loggingPoint(){
		Object[] parameters = thisJoinPoint.getArgs();
		Player temp = (Player) parameters[1];
		System.out.println("move: " +parameters[0] +" player: " +temp.name());
	}
}