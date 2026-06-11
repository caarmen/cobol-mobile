#include <jni.h>

#include <libcob.h>

COB_EXT_EXPORT "C" int ANSWER__TO__LIFE(JNIEnv *env, jobject context, int *);

extern "C" {
JNIEXPORT jint JNI_OnLoad(JavaVM *vm, void *reserved) {
    cob_init(0, nullptr);

    return JNI_VERSION_1_6;
}

void showToast(JNIEnv *env, jobject context, const char *message) {
    jclass toastClass = env->FindClass("android/widget/Toast");
    jmethodID makeTextMethod = env->GetStaticMethodID(
            toastClass, "makeText",
            "(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;"
    );
    jstring jMessage = env->NewStringUTF(message);
    jobject toastObject = env->CallStaticObjectMethod(
            toastClass, makeTextMethod, context, jMessage, 5
    );
    jmethodID showMethod = env->GetMethodID(toastClass, "show", "()V");
    env->CallVoidMethod(toastObject, showMethod);
    env->DeleteLocalRef(jMessage);
}

JNIEXPORT jint Java_com_example_coboldemo_AnswerToLife_cobAnswerToLife(
        JNIEnv *env,
        jobject obj,
        jobject context
) {
    int result = 0;

    ANSWER__TO__LIFE(env, context, &result);

    return result;
}
jclass cobol_jni_find_class(JNIEnv* env, const char* name) {
    // Because this is a native C++ function compiled by the Android Clang compiler,
    // it respects all Scudo, x86_64 System V ABI, and prototyping rules.
    return env->FindClass(name);
}
}