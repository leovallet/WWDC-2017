import UIKit

class File: NSObject {
	
	// FileType
	enum fileType : Int {
		
		case audio
		case code
		case image
		case video
		case ai
		case pdf
	}
	
	var type: fileType!
	var value: Int!
	var color: UIColor!
	var image: UIImage!
	var selected: Bool!
	
	required init(value: Int, type: fileType, color: UIColor) {
		
		super.init()
		self.type = type
		self.selected = false
		self.value = value
		self.color = color
		self.image = imageByFileType(type: type)
	}
	
	func imageByFileType(type: fileType) -> UIImage {
		switch type {
		case .audio:
			return UIImage(named: "audio_file.png")!
		case .code:
			return UIImage(named: "code_file.png")!
		case .image:
			return UIImage(named: "image_file.png")!
		case .video:
			return UIImage(named: "video_file.png")!
		case .ai:
			return UIImage(named: "ai_file.png")!
		case .pdf:
			return UIImage(named: "pdf_file.png")!
		}
	}
}
