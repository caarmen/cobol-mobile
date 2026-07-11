      *>======================================================================
      *> ANSWER-TO-LIFE.
      *>
      *> Procedure which returns a random number from 0 to 42.
      *>======================================================================
       IDENTIFICATION DIVISION.
       PROGRAM-ID. ANSWER-TO-LIFE.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT FD-DATA ASSIGN TO IN-FILE-PATH
           ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.

       FILE SECTION.
       FD FD-DATA.
       01 F-FILE-RECORD PIC X(10).

       LINKAGE SECTION.
       01 IN-FILE-PATH PIC X(100).
       01 OUT-ANSWER BINARY-SHORT UNSIGNED.

       PROCEDURE DIVISION USING BY REFERENCE IN-FILE-PATH OUT-ANSWER.

           COMPUTE OUT-ANSWER = 42 *
               FUNCTION RANDOM(FUNCTION CURRENT-DATE(1:16))
           OPEN OUTPUT FD-DATA
           MOVE "hello" TO F-FILE-RECORD
           WRITE F-FILE-RECORD
           CLOSE FD-DATA

           SET RETURN-CODE TO 1.

       END PROGRAM ANSWER-TO-LIFE.
