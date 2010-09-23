// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

#import "ECGLCommon.h"

@class ECGLShaderProgram;
@class ECGLTexture;
@class ECGLAttribute;

// --------------------------------------------------------------------------
//! A collection of geometry which can be drawn.
// --------------------------------------------------------------------------

@interface ECGLGeometry : NSObject 
{
	Matrix3D		mTransform;
	GLint			mMVP;
	NSMutableArray*	mGeometry;
}

// --------------------------------------------------------------------------
// Public Properties.
// --------------------------------------------------------------------------

ECPropertyAssigned(count, NSUInteger);
ECPropertyRetained(attributes, NSMutableArray*);
ECPropertyRetained(textures, NSMutableArray*);
ECPropertyRetained(shaders, ECGLShaderProgram*);
ECPropertyAssigned(cullFace, BOOL);

// --------------------------------------------------------------------------
// Public Methods.
// --------------------------------------------------------------------------

- (void)		updateTransformForPosition: (Vector3D) position orientation: (Vector3D) orientation;
- (GLfloat*)	transform;
- (void)		resolveIndexes;
- (void)		drawWithCamera: (GLfloat*) camera projection: (GLfloat*) projection;
- (void)		drawWireframeWithCamera: (GLfloat*) camera projection: (GLfloat*) projection;

- (void)		addTexture: (ECGLTexture*) texture;
- (void)		addAttribute: (ECGLAttribute*) attribute;
- (void)		addGeometry:(ECGLGeometry *) geometry;

@end
