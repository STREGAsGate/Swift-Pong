import Raylib
import Foundation

class GameLogic {
    // Game states
    private enum GameState {
        case idle, start, scored, lost
    }

    // Game logic variables
    private var state: GameState = .idle
    var score: Int = 0
    var previousScore: Int = 0
    var aiDidScore: Bool = false
    
    //Sound manager singleton <-- Receiving
    let sfxManager: SoundManager = SoundManager()

    // Game objects Initialisation
    private var playerPaddle = Paddle(paddlePosition: Vector2(x: 10, y: 320), paddleSize: Vector2(x: 10, y: 100), paddleSpeed: 550, paddleColor: .white, isAI: false)
    private var servingBall = Ball(ballPosition: Vector2(x: Float(1280/2), y: Float(720/2)), ballSize: Vector2(x: 10, y: 10), ballSpeed: Vector2(x: 420, y: 420), ballColor: .white)
    private var aiPaddle = Paddle(paddlePosition: Vector2(x: 1260, y: 320), paddleSize: Vector2(x: 10, y: 100), paddleSpeed: 420, paddleColor: .white, isAI: true)
    
    // Function that resets the whole game after losing/winning
    func gameReset() {
        state = .idle
        servingBall.ballPosition.x = Float(1280/2)
        servingBall.ballPosition.y = Float(720/2)
        servingBall.ballSpeed.x = 420
        servingBall.ballSpeed.y = 420
        playerPaddle.paddlePosition.x = 10
        playerPaddle.paddlePosition.y = 320
        playerPaddle.paddleSpeed = 550
        aiPaddle.paddlePosition.x = 1260
        aiPaddle.paddlePosition.y = 320
    }

    // Resets players score to 0
    func resetScore() {
        score = 0 
    }

    // Function to create blinking text effect 
    private func createBlinkingText(text: String, positionX: Int32, positionY: Int32, fontSize: Int32, color: Color) {
        let floorTime = floor(Raylib.getTime().truncatingRemainder(dividingBy: 2))
        if floorTime == 0 {
            Raylib.drawText(text, positionX, positionY, fontSize, color)
        }
    }

    // Clamp function
    private func clamp(value: Float, min: Float, max: Float) -> Float {
        if value < min {
            return min
        } else if value < max {
            return value
        } else {
            return max
        }
    }
}

extension GameLogic {
    func update() {
        switch state {
            case .idle:
                createBlinkingText(text: "PRESS SPACE TO SERVE", positionX: 500, positionY: 200, fontSize: 24, color: .rayWhite)
                if Raylib.isKeyPressed(.space) {
                    state = .start
                }
            
            case .start:
                playerPaddle.update()
                aiPaddle.update()
                servingBall.update()

                // Set previous score to current score so that highscore can be shown when player loses or wins
                previousScore = score

                // Sound settings (mainly volume)
                sfxManager.setSoundVolume(soundName: sfxManager.paddleHitSFX, soundVolume: 0.04)
                sfxManager.setSoundVolume(soundName: sfxManager.scoreSFX, soundVolume: 0.04)
                sfxManager.setSoundVolume(soundName: sfxManager.wallHitSFX, soundVolume: 0.04)

                // Clamping speed of ball to a limited amount
                if servingBall.ballSpeed.x >= 700 {
                    playerPaddle.paddleSpeed = 600
                    servingBall.ballSpeed.x = clamp(value: servingBall.ballSpeed.x, min: 400, max: 2000)
                }

                // Collision detection between paddles & ball
                if servingBall.hasCollided(with: playerPaddle) || servingBall.hasCollided(with: aiPaddle) {
                    servingBall.ballSpeed.x *= -1.05
                    score += 5
                    Raylib.playSound(sfxManager.paddleHitSFX)
                } 

                // Very basic AI movement
                if servingBall.ballPosition.x < 50 && aiPaddle.paddlePosition.x == 0 || servingBall.ballPosition.x > 90 && aiPaddle.paddlePosition.x > 90 {
                    if servingBall.ballPosition.y > aiPaddle.paddlePosition.y + (aiPaddle.paddleSize.y / 2) {
                        aiPaddle.paddlePosition.y += Raylib.getFrameTime() * aiPaddle.paddleSpeed
                    } else if servingBall.ballPosition.y < aiPaddle.paddlePosition.y + (aiPaddle.paddleSize.y / 2) && aiPaddle.paddlePosition.y > 0 {
                        aiPaddle.paddlePosition.y -= Raylib.getFrameTime() * aiPaddle.paddleSpeed
                    }
                }

                // When ball hits wall play sound effect and send it to the opposite direction
                if servingBall.ballPosition.y < 5 || servingBall.ballPosition.y >= Float(Raylib.getScreenHeight()) {
                    Raylib.playSound(sfxManager.wallHitSFX)
                    servingBall.ballSpeed.y *= -1
                }

                // Player scored --> Holy shit the game can actually be won... Send player to .SCORED game state after playing score SFX
                if servingBall.ballPosition.x >= Float(Raylib.getScreenWidth()) {
                    Raylib.playSound(sfxManager.scoreSFX)
                    state = .scored
                }

                // Player lost, send player to the .LOST game state after playing score SFX
                if servingBall.ballPosition.x <= -4 {
                    Raylib.playSound(sfxManager.scoreSFX)
                    state = .lost
                }

            // SCORED game state displaying blinking text with instructions
            case .scored:
                createBlinkingText(text: "PRESS SPACE TO RESTART THE GAME", positionX: 410, positionY: 200, fontSize: 24, color: .rayWhite)
                if Raylib.isKeyPressed(.space) {
                    gameReset()
                    resetScore()
                }

            // As above
            case .lost:
                createBlinkingText(text: "PRESS SPACE TO RESTART THE GAME", positionX: 410, positionY: 200, fontSize: 24, color: .rayWhite)
                if Raylib.isKeyPressed(.space) {
                    gameReset()
                    resetScore()
                }
        }
    }
}

// Main game logic draw function, calling all draw functions from other objects all very self explanatory
extension GameLogic {
    func draw() {
        playerPaddle.draw()
        aiPaddle.draw()
        servingBall.draw()
        
        switch state {
        case .start:
            Raylib.drawText("Score: \(String(score))", 600, 100, 24, .rayWhite)
        case .lost:
            Raylib.drawText("Highest Score: \(String(previousScore))", 530, 120, 30, .rayWhite)
            Raylib.drawText("You lose!", 580, 80, 30, .rayWhite)
        case .scored:
            Raylib.drawText("Congratulations You actually won the impossible game!", 300, 80, 27, .rayWhite)
            Raylib.drawText("Your score: \(String(score))", 565, 120, 24, .rayWhite)
        case .idle:
            break
        }
    }
}
