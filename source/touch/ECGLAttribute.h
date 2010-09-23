// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECGLCommon.h"

@class ECGLShaderProgram;

// --------------------------------------------------------------------------
//! A high level abstraction of some 3d attributes - for example
//! an array of vertices or texture coordinates.
// --------------------------------------------------------------------------

@interface ECGLAttribute : NSObject 
{
}

// --------------------------------------------------------------------------
// Public Properties.
// --------------------------------------------------------------------------

ECPropertyRetained(name, NSString*);
ECPropertyAssigned(index, GLuint);


// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

- (void) use;
- (void) resolveIndexForProgram: (ECGLShaderProgram*) program;

@end
