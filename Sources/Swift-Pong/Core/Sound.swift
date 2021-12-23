import Raylib
import Foundation

// Sound Manager holds all paths to sound effects of the game and loads them up only when needed (lazy)
class SoundManager {

    // Get path from resource bundle
    let paddleHitPath = Bundle.module.url(forResource: "paddleHit", withExtension: "wav")
    let scorePath = Bundle.module.url(forResource: "score", withExtension: "wav")
    let wallHitPath = Bundle.module.url(forResource: "wallHit", withExtension: "wav")

    // Load all SFX
    lazy private(set) var paddleHitSFX = Raylib.loadSound(paddleHitPath!.path)
    lazy private(set) var scoreSFX = Raylib.loadSound(scorePath!.path)
    lazy private(set) var wallHitSFX = Raylib.loadSound(wallHitPath!.path)

    // Sound Manager singleton --> Outgoing
    init() { }
}

// Helper functions
extension SoundManager {
    // Set volume of SFX
    func setSoundVolume(soundName: Sound, soundVolume: Float) {
        Raylib.setSoundVolume(soundName, soundVolume)
    }

    // Unload all audio from RAM and close audio device
    func closeAudio() {
        self.unloadAudio(soundName: paddleHitSFX)
        self.unloadAudio(soundName: scoreSFX)
        self.unloadAudio(soundName: wallHitSFX)
        Raylib.closeAudioDevice()
    }

    // Unload sound from RAM function as used above
    func unloadAudio(soundName: Sound) {
        Raylib.unloadSound(soundName)
    }
}
