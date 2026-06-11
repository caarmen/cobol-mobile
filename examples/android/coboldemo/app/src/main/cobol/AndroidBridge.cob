       IDENTIFICATION DIVISION.
       PROGRAM-ID. SHOW-TOAST.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 C-TOAST-CLASS-NAME PIC X(100) VALUE Z"android/widget/Toast".
       01 C-METHOD-MAKE-TEXT-SIGNATURE PIC X(100) VALUE
           "(Landroid/content/Context;Ljava/lang/CharSequence;I)"
           & Z"Landroid/widget/Toast;".
       LOCAL-STORAGE SECTION.
       01 LS-PTR-CLASS-TOAST USAGE POINTER.
       01 LS-PTR-METHOD-MAKE-TEXT USAGE POINTER.

       LINKAGE SECTION.
       01 IN-PTR-JNI-ENV USAGE POINTER.
       01 IN-PTR-CONTEXT USAGE POINTER.
       01 IN-MESSAGE PIC X(10).


       PROCEDURE DIVISION USING BY REFERENCE
           IN-PTR-JNI-ENV
           IN-PTR-CONTEXT
           IN-MESSAGE.

           CALL STATIC "jni_find_class" USING
               IN-PTR-JNI-ENV
               C-TOAST-CLASS-NAME
               RETURNING LS-PTR-CLASS-TOAST

           CALL STATIC "jni_get_static_method_id" USING
               IN-PTR-JNI-ENV
               BY VALUE LS-PTR-CLASS-TOAST
               Z"makeText"
               C-METHOD-MAKE-TEXT-SIGNATURE
               RETURNING LS-PTR-METHOD-MAKE-TEXT

           GOBACK.

       END PROGRAM SHOW-TOAST.

