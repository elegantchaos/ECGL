// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECGLUniformColourAttribute.h"
#import "ECGLShaderProgram.h"

@implementation ECGLUniformColourAttribute

// --------------------------------------------------------------------------
//! Properties.
// --------------------------------------------------------------------------

- (void) resolveIndexForShader: (ECGLShaderProgram*) shader
{
	self.index = [shader locationForUniform: self.name];
}

- (void) use
{
	Color c = self.colour;
	glUniform4fv(self.index, GL_FLOAT, (GLfloat*) &c); 
}

@end
