#include <jni.h>

/**
 * Show the given message as a Toast.
 *
 * This function demonstrates centralizing JNI boilerplate for multiple jvm method calls
 * in a C function.
 */
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

/**
 * Show the given message as a Toast.
 *
 * This function demonstrates putting the minimal amount of JNI boilerplate in a C function,
 * delegating the bulk of the logic to a Kotlin function.
 */
void showToastKt(JNIEnv *env, jobject context, const char *message) {
    jclass bridgeClass = (*env)->FindClass(env, "com/example/coboldemo/AndroidBridgeKt");
    jmethodID showTextMethod = (*env)->GetStaticMethodID(
            env,
            bridgeClass,
            "showToast",
            "(Landroid/content/Context;Ljava/lang/String;)V"
    );
    jstring jMessage = (*env)->NewStringUTF(env, message);
    (*env)->CallStaticVoidMethod(env, bridgeClass, showTextMethod, context, jMessage);
    (*env)->DeleteLocalRef(env, jMessage);
}