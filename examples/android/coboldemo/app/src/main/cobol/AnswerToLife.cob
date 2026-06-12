       IDENTIFICATION DIVISION.
       PROGRAM-ID. ANSWER-TO-LIFE.
       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01 C-FIZZ PIC X(10) VALUE Z"Fizz!".
       01 C-BUZZ PIC X(10) VALUE Z"Buzz!".

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

          *> Show a toast for some numbers
           EVALUATE TRUE
           WHEN FUNCTION MOD(OUT-ANSWER, 3) = 0
               CALL STATIC "showToastC" USING BY REFERENCE
                   IN-PTR-JNI-ENV
                   IN-PTR-CONTEXT
                   C-FIZZ
           WHEN FUNCTION MOD(OUT-ANSWER, 5) = 0
               CALL STATIC "SHOW-TOAST" USING BY REFERENCE
                   IN-PTR-JNI-ENV
                   IN-PTR-CONTEXT
                   C-BUZZ
           END-EVALUATE
           SET RETURN-CODE TO 1.


       END PROGRAM ANSWER-TO-LIFE.
