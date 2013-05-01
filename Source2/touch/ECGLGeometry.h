// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

//#import "ECGLCommon.h"

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

- (void)		updateTransformForPosition: (GLKVector3) position orientation: (GLKVector3) orientation;
- (GLfloat*)	transform;
- (void)		resolveIndexes;
- (void)		drawWithCamera: (GLfloat*) camera projection: (GLfloat*) projection;
- (void)		drawWireframeWithCamera: (GLfloat*) camera projection: (GLfloat*) projection;

- (void)		addTexture: (ECGLTexture*) texture;
- (void)		addAttribute: (ECGLAttribute*) attribute;
- (void)		addGeometry:(ECGLGeometry *) geometry;

@end
