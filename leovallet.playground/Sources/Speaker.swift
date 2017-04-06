import AVFoundation

class Speaker: NSObject {
	
	let synth = AVSpeechSynthesizer()
	var delegate: AVSpeechSynthesizerDelegate?
	
	override init() {
		super.init()
	}
	
	func speak(_ announcement: String) {
		
		synth.delegate = delegate
		
		prepareAudioSession()
		let utterance = AVSpeechUtterance(string: announcement.lowercased())
		utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Karen-compact")
		synth.speak(utterance)
	}
	
	private func prepareAudioSession() {
		do {
			try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient, with: .mixWithOthers)
		} catch {
			print(error)
		}
		
		do {
			try AVAudioSession.sharedInstance().setActive(true)
		} catch {
			print(error)
		}
	}
	
	func stop() {
		if synth.isSpeaking {
			synth.stopSpeaking(at: .immediate)
		}
	}
}
