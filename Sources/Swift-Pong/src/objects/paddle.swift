import Raylib

// Paddle object
struct paddle {

    // Object initialisation
    var paddlePosition: Vector2
    let paddleSize: Vector2
    var paddleSpeed: Float
    let paddleColor: Color
    let isAI: Bool
}

// Paddles own draw function
extension paddle {
    func draw() {
        Raylib.drawRectangleV(paddlePosition, paddleSize, paddleColor)
    }
}

// Paddles own update function which also check if each paddle is AI, if not it's controllable
extension paddle {
    mutating func update() {
        if Raylib.isKeyDown(.letterW) && !isAI {
            paddlePosition.y -= Raylib.getFrameTime() * paddleSpeed
        }
        if Raylib.isKeyDown(.letterS) && !isAI {
            paddlePosition.y += Raylib.getFrameTime() * paddleSpeed
        }

        if paddlePosition.y < 0 {
            paddlePosition.y = 0
        } else if paddlePosition.y > Float(Raylib.getScreenHeight()) - paddleSize.y {
            paddlePosition.y = Float(Raylib.getScreenHeight()) - paddleSize.y
        }
    }
}