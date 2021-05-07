import Foundation
import CRaylib
import Raylib

enum GameState {
  case IDLE, START, GAME_OVER
}

var state = GameState.IDLE

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

    /// Draw method that takes all game-related drawing responsibilities.
    static func Draw() {
        BeginDrawing()
        ClearBackground(OLIVEDAB)
        DrawFPS(10,10)
        player.Draw()
        AI.Draw()
        ball.Draw()
        EndDrawing()
    }

    static func Reset() {
        state = .IDLE
        ball.position.x = Float(GameConfig.WINDOW_WIDTH/2)
        ball.position.y = Float(GameConfig.WINDOW_HEIGHT/2)
        ball.velocity.x = 400
        ball.velocity.y = 400
        player.position.x = 10
        player.position.y = 320
        player.velocity.y = 550
        AI.position.x = 1260
        AI.position.y =  320
    }

    /// Function taking over the responsibility of updating the game loop
    static func Update(dt: Float) {
        switch state {
        case .IDLE:
            DrawText("PRESS SPACE TO SERVE", 500, 200, 24, WHITE)
            if IsKeyPressed(Int32(KEY_SPACE.rawValue)) {
                state = .START
            }
        case .START:
            if IsKeyDown(Int32(KEY_W.rawValue)) {
                player.position.y -= player.velocity.y * dt
            }
            if IsKeyDown(Int32(KEY_S.rawValue)) {
                player.position.y += player.velocity.y * dt
            }

            if player.position.y < 0 {
                player.position.y = 0
            } else if player.position.y > (Float(GameConfig.WINDOW_HEIGHT) - player.paddleHeight) {
                player.position.y = Float(GameConfig.WINDOW_HEIGHT) - player.paddleHeight
            }

            if AI.position.y < 0 {
                AI.position.y = 0
            } else if AI.position.y > (Float(GameConfig.WINDOW_HEIGHT) - AI.paddleHeight) {
                AI.position.y = Float(GameConfig.WINDOW_HEIGHT) - AI.paddleHeight
            }

            ball.position.x -= ball.velocity.x * dt
            ball.position.y -= ball.velocity.y * dt

            if ball.position.y < 5 || ball.position.y >= Float(GameConfig.WINDOW_HEIGHT) + -7 {
                ball.velocity.y *= -1
            }

            if ball.velocity.x >= 700 {
                player.velocity.y = 600
            }

            if ball.hasCollided(with: player) || ball.hasCollided(with: AI) {
                ball.velocity.x *= -1.05
                print(ball.velocity.x)
            }

            if ball.position.x < 50 && AI.position.x == 0 || ball.position.x > 90 && AI.position.x > 40 {
                if ball.position.y > AI.position.y + (AI.paddleHeight / 2) {
                    AI.position.y += AI.velocity.y * dt
                } else if ball.position.y < AI.position.y + (AI.paddleHeight / 2) && AI.position.y > 0 {
                    AI.position.y -= AI.velocity.y * dt
                }
            }

            if ball.position.x >= Float(GameConfig.WINDOW_WIDTH) + 4 || ball.position.x <= 0 - 4{
                Reset()
            }

        case .GAME_OVER:
            print("Game Over")
        }
    }
}

var player = Paddle(position: Rectangle(x: 10, y: 320, width: 10, height: 100), velocity: Vector2(x: 0, y: 550), paddleWidth: 10, paddleHeight: 100, paddleColor: WHITE)
var AI = Paddle(position: Rectangle(x:1260, y: 320, width: 10, height: 100), velocity: Vector2(x: 420, y: 420), paddleWidth: 10, paddleHeight: 100, paddleColor: WHITE)
var ball = Ball(position: Rectangle(x:Float(GameConfig.WINDOW_WIDTH/2), y:Float(GameConfig.WINDOW_HEIGHT/2), width: 10, height: 10), velocity: Vector2(x: 420, y:420), ballWidth: 10, ballHeight: 10, ballColor: WHITE)
