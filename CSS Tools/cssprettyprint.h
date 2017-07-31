//
//  cssprettyprint.h
//  WebTools
//
//  Created by Daniel Strokis on 7/30/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

#ifndef cssprettyprint_h
#define cssprettyprint_h

#include <stddef.h>

void skipSpace(int *i, char *line, size_t linelen);
char next(int i, const char *line, size_t linelen);
void addNewLine(int i, const char *line, size_t linelen, char *out);
int prettyprint(char *css, char *out);

#endif /* cssprettyprint_h */
