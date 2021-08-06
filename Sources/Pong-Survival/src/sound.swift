import Foundation
import CRaylib
import Raylib

struct SoundManager {
    private static let SFX = ["paddleHit": "Assets/Sounds/paddleHit.wav"]
    static var paddleHit = LoadSound(SFX["paddleHit"])

    static func UpdateMusic() {
        SetSoundVolume(self.paddleHit, 0.04)
    }

    static func UnloadMusic() {
        UnloadSound(self.paddleHit)
        CloseAudioDevice()
    }
}