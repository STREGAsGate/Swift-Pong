import Foundation
import CRaylib
import Raylib

struct Ball {
    var Position: Rectangle
    var Velocity: Vector2
    var BallWidth: Float32
    var BallHeight: Float32
    var BallColor: Color

    init(Position: Rectangle, Velocity: Vector2, BallWidth: Float32, BallHeight: Float32, BallColor: Color) {
        self.Position = Position
        self.Velocity = Velocity
        self.BallWidth = BallWidth
        self.BallHeight = BallHeight
        self.BallColor = BallColor
    }

    mutating func Draw() {
        DrawRectangleRec(Position, BallColor)
    }
}