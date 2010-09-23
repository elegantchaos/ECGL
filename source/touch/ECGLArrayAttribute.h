// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECGLAttribute.h"

// --------------------------------------------------------------------------
//! A high level abstraction of some 3d attributes - for example
//! an array of vertices or texture coordinates.
// --------------------------------------------------------------------------

@interface ECGLArrayAttribute : ECGLAttribute 
{
}

// --------------------------------------------------------------------------
// Public Properties.
// --------------------------------------------------------------------------

ECPropertyAssigned(offset, NSUInteger);
ECPropertyAssigned(count, NSUInteger);
ECPropertyRetained(data, NSData*);
ECPropertyAssigned(size, GLint);
ECPropertyAssigned(type, GLenum);
ECPropertyAssigned(normalized, GLboolean);
ECPropertyAssigned(stride, GLsizei);

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

- (void) use;

@end
