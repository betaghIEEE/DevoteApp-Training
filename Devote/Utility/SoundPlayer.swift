//
//  SoundPlayer.swift
//  Devote
//
//  Created by Daniel Beatty on 11/14/21.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do {
            let soundURL = URL(fileURLWithPath: path)
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
            
        } catch {
            print("Could not find and play the sound file.")
        }
        
    }
}
