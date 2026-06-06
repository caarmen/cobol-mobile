       IDENTIFICATION DIVISION.
       PROGRAM-ID. ANSWER-TO-LIFE.
       DATA DIVISION.
       LINKAGE SECTION.

       01 IN-PTR-JNI-ENV USAGE POINTER.
       01 IN-PTR-CONTEXT USAGE POINTER.
       01 OUT-ANSWER BINARY-SHORT UNSIGNED.

       PROCEDURE DIVISION USING
           BY REFERENCE
               IN-PTR-JNI-ENV
               IN-PTR-CONTEXT
               OUT-ANSWER.
           COMPUTE OUT-ANSWER = 42 *
               FUNCTION RANDOM(FUNCTION CURRENT-DATE(1:16))
           IF FUNCTION MOD(OUT-ANSWER, 5) = 0
           THEN
               CALL STATIC "showToast" USING BY REFERENCE
                   IN-PTR-JNI-ENV
                   IN-PTR-CONTEXT
                   Z"Divisible by 5, congrats!"
           END-IF
           SET RETURN-CODE TO 1.


       END PROGRAM ANSWER-TO-LIFE.
