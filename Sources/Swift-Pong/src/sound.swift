import Foundation
import CRaylib
import Raylib

let filepath = Bundle.main.path(forResource: "bgm", ofType: "wav")

struct SoundManager {
    private static var backgroundMusicPath = URL(string: "src/Assets/Sounds/bgm.wav")!
    private static var paddleHitPath = URL(string: "src/Assets/Sounds/paddleHit.wav")!
    static var backgroundMusic = LoadMusicStream(backgroundMusicPath.path)
    static var paddleHit = LoadSound(paddleHitPath.path)

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