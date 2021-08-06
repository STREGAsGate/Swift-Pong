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

    func hasCollided(with paddle: Paddle) -> Bool {
        if self.position.x > paddle.position.x + paddle.paddleWidth + 5 || paddle.position.x > self.position.x + self.ballWidth + 5{
            return false
        }

        if self.position.y > paddle.position.y + paddle.paddleHeight + 5 || paddle.position.y > self.position.y + self.ballHeight + 5{
            return false
        }

        return true
    }
}

var player = Paddle(position: Rectangle(x: 10, y: 320, width: 10, height: 100), velocity: Vector2(x: 0, y: 550), paddleWidth: 10, paddleHeight: 100, paddleColor: WHITE)
var AI = Paddle(position: Rectangle(x:1260, y: 320, width: 10, height: 100), velocity: Vector2(x: 420, y: 420), paddleWidth: 10, paddleHeight: 100, paddleColor: WHITE)
var ball = Ball(position: Rectangle(x:Float(GameConfig.WINDOW_WIDTH/2), y:Float(GameConfig.WINDOW_HEIGHT/2), width: 10, height: 10), velocity: Vector2(x: 420, y:420), ballWidth: 10, ballHeight: 10, ballColor: WHITE)