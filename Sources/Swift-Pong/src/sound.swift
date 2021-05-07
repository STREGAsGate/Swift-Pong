import Foundation
import CRaylib
import Raylib

struct SoundManager {
    static var backgroundMusic = LoadMusicStream("Sources/Resources/bgm.wav")
    static var paddleHit = LoadSound("Sources/Resources/paddleHit.wav")

    static func UpdateMusic() {
        UpdateMusicStream(self.backgroundMusic)
        SetMusicVolume(self.backgroundMusic, 0.03)
        SetSoundVolume(self.paddleHit, 0.04)
    }

    static func UnloadMusic() {
        UnloadMusicStream(self.backgroundMusic)
        UnloadSound(self.paddleHit)
        CloseAudioDevice()
    }
}