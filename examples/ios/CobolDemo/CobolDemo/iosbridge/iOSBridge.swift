import AVFoundation
private let synthesizer = AVSpeechSynthesizer()

@_silgen_name("speakSwift")
func speak(message: UnsafePointer<CChar>) {
    // https://developer.apple.com/documentation/avfoundation/speech-synthesis
    let utterance = AVSpeechUtterance(string: String(cString: message))
    synthesizer.speak(utterance)
}
