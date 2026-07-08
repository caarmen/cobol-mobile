//==========================================================================
// Expose COBOL procedure to Kotlin via JNI.
//==========================================================================

#include <jni.h>
#include <string.h>

#include <libcob.h>

COB_EXT_EXPORT int ANSWER__TO__LIFE(int *);

jint Java_ca_rmen_coboldemo_AndroidAnswerToLifeGateway_cobAnswerToLife(
        JNIEnv *env,
        jobject obj
) {
    int result = 0;

    ANSWER__TO__LIFE(&result);

    return result;
}