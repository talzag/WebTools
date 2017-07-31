//
//  cssprettyprint.c
//  WebTools
//
//  Created by Daniel Strokis on 7/30/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <ctype.h>

#include "cssprettyprint.h"

char next(int i, const char *line, size_t linelen) {
    if (i + 1 < linelen) {
        char c = line[i + 1];
        return c;
    }
    
    return '\0';
}

void skipSpace(int *i, char *line, size_t linelen) {
    char c = next(*i, line, linelen);
    
    while (c == ' '){
        *i += 1;
        c = next(*i, line, linelen);
    }
}

void addNewLine(int i, const char *line, size_t linelen, char *out) {
    char n = next(i, line, linelen);
    if (n != '\n')
        strncat(out, "\n", 1);
}

int prettyprint(char *css, char *out) {
    int indent = 0;
    char *line = NULL;
    size_t linelen;

    int needsnl = 0;
    int inQuery = 0;
    int inSelector = 1;
    int inRule = 0;

    char c;
    
    while ((line = strsep(&css, "\n")) != NULL) {
        linelen = strlen(line);
        
        int i, j;
        for (j = 0; j < linelen; j++) {
            c = line[j];
            
            if (needsnl && c != '\n') {
                strncat(out, "\n", 1);
                needsnl = 0;
            }
            
            if (c == '@') {
                inQuery = 1;
                inSelector = 0;
                inRule = 0;
            }
            
            strncat(out, &c, 1);
            
            if (c != ' ' && next(j, line, linelen) == '{') {
                strncat(out, " ", 1);
            }
            
            if (c == '{') {
                if (inQuery) {
                    inQuery = 0;
                    inSelector = 1;
                } else if (inSelector) {
                    inSelector = 0;
                    inRule = 1;
                }
                
                indent += 4;
                
                skipSpace(&j, line, linelen);
                addNewLine(j, line, linelen, out);
                
                if (next(j, line, linelen) != '}') {
                    for (i = 0; i < indent; i++)
                        strncat(out, " ", 1);
                }
            } else if (c == '}') {
                if (inRule) {
                    inRule = 0;
                    inSelector = 1;
                } else if (inQuery) {
                    inQuery = 0;
                }
                
                indent -= 4;
                
                skipSpace(&j, line, linelen);
                addNewLine(j, line, linelen, out);
                needsnl = 1;
            } else if (c == ';') {
                skipSpace(&j, line, linelen);
                addNewLine(j, line, linelen, out);
                
                if (next(j, line, linelen) != '}') {
                    for (i = 0; i < indent; i++)
                        strncat(out, " ", 1);
                }
            } else if (c == ',') {
                strncat(out, " ", 1);
            } else if (c == ':') {
                if (inRule)
                    strncat(out, " ", 1);
            }
        }
    }

    return 0;
}
