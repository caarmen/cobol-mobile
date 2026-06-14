       IDENTIFICATION DIVISION.
       PROGRAM-ID. ANSWER-TO-LIFE.
       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01 C-FIZZ PIC X(10) VALUE Z"Fizz!".
       01 C-BUZZ PIC X(10) VALUE Z"Buzz!".
       01 C-FIZZBUZZ PIC X(10) VALUE Z"FizzBuzz!".

       01 WS-PTR-AVSpeechSynthesizer USAGE POINTER.
       01 WS-PTR-AVSpeechSynthesizer-instance USAGE POINTER.
       01 WS-PTR-alloc USAGE POINTER.
       01 WS-PTR-init USAGE POINTER.
       01 WS-PTR-retain USAGE POINTER.
       01 WS-PTR-speakUtterance USAGE POINTER.
       01 WS-PTR-NSString USAGE POINTER.
       01 WS-PTR-stringWithUTF8String USAGE POINTER.
       01 WS-PTR-speechUtteranceWithString USAGE POINTER.
       01 WS-PTR-AVSpeechUtterance USAGE POINTER.

       LOCAL-STORAGE SECTION.
       01 LS-PTR-message USAGE POINTER.
       01 LS-PTR-utterance USAGE POINTER.



       LINKAGE SECTION.
       01 OUT-ANSWER BINARY-SHORT UNSIGNED.

       PROCEDURE DIVISION USING BY REFERENCE OUT-ANSWER.

           COMPUTE OUT-ANSWER = 42 *
               FUNCTION RANDOM(FUNCTION CURRENT-DATE(1:16))

          *> Resolve AV-related classes
           CALL STATIC "objc_getClass" USING Z"NSString"
                RETURNING WS-PTR-NSString
           CALL STATIC "objc_getClass" USING Z"AVSpeechUtterance"
                RETURNING WS-PTR-AVSpeechUtterance
           CALL STATIC "objc_getClass" USING Z"AVSpeechSynthesizer"
                RETURNING WS-PTR-AVSpeechSynthesizer

          *> Resolve AV-related methods
           CALL STATIC "sel_registerName" USING Z"stringWithUTF8String:"
                RETURNING WS-PTR-stringWithUTF8String
           CALL STATIC "sel_registerName"
                    USING Z"speechUtteranceWithString:"
                RETURNING WS-PTR-speechUtteranceWithString
           CALL STATIC "sel_registerName" USING Z"alloc"
                RETURNING WS-PTR-alloc
           CALL STATIC "sel_registerName" USING Z"init"
                RETURNING WS-PTR-init
           CALL STATIC "sel_registerName" USING Z"retain"
                RETURNING WS-PTR-retain
           CALL STATIC "sel_registerName" USING Z"speakUtterance:"
                RETURNING WS-PTR-speakUtterance

           CALL STATIC "objc_msgSend" USING
                BY VALUE WS-PTR-NSString
                BY VALUE WS-PTR-stringWithUTF8String
                BY REFERENCE C-FIZZ
                RETURNING LS-PTR-message

           CALL STATIC "objc_msgSend" USING
                BY VALUE WS-PTR-AVSpeechUtterance
                BY VALUE WS-PTR-speechUtteranceWithString
                BY VALUE LS-PTR-message
                RETURNING LS-PTR-utterance

           CALL STATIC "objc_msgSend" USING
                BY VALUE WS-PTR-AVSpeechSynthesizer
                BY VALUE WS-PTR-alloc
                RETURNING WS-PTR-AVSpeechSynthesizer-instance
           CALL STATIC "objc_msgSend" USING
                BY VALUE WS-PTR-AVSpeechSynthesizer-instance
                BY VALUE WS-PTR-init
           CALL STATIC "objc_msgSend" USING
                BY VALUE WS-PTR-AVSpeechSynthesizer-instance
                BY VALUE WS-PTR-retain

           CALL STATIC "objc_msgSend" USING
                BY VALUE WS-PTR-AVSpeechSynthesizer-instance
                BY VALUE WS-PTR-speakUtterance
                BY VALUE LS-PTR-utterance

          *> Handle some specific numbers
           EVALUATE TRUE
           WHEN FUNCTION MOD(OUT-ANSWER, 3) = 0
               AND FUNCTION MOD(OUT-ANSWER, 5) = 0
               CALL STATIC "speakSwift" USING BY REFERENCE
                   C-FIZZBUZZ

           WHEN FUNCTION MOD(OUT-ANSWER, 3) = 0
               CALL STATIC "speakSwift" USING BY REFERENCE
                   C-FIZZ
           WHEN FUNCTION MOD(OUT-ANSWER, 5) = 0
               CALL STATIC "speakSwift" USING BY REFERENCE
                   C-BUZZ
           END-EVALUATE
           SET RETURN-CODE TO 1.

       END PROGRAM ANSWER-TO-LIFE.
