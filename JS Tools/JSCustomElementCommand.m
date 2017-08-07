//
//  JSCustomElementCommand.m
//  WebTools
//
//  Created by Daniel Strokis on 7/25/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

#import "JSCustomElementCommand.h"

@implementation JSCustomElementCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation
                   completionHandler:(void (^)(NSError * _Nullable))completionHandler
{
    NSError *error;
    if (![self content:[invocation buffer] isJS:&error]) {
        completionHandler(nil);
        return;
    }
    
    NSString *customElementTemplate =
   @"// Custom Element API - https://html.spec.whatwg.org/#custom-elements \n"
    "class <#ElementName#> extends HTMLElement {\n"
    "   constructor() {\n"
    "       super();\n"
    "       const shadowRoot = this.attachShadow({mode: 'closed'});\n"
    "       shadowRoot.innerHTML = `<div>Hello from my custom element!</div>`\n"
    "   }\n"
    "}\n"
    "\n"
    "customElements.define('<#element-name#>', <#ElementName#>);\n"
    "\n";
    
    // TODO: Check selections. Overwrite selected lines, or insert at cursor
    NSMutableArray <NSString *> *lines = [[invocation buffer] lines];
    NSMutableArray <XCSourceTextRange *> *selections = [[invocation buffer] selections];
    
    XCSourceTextPosition start = [[selections firstObject] start];
    XCSourceTextPosition end = [[selections lastObject] end];
    
    NSRange range = NSMakeRange(start.line, end.line - start.line + 1);
    
    if (range.length > 1) {
        [lines removeObjectsInRange:range];
    }
    
    [lines insertObject:customElementTemplate atIndex:start.line];
    
    completionHandler(nil);
}

@end
