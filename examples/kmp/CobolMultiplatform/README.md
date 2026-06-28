# Cobol Mobile Kotlin multiplatform app demo

This project demonstrates how to communicate from kotlin to COBOL in a Kotlin multiplatform application,
targeting Android and iOS.

This example uses the [kmp library](../../../kmp/).

## Demo

Everything is in one screen. This example is built on top of
a [Kotlin multiplatform template](https://kmp.jetbrains.com/templates/).

The screen has a button. Clicking on it will make a random number between 0 and 42 appear.

This is done by Kotlin code calling a COBOL procedure (via a JNI/C intermediary on Android, and c-interop on Kotlin).

| Android                                                           | iOS                                                       |
|-------------------------------------------------------------------|-----------------------------------------------------------|
| <img height="400" src="doc/android.png" alt="android screenshot"> | <img height="400" src="doc/ios.png" alt="ios screenshot"> |

## Architecture

The UI is shared between Android and iOS.

A "gateway" interface to call the COBOL prodedure is defined, and implemented
by Android (using JNI) and iOS (using c-interop).

The "gateway" implementation is injected into the `App` composable from each application's entry point:
* Android: `MainActivity`.
* iOS: `MainViewController`.

This example is as simple as possible. In a real app (really? a real mobile app with COBOL?), you
would likely:
* Provide the gateway implementation using a dependency injection framework.
* Have a viewmodel, and a use case, so the UI wouldn't directly be calling the "gateway" into COBOL.

```mermaid
graph TD
  subgraph shared
    subgraph commonMain
      subgraph App.kt
        app["App(gateway)"]
      end
      subgraph AnswerToLifeGateway.kt
        igateway["AnswerToLifeGateway.getAnswerToLife()"]
      end
      subgraph sharedCobol["AnswerToLife.cob"]
        cob["ANSWER-TO-LIFE"]
      end
  
      app --> igateway
    end
  
    subgraph androidMain
      subgraph AndroidAnswerToLifeGateway.kt
        gatewayAndroid["AndroidAnswerToLifeGateway.getAnswerToLife()"]
      end
    end
    subgraph iosMain
      subgraph IOSAnswerToLifeGateway.kt
        gatewayIos["IOSAnswerToLifeGateway.getAnswerToLife()"]
      end
  
      subgraph ExposeToKotlin.h
        kotlinheader["answerToLife()"]
      end
    end
  end

  subgraph androidCpp["androidApp/src/main/cpp"]
    subgraph AnswerToLifeJni.c
      jni["Java_ca_rmen_coboldemo_AndroidAnswerToLifeGateway_cobAnswerToLife"]
    end
  end

  subgraph iosBridge["iosApp/bridge"]
    subgraph AnswerToLifeWrapper.c
      wrapper["answerToLife()"]
    end
  end

  igateway --> gatewayAndroid
  gatewayAndroid --> jni
  jni --> cob

  igateway --> gatewayIos
  kotlinheader --> wrapper
  gatewayIos --> kotlinheader
  wrapper --> cob
```

