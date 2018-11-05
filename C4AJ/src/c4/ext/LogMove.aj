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