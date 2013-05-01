// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECGLUniformColourAttribute.h"
#import "ECGLShaderProgram.h"
#import "ECGLBoundAttribute.h"

@implementation ECGLUniformColourAttribute

// --------------------------------------------------------------------------
//! Properties.
// --------------------------------------------------------------------------

- (void)useWithBinding:(ECGLBoundAttribute*)binding
{
	GLKVector4 c = self.colour;
	glUniform4fv(binding.location, GL_FLOAT, (GLfloat*) &c);
}

@end
