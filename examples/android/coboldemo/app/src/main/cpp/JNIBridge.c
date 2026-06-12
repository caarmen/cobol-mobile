#include <jni.h>

jclass jni_find_class(JNIEnv *env, const char *name) {
    return (*env)->FindClass(env, name);
}

jmethodID jni_get_static_method_id(
        JNIEnv *env,
        jclass class,
        const char *methodName,
        const char *methodSignature
) {
    jmethodID result = (*env)->GetStaticMethodID(env, class, methodName, methodSignature);
    return result;
}

jstring jni_new_string_UTF(
        JNIEnv *env,
        const char *message
) {
    return (*env)->NewStringUTF(env, message);
}

void jni_delete_local_ref(
        JNIEnv *env,
        jobject object
) {
    return (*env)->DeleteLocalRef(env, object);
}

jobject jni_call_static_object_method_a(
        JNIEnv *env,
        jclass clazz,
        jmethodID methodID,
        const jvalue *args
) {
    return (*env)->CallStaticObjectMethodA(env, clazz, methodID, args);
}

jmethodID jni_get_method_id(
        JNIEnv *env,
        jclass clazz,
        const char *methodName,
        const char *methodSignature
) {
    return (*env)->GetMethodID(env, clazz, methodName, methodSignature);
}

void jni_call_void_method_a(
        JNIEnv *env,
        jobject object,
        jmethodID methodID,
        const jvalue *args
) {
    (*env)->CallVoidMethodA(env, object, methodID, args);
}
