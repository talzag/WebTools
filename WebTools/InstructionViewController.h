//
//  InstructionViewController.h
//  WebTools
//
//  Created by Daniel Strokis on 7/17/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface InstructionViewController : NSViewController

@property (weak) IBOutlet NSImageView *imageView;
@property (weak) IBOutlet NSTextField *instructionsTextField;

@property NSString *instructions;

@end
