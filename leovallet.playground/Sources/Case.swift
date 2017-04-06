import UIKit
import SpriteKit

class Case: SKShapeNode {
	
	var file: File!
	
	init(fillColor: UIColor, path: CGPath, position: CGPoint) {
		
		super.init()
		self.fillColor = fillColor
		self.path = path
		self.position = position
		self.lineWidth = 0
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
