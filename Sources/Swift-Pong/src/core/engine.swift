import Raylib
import Foundation

struct engine {
    // Engine singleton --> Outgoing
    static let game = engine()
    private init() { }

    // Game logic <-- Receiving
    var logic = gameLogic()

    // Window Defines
    let windowWidth: Int32 = 1280
    let windowHeight: Int32 = 720
    let targetFPS:Int32 = 60

    // Run function that starts the game
    mutating func run() {
        // Initialisation
        Raylib.initWindow(windowWidth, windowHeight, "Pong Survival")
        Raylib.initAudioDevice()
        Raylib.setTargetFPS(targetFPS)

        // Main game loop
        while !Raylib.windowShouldClose {
            self.update()
            self.draw()
        }
        // Deinit and close the window and audio stream
        logic.sfxManager.closeAudio()
        Raylib.closeWindow()
    }
}

// Main engine update function which calls logic update
extension engine {
    private mutating func update() {
        logic.update()
    }
}
// Main engine draw function which calls logics draw function that holds all of objects draw function
extension engine {
    private func draw() {
        Raylib.beginDrawing()
        Raylib.clearBackground(.darkGreen)
        logic.draw()
        Raylib.endDrawing()
    }
}
