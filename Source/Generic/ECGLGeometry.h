// --------------------------------------------------------------------------
//  Copyright 2013 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

@class ECGLShaderProgram;
@class ECGLTexture;
@class ECGLAttribute;

// --------------------------------------------------------------------------
//! A collection of geometry which can be drawn.
// --------------------------------------------------------------------------

@interface ECGLGeometry : NSObject 
{
	GLKMatrix4		mTransform;
	GLint			mMVP;
	NSMutableArray*	mGeometry;
}

// --------------------------------------------------------------------------
// Public Properties.
// --------------------------------------------------------------------------

@property (assign, nonatomic) NSUInteger count;
@property (strong, nonatomic) NSMutableArray* attributes;
@property (strong, nonatomic) NSMutableArray* textures;
@property (strong, nonatomic) ECGLShaderProgram* shaders;
@property (assign, nonatomic) BOOL cullFace;

// --------------------------------------------------------------------------
// Public Methods.
// --------------------------------------------------------------------------

- (void)		updateTransformForPosition:(GLKVector3)position orientation:(GLKVector3)orientation;
- (GLKMatrix4)	transform;
- (void)		resolveIndexes;
- (void)		drawWithCamera:(GLKMatrix4)camera projection:(GLKMatrix4)projection;
- (void)		drawWireframeWithCamera:(GLKMatrix4) camera projection:(GLKMatrix4)projection;

- (void)		addTexture:(ECGLTexture*)texture;
- (void)		addAttribute:(ECGLAttribute*)attribute;
- (void)		addGeometry:(ECGLGeometry*)geometry;

@end
