       IDENTIFICATION DIVISION.
       PROGRAM-ID. FIND-CLASS.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       COPY "JNIConstants".

       LOCAL-STORAGE SECTION.
       01 PTR-FIND-CLASS PROGRAM-POINTER.
       01 LS-PTR-CLASS USAGE POINTER.
       LINKAGE SECTION.
       01 IN-JNI-ENV USAGE POINTER.
       01 IN-CLASS-NAME PIC X(100).
       01 OUT-PTR-CLASS USAGE POINTER.

       *>01 JNI-NATIVE-INTERFACE.
       *>   05 JNI-FN-TABLE OCCURS 232 TIMES PROCEDURE-POINTER.
       *> 1. This maps the 'env' pointer handle
       *>01 JNI-ENV-HANDLE.
       *>   05 VTABLE-PTR USAGE POINTER.  *> This points to 'reserved0'

       *> 2. This maps the actual JNI VTable
       01 JNI-NATIVE-INTERFACE.
          05 JNI-FN-TABLE OCCURS 232 TIMES  PROGRAM-POINTER.


       PROCEDURE DIVISION USING
           IN-JNI-ENV
           IN-CLASS-NAME
           OUT-PTR-CLASS.
           *> Step A: Point our handle structure to the 'env' address
           *>SET ADDRESS OF JNI-ENV-HANDLE TO IN-JNI-ENV

           *> Step B: Map the function table to the address FOUND inside 'env'
           *> In your lldb dump, this is the 0x00007867fe5ca0b8 address
           *>SET ADDRESS OF JNI-NATIVE-INTERFACE TO VTABLE-PTR

           *> Step C: Subscript 7 is the 1-based COBOL index for 'FindClass'
           *> Passing IN-JNI-ENV BY VALUE is mandatory for JNI [11.8.5]
           *>CALL JNI-FN-TABLE(7) USING
            *>   BY VALUE     IN-JNI-ENV
           *>    BY REFERENCE IN-CLASS-NAME
           *>    RETURNING    OUT-PTR-CLASS.
            SET ADDRESS OF JNI-NATIVE-INTERFACE
                TO ADDRESS OF IN-JNI-ENV

       *>     SET ADDRESS OF JNI-NATIVE-INTERFACE TO VTABLE-PTR

            SET PTR-FIND-CLASS TO
                JNI-FN-TABLE(C-IDX-JNI-FIND-CLASS + 1)

            *>CALL PTR-FIND-CLASS USING
            *>CALL JNI-FN-TABLE(C-IDX-JNI-FIND-CLASS + 1) USING
            CALL STATIC "cobol_jni_find_class" USING
                BY REFERENCE IN-JNI-ENV
                BY REFERENCE IN-CLASS-NAME
                RETURNING LS-PTR-CLASS

           SET RETURN-CODE TO 1
           .
       END PROGRAM FIND-CLASS.
