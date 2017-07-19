//
//  ViewController.m
//  WebTools
//
//  Created by Daniel Strokis on 7/15/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

#import "InstructionsPageController.h"
#import "InstructionViewController.h"

#define kInstructionViewController @"InstructionViewController"

@implementation InstructionsPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setDelegate:self];
    
    NSArray *instructions = [Instruction appExtensionInstructions];
    
    [self setArrangedObjects:instructions];
}

// MARK: - Page controller delegate

- (NSString *)pageController:(NSPageController *)pageController identifierForObject:(id)object {
    return [(Instruction *)object instructionIdentifier];
}

- (NSViewController *)pageController:(NSPageController *)pageController viewControllerForIdentifier:(NSString *)identifier {
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    
    InstructionViewController *viewController = [storyboard instantiateControllerWithIdentifier:kInstructionViewController];
    
    return viewController;
}

- (void)pageController:(NSPageController *)pageController prepareViewController:(NSViewController *)viewController withObject:(id)object {
    if ([object isKindOfClass:[Instruction class]]) {
        [(InstructionViewController *)viewController setInstruction:(Instruction *)object];
    }
}

- (void)pageControllerDidEndLiveTransition:(NSPageController *)pageController {
    [pageController completeTransition];
}

@end
