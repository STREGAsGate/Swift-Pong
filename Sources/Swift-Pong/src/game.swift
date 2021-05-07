import Foundation
import CRaylib
import Raylib

/// All constants and system configurations.
struct GameConfig {
    static let WINDOW_WIDTH: Int32 = 1280
    static let WINDOW_HEIGHT: Int32 = 720
    static let WINDOW_TITLE: String = "Swift-Pong"
    static let deltaTime = GetFrameTime()

    /// Holds all Raylib related config flags.
    static func ConfigFlags() {
        SetConfigFlags(FLAG_VSYNC_HINT.rawValue)
    }
}

/// Game struct holding all game related methods that are responsible for running the game.
struct Game {

    let deltaTime = GetFrameTime()

    /// Draw method that takes all game-related drawing responsibilities.
    static func Draw() {
        BeginDrawing()
        ClearBackground(BLACK)
        Player.Draw()
        AI.Draw()
        ball.Draw()
        EndDrawing()
    }

    static func Update(dt: Float) {
        if IsKeyDown(Int32(KEY_W.rawValue)) {
            Player.Position.y -= Player.Speed * dt
        }

        if IsKeyDown(Int32(KEY_S.rawValue)) {
            Player.Position.y += Player.Speed * dt
        }

        if Player.Position.y <= 0 {
            Player.Position.y = 0
        } else if Player.Position.y >= (Float(GameConfig.WINDOW_HEIGHT) - Player.PaddleHeight) {
            Player.Position.y = Float(GameConfig.WINDOW_HEIGHT) - Player.PaddleHeight
        }

        if AI.Position.y <= 0 {
            AI.Position.y = 0
        } else if AI.Position.y >= (Float(GameConfig.WINDOW_HEIGHT) - AI.PaddleHeight) {
            AI.Position.y = Float(GameConfig.WINDOW_HEIGHT) - Player.PaddleHeight
        }
    }
}

var Player = Paddle(Position: Rectangle(x: 10, y: 320, width: 10, height: 100), Speed: 400, PaddleWidth: 10, PaddleHeight: 100, PaddleColor: WHITE)
var AI = Paddle(Position: Rectangle(x:1260, y: 320, width: 10, height: 100), Speed: 400, PaddleWidth: 10, PaddleHeight: 100, PaddleColor: WHITE)
var ball = Ball(Position: Rectangle(x:Float(GameConfig.WINDOW_WIDTH/2), y:Float(GameConfig.WINDOW_HEIGHT/2), width: 10, height: 10), Velocity: Vector2(x: 400, y:400), BallWidth: 10, BallHeight: 10, BallColor: WHITE)