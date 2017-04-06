import SpriteKit
import GameKit

public class FinalScene: SKScene {
	
	// DesktopType
	enum victoryType : Int {
		
		case failed
		case success
		case battery
	}
	
	let speaker = Speaker()
	
	var toggleMenuButton = SKShapeNode()
	var background = SKSpriteNode()
	var victory = FinalScene.victoryType.failed
	
	public override func didMove(to view: SKView) {
		
		super.didMove(to: view)
		scaleMode = .aspectFit
		backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
		
		setupTimer()
	}
	
	func setupTimer() {
	
		switch victory {
		case .failed:
			background = SKSpriteNode.init(imageNamed: "mac_response_failed.jpeg")
			background.size = self.size
			background.position = CGPoint(x: frame.midX, y: frame.midY)
			addChild(background)
			
			speaker.delegate = self
			speaker.speak("Dear... Thank you for applying for a WWDC 2017 Scholarship... We regret that you did not send your playground on time... Maybe the next year!")
			
			toggleMenuButton = SKShapeNode(rectOf: CGSize(width: 104, height: 22))
			toggleMenuButton.fillColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 0)
			toggleMenuButton.strokeColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 0)
			toggleMenuButton.position = CGPoint(x: 316 + 52, y: 82 + 11)
			addChild(toggleMenuButton)
		case .success:
			background = SKSpriteNode.init(imageNamed: "mac_response_success.jpeg")
			background.size = self.size
			background.position = CGPoint(x: frame.midX, y: frame.midY)
			addChild(background)

			speaker.delegate = self
			speaker.speak("Dear... Thank you for applying for a WWDC 2017 Scholarship... Congratulations, you have sent your project on time, we are pleased to announce that ...")
			
			toggleMenuButton = SKShapeNode(rectOf: CGSize(width: 104, height: 22))
			toggleMenuButton.fillColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 0)
			toggleMenuButton.strokeColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 0)
			toggleMenuButton.position = CGPoint(x: 316 + 52, y: 82 + 11)
			addChild(toggleMenuButton)
		case .battery:
			
			background = SKSpriteNode.init(imageNamed: "mac_response_battery.jpeg")
			background.size = self.size
			background.position = CGPoint(x: frame.midX, y: frame.midY)
			addChild(background)
			
			speaker.delegate = self
			speaker.speak("You forgot to click on the battery notification at the beginning...")
			
			toggleMenuButton = SKShapeNode(rectOf: CGSize(width: size.width, height: size.height))
			toggleMenuButton.fillColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 0)
			toggleMenuButton.strokeColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 0)
			toggleMenuButton.position = CGPoint(x: frame.midX, y: frame.midY)
			addChild(toggleMenuButton)
		}
	}
	
	override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first {
			let location = touch.location(in: self)
			if toggleMenuButton.contains(location) {
				
				MusicManager.shared.stop()
				
				speaker.stop()
				let nextScene = Menu(size: self.scene!.size)
				nextScene.scaleMode = .aspectFill
				self.scene?.view?.presentScene(nextScene)
			}
		}
	}

}

extension FinalScene: AVSpeechSynthesizerDelegate {
	
	public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
		//print("Speaker class started")
	}
	
	public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
		//print("Speaker class finished")
	}
}
