// --------------------------------------------------------------------------
//  Copyright 2013 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's
//  liberal license: http://www.elegantchaos.com/license/liberal
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
