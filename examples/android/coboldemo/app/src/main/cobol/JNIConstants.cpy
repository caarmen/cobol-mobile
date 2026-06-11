      *>================================================
      *> Map the functions in the JNINativeInterface
      *> From jni.h:
      *>
      *> struct JNINativeInterface {
      *>      void*       reserved0;
      *>      void*       reserved1;
      *>      void*       reserved2;
      *>      void*       reserved3;
      *>
      *>      jint        (*GetVersion)(JNIEnv *);
      *>
      *>      jclass      (*DefineClass)(JNIEnv*, const char*, jobject, const jbyte*,
      *>                          jsize);
      *>      jclass      (*FindClass)(JNIEnv*, const char*);
      *> ...
      *>================================================
       01 C-IDX-JNI-FIND-CLASS CONSTANT 6.
       01 C-IDX-JNI-DELETE-LOCAL-REF CONSTANT 23.
       01 C-IDX-JNI-GET-METHOD-ID CONSTANT 33.
       01 C-IDX-JNI-CALL-VOID-METHOD CONSTANT 61.
       01 C-IDX-JNI-GET-STATIC-METHOD-ID CONSTANT 113.
       01 C-IDX-JNI-CALL-STATIC-OBJECT-METHOD CONSTANT 114.
       01 C-IDX-JNI-NEW-STRING-UTF CONSTANT 167.
