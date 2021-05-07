import Foundation
import CRaylib
import Raylib

struct Ball {
    var position: Rectangle
    var velocity: Vector2
    var ballWidth: Float32
    var ballHeight: Float32
    var ballColor: Color

    init(position: Rectangle, velocity: Vector2, ballWidth: Float32, ballHeight: Float32, ballColor: Color) {
        self.position = position
        self.velocity = velocity
        self.ballWidth = ballWidth
        self.ballHeight = ballHeight
        self.ballColor = ballColor
    }

    mutating func Draw() {
        DrawRectangleRec(position, ballColor)
    }
}