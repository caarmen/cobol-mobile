       IDENTIFICATION DIVISION.
       PROGRAM-ID. SHOW-TOAST.

       DATA DIVISION.

       LOCAL-STORAGE SECTION.
      *> Introspection information about the Toast class
       01 LS-PTR-CLASS-TOAST USAGE POINTER.
       01 LS-PTR-METHOD-MAKE-TEXT USAGE POINTER.
       01 LS-PTR-METHOD-SHOW USAGE POINTER.

      *> The arguments to provide to Toast.makeText()
       01 LS-MAKE-TEXT-ARGS.
           05 ARG-PTR-CONTEXT USAGE POINTER.
           05 ARG-PTR-MESSAGE USAGE POINTER.
           05 ARG-LENGTH USAGE BINARY-LONG SIGNED VALUE 0.

      *> The Toast instance, returned by Toast.makeText()
       01 LS-OBJECT-TOAST USAGE POINTER.

       LINKAGE SECTION.
       01 IN-PTR-JNI-ENV USAGE POINTER.
       01 IN-PTR-CONTEXT USAGE POINTER.
       01 IN-MESSAGE PIC X(10).

       PROCEDURE DIVISION USING BY REFERENCE
           IN-PTR-JNI-ENV
           IN-PTR-CONTEXT
           IN-MESSAGE.

          *> Get introspection info about the Toast class.

          *> Get the Toast class:
           CALL STATIC "jni_find_class" USING
               IN-PTR-JNI-ENV
               Z"android/widget/Toast"
               RETURNING LS-PTR-CLASS-TOAST

          *> Get the makeText method:
           CALL STATIC "jni_get_static_method_id" USING
               IN-PTR-JNI-ENV
               BY VALUE LS-PTR-CLASS-TOAST
               Z"makeText"
               "(Landroid/content/Context;Ljava/lang/CharSequence;I)"
               & Z"Landroid/widget/Toast;"
               RETURNING LS-PTR-METHOD-MAKE-TEXT

          *> Get the show method:
           CALL STATIC "jni_get_method_id" USING
               IN-PTR-JNI-ENV
               BY VALUE LS-PTR-CLASS-TOAST
               Z"show"
               Z"()V"
               RETURNING LS-PTR-METHOD-SHOW


          *> Prepare arguments for Toast.makeText():
          *> Convert the message argument to a jstring.
           CALL STATIC "jni_new_string_UTF" USING
               IN-PTR-JNI-ENV
               IN-MESSAGE
               RETURNING ARG-PTR-MESSAGE

          *> Get a Toast instance by calling Toast.makeText().
           SET ARG-PTR-CONTEXT TO ADDRESS OF IN-PTR-CONTEXT
           CALL STATIC "jni_call_static_object_method_a" USING
               IN-PTR-JNI-ENV
               BY VALUE LS-PTR-CLASS-TOAST
               BY VALUE LS-PTR-METHOD-MAKE-TEXT
               BY REFERENCE LS-MAKE-TEXT-ARGS
               RETURNING LS-OBJECT-TOAST

          *> Call the show method:
           CALL STATIC "jni_call_void_method_a" USING
               IN-PTR-JNI-ENV
               BY VALUE LS-OBJECT-TOAST
               BY VALUE LS-PTR-METHOD-SHOW

          *> Free our message jstring copy.
           CALL STATIC "jni_delete_local_ref" USING
               IN-PTR-JNI-ENV
               BY VALUE ARG-PTR-MESSAGE

           GOBACK.

       END PROGRAM SHOW-TOAST.

