import SpriteKit
import AVFoundation

public class ZipScene: SKScene {
	
	let speaker = Speaker()
	
	var types = [File.fileType.audio, File.fileType.code, File.fileType.image, File.fileType.video, File.fileType.ai, File.fileType.pdf]
	
	var total_size: Int = 0
	
	var images_value: [File] = []
	var grid: [Case] = []
	var colors = [#colorLiteral(red: 0.831372549, green: 0.3490196078, blue: 0.3294117647, alpha: 1), #colorLiteral(red: 0.9098039216, green: 0.6431372549, blue: 0.2, alpha: 1), #colorLiteral(red: 0.06666666667, green: 0.8588235294, blue: 0.8901960784, alpha: 1), #colorLiteral(red: 0.4823529412, green: 0.8588235294, blue: 0.2705882353, alpha: 1), #colorLiteral(red: 0.07843137255, green: 0.5921568627, blue: 0.9882352941, alpha: 1), #colorLiteral(red: 0.5333333333, green: 0.5058823529, blue: 0.9411764706, alpha: 1)]
	var calcul_order = [3, 3, 1, 2, 0, 1, 1, 0, 1, 0, 0, 0]
	
	let done_button = SKLabelNode()
	var timerLabel = SKLabelNode()
	var timer = LTimer()
	
	var batteryislow: Bool!
	var isVoiceIsNeeded = true

	public override func didMove(to view: SKView) {
		
		super.didMove(to: view)
		backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		scaleMode = .aspectFit
		view.isMultipleTouchEnabled = false
		
		setupHUD(image: "mac_zip.jpeg")
		setupValues()
		
		if isVoiceIsNeeded {
		speaker.delegate = self
		speaker.speak("Calculate the value of each type of file and when your done, click on the \"Next Step\" button.")
		} else {
			
			var weight: String!
			if total_size > 25 {
				weight = String(format: "Your zip file is too large... it must weigh 25 megabyte not %d", total_size)
			} else {
				weight = String(format: "Your zip file is too small... it must weigh 25 megabyte not %d", total_size)
			}
			
			speaker.delegate = self
			speaker.speak(weight)
			total_size = 0
		}
	}
	
	func setupHUD(image: String) {
		let background = SKSpriteNode(imageNamed: image)
		background.name = "background"
		background.size = self.size
		background.position = CGPoint(x: frame.midX, y: frame.midY)
		addChild(background)
		
		done_button.position = CGPoint(x: frame.midX, y: 12)
		done_button.fontSize = 20
		done_button.fontColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
		done_button.text = "Next step"
		done_button.fontName = "HelveticaNeue-Medium"
		addChild(done_button)
		
		timerLabel.position = CGPoint(x: frame.midX, y: 384)
		timerLabel.fontSize = 20
		timerLabel.fontColor = #colorLiteral(red: 0.3254901961, green: 0.3450980392, blue: 0.3725490196, alpha: 1)
		timerLabel.fontName = "HelveticaNeue"
		addChild(timerLabel)
	}
	
	func setupValues() {
		
		var randomIndexColors = Int(arc4random_uniform(UInt32(colors.count)))
		var randomIndexTypes = Int(arc4random_uniform(UInt32(types.count)))
		
		var file = File(value: 5, type: types[randomIndexTypes], color: colors[randomIndexColors])
		
		images_value.append(file)
		types.remove(at: randomIndexTypes)
		colors.remove(at: randomIndexColors)
		randomIndexColors = Int(arc4random_uniform(UInt32(colors.count)))
		randomIndexTypes = Int(arc4random_uniform(UInt32(types.count)))
		
		file = File(value: 2, type: types[randomIndexTypes], color: colors[randomIndexColors])
		
		images_value.append(file)
		types.remove(at: randomIndexTypes)
		colors.remove(at: randomIndexColors)
		randomIndexColors = Int(arc4random_uniform(UInt32(colors.count)))
		randomIndexTypes = Int(arc4random_uniform(UInt32(types.count)))
		
		file = File(value: 4, type: types[randomIndexTypes], color: colors[randomIndexColors])
		
		images_value.append(file)
		types.remove(at: randomIndexTypes)
		colors.remove(at: randomIndexColors)
		randomIndexColors = Int(arc4random_uniform(UInt32(colors.count)))
		randomIndexTypes = Int(arc4random_uniform(UInt32(types.count)))
		
		file = File(value: 1, type: types[randomIndexTypes], color: colors[randomIndexColors])
		
		images_value.append(file)
		types.remove(at: randomIndexTypes)
		colors.remove(at: randomIndexColors)
		randomIndexColors = Int(arc4random_uniform(UInt32(colors.count)))
		randomIndexTypes = Int(arc4random_uniform(UInt32(types.count)))
		
		file = File(value: 0, type: types[randomIndexTypes], color: colors[randomIndexColors])
		
		images_value.append(file)
		types.remove(at: randomIndexTypes)
		colors.remove(at: randomIndexColors)
		randomIndexColors = Int(arc4random_uniform(UInt32(colors.count)))
		randomIndexTypes = Int(arc4random_uniform(UInt32(types.count)))
		
		file = File(value: 0, type: types[randomIndexTypes], color: colors[randomIndexColors])
		
		images_value.append(file)
		types.remove(at: randomIndexTypes)
		colors.remove(at: randomIndexColors)
		randomIndexColors = Int(arc4random_uniform(UInt32(colors.count)))
		randomIndexTypes = Int(arc4random_uniform(UInt32(types.count)))
		
		setupGameCalcul()
	}
	
	func setupGameCalcul() {
	
		var i = 0
		for order in calcul_order {
			let colorPicker = SKShapeNode()
			colorPicker.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 41, height: 41), cornerRadius: 5).cgPath
			colorPicker.position = CGPoint(x: 238 + ((i % 3) * 69), y: 86 + ((i / 3) * 67))
			colorPicker.fillColor = images_value[order].color
			colorPicker.lineWidth = 0
			
			let texture = SKTexture(image: images_value[order].image)
			let texturedPiece = SKSpriteNode(texture: texture)
			texturedPiece.position = CGPoint(x: 20.5, y: 20.5)
			texturedPiece.size = CGSize(width: 23, height: 23)
			colorPicker.addChild(texturedPiece)
			
			addChild(colorPicker)
			i += 1
		}
	}
	
	func setupGameConstruction() {
	
		speaker.delegate = self
		speaker.speak("Now you have to build your zip file by making a 25 megabyte file... Selecting a file will add his value to the total weight of the zip file...")
		
		self.removeAllChildren()
		setupHUD(image: "mac_form.jpeg")
	
		done_button.text = "I'm done"
		
		var array: [Int] = []
		
		var a = 0
		while a < 36 {
			if a < 4 {
				array.append(0)
			} else if a < 6 {
				array.append(1)
			} else if a < 7 {
				array.append(2)
			} else {
				array.append(Int(arc4random_uniform(6 - 1) + 1))
			}
			a += 1
		}
		
		let newArray = array.shuffled()
		
		var i = 0
		for index in newArray {
			let colorPicker = Case(fillColor: images_value[index].color, path: UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 41, height: 41), cornerRadius: 5).cgPath, position: CGPoint(x: 70 + ((i % 9) * 70), y: 85 + ((i / 9) * 68)))
		
			let texture = SKTexture(image: images_value[index].image)
			let texturedPiece = SKSpriteNode(texture: texture)
			texturedPiece.name = "file"
			texturedPiece.position = CGPoint(x: 20.5, y: 20.5)
			texturedPiece.size = CGSize(width: 23, height: 23)
			colorPicker.addChild(texturedPiece)
			addChild(colorPicker)
			colorPicker.file = File(value: images_value[index].value, type: images_value[index].type, color: images_value[index].color)
			grid.append(colorPicker)
			i += 1
		}
	}
	
	public override func update(_ currentTime: TimeInterval) {
		
		timerLabel.text = timer.update() + "sec."
		
		if timer.hasFinish() {
			speaker.stop()
			let nextScene = FinalScene(size: scene!.size)
			nextScene.victory = FinalScene.victoryType.failed
			nextScene.scaleMode = .aspectFill
			scene?.view?.presentScene(nextScene)
		}
	}
	
	override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if let touch = touches.first {
			let location = touch.location(in: self)
			
			for elm in grid {
				if elm.contains(location) {
					let shape = grid[grid.index(of: elm)!]
					let file = shape.file
					
					file?.selected = !(file?.selected)!
				
					if (file?.selected)! {
						total_size = total_size + (file?.value)!
						shape.childNode(withName: "file")?.alpha = 0.25
					} else {
						total_size = total_size - (file?.value)!
						shape.childNode(withName: "file")?.alpha = 1
					}
					grid[grid.index(of: elm)!].file = file
				}
			}
						
			if done_button.contains(location) {
				if done_button.text == "Next step" {
					setupGameConstruction()
				} else {
					if total_size == 25 {
						speaker.stop()
						let nextScene = Desktop(size: scene!.size)
						nextScene.timer = self.timer
						nextScene.batteryislow = batteryislow
						nextScene.typeScene = Desktop.desktopType.safari
						nextScene.scaleMode = .aspectFill
						scene?.view?.presentScene(nextScene)
					} else {
						speaker.stop()
						let nextScene = ZipScene(size: scene!.size)
						nextScene.timer = self.timer
						nextScene.batteryislow = batteryislow
						nextScene.total_size = total_size
						nextScene.isVoiceIsNeeded = false
						nextScene.scaleMode = .aspectFill
						scene?.view?.presentScene(nextScene)
					}
				}
			}
		}
	}
}

extension MutableCollection where Indices.Iterator.Element == Index {

	mutating func shuffle() {
		let c = count
		guard c > 1 else { return }
		
		for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
			let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
			guard d != 0 else { continue }
			let i = index(firstUnshuffled, offsetBy: d)
			swap(&self[firstUnshuffled], &self[i])
		}
	}
}

extension Sequence {

	func shuffled() -> [Iterator.Element] {
		var result = Array(self)
		result.shuffle()
		return result
	}
}

extension ZipScene: AVSpeechSynthesizerDelegate {
	
	public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
		//print("Speaker class started")
	}
	
	public func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
		//print("Speaker class finished")
	}
}
