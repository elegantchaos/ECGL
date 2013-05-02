// --------------------------------------------------------------------------
//  Copyright 2013 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECGLVertexShader.h"


@implementation ECGLVertexShader

// --------------------------------------------------------------------------
//! Initialise the shader.
// --------------------------------------------------------------------------

- (id) init
{
	if ((self = [super initWithType: GL_VERTEX_SHADER]) != nil)
	{
		
	}
	
	return self;
}

// --------------------------------------------------------------------------
//! Return the type of file to load the shader from.
// --------------------------------------------------------------------------

- (NSString*) fileType
{
	return @"vsh";
}

@end
