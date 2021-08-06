import Foundation
import CRaylib
import Raylib

GameConfig.ConfigFlags()
InitWindow(GameConfig.WINDOW_WIDTH, GameConfig.WINDOW_HEIGHT, GameConfig.WINDOW_TITLE)

InitAudioDevice()
PlayMusicStream(SoundManager.backgroundMusic)

while !WindowShouldClose() {
    Game.Draw()
    Game.Update()
    SoundManager.UpdateMusic()
}
SoundManager.UnloadMusic()
CloseWindow()