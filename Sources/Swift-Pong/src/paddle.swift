import Foundation
import CRaylib
import Raylib

struct Paddle {
    var position: Rectangle
    var velocity: Vector2
    var paddleWidth: Float32
    var paddleHeight: Float32
    var paddleColor: Color

    init(position: Rectangle, velocity: Vector2, paddleWidth: Float32, paddleHeight: Float32, paddleColor: Color) {
        self.position = position
        self.velocity = velocity
        self.paddleWidth = paddleWidth
        self.paddleHeight = paddleHeight
        self.paddleColor = paddleColor
    }

    mutating func Draw() {
        DrawRectangleRec(position, paddleColor)
    }
}