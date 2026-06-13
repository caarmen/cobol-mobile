#import <AVFoundation/AVFoundation.h>

/**
 * Expose the speech synthesizer api in a single objective C function.
 */
void speakObjC(const char *message) {
    // Keep the synthesizer around for later invocations.
    static AVSpeechSynthesizer *synthesizer = nil;
    if (!synthesizer) synthesizer = [[AVSpeechSynthesizer alloc] init];

    NSString *str = [NSString stringWithUTF8String:message];
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:str];
    [synthesizer speakUtterance:utterance];
}
