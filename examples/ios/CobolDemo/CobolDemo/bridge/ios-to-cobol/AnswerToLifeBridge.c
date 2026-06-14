#include "AnswerToLifeBridge.h"
#include <libcob.h>

// Expose COBOL functions to Swift
extern int ANSWER__TO__LIFE(int *);
int answerToLife(void) {
    int result = 0;
    ANSWER__TO__LIFE(&result);
    return result;
}
