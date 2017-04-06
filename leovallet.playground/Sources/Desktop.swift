import SpriteKit
import AVFoundation

public class Desktop: SKScene {
	
	// DesktopType
	enum desktopType : Int {
		
		case start
		case zip
		case safari
		case upload
	}
	
	let speaker = Speaker()
	
	var timerLabel = SKLabelNode()
	var timer = LTimer()
	var typeScene = Desktop.desktopType.start
	var toggleStartButton = SKShapeNode()
	
	var button = SKSpriteNode()
	var cameraScene: SKCameraNode!
	
	var batteryislow: Bool!
	
	public override func didMove(to view: SKView) {
		
		super.didMove(to: view)
		scaleMode = .aspectFit
		
		switch typeScene {
		case .start:
			
			batteryislow = true
			
			speaker.delegate = self
			speaker.speak("OK, I need your help, I only have 2 minutes to finish my project and send it to apple...  Click on the Playground to finish it together.")
			
			setupTimer(image: "mac_park_stroke.jpeg")
			timer.start(duration: 120)
			toggleStartButton = SKShapeNode(rectOf: CGSize(width: 644, height: 319))
			toggleStartButton.fillColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 0)
			toggleStartButton.strokeColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 0)
			toggleStartButton.position = CGPoint(x: 16 + 322, y: 53 + 159.5)
			addChild(toggleStartButton)
			
			button = SKSpriteNode(imageNamed: "battery")
			button.name = "zip"
			button.size = CGSize(width: 172, height: 48)
			button.position = CGPoint(x: 746 + 86, y: 339 + 24)
			addChild(button)
			
			let when = DispatchTime.now() + 1.5
			DispatchQueue.main.asyncAfter(deadline: when) {
				self.moveNotification()
			}
		case .zip:
			
			speaker.delegate = self
			speaker.speak("Click on the playground file to unleash the zip file.")
			
			setupTimer(image: "mac_park.jpeg")
			toggleStartButton = SKShapeNode(rectOf: CGSize(width: 30, height: 51))
			toggleStartButton.fillColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 0)
			toggleStartButton.strokeColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 0)
			toggleStartButton.position = CGPoint(x: 691 + 15, y: 330 + 25.5)
			addChild(toggleStartButton)
		case .safari:
			
			speaker.delegate = self
			speaker.speak("Open Safari by clicking on its icon.")
			
			setupTimer(image: "mac_park.jpeg")
			toggleStartButton = SKShapeNode(rectOf: CGSize(width: 16, height: 16))
			toggleStartButton.fillColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 0)
			toggleStartButton.strokeColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 0)
			toggleStartButton.position = CGPoint(x: 342 + 8, y: 7 + 8)
			addChild(toggleStartButton)
			
			button = SKSpriteNode(imageNamed: "zip_file")
			button.name = "zip"
			button.size = CGSize(width: 30, height: 51)
			button.position = CGPoint(x: 691 + 15, y: 261 + 25.5)
			addChild(button)
		case .upload:
			
			speaker.delegate = self
			speaker.speak("Drag and drop the zip file on the upload button and we will be finished.")
			
			setupTimer(image: "mac_safari.jpeg")
			
			button = SKSpriteNode(imageNamed: "zip_file")
			button.name = "zip"
			button.size = CGSize(width: 30, height: 51)
			button.position = CGPoint(x: 691 + 15, y: 261 + 25.5)
			addChild(button)
		}
	}
	
	func setupTimer(image: String) {
		
		cameraScene = SKCameraNode()
		cameraScene.position = CGPoint(x: frame.midX, y: frame.midY)
		camera = cameraScene
		addChild(cameraScene)
		
		let background = SKSpriteNode(imageNamed: image)
		background.name = "background"
		background.size = self.size
		background.position = CGPoint(x: frame.midX, y: frame.midY)
		addChild(background)

		timerLabel.position = CGPoint(x: frame.midX, y: 384)
		timerLabel.fontSize = 20
		timerLabel.fontColor = #colorLiteral(red: 0.3254901961, green: 0.3450980392, blue: 0.3725490196, alpha: 1)
		timerLabel.fontName = "HelveticaNeue"
		addChild(timerLabel)
	}
	
	public override func update(_ currentTime: TimeInterval) {
		
		if !timer.hasFinish() {
			timerLabel.text = timer.update() + "sec."
		} else {
			speaker.stop()
			let nextScene = FinalScene(size: scene!.size)
			nextScene.victory = FinalScene.victoryType.failed
			nextScene.scaleMode = .aspectFill
			scene?.view?.presentScene(nextScene)
		}
	}
	
	var movableNode : SKNode?
	var movablePoint : CGPoint?
	
	override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first {
			let location = touch.location(in: self)
			
			switch typeScene {
			case .start:
				if button.contains(location) {
					batteryislow = false
					removeNotification()
				} else if toggleStartButton.contains(location) {
					moveToFormGame()
				}
			case .zip:
				if toggleStartButton.contains(location) {
					speaker.stop()
					let nextScene = ZipScene(size: self.scene!.size)
					nextScene.timer = self.timer
					nextScene.batteryislow = batteryislow
					nextScene.scaleMode = .aspectFill
					self.scene?.view?.presentScene(nextScene)
				}
			case .safari:
				if toggleStartButton.contains(location) {
					speaker.stop()
					let nextScene = Desktop(size: self.scene!.size)
					nextScene.timer = self.timer
					nextScene.typeScene = .upload
					nextScene.batteryislow = batteryislow
					nextScene.scaleMode = .aspectFill
					self.scene?.view?.presentScene(nextScene)
				}
			case .upload:
				if button.contains(location) {
					movablePoint = button.position
					movableNode = button
					movableNode!.position = location
				}
			}
		}
	}
	
	override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first, movableNode != nil {
			movableNode!.position = touch.location(in:
				self)
			let location = touch.location(in: self)
			
			switch typeScene {
			case .start:
				break
			case .zip:
				break
			case .safari:
				break
			case .upload:
				if batteryislow {
					if location.x > 0 && location.x < 496 && location.y > 0 && location.y < 414 {
						
						MusicManager.shared.stop()
						speaker.stop()
						let nextScene = FinalScene(size: scene!.size)
						nextScene.victory = FinalScene.victoryType.battery
						nextScene.scaleMode = .aspectFill
						scene?.view?.presentScene(nextScene)
					}
				} else {
					if location.x > 208 && location.x < 208 + 176 && location.y > 73 && location.y < 73 + 38 {
						
						speaker.stop()
						let nextScene = FinalScene(size: scene!.size)
						nextScene.victory = FinalScene.victoryType.success
						nextScene.scaleMode = .aspectFill
						scene?.view?.presentScene(nextScene)
					}
				}
			}
		}
	}
	
	override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first, movableNode != nil {
			movableNode!.position = touch.location(in: self)
			
			let moveRect = SKAction.move(to: movablePoint!, duration: 0.5)
			moveRect.timingMode = .easeInEaseOut
			movableNode?.run(moveRect)
			
			movableNode = nil
		}
	}
	
	override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		if touches.first != nil {
			movableNode = nil
		}
	}
	
	func moveToFormGame() {
				
		let move = SKAction.move(to: CGPoint(x: frame.midX + 137, y: frame.midY + 75), duration: 0.2)
		move.timingMode = .easeInEaseOut
		let scale = SKAction.scale(by: 0.384, duration: 0.2)
		let group = SKAction.group([move, scale])
		cameraScene.run(group) {
			
			self.speaker.stop()
			let nextScene = FormScene(size: self.scene!.size)
			nextScene.timer = self.timer
			nextScene.batteryislow = self.batteryislow
			nextScene.scaleMode = .aspectFill
			self.scene?.view?.presentScene(nextScene)
		}
	}
	
	func moveNotification() {
		
		let move = SKAction.move(to: CGPoint(x: 555 + 86, y: 339 + 24), duration: 0.5)
		move.timingMode = .easeInEaseOut
		let group = SKAction.group([move])
		button.run(group) {
			let when = DispatchTime.now() + 4
			DispatchQueue.main.asyncAfter(deadline: when) {
				self.removeNotification()
			}
		}
	}
	
	func removeNotification() {
		let move = SKAction.move(to: CGPoint(x: 746 + 86, y: 339 + 24), duration: 0.5)
		move.timingMode = .easeInEaseOut
		let group = SKAction.group([move])
		button.run(group) {
			Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.removeNotification), userInfo: nil, repeats: false).fire()
		}
	}
}

extension Desktop: AVSpeechSynthesizerDelegate {
	
	public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
		//print("Speaker class started")
	}
	
	public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
		//print("Speaker class finished")
	}
}
