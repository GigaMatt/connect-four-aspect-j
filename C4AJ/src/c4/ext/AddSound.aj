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
 * FEATURE 3:
 * - Play a sound when a player drops a disc. Use a distinct sound for each player
 * - Play a sound of applause, or cheering, when a player wins *****************
 */

package c4.ext;

import java.io.IOException;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.sound.sampled.LineUnavailableException;
import javax.sound.sampled.UnsupportedAudioFileException;
import c4.base.C4Dialog;

privileged aspect AddSound {
                
    /** Directory where audio files are stored. */
    private static final String SOUND_DIR = "/sound/";

	
    //plays sound based on current player's turn
    before(C4Dialog c4Dialog) : execution(* C4Dialog.makeMove(int)) && this(c4Dialog) {  
    	//if blue turn
    	if(c4Dialog.player.name() == "Blue"){
    		playAudio("");
        }
        //if red turn
        if(c4Dialog.player.name() == "Red"){
        	playAudio("");
        	}
        }
     
    
        

    /** Play the given audio file. Inefficient because a file will be 
     * (re)loaded each time it is played. */
    public static void playAudio(String filename) {
      try {
          AudioInputStream audioIn = AudioSystem.getAudioInputStream(
            AddSound.class.getResource(SOUND_DIR + filename));
          Clip clip = AudioSystem.getClip();
          clip.open(audioIn);
          clip.start();
      } catch (UnsupportedAudioFileException 
            | IOException | LineUnavailableException e) {
          e.printStackTrace();
      }
    }
    
}