//
//  SourceEditorCommand.m
//  HTML Tools
//
//  Created by Daniel Strokis on 7/15/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

#import "HTMLTemplateCommand.h"

static NSString *HTMLCommandID = @"HTMLTemplate";
static NSString *PugCommandID = @"PugTemplate";

@implementation HTMLTemplateCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation
                   completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
    NSError *error;
    if (![self content:[invocation buffer] isHTML:&error]) {
        completionHandler(nil);
        return;
    }
    
    NSString *htmlTemplate =
   @"<!DOCTYPE html>\n"
    "<html>\n"
    "   <head>\n"
    "       <title><#title#></title>\n"
    "   </head>\n"
    "   <body>\n"
    "       \n"
    "   </body>\n"
    "</html>\n";
    
    NSString *pugTemplate =
   @"doctype html\n"
    "html\n"
    "   head\n"
    "       title= <#title#>\n"
    "   body\n";
    
    NSString *command = [[[invocation commandIdentifier] componentsSeparatedByString:@"."] lastObject];
    
    NSString *docTemplate;
    if ([command isEqualToString:HTMLCommandID]) {
        docTemplate = htmlTemplate;
    } else if ([command isEqualToString:PugCommandID]) {
        docTemplate = pugTemplate;
    }
    
    [[[invocation buffer] lines] insertObject:docTemplate atIndex:0];
    
    completionHandler(nil);
}

@end

