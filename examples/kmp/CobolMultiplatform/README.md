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
by Android (using JNI) and iOS (using c-interop). The different implementations are implemented using expect/actual.

This example is as simple as possible. In a real app (really? a real mobile app with COBOL?), you
would likely have a viewmodel, and a use case, so the UI wouldn't directly be calling the "gateway" into COBOL.

### Initialization

Before running the `ANSWER-TO-LIFE` procedure, the GnuCOBOL runtime must be initialized. Specifically, the `cob_init` function defined in the GnuCOBOL runtime must be called.

In this KMP application, we use a kotlin API `GnuCOBOL.initialize()` exposed by the KMP library.

The implementation of `GnuCOBOL.initialize()` depends on the platform:
- For Android, it calls into the gnucobol-android library, which calls through to `cob_init` via a JNI layer.
- For iOS, it calls into `cob_init` function exposed by the GnuCOBOL-ios package. The swift layer isn't used by the KMP library. Direct calls from Kotlin to Swift aren't currently possible. An additional Objective-C layer would be required. Instead, the KMP library directly accesses the `cob_init` C function via c-interop. The swift layer is relevant for an iOS app not using kotlin multiplatform. See the [ios example](../../ios/CobolDemo).

```mermaid
graph TD
  subgraph application
    subgraph commonMain
      app["App"]
    end
  end

  subgraph kmplib[gnucobol-kmp library]
    subgraph shared
      subgraph commonMainlib[commonMain]
        GnuCOBOL.initializekmp["GnuCOBOL.initialize()"]
        initializeImpl["expect fun initializeImpl()"]
      end
      subgraph androidMain
        initializeImplAndroid["actual fun initializeImpl()"]
      end
      subgraph iosMain
        initializeImplIos["actual fun initializeImpl()"]
      end
    end
  end
  subgraph androidlib[gnucobol-android library]
    subgraph kotlinlayer[kotlin wrapper]
      GnuCOBOL.initializeandroid["GnuCOBOL.initialize()"]
      cobInit["external fun cobInit()"]
    end
    Java_ca_rmen_gnucobol_GnuCOBOL_cobInit
    subgraph clayerandroid[C]
        cob_initandroid["libcob.so: cob_init()"]
    end
  end
  subgraph ioslib[GnuCOBOL-ios package]
    subgraph swiftlayer["`*GnuCOBOL - swift wrapper (unused)*`"]
      GnuCOBOL.initializeios["`*GnuCOBOL.initialize()*`"]
    end
    style swiftlayer stroke-dasharray: 5 5
    subgraph clayerios[GnuCOBOLCore - framework target]
      cob_initios["libcob.a: cob_init()"]
    end
  end
  
  app --> GnuCOBOL.initializekmp
  GnuCOBOL.initializekmp --> initializeImpl
  initializeImpl --> initializeImplAndroid
  initializeImplAndroid --> GnuCOBOL.initializeandroid
  GnuCOBOL.initializeandroid -->cobInit
  cobInit --> |jni|Java_ca_rmen_gnucobol_GnuCOBOL_cobInit
  Java_ca_rmen_gnucobol_GnuCOBOL_cobInit --> cob_initandroid

  initializeImpl --> initializeImplIos
  initializeImplIos --> |c-interop|cob_initios
  GnuCOBOL.initializeios -.-> |"`*modulemap*`"|cob_initios
```

### ANSWER-TO-LIFE application procedure

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

