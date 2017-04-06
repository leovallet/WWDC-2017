import Foundation
import AVFoundation

public class MusicManager {
	
	public static let shared = MusicManager()
	var player: AVAudioPlayer?
	
	private init() { }
	
	public func setup() {
		let url = Bundle.main.url(forResource: "background", withExtension: "m4a")!
		
		do {
			player = try AVAudioPlayer(contentsOf: url)
			guard let player = player else { return }
			
			player.volume = 0.25
			player.numberOfLoops = -1
			player.prepareToPlay()
			player.play()
		} catch let error {
			print(error.localizedDescription)
		}
	}
	
	public func play() {
		player?.play()
	}
	
	public func stop() {
		player?.stop()
		player?.currentTime = 0
		player?.prepareToPlay()
	}
}
