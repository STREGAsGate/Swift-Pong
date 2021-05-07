import Foundation
import CRaylib
import Raylib

struct SoundManager {
    private static var backgroundMusicPath = URL(string: "src/sound/bgm.wav")!
    private static var paddleHitPath = URL(string: "src/sound/paddleHit.wav")!
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