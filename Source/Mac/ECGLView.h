// --------------------------------------------------------------------------
//  Copyright 2013 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

@interface ECGLView : NSOpenGLView

@property (strong, nonatomic) NSColor* background;

- (void)setupResources;
- (void)setupViewport;
- (void)drawContent:(NSRect)dirtyRect;
- (void)update:(NSTimeInterval)deltaTime;

@end
