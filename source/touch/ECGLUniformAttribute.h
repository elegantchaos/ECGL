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

@interface ECGLUniformAttribute : ECGLAttribute 
{
}

// --------------------------------------------------------------------------
// Public Properties.
// --------------------------------------------------------------------------

- (void) resolveIndexForProgram: (ECGLShaderProgram*) shader;

@end
