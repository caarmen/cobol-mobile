#include <objc/message.h>

//void * objc_msgSend(void *self, void *op, ...);
void * cob_objc_msgSend(
    id self,
    SEL op,
    id arg
) {
    return ((id(*)(id,SEL,id))objc_msgSend)(self, op, arg);
}
