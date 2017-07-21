//
//  Instruction.m
//  WebTools
//
//  Created by Daniel Strokis on 7/19/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

#import "Instruction.h"

#define kHTMLImageName @"HTML"
#define kCSSImageName @"CSS"
#define kJSImageName @"JS"

@implementation Instruction

- (instancetype)initWithInstructionType:(WebToolsInstructionType)type andInstructionText:(NSString *)text {
    self = [super init];
    if (self) {
        _instructionType = type;
        _instructionText = text;
        
        NSString *instructionName;
        switch (type) {
            case WebToolsInstructionTypeHTML:
                instructionName = kHTMLImageName;
                break;
            case WebToolsInstructionTypeCSS:
                instructionName = kCSSImageName;
                break;
            case WebToolsInstructionTypeJS:
                instructionName = kJSImageName;
                break;
            default:
                break;
        }
        
        _instructionIdentifier = instructionName;
        _instructionExample = [NSImage imageNamed:instructionName];
    }
    
    return self;
}

+ (NSArray <Instruction *> *)appExtensionInstructions {
    Instruction *htmlInstructions = [[Instruction alloc] initWithInstructionType:WebToolsInstructionTypeHTML
                                                              andInstructionText:NSLocalizedString(@"HTML_Text", @"Features of the HTML tool")];
    
    Instruction *cssInstructions = [[Instruction alloc] initWithInstructionType:WebToolsInstructionTypeCSS
                                                             andInstructionText:NSLocalizedString(@"CSS_Text", @"Features of the CSS tool")];
    
    Instruction *jsInstructions = [[Instruction alloc] initWithInstructionType:WebToolsInstructionTypeJS
                                                            andInstructionText:NSLocalizedString(@"JS_Text", @"Features of the JS tool")];
    
    return @[htmlInstructions, cssInstructions, jsInstructions];
}

@end
