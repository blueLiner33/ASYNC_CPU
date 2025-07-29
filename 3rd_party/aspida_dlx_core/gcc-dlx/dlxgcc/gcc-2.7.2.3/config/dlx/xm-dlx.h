
/* Since there is no OS running on dlx, this 
   file doesn't contain any os dependancies. */

/* #defines that need visibility everywhere.  */
#define FALSE 0
#define TRUE 1

#define SUCCESS_EXIT_CODE 0
#define FATAL_EXIT_CODE 1

/* This describes the machine the compiler is hosted on.  */
#define HOST_BITS_PER_CHAR 8
#define HOST_BITS_PER_SHORT 16
#define HOST_BITS_PER_INT 32
#define HOST_BITS_PER_LONG 32
#define HOST_BITS_PER_LONGLONG 64

#include "tm.h"		/* this will be dlx.h */
