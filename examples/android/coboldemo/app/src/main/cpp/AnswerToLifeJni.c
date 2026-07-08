#include <jni.h>
#include <string.h>

#include <libcob.h>

COB_EXT_EXPORT int ANSWER__TO__LIFE(JNIEnv *, jobject, int *);

jint Java_com_example_coboldemo_AnswerToLife_cobAnswerToLife(
        JNIEnv *env,
        jobject obj,
        jobject context
) {
    int result = 0;

    ANSWER__TO__LIFE(env, context, &result);

    return result;
}