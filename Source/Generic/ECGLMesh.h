// --------------------------------------------------------------------------
//  Copyright 2013 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

@class ECGLGeometry;

// --------------------------------------------------------------------------
//! A collection of geometry which can be drawn.
// --------------------------------------------------------------------------

@interface ECGLMesh : NSObject 
{
}

// --------------------------------------------------------------------------
// Public Properties.
// --------------------------------------------------------------------------

@property (assign, nonatomic) GLKVector3 position;
@property (assign, nonatomic) GLKVector3 orientation;
@property (strong, nonatomic) ECGLGeometry* geometry;

// --------------------------------------------------------------------------
// Public Methods.
// --------------------------------------------------------------------------

- (void)updateTransform;
- (void)resolveIndexes;
- (void)drawWithCamera:(GLKMatrix4)camera projection:(GLKMatrix4)projection wireframe:(BOOL)wireframe;
- (void)addGeometry:(ECGLGeometry *) geometry;

@end
