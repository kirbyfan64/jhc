#ifndef ST_CBITS_H
#define ST_CBITS_H

#include <stdint.h>

#define MAX_ENTRY_SIZE 256
#define ATOM_LEN_MASK 0xff

// zero is always the empty string.
#define ATOM_EMPTY 0
typedef uint32_t atom_t;

atom_t stringtable_lookup(unsigned char *cs, int len);
void stringtable_stats(void);
int stringtable_find(atom_t cl, unsigned char **res);
unsigned char *stringtable_ptr(atom_t cl);

#endif
