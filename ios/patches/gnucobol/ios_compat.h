/*
Define system() because the default system function isn't available on iOS;
Without this patch, we get compilation errors like this:

common.c:6383:14: error: 'system' is unavailable: not available on iOS
 6383 |                                 status = system (command);
*/

#pragma once
#include <errno.h>
static inline int system(const char *cmd) { 
    (void)cmd;
    errno = ENOSYS;
    return -1; 
}
