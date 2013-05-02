//
//  ECGLView.h
//  ECGL
//
//  Created by Sam Deane on 02/05/2013.
//  Copyright (c) 2013 Elegant Chaos. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ECGLView : NSOpenGLView

@property (strong, nonatomic) NSColor* background;

- (void)setupResources;
- (void)setupViewport;
- (void)drawContent:(NSRect)dirtyRect;
- (void)update:(NSTimeInterval)deltaTime;

@end
