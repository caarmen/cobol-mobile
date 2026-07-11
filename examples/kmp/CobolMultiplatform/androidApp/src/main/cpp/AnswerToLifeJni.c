//==========================================================================
// Expose COBOL procedure to Kotlin via JNI.
//==========================================================================

#include <jni.h>
#include <string.h>

#include <libcob.h>

COB_EXT_EXPORT int ANSWER__TO__LIFE(const char *, int *);

jint Java_ca_rmen_coboldemo_AndroidAnswerToLifeGateway_cobAnswerToLife(
        JNIEnv *env,
        jobject obj,
        jstring filePath
) {
    int result = 0;

    const char *cFilePath = (*env)->GetStringUTFChars(env, filePath, 0);
    ANSWER__TO__LIFE(cFilePath, &result);
    (*env)->ReleaseStringUTFChars(env, filePath, cFilePath);

    return result;
}