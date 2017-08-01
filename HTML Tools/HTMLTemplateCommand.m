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
static NSString *EJSCommandID = @"EJSTemplate";

@implementation HTMLTemplateCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation
                   completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
    NSString *htmlTemplate =
   @"<!DOCTYPE html>\n"
    "<html>\n"
    "   <head>\n"
    "       <title><#HTML Template#></title>\n"
    "   </head>\n"
    "   <body>\n"
    "       \n"
    "   </body>\n"
    "</html>\n";
    
    NSString *pugTemplate =
   @"doctype html\n"
    "html\n"
    "   head\n"
    "       title= <#Pug Template#>\n"
    "   body\n";
    
    NSString *ejsTemplate =
   @"<!DOCTYPE html>\n"
    "<html>\n"
    "   <head>\n"
    "       <% var title = <#'EJS Template'#> %>\n"
    "       <title><%= title %></title>\n"
    "   </head>\n"
    "   <body>\n"
    "       <% var greeting = <#'Hello, world!'#> %>\n"
    "       <h1><%= greeting %></h1>\n"
    "   </body>\n"
    "</html>\n";
    
    NSString *command = [[[invocation commandIdentifier] componentsSeparatedByString:@"."] lastObject];
    
    NSError *error;
    NSString *docTemplate;
    
    if ([command isEqualToString:HTMLCommandID]) {
        docTemplate = htmlTemplate;
    } else if ([command isEqualToString:PugCommandID]) {
        docTemplate = pugTemplate;
    } else if ([command isEqualToString:EJSCommandID]) {
        docTemplate = ejsTemplate;
    } else {
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey: @"Unrecognized command identifier." };
        error = [NSError errorWithDomain:(NSString *)HTMLErrorDomain
                                    code:HTMLErrorUnrecognizedCommand
                                userInfo:userInfo];
        
        completionHandler(error);
        return;
    }
    
    [[[invocation buffer] lines] insertObject:docTemplate atIndex:0];
    
    completionHandler(nil);
}

@end

