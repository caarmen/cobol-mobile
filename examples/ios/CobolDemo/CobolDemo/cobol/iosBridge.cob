       *>========================================================
       *> Procedure to speak a message using the voice
       *> synthesizer.
       *>
       *> Input arguments:
       *>
       *> IN-MESSAGE: The message to speak.
       *>
       *> This procedure demonstrates placing a maximum of the
       *> logic of calls to iOS framework APIs, in COBOL.
       *>========================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. SPEAK.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 WS-PTR-AVSpeechSynthesizer USAGE POINTER.
           88 FIRST-ENTRY VALUE NULL.
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
       01 LS-PTR-MESSAGE USAGE POINTER.
       01 LS-PTR-UTTERANCE USAGE POINTER.

       LINKAGE SECTION.
       01 IN-MESSAGE PIC X(10).

       PROCEDURE DIVISION USING BY REFERENCE IN-MESSAGE.

          *> Initialize static information like class and method
          *> pointers only the first time we enter the procedure.
          *> They are persisted in working storage across invocations.
          *>
          *> In addition to static info, we also initialize an
          *> AVSpeechthesizer instance which we reuse across invocations.
           IF FIRST-ENTRY
           THEN
              *> Resolve AV-related classes
               CALL "objc_getClass" USING Z"NSString"
                    RETURNING WS-PTR-NSString
               CALL "objc_getClass" USING Z"AVSpeechUtterance"
                    RETURNING WS-PTR-AVSpeechUtterance
               CALL "objc_getClass" USING Z"AVSpeechSynthesizer"
                    RETURNING WS-PTR-AVSpeechSynthesizer

              *> Resolve AV-related methods.
               CALL "sel_registerName"
                        USING Z"speechUtteranceWithString:"
                    RETURNING WS-PTR-speechUtteranceWithString
               CALL "sel_registerName" USING Z"speakUtterance:"
                    RETURNING WS-PTR-speakUtterance

              *> Resolve other framework methods.
               CALL "sel_registerName"
                    USING Z"stringWithUTF8String:"
                    RETURNING WS-PTR-stringWithUTF8String
               CALL "sel_registerName" USING Z"alloc"
                    RETURNING WS-PTR-alloc
               CALL "sel_registerName" USING Z"init"
                    RETURNING WS-PTR-init
               CALL "sel_registerName" USING Z"retain"
                    RETURNING WS-PTR-retain

              *> Initialize the speech synthesizer.
               CALL "objc_msgSend" USING
                    BY VALUE WS-PTR-AVSpeechSynthesizer
                    BY VALUE WS-PTR-alloc
                    RETURNING WS-PTR-AVSpeechSynthesizer-instance
               CALL "objc_msgSend" USING
                    BY VALUE WS-PTR-AVSpeechSynthesizer-instance
                    BY VALUE WS-PTR-init
                    RETURNING WS-PTR-AVSpeechSynthesizer-instance
               CALL "objc_msgSend" USING
                    BY VALUE WS-PTR-AVSpeechSynthesizer-instance
                    BY VALUE WS-PTR-retain
           END-IF

          *> Convert the message from a COBOL PIC into an NSString.
           CALL "objc_msgSend" USING
                BY VALUE WS-PTR-NSString
                BY VALUE WS-PTR-stringWithUTF8String
                BY REFERENCE IN-MESSAGE
                RETURNING LS-PTR-MESSAGE

          *> Create an utterance instance.
           CALL "objc_msgSend" USING
                BY VALUE WS-PTR-AVSpeechUtterance
                BY VALUE WS-PTR-speechUtteranceWithString
                BY VALUE LS-PTR-message
                RETURNING LS-PTR-UTTERANCE

          *> Speak!
           CALL "objc_msgSend" USING
                BY VALUE WS-PTR-AVSpeechSynthesizer-instance
                BY VALUE WS-PTR-speakUtterance
                BY VALUE LS-PTR-UTTERANCE
       .
       END PROGRAM SPEAK.
