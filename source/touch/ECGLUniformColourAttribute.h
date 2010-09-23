// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECGLUniformAttribute.h"

// --------------------------------------------------------------------------
//! A high level abstraction of some 3d attributes - for example
//! an array of vertices or texture coordinates.
// --------------------------------------------------------------------------

@interface ECGLUniformColourAttribute : ECGLUniformAttribute 
{
}

ECPropertyAssigned(colour, Color);

// --------------------------------------------------------------------------
// Public Properties.
// --------------------------------------------------------------------------

- (void) resolveIndexForShader: (ECGLShaderProgram*) shader;
- (void) use;

@end
