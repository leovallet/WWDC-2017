import SpriteKit
import AVFoundation

public class FormScene: SKScene {
	
	let speaker = Speaker()
	
	let timer_memory = LTimer()
	var isTimerAlreadyFinish = false
	var isVoiceFinished = false
	var isVoiceIsNeeded = true
	
	// Apple Park
	let circle_inside = SKShapeNode(circleOfRadius: 92)
	let circle_inside_mask = SKShapeNode(circleOfRadius: 87.5)
	let circle_outside = SKShapeNode(circleOfRadius: 126)
	let circle_outside_mask = SKShapeNode(circleOfRadius: 121.5)
	let fitness_center = SKShapeNode(rect: CGRect(x: 101, y: 39, width: 23, height: 74))
	let auditorium = SKShapeNode(circleOfRadius: 15)
	let parking_small = SKShapeNode()
	let parking_big = SKShapeNode()
	
	let background = SKSpriteNode(imageNamed: "mac_form.jpeg")
	let done_button = SKLabelNode()
	var timerLabel = SKLabelNode()
	var timer = LTimer()
	
	var batteryislow: Bool!
	
	// Color picker
	let colors = [#colorLiteral(red: 0.1607843137, green: 0.6901960784, blue: 0.8078431373, alpha: 1), #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)]
	var colorsRandom: [UIColor] = []
	var colorShapes: [SKShapeNode] = []
	var shapes: [SKShapeNode] = []
	
	
	public override func didMove(to view: SKView) {
		
		super.didMove(to: view)
		backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		scaleMode = .aspectFit
		view.isMultipleTouchEnabled = false
		
		background.name = "background"
		background.size = self.size
		background.position = CGPoint(x: frame.midX, y: frame.midY)
		addChild(background)
		
		done_button.position = CGPoint(x: frame.midX, y: 12)
		done_button.fontSize = 20
		done_button.fontColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		done_button.text = "Memorize"
		done_button.fontName = "HelveticaNeue-Medium"
		addChild(done_button)
		
		if isVoiceIsNeeded {
			speaker.delegate = self
			speaker.speak("You have five seconds to remember the colors on the lines... After this delay, you will need to fill them back like on the original. Go!")
		} else {
			speaker.delegate = self

			speaker.speak("Your memory is playing tricks on you!")
			setupForms()
			timer_memory.start(duration: 5)
			isVoiceFinished = true
		}
		
		timerLabel.position = CGPoint(x: frame.midX, y: 384)
		timerLabel.fontSize = 20
		timerLabel.fontColor = #colorLiteral(red: 0.3254901961, green: 0.3450980392, blue: 0.3725490196, alpha: 1)
		timerLabel.fontName = "HelveticaNeue"
		addChild(timerLabel)
	}
	
	public override func update(_ currentTime: TimeInterval) {
		
		timerLabel.text = timer.update() + "sec."
		
		if isVoiceFinished && timer_memory.hasFinish() && !isTimerAlreadyFinish {
			
			circle_inside.fillColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
			circle_outside.fillColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
			fitness_center.strokeColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
			auditorium.strokeColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
			parking_small.strokeColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
			parking_big.strokeColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
			
			setupColorPicker()
			
			done_button.text = "I'm done"
		}
		
		if timer.hasFinish() {
			let nextScene = FinalScene(size: scene!.size)
			nextScene.victory = FinalScene.victoryType.failed
			nextScene.scaleMode = .aspectFill
			scene?.view?.presentScene(nextScene)
		}
	}
	
	func setupForms() {
		
		var formColor = Array(colors)
		var randomIndex = Int(arc4random_uniform(UInt32(colors.count)))
		
		circle_outside.position = CGPoint(x: 121 + 123, y: 129 + 123)
		circle_outside.lineWidth = 0
		circle_outside.fillColor = formColor[randomIndex]
		addChild(circle_outside)
		
		circle_outside_mask.position = CGPoint(x: 121 + 123, y: 129 + 123)
		circle_outside_mask.lineWidth = 0
		circle_outside_mask.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		addChild(circle_outside_mask)
		
		shapes.append(circle_outside)
		colorsRandom.append(formColor[randomIndex])
		formColor.remove(at: randomIndex)
		randomIndex = Int(arc4random_uniform(UInt32(formColor.count)))
		
		circle_inside.position = CGPoint(x: 156 + 89, y: 163 + 89)
		circle_inside.lineWidth = 0
		circle_inside.fillColor = formColor[randomIndex]
		addChild(circle_inside)
		
		circle_inside_mask.position = CGPoint(x: 156 + 89, y: 163 + 89)
		circle_inside_mask.lineWidth = 0
		circle_inside_mask.fillColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		addChild(circle_inside_mask)
		
		shapes.append(circle_inside)
		colorsRandom.append(formColor[randomIndex])
		formColor.remove(at: randomIndex)
		randomIndex = Int(arc4random_uniform(UInt32(formColor.count)))
		
		fitness_center.lineWidth = 3
		fitness_center.strokeColor = formColor[randomIndex]
		addChild(fitness_center)
		
		shapes.append(fitness_center)
		colorsRandom.append(formColor[randomIndex])
		formColor.remove(at: randomIndex)
		randomIndex = Int(arc4random_uniform(UInt32(formColor.count)))
		
		auditorium.position = CGPoint(x: 462 + 15, y: 290 + 15)
		auditorium.lineWidth = 3
		auditorium.strokeColor = formColor[randomIndex]
		addChild(auditorium)
		
		shapes.append(auditorium)
		colorsRandom.append(formColor[randomIndex])
		formColor.remove(at: randomIndex)
		randomIndex = Int(arc4random_uniform(UInt32(formColor.count)))
		
		parking_small.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 30, height: 205), cornerRadius: 15).cgPath
		parking_small.position = CGPoint(x: 434, y: 108)
		parking_small.strokeColor = formColor[randomIndex]
		parking_small.lineWidth = 3
		parking_small.zRotation = 5.61996
		addChild(parking_small)
		
		shapes.append(parking_small)
		colorsRandom.append(formColor[randomIndex])
		formColor.remove(at: randomIndex)
		randomIndex = Int(arc4random_uniform(UInt32(formColor.count)))
		
		parking_big.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 30, height: 236), cornerRadius: 15).cgPath
		parking_big.position = CGPoint(x: 465, y: 84)
		parking_big.strokeColor = formColor[randomIndex]
		parking_big.lineWidth = 3
		parking_big.zRotation = 5.61996
		addChild(parking_big)
		
		shapes.append(parking_big)
		colorsRandom.append(formColor[randomIndex])
		formColor.remove(at: randomIndex)
	}
	
	func setupColorPicker() {
		
		isTimerAlreadyFinish = true
		
		var i = 0
		while i < colors.count {
			let colorPicker = SKShapeNode()
			colorPicker.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 38, height: 38), cornerRadius: 5).cgPath
			colorPicker.position = CGPoint(x: 668, y: 48 + (i * 57))
			colorPicker.fillColor = colors[i]
			colorPicker.lineWidth = 0
			addChild(colorPicker)
			colorShapes.append(colorPicker)
			i += 1
		}
	}
	
	var movableNode : SKNode?
	var movableColor : UIColor?
	var movablePoint : CGPoint?
	
	override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first {
			let location = touch.location(in: self)			
			
			
			// Handle done button only after memorize
			if isVoiceFinished && timer_memory.hasFinish() && isTimerAlreadyFinish {
				
				for clrShp in colorShapes {
					if clrShp.contains(location) {
						movablePoint = clrShp.position
						movableNode = clrShp
						movableColor = clrShp.fillColor
						movableNode!.position = CGPoint(x: location.x - 19, y: location.y - 19)
					}
				}
				
				if done_button.contains(location) {
					if isSameColors() {
						let nextScene = Desktop(size: scene!.size)
						nextScene.timer = self.timer
						nextScene.batteryislow = batteryislow
						nextScene.scaleMode = .aspectFill
						nextScene.typeScene = Desktop.desktopType.zip
						scene?.view?.presentScene(nextScene)
					} else {
						let nextScene = FormScene(size: scene!.size)
						nextScene.isVoiceIsNeeded = false
						nextScene.timer = self.timer
						nextScene.batteryislow = batteryislow
						nextScene.scaleMode = .aspectFill
						scene?.view?.presentScene(nextScene)
					}
				}
			}
		}
	}
	
	override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first, movableNode != nil {
			
			movableNode!.position = touch.location(in:
				self)
			movableNode!.position = CGPoint(x: (movableNode?.position.x)! - 19, y: (movableNode?.position.y)! - 19)
			let location = touch.location(in: self)

			if shapes[0].contains(location) && !circle_outside_mask.contains(location) {
				shapes[0].fillColor = movableColor!
			}
			
			if shapes[1].contains(location) && !circle_inside_mask.contains(location) {
				shapes[1].fillColor = movableColor!
			}
			
			if shapes[2].contains(location) {
				shapes[2].strokeColor = movableColor!
			}
			
			if shapes[3].contains(location) {
				shapes[3].strokeColor = movableColor!
			}
			
			if shapes[4].contains(location) {
				shapes[4].strokeColor = movableColor!
			}
			
			if shapes[5].contains(location) {
				shapes[5].strokeColor = movableColor!
			}
		}
	}
	
	override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first, movableNode != nil {
			movableNode!.position = touch.location(in: self)
			movableNode!.position = CGPoint(x: (movableNode?.position.x)! - 19, y: (movableNode?.position.y)! - 19)
			
			let moveRect = SKAction.move(to: movablePoint!, duration: 0.5)
			moveRect.timingMode = .easeInEaseOut
			movableNode?.run(moveRect)
			
			movableNode = nil
			movableColor = nil
		}
	}
	
	override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		if touches.first != nil {
			movableNode = nil
			movableColor = nil
		}
	}

	func isSameColors() -> Bool {
		
		var i = 0
		while i < colors.count {
			if i == 2 || i == 3 || i == 4 || i == 5 {
				if colorsRandom[i] != shapes[i].strokeColor {
					return false
				}
			} else {
				if colorsRandom[i] != shapes[i].fillColor {
					return false
				}
			}
			i += 1
		}
		return true
	}
}

extension FormScene: AVSpeechSynthesizerDelegate {
	
	public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
		//print("Speaker class started")
	}
	
	public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
		//print("Speaker class finished")
		
		if isVoiceIsNeeded {
			setupForms()
			timer_memory.start(duration: 5)
			isVoiceFinished = true
		}
	}
}
