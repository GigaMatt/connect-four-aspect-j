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
<<<<<<< HEAD
 * FEATURE 3: Add Sounds When Disks Are Dropped
=======
 * FEATURE 3:
 * - Play a sound when a player drops a disc. Use a distinct sound for each player
 * - Play a sound of applause, or cheering, when a player wins *****************
>>>>>>> jaime
 */


package c4.ext;
import java.awt.Color;
import java.io.IOException;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.sound.sampled.LineUnavailableException;
import javax.sound.sampled.UnsupportedAudioFileException;
import c4.base.C4Dialog;


public privileged aspect AddSound {
	
	/** feature enable: TRUE = Disabled, FALSE = Enabled */
	private static final boolean DISABLED = false;
	
	private static final String AUDIO_DIRECTORY = "/audio_clips/";

		//plays sound based on current player's turn
		before(C4Dialog c4Dialog) : execution(* C4Dialog.makeMove(int)) && this(c4Dialog) {  
			if(DISABLED == true) { return; }
			else {
			//if blue turn
			if(c4Dialog.player.color() == Color.BLUE){
				playAudio("notification.wav");
			}
			//if red turn
			if(c4Dialog.player.color() == Color.RED){
				playAudio("coin.wav");
			}
			}
		}




		/** Play the given audio file. Inefficient because a file will be 
		 * (re)loaded each time it is played. */
		public static void playAudio(String filename) {
			try {
				Clip audio_clip = AudioSystem.getClip();
		        AudioInputStream audio_stream = AudioSystem.getAudioInputStream(AddSound.class.getResource(AUDIO_DIRECTORY + filename));	
		        audio_clip.open(audio_stream);							//Open selected audio file
		        audio_clip.start();	
			} catch (UnsupportedAudioFileException 
					| IOException | LineUnavailableException e) {
				e.printStackTrace();
			}
		}

	}
	/**

package c4.ext;
import java.awt.Color;
import java.io.IOException;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.sound.sampled.LineUnavailableException;
import javax.sound.sampled.UnsupportedAudioFileException;
import c4.base.C4Dialog;


public privileged aspect AddSound {
	//TODO add sound directory location
	private static final String AUDIO_DIRECTORY = "/audio_clips/";

>>>>>>> jaime
	public static void play_audio(String file_name){
	     try{
	    	//Import audio file from project directory 
	         Clip audio_clip = AudioSystem.getClip();
	         AudioInputStream audio_stream = AudioSystem.getAudioInputStream(AddSound.class.getResource(AUDIO_DIRECTORY + file_name));	
	         audio_clip.open(audio_stream);							//Open selected audio file
	         audio_clip.start();									//Play audio file
	     }
	     catch(IOException | UnsupportedAudioFileException | LineUnavailableException e){
	         e.printStackTrace();	//WORST-CASE SCENARIO
	     }
	   }

	pointcut disc_drop(C4Dialog c4_dialog):execution(* makeMove(int)) && this(c4_dialog);
	before(C4Dialog c4_dialog):disc_drop(c4_dialog){

		if(c4_dialog.player.color() == Color.RED)
			play_audio("fb_notification_sound.mp3");	//TODO: VERIFY MP3 IS ACCEPTED

		//FIXME: Audio may need to be converted to .wav format
		if(c4_dialog.player.color() == Color.BLUE)
			play_audio("coin_sound_effect.mp3");		//TODO: VERIFY MP3 IS ACCEPTED
		
		//Worst case scenario because half the time, code doesn't work
		else 
			play_audio("lotr_nazgul_scream.mp3");		//TODO: VERIFY MP3 IS ACCEPTED
	}
}
}
	 */
