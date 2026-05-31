#include <jni.h>
#include <string.h>

#include <libcob.h>

COB_EXT_EXPORT int ANSWER__TO__LIFE(cob_u8_t *);

jstring Java_com_example_coboldemo_AnswerToLife_cobAnswerToLife(JNIEnv *env, jobject obj) {
    cob_u8_t result[11];
    memset(result, ' ', sizeof(result));

    cob_init(0, NULL);
    ANSWER__TO__LIFE(result);

    // Trim trailing spaces
    int len = 10;
    while (len > 0 && result[len-1] == ' ') len--;
    result[len] = '\0';

    return (*env)->NewStringUTF(env, (const char*) result);
}