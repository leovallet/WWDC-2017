import SpriteKit
import AVFoundation

public class Menu: SKScene {
	
	let speaker = Speaker()
	let background = SKSpriteNode(imageNamed: "mac_lock.jpeg")
	let toggleStartButton = SKShapeNode(rectOf: CGSize(width: 104, height: 22))
	
	public override func didMove(to view: SKView) {
		
		super.didMove(to: view)
		scaleMode = .aspectFit
		setupNodes()
		
		MusicManager.shared.play()
		
		speaker.delegate = self
		speaker.speak("Hello, welcome to my playground, click on the \"I'm ready!\" button to start the game")
	}
	
	// Add nodes to the scene
	func setupNodes() {

		background.name = "background"
		background.size = self.size
		background.position = CGPoint(x: frame.midX, y: frame.midY)
		addChild(background)
		
		toggleStartButton.fillColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 0)
		toggleStartButton.strokeColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 0)
		toggleStartButton.position = CGPoint(x: 316 + 52, y: 164 + 11)
		addChild(toggleStartButton)
	}
	
	public override func update(_ currentTime: TimeInterval) {
		
	}
	
	override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first {
			let location = touch.location(in: self)
			if toggleStartButton.contains(location) {
				speaker.stop()
				let nextScene = Desktop(size: self.scene!.size)
				nextScene.scaleMode = .aspectFill
				self.scene?.view?.presentScene(nextScene)
			}
		}
	}
}

extension Menu: AVSpeechSynthesizerDelegate {
	
	public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
		//print("Speaker class started")
	}
	
	public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
		//print("Speaker class finished")
	}
}
