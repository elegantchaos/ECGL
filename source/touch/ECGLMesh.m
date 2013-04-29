// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECGLMesh.h"
#import "ECGLGeometry.h"

@implementation ECGLMesh

- (void) updateTransform
{
	[self.geometry updateTransformForPosition: self.position orientation: self.orientation];
}

- (void) resolveIndexes
{
	[self.geometry resolveIndexes];
}

- (void) drawWithCamera: (GLfloat*) camera projection: (GLfloat*) projection  wireframe: (BOOL) wireframe
{
	
	if (wireframe)
	{
		[self.geometry drawWireframeWithCamera: camera projection: projection];
	}
	else
	{
		[self.geometry drawWithCamera: camera projection: projection];
	}
}

- (void) addGeometry:(ECGLGeometry *) geometry
{
	if (self.geometry)
	{
		[self.geometry addGeometry: geometry];
	}
	else
	{
		self.geometry = geometry;
	}
}

@end