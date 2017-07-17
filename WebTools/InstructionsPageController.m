//
//  ViewController.m
//  WebTools
//
//  Created by Daniel Strokis on 7/15/17.
//  Copyright © 2017 dstrokis. All rights reserved.
//

#import "InstructionsPageController.h"
#import "InstructionViewController.h"

@implementation InstructionsPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setDelegate:self];
    
    NSArray *instructions = @[
                              @"Instructions 1",
                              @"Instructions 2",
                              @"Instructions 3"
                              ];
    [self setArrangedObjects:instructions];
}

// MARK: - Page controller delegate

- (NSString *)pageController:(NSPageController *)pageController identifierForObject:(id)object {
    return (NSString *)object;
}

- (NSViewController *)pageController:(NSPageController *)pageController viewControllerForIdentifier:(NSString *)identifier {
    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
    
    InstructionViewController *viewController = [storyboard instantiateControllerWithIdentifier:@"InstructionViewController"];
    
    [viewController setInstructions:identifier];
    
    return viewController;
}

- (void)pageControllerDidEndLiveTransition:(NSPageController *)pageController {
    [pageController completeTransition];
}

@end
