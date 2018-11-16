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
 * FEATURE 3: Add Sounds When Disks Are Dropped
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
	//TODO add sound directory location
	private static final String AUDIO_DIRECTORY = "/audio_clips/";
	
	/**
	 * play_audio(filename)
	 * This method plays specific sounds that are called in the SOUND_DIRECTORY
	 * @param filename
	 */
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
	
	
	/**
	 * POINTCUT disc_drop(c4_dialog)
	 * This section allows us to determine which player is dropping the disk
	 * @param c4_dialog
	 */
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