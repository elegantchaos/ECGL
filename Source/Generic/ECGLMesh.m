// --------------------------------------------------------------------------
//  Copyright 2013 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's
//  liberal license: http://www.elegantchaos.com/license/liberal
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

- (void) drawWithCamera:(GLKMatrix4)camera projection:(GLKMatrix4)projection wireframe:(BOOL)wireframe
{
	
	if (wireframe)
	{
		[self.geometry drawWireframeWithCamera:camera projection:projection];
	}
	else
	{
		[self.geometry drawWithCamera:camera projection:projection];
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