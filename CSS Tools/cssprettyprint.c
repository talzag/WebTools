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

char prev(int i, const char *line, size_t linelen) {
    if (i - 1 >= 0)
        return line[i - 1];
    
    return '\0';
}

char next(int i, const char *line, size_t linelen) {
    if (i + 1 < linelen)
        return line[i + 1];
    
    return '\0';
}

void skipSpace(int *i, char *line, size_t linelen) {
    char c = next(*i, line, linelen);
    
    while (c == ' ') {
        *i += 1;
        c = next(*i, line, linelen);
    }
}

void addNewLine(int i, const char *line, size_t linelen, char *out) {
    if (next(i, line, linelen) != '\n')
        strncat(out, "\n", 1);
}

void indent(char *out, unsigned level, int useTabs) {
    int i;
    for (i = 0; i < level * 4; i++)
        strncat(out, " ", 1);
}

// FIXME: consume comments
// FIXME: @media rules not indenting
int prettyprint(char *css, char *out) {
    int indentLvl = 0;
    char *line = NULL;
    size_t linelen;

    int needsnl = 0;
    int inQuery = 0;
    int inSelector = 1;
    int inRule = 0;

    char c;
    
    // @media screen{body{background-color:#fff;}}li,a:active,p{color:red;}
    while ((line = strsep(&css, "\n")) != NULL) {
        linelen = strlen(line);
        
        int i;
        for (i = 0; i < linelen; i++) {
            c = line[i];
            
            if (needsnl && c != '\n') {
                strncat(out, "\n", 1);
                needsnl = 0;
            }
            
            // FIXME: - handle at-rules
            if (c == '@') {
                char n = next(i, line, linelen);
                // @media || @supports
                if (n == 'm' || n == 's') {
                    inQuery = 1;
                    inSelector = 0;
                    inRule = 0;
                } else {
                    inQuery = 0;
                }
            }
            
            strncat(out, &c, 1);
            
            if (c == '{') {
                indentLvl++;
                
                if (inSelector) {
                    inSelector = 0;
                    inRule = 1;
                } else {
                    inSelector = 1;
                    inRule = 0;
                }
                
                skipSpace(&i, line, linelen);
                addNewLine(i, line, linelen, out);
                
                if (next(i, line, linelen) != '}')
                    indent(out, indentLvl, 0);
            } else if (c == '}') {
                indentLvl--;
                
                if (inRule) {
                    inRule = 0;
                    inSelector = 1;
                }
                
                if (inQuery) {
                    skipSpace(&i, line, linelen);
                    
                    // are we exiting the  @-query?
                    if (prev(i, line, linelen) == '}') {
                        inQuery = 0;
                        inSelector = 1;
                        inRule = 0;
                        addNewLine(i, line, linelen, out);
                    }
                }
                
                skipSpace(&i, line, linelen);
                needsnl = 1;
            } else if (c == ';') {
                skipSpace(&i, line, linelen);
                addNewLine(i, line, linelen, out);
                
                if (next(i, line, linelen) != '}')
                    indent(out, indentLvl, 0);
                else if (inQuery) {
                    indent(out, indentLvl - 1, 0);
                    needsnl = 0;
                }
            } else if (c == ',' || c == '>') {
                strncat(out, " ", 1);
            } else if (c == ':')
                if (inRule)
                    strncat(out, " ", 1);

            if (next(i, line, linelen) == '{' && c != ' ')
                strncat(out, " ", 1);
            else if (next(i, line, linelen) == '}' && c != ';' && inRule) { // some CSS files don't end all rules with a semicolon
                addNewLine(i, line, linelen, out);
                if (inQuery)
                    indent(out, indentLvl - 1, 0);
            }
        }
    }

    return 0;
}
