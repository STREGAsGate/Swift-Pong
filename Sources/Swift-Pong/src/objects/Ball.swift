import Raylib

// Ball object
struct Ball {

    // Object initialisation
    var ballPosition: Vector2
    let ballSize: Vector2
    var ballSpeed: Vector2
    let ballColor: Color

    // Random int generator to determine who serves each round
    var randomServeChoice = Int.random(in: 0...1)

    // Function to reset randomness each round
    mutating func resetRandomness() {
        self.randomServeChoice = Int.random(in: 0...1)
    }

    // Collision detection function against paddle objects
    func hasCollided(with paddle: Paddle) -> Bool {
        if self.ballPosition.x > paddle.paddlePosition.x + paddle.paddleSize.x + 5 || paddle.paddlePosition.x > self.ballPosition.x + self.ballSize.x + 5{
            return false
        }

        if self.ballPosition.y > paddle.paddlePosition.y + paddle.paddleSize.y + 5 || paddle.paddlePosition.y > self.ballPosition.y + self.ballSize.y + 5{
            return false
        }

        return true
    }
}

// Balls own update function
extension Ball {
    mutating func update() {
        if randomServeChoice == 0 {
            self.ballPosition.x -= self.ballSpeed.x * Raylib.getFrameTime()
            self.ballPosition.y -= self.ballSpeed.y * Raylib.getFrameTime()
        } else {
            self.ballPosition.x += self.ballSpeed.x * Raylib.getFrameTime()
            self.ballPosition.y += self.ballSpeed.y * Raylib.getFrameTime()
        }

    }
}

// Balls own draw function
extension Ball {
    func draw() {
        Raylib.drawRectangleV(self.ballPosition, self.ballSize, self.ballColor)
    }
}