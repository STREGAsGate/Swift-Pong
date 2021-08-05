import Foundation
import CRaylib
import Raylib

struct SoundManager {
    private static let SFX = [
        "background": "Assets/Sounds/bgm.wav", 
        "paddleHit": "Assets/Sounds/paddleHit.wav"
        ]

    static var backgroundMusic = LoadMusicStream(SFX["background"])
    static var paddleHit = LoadSound(SFX["paddleHit"])

    static func UpdateMusic() {
        UpdateMusicStream(self.backgroundMusic)
        SetMusicVolume(self.backgroundMusic, 0.04)
        SetSoundVolume(self.paddleHit, 0.04)
    }

    static func UnloadMusic() {
        UnloadMusicStream(self.backgroundMusic)
        UnloadSound(self.paddleHit)
        CloseAudioDevice()
    }
}