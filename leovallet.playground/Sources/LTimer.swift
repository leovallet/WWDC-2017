import Foundation

class LTimer: NSObject {
	
	var end: Date!
	
	func update() -> String {
		
		return String(Int(timeLeft()))
	}
	
	func start(duration: TimeInterval) {
		
		let now = Date()
		end = now.addingTimeInterval(duration)
	}
	
	func hasFinish() -> Bool {
		
		return timeLeft() == 0
	}
	
	private func timeLeft() -> TimeInterval {
		
		let now = Date()
		let remaining = end.timeIntervalSince(now)
		
		return max(remaining, 0)
	}
}
