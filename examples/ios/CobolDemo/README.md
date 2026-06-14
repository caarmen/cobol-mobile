# Cobol Mobile iOS app demo

This project demonstrates how to communicate between
COBOL and the Swift/Objective-C layer of an iOS application.

Everything is in one screen.

The screen has a button. Clicking on it will make a random
number between 0 and 42 appear. This is done by Swift code calling
a COBOL procedure. 

Then, depending on the number, a text may be spoken by the speech synthesizer. This is done by
COBOL calling out to the AVFAudio framework's speech synthesizer apis. A few variants of
this communication direction are demonstrated:

| Number Divisible by  | Spoken text | Demonstrates                                                                   |
|---|---|---|
| 3 and 5 | FizzBuzz! | Calling app Swift from COBOL |
| 3       | Fizz!      | Calling app Objective-C from COBOL |
| 5       | Buzz!      | Calling framework APIs from COBOL, using introspection |

<img alt="fizzbuzz" width="240" src="doc/fizzbuzz.png">

## Calling COBOL from Swift

```mermaid
graph TD
  ContentView[ContentView.swift]
  subgraph iostocobol[ios-to-cobol]
    subgraph AnswerToLifeBridge[AnswerToLifeBridge.c,h]
      funcC[int answerToLife]
    end
  end
  subgraph cobol
    subgraph AnswerToLife.cob
      funcCob[ANSWER-TO-LIFE]
    end
  end

ContentView --> funcC
funcC --> funcCob
```

## Calling the iOS framework from COBOL
### Most logic in Swift
```mermaid
graph BT
  subgraph iOS[iOS Framework]
    subgraph AVSpeechSynthesizer
      funciOS[AVSpeechSynthesizer.speak]
    end
  end
  subgraph coboltoios[cobol-to-ios]
    subgraph iOSBridge[iOSBridge.swift,h]
      funcSwift[_cdecl speakSwift]
    end
  end
  subgraph cobol[cobol]
    subgraph AnswerToLife.cob
      funcCob[ANSWER-TO-LIFE]
    end
  end

funcSwift --> funciOS
funcCob --> funcSwift
```
### Most logic in Objective-C
```mermaid
graph BT
  subgraph iOS[iOS Framework]
    subgraph AVSpeechSynthesizer
      funciOS[AVSpeechSynthesizer.speak]
    end
  end
  subgraph coboltoios[cobol-to-ios]
    subgraph iIOSBridge[iOSBridge.m,h]
      funcObjc[speakObjc]
    end
  end
  subgraph cobol[cobol]
    subgraph AnswerToLife.cob
      funcCob[ANSWER-TO-LIFE]
    end
  end

funcObjc --> funciOS
funcCob --> funcObjc
```
### Most logic in COBOL
```mermaid
graph BT
  subgraph iOS[iOS Framework]
    subgraph AVSpeechSynthesizer
      funciOS[AVSpeechSynthesizer.speak]
    end
  end

  subgraph cobol[cobol]
    subgraph AnswerToLife.cob
      funcCob[ANSWER-TO-LIFE<br>Introspection]
    end
  end

funcCob --> funciOS
```

## XCode setup
See [doc/xcode-setup.md](doc/xcode-setup.md) for some tips on building with COBOL in Xcode.