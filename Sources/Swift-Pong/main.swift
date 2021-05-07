import Foundation
import CRaylib
import Raylib

GameConfig.ConfigFlags()
InitWindow(GameConfig.WINDOW_WIDTH, GameConfig.WINDOW_HEIGHT, GameConfig.WINDOW_TITLE)
InitAudioDevice()

PlayMusicStream(SoundManager.backgroundMusic)

while !WindowShouldClose() {
    let DT = GetFrameTime()
    Game.Draw()
    Game.Update(dt: DT)
}

UnloadMusicStream(SoundManager.backgroundMusic)
CloseAudioDevice()
CloseWindow()