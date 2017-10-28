//
//  cssprettyprint-private.h
//  WebTools
//
//  Created by Daniel Strokis on 10/28/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//
//  This file contains declarations for the pretty printing functions for use in unit tests
//

#ifndef cssprettyprint_private_h
#define cssprettyprint_private_h

char next(int i, char *line, size_t linelen);
void skipSpace(int *i, char *line, size_t linelen);
void addNewLine(int i, char *line, size_t linelen, char *out);
void indent(char *out, unsigned level, int useTabs);
void consumeComment(int *i, char *out, char*line, size_t linelen);

#endif /* cssprettyprint_private_h */
