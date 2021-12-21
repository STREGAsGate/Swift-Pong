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
    func draw() {
        Raylib.drawRectangleV(self.paddlePosition, self.paddleSize, self.paddleColor)
    }
}

// Paddles own update function which also check if each paddle is AI, if not it's controllable
extension Paddle {
    mutating func update() {
        if Raylib.isKeyDown(.letterW) && !isAI {
            self.paddlePosition.y -= Raylib.getFrameTime() * self.paddleSpeed
        }
        if Raylib.isKeyDown(.letterS) && !isAI {
            self.paddlePosition.y += Raylib.getFrameTime() * self.paddleSpeed
        }

        if self.paddlePosition.y < 0 {
            self.paddlePosition.y = 0
        } else if paddlePosition.y > Float(Raylib.getScreenHeight()) - self.paddleSize.y {
            self.paddlePosition.y = Float(Raylib.getScreenHeight()) - self.paddleSize.y
        }
    }
}