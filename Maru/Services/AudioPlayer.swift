//
//  AudioPlayer.swift
//  Maru
//
//  Created by John-Patrick Whitaker on 7/31/24.
//

import AVFoundation
import Combine

class AudioPlayer: ObservableObject {
    static let shared = AudioPlayer()
    
    @Published private var audioPlayers: [String: AVAudioPlayer] = [:]
    
    private init() {}
    
    func preloadSound(named filename: String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "mp3") else {
            print("Sound file not found: \(filename).mp3")
            print("Bundle path: \(Bundle.main.bundlePath)")
            return
        }
        
        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.prepareToPlay()
            audioPlayers[filename] = audioPlayer
        } catch {
            print("Couldn't preload sound: \(error)")
        }
    }
    
    func playSound(named filename: String) async {
        // Configure audio session
        do {
            try AVAudioSession.sharedInstance()
                .setCategory(.playback, options: .mixWithOthers)
            try AVAudioSession.sharedInstance()
                .setActive(true)
        } catch {
            print("Error setting up audio session: \(error)")
        }
        
        if let audioPlayer = audioPlayers[filename] {
            audioPlayer.play()
            // Wait for the sound to finish playing
            while audioPlayer.isPlaying {
                try? await Task.sleep(nanoseconds: 100_000_000) // Sleep for 0.1 seconds
            }
        } else {
            // If the sound wasn't preloaded, load and play it immediately
            preloadSound(named: filename)
            if let audioPlayer = audioPlayers[filename] {
                audioPlayer.play()
                // Wait for the sound to finish playing
                while audioPlayer.isPlaying {
                    try? await Task.sleep(nanoseconds: 100_000_000) // Sleep for 0.1 seconds
                }
            }
        }
    }
}
