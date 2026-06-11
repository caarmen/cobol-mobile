#include <jni.h>

jclass jni_find_class(JNIEnv *env, const char *name) {
    jclass class = (*env)->FindClass(env, name);
    return class;
}

jmethodID jni_get_static_method_id(
        JNIEnv *env,
        jclass class,
        const char *methodName,
        const char *methodSignature
) {
    return (*env)->GetStaticMethodID(env, class, methodName, methodSignature);
}

jstring jni_new_string_UTF(
        JNIEnv *env,
        jstring message
) {
    return (*env)->NewStringUTF(env, message);
}

void jni_delete_local_ref(
        JNIEnv *env,
        jobject object
) {
    return (*env)->DeleteLocalRef(env, object);
}

/*
 *
    jobject toastObject = (*env)->CallStaticObjectMethod(
            env,
            toastClass, makeTextMethod, context, jMessage, 0
);
jmethodID showMethod = (*env)->GetMethodID(env, toastClass, "show", "()V");
(*env)->CallVoidMethod(env, toastObject, showMethod);
 */