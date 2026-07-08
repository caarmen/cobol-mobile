#include <jni.h>

#include <libcob.h>

extern "C"
JNIEXPORT void JNICALL
Java_ca_rmen_gnucobol_GnuCOBOL_cobInit(JNIEnv *env, jobject thiz) {
    cob_init(0, nullptr);
}