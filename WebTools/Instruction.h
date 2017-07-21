//
//  Instruction.h
//  WebTools
//
//  Created by Daniel Strokis on 7/19/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSUInteger, WebToolsInstructionType) {
    WebToolsInstructionTypeInstall,
    WebToolsInstructionTypeHTML,
    WebToolsInstructionTypeCSS,
    WebToolsInstructionTypeJS
};

@interface Instruction : NSObject

@property WebToolsInstructionType instructionType;
@property (readonly) NSString *instructionIdentifier;
@property NSImage *instructionExample;
@property NSString *instructionText;

- (instancetype)initWithInstructionType:(WebToolsInstructionType)type andInstructionText:(NSString *)text;

+ (NSArray <Instruction *> *)appExtensionInstructions;

@end
