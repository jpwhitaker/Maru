//
//  AudioPlayer.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 7/31/24.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(named filename: String) async {
    guard let url = Bundle.main.url(forResource: filename, withExtension: "mp3") else {
        print("Sound file not found: \(filename).mp3")
        print("Bundle path: \(Bundle.main.bundlePath)")
        return
    }
    
    do {
        let audioPlayer = try AVAudioPlayer(contentsOf: url)
        audioPlayer.play()
        // Wait for the sound to finish playing
        while audioPlayer.isPlaying {
            try await Task.sleep(nanoseconds: 100_000_000) // Sleep for 0.1 seconds
        }
    } catch {
        print("Couldn't play sound: \(error)")
    }
}
