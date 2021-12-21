import Raylib
import Foundation

// Sound Manager holds all paths to sound effects of the game and loads them up only when needed (lazy)
struct soundManager {

    // Get path from resource bundle
    lazy var paddleHitPath = Bundle.module.url(forResource: "paddleHit", withExtension: "wav")
    lazy var scorePath = Bundle.module.url(forResource: "score", withExtension: "wav")
    lazy var wallHitPath = Bundle.module.url(forResource: "wallHit", withExtension: "wav")

    // Load all SFX
    lazy var paddleHitSFX = Raylib.loadSound(paddleHitPath!.path)
    lazy var scoreSFX = Raylib.loadSound(scorePath!.path)
    lazy var wallHitSFX = Raylib.loadSound(wallHitPath!.path)

    // Sound Manager singleton --> Outgoing
    static let shared = soundManager()
    private init() { }
}

// Helper functions
extension soundManager {
    // Set volume of SFX
    func setSoundVolume(soundName: Sound, soundVolume: Float) {
        Raylib.setSoundVolume(soundName, soundVolume)
    }

    // Unload all audio from RAM and close audio device
    mutating func closeAudio() {
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