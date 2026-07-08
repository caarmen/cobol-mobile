# Cobol Mobile Android app demo

This project demonstrates how to communicate between
COBOL and the Java/Kotlin layer of an Android application.

Everything is in one screen.

The screen has a button. Clicking on it will make a random
number between 0 and 42 appear. This is done by Kotlin code calling
a COBOL procedure (via a JNI/C intermediary).

Then, depending on the number, a Toast will appear. This is done by
COBOL calling out to AOSP's `Toast.makeText` API. A few variants of
this communication direction are demonstrated:

| Number Divisible by  | Toast text | Demonstrates                                                                   |
|---|---|---|
| 3 and 5 | FizzBuzz!  | Calling app Kotlin from COBOL                                                  |
| 3       | Fizz!      | Calling Android framework from COBOL,<br> with JNI boilerplate in a C function |
| 5       | Buzz!      | Calling Android framework from COBOL,<br> with JNI boilerplate in COBOL        |

<img alt="fizzbuzz" width="240" src="doc/fizzbuzz.png">

## Calling COBOL from Kotlin

### Initialization

Before running the `ANSWER-TO-LIFE` procedure, the GnuCOBOL runtime must be initialized. Specifically, the `cob_init` function defined in the GnuCOBOL runtime must be called.

For this purpose, a kotlin wrapper is provided.

```mermaid
graph TD
  subgraph application
    MainActivity
  end

  subgraph androidlib[gnucobol-android library]
    subgraph kotlinlayer[kotlin wrapper]
      GnuCOBOL.initialize["GnuCOBOL.initialize()"]
      cobInit["external fun cobInit()"]
    end
    Java_ca_rmen_gnucobol_GnuCOBOL_cobInit
    subgraph clayer[C]
        cob_init["libcob.so: cob_init()"]
    end
  end

  MainActivity -->GnuCOBOL.initialize
  GnuCOBOL.initialize -->cobInit
  cobInit --> |jni| Java_ca_rmen_gnucobol_GnuCOBOL_cobInit
  Java_ca_rmen_gnucobol_GnuCOBOL_cobInit --> cob_init
```

### ANSWER-TO-LIFE application procedure

```mermaid
graph TD
  subgraph kt[java sourceSet]
    subgraph AnswerToLife.kt
      funcKt(external fun cobAnswerToLife)
    end
  end
  subgraph cpp[cpp sourceSet]
    subgraph AnswerToLifeJNI.c
      funcJni(jint Java_com_example_coboldemo_AnswerToLife_cobAnswerToLife)
    end
  end
  subgraph cobol[cobol sourceSet]
    subgraph AnswerToLife.cob
      funcCob[ANSWER-TO-LIFE]
    end
  end

funcKt --> funcJni
funcJni --> funcCob
```

## Calling AOSP from COBOL
### Most logic in Kotlin
```mermaid
graph BT
  subgraph AOSP
    subgraph Toast
      funcAOSP[Toast.makeText]
    end
  end
  subgraph kt[java sourceSet]
    subgraph AndroidBridge.kt
      funcKt(showToast)
    end
  end
  subgraph cpp[cpp sourceSet]
    subgraph AndroidBridge.c
      funcJni(showToastKt<br>JNI boilerplate)
    end
  end
  subgraph cobol[cobol sourceSet]
    subgraph AnswerToLife.cob
      funcCob[ANSWER-TO-LIFE]
    end
  end

funcKt --> funcAOSP
funcJni --> funcKt
funcCob --> funcJni
```
### Most logic in C
```mermaid
graph BT
  subgraph AOSP
    subgraph Toast
      funcAOSP[Toast.makeText]
    end
  end

  subgraph cpp[cpp sourceSet]
    subgraph AndroidBridge.c
      funcJni(showToastC<br>JNI boilerplate)
    end
  end
  subgraph cobol[cobol sourceSet]
    subgraph AnswerToLife.cob
      funcCob[ANSWER-TO-LIFE]
    end
  end

funcJni --> funcAOSP
funcCob --> funcJni
```
### Most logic in COBOL
```mermaid
graph BT
  subgraph AOSP
    subgraph Toast
      funcAOSP[Toast.makeText]
    end
  end

  subgraph cpp[cpp sourceSet]
    subgraph JNIBridge.c
      subgraph funcJni[JNI thin wrapper]
         jni_find_class
         jni_get_static_method_id
         jni_call_void_method_a
      end
    end
  end
  subgraph cobol[cobol sourceSet]
    subgraph AnswerToLife.cob
      funcCob[ANSWER-TO-LIFE<br>JNI boilerplate]
    end
  end

funcJni --> funcAOSP
funcCob --> funcJni
```
