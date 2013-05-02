// --------------------------------------------------------------------------
//  Copyright 2013 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECGLFragmentShader.h"

@implementation ECGLFragmentShader

// --------------------------------------------------------------------------
//! Initialise the shader.
// --------------------------------------------------------------------------

- (id) init
{
	if ((self = [super initWithType: GL_FRAGMENT_SHADER]) != nil)
	{
		
	}
	
	return self;
}

// --------------------------------------------------------------------------
//! Return the type of file to load the shader source from.
// --------------------------------------------------------------------------

- (NSString*) fileType
{
	return @"fsh";
}

@end
