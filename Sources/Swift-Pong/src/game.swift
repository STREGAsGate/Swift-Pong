import Foundation
import CRaylib
import Raylib

private enum GameState {
  case IDLE, START
}

private var state = GameState.IDLE
private var score = 0
private var previousScore = 0
private var aiScored = false

/// All constants and system configurations.
struct GameConfig {
    static let WINDOW_WIDTH: Int32 = 1280
    static let WINDOW_HEIGHT: Int32 = 720
    static let WINDOW_TITLE: String = "Swift-Pong"
    static let TARGET_FPS: Int32 = 60

    /// Holds all Raylib related config flags.
    static func ConfigFlags() {
        SetTargetFPS(TARGET_FPS)
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
        if state == .START {
            DrawText("Score: \(String(score))", 600, 100, 24, RAYWHITE)
        }
        if aiScored && state == .IDLE {
            DrawText("Highest Score: \(String(previousScore))", 530, 120, 30, RAYWHITE)
            DrawText("You lose!", 580, 80, 30, RAYWHITE)
        }
        EndDrawing()
    }

    /// Reset paddles, ball and game state after score
    private static func Reset() {
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

    /// When AI scores, reset players score and set previousScore to score to let player know their highest score
    private static func ResetScore() {
        previousScore = score
        score = 0
        aiScored = true
    }

    /// Function taking over the responsibility of updating the game loop
    static func Update(dt: Float = GetFrameTime()) {
        switch state {
        case .IDLE:
            CreateBlinkingText(text: "PRESS SPACE TO SERVE", posX: 500, posY: 200, fontSize: 24, color: RAYWHITE)
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

            if ball.position.y < 5 || ball.position.y >= Float(GameConfig.WINDOW_HEIGHT){
                ball.velocity.y *= -1
            }


            if ball.velocity.x >= 700 {
                player.velocity.y = 600
                ball.velocity.x = Clamp(value: ball.velocity.x, min: 400, max: 2000)
            }
            
            if ball.hasCollided(with: player) || ball.hasCollided(with: AI) {
                ball.velocity.x *= -1.05
                score += 5
                PlaySound(SoundManager.paddleHit)
            }

            if ball.position.x < 50 && AI.position.x == 0 || ball.position.x > 90 && AI.position.x > 40 {
                if ball.position.y > AI.position.y + (AI.paddleHeight / 2) {
                    AI.position.y += AI.velocity.y * dt
                } else if ball.position.y < AI.position.y + (AI.paddleHeight / 2) && AI.position.y > 0 {
                    AI.position.y -= AI.velocity.y * dt
                }
            }

            if ball.position.x >= Float(GameConfig.WINDOW_WIDTH) + 4 {
                Reset()
            } else if ball.position.x <= 0 - 4 {
                Reset()
                ResetScore()
            }
        }
    }
}

func CreateBlinkingText(text: String, posX: Int32, posY: Int32, fontSize: Int32, color: Color) {
    let floorTime = floor(GetTime().truncatingRemainder(dividingBy: 2))
    if floorTime == 0 {
                DrawText(text, posX, posY, fontSize, color)
            }
}

/// Clamping value to min and max
func Clamp(value: Float, min: Float, max: Float) -> Float {
    if value < min {
        return min
    } else if value < max {
        return value
    } else {
        return max
    }
}
