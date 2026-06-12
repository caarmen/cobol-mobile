#include <jni.h>

void showToastC(JNIEnv *env, jobject context, const char *message) {
    jclass toastClass = (*env)->FindClass(env, "android/widget/Toast");
    jmethodID makeTextMethod = (*env)->GetStaticMethodID(
            env,
            toastClass, "makeText",
            "(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;"
    );
    jstring jMessage = (*env)->NewStringUTF(env, message);
    jobject toastObject = (*env)->CallStaticObjectMethod(
            env,
            toastClass, makeTextMethod, context, jMessage, 0 /* LENGTH_SHORT */
    );
    jmethodID showMethod = (*env)->GetMethodID(env, toastClass, "show", "()V");
    (*env)->CallVoidMethod(env, toastObject, showMethod);
    (*env)->DeleteLocalRef(env, jMessage);
}