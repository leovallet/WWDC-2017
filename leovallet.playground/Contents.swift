import SpriteKit
import PlaygroundSupport

let width = 736
let height = 414

// Set up containing view
let skView = SKView(frame: CGRect(x: 0, y: 0, width: width, height: height))
skView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
skView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]

// Add main scene
let scene = Menu(size: CGSize(width: width, height: height))
scene.scaleMode = .aspectFit
skView.presentScene(scene)

// Background Sound function
MusicManager.shared.setup()

// Show in Playground live view
let page = PlaygroundPage.current
page.liveView = skView
