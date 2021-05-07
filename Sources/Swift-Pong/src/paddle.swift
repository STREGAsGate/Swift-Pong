import Foundation
import CRaylib
import Raylib

struct Paddle {
    var Position: Rectangle
    var Speed: Float32
    var PaddleWidth: Float32
    var PaddleHeight: Float32
    var PaddleColor: Color

    init(Position: Rectangle, Speed: Float32, PaddleWidth: Float32, PaddleHeight: Float32, PaddleColor: Color) {
        self.Position = Position
        self.Speed = Speed
        self.PaddleWidth = PaddleWidth
        self.PaddleHeight = PaddleHeight
        self.PaddleColor = PaddleColor
    }

    mutating func Draw() {
        DrawRectangleRec(Position, PaddleColor)
    }
}