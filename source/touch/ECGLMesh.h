// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import <Foundation/Foundation.h>

#import "ECGLCommon.h"

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

ECPropertyAssigned(position, Vertex3D);
ECPropertyAssigned(orientation, Vertex3D);
ECPropertyRetained(geometry, ECGLGeometry*);

// --------------------------------------------------------------------------
// Public Methods.
// --------------------------------------------------------------------------

- (void)		updateTransform;
- (void)		resolveIndexes;
- (void)		drawWithCamera: (GLfloat*) camera projection: (GLfloat*) projection  wireframe: (BOOL) wireframe;
- (void)		addGeometry:(ECGLGeometry *) geometry;

@end
