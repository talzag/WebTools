//
//  cssprettyprint.c
//  WebTools
//
//  Created by Daniel Strokis on 7/30/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

#include <string.h>
#include <ctype.h>

#include "cssprettyprint.h"

char next(int i, char *line, size_t linelen) {
    if (i + 1 < linelen)
        return line[i + 1];
    
    return '\0';
}

void skipSpace(int *i, char *line, size_t linelen) {
    char c = next(*i, line, linelen);
    
    while (isspace(c)){
        *i += 1;
        c = next(*i, line, linelen);
    }
}

void addNewLine(int i, char *line, size_t linelen, char *out) {
    if (next(i, line, linelen) != '\n')
        strncat(out, "\n", 1);
}

void indent(char *out, unsigned level, int useTabs) {
    int i;
    for (i = 0; i < level * 4; i++)
        strncat(out, " ", 1);
}

void consumeComment(int *i, char *out, char*line, size_t linelen) {
    char c = next(*i, line, linelen);
    strncat(out, &c, 1);
    
    while (1) {
        (*i)++;
        c = next(*i, line, linelen);
        strncat(out, &c, 1);
        
        if (c == '*') {
            (*i)++;
            c = next(*i, line, linelen);
            strncat(out, &c, 1);
            
            if (c == '/')
                break;
        }
    }
    
    strncat(out, "\n", 1);
    (*i)++;
}
void prettyprint(char *src, char *out, size_t srcLen) {
    int indentLvl = 0;
    
    char c, n;
    int i;
    for (i = 0; i < srcLen; i++) {
        c = src[i];
        n = next(i, src, srcLen);
        
        strncat(out, &c, 1);
        
        if ((n == '{' || n == '>' || n == '+') && c != ' ')
            strncat(out, " ", 1);
        
        if ((c == ',' || c == '>' || c == '+') && n != ' ') {
            strncat(out, " ", 1);
            continue;
        }
        
        if (c == '{') {
            indentLvl++;
            
            skipSpace(&i, src, srcLen);
            addNewLine(i, src, srcLen, out);
            
            if (n != '}')
                indent(out, indentLvl, 0);
            continue;
        }
        
        if (c == '}') {
            indentLvl--;
            
            skipSpace(&i, src, srcLen);
            addNewLine(i, src, srcLen, out);
            
            if (n != '}' && i < srcLen - 1) {
                addNewLine(i, src, srcLen, out);
                indent(out, indentLvl, 0);
            }
            continue;
        }
        
        if (c == ';') {
            skipSpace(&i, src, srcLen);
            addNewLine(i, src, srcLen, out);
            
            if (n == '}')
                indent(out, indentLvl - 1, 0);
            else
                indent(out, indentLvl, 0);
            continue;
        }
        
        if (c == '/') {
            if (n == '*')
                consumeComment(&i, out, src, srcLen);
            indent(out, indentLvl, 0);
            continue;
        }
        
        // some CSS files don't end all rules with a semicolon
        if (n == '}' && c != ';') {
            addNewLine(i, src, srcLen, out);
            indent(out, indentLvl - 1, 0);
        }
    }
}
