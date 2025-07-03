#include <jni.h>
#include <string>

extern "C" {

JNIEXPORT jstring JNICALL
Java_com_example_MainActivity_hello(JNIEnv *env, jobject) {
  return env->NewStringUTF("Hello World!");
}

}