import AVFoundation
private let synthesizer = AVSpeechSynthesizer()

/**
 * Expose the speech synthesizer api in a single swift function.
 */
@_cdecl("speakSwift")
func speakSwift(message: UnsafePointer<CChar>) {
    // https://developer.apple.com/documentation/avfoundation/speech-synthesis
    let utterance = AVSpeechUtterance(string: String(cString: message))
    synthesizer.speak(utterance)
}
