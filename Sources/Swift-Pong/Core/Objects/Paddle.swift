import Raylib

// Paddle object
struct Paddle {

    // Object initialisation
    var paddlePosition: Vector2
    let paddleSize: Vector2
    var paddleSpeed: Float
    let paddleColor: Color
    let isAI: Bool
}

// Paddles own draw function
extension Paddle {
    @inlinable
    func draw() {
        Raylib.drawRectangleV(paddlePosition, paddleSize, paddleColor)
    }
}

// Paddles own update function which also check if each paddle is AI, if not it's controllable
extension Paddle {
    @inlinable
    mutating func update() {
        if isAI == false {
            if Raylib.isKeyDown(.letterW) {
                paddlePosition.y -= Raylib.getFrameTime() * paddleSpeed
            }
            if Raylib.isKeyDown(.letterS) {
                paddlePosition.y += Raylib.getFrameTime() * paddleSpeed
            }
        }

        if paddlePosition.y < 0 {
            paddlePosition.y = 0
        }else if paddlePosition.y > Float(Raylib.getScreenHeight()) - paddleSize.y {
            paddlePosition.y = Float(Raylib.getScreenHeight()) - paddleSize.y
        }
    }
}
