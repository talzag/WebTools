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
    char n = next(*i, line, linelen);
    strncat(out, &n, 1);
    
    while (1) {
        (*i)++;
        n = next(*i, line, linelen);
        strncat(out, &n, 1);
        
        if (n == '*') {
            (*i)++;
            n = next(*i, line, linelen);
            strncat(out, &n, 1);
            
            if (n == '/') {
                (*i)++;
                break;
            }
        }
    }
    
    (*i)++;
}

void prettyprint(char *src, char *out, size_t srcLen) {
    int indentLvl = 0;
    
    char c, n;
    int i;
    for (i = 0; i < srcLen; i++) {
        c = src[i];
        n = next(i, src, srcLen);
        
        if (isspace(c)) {
            if (i != 0)
                strncat(out, &c, 1);
            
            skipSpace(&i, src, srcLen);
            continue;
        }
        
        strncat(out, &c, 1);
        
        if (n == '{' || n == '>' || n == '+')
            strncat(out, " ", 1);
        
        if (c == ',' || c == '>' || c == '+') {
            strncat(out, " ", 1);
            skipSpace(&i, src, srcLen);
            continue;
        }
        
        if (c == '{') {
            indentLvl++;
            
            skipSpace(&i, src, srcLen);
            addNewLine(i, src, srcLen, out);
            
            if (next(i, src, srcLen)  != '}')
                indent(out, indentLvl, 0);
            continue;
        }
        
        if (c == '}') {
            indentLvl--;
            
            skipSpace(&i, src, srcLen);
            addNewLine(i, src, srcLen, out);
            
            if (next(i, src, srcLen) == '}') {
                indent(out, indentLvl - 1, 0);
            } else {
                addNewLine(i, src, srcLen, out);
                indent(out, indentLvl, 0);
            }
            continue;
        }
        
        if (c == ';') {
            skipSpace(&i, src, srcLen);
            addNewLine(i, src, srcLen, out);
            
            if (next(i, src, srcLen) == '}')
                indent(out, indentLvl - 1, 0);
            else
                indent(out, indentLvl, 0);
            continue;
        }
        
        if (c == '/') {
            if (n == '*') {
                consumeComment(&i, out, src, srcLen);
                addNewLine(i, src, srcLen, out);
                indent(out, indentLvl, 0);
                skipSpace(&i, src, srcLen);
            }
            continue;
        }
        
        // some CSS files don't end all rules with a semicolon
        n = next(i, src, srcLen);
        if ((n == '}' || n == '\n') && c != ';') {
            int level = n == '}' ? indentLvl - 1 : indentLvl;
            addNewLine(i, src, srcLen, out);
            indent(out, level, 0);
            i++;
        }
    }
}
