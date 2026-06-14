#include "AnswerToLifeBridge.h"
#include <libcob.h>

// Declared by cobc-generated code (AnswerToLife.c)
extern int ANSWER__TO__LIFE(int *);

int answerToLife(void) {
    int result = 0;
    ANSWER__TO__LIFE(&result);
    return result;
}
