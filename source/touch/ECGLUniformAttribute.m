// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECGLUniformAttribute.h"
#import "ECGLShaderProgram.h"

@implementation ECGLUniformAttribute

// --------------------------------------------------------------------------
//! Properties.
// --------------------------------------------------------------------------

- (void) dealloc
{
	
	[super dealloc];
}

- (void) resolveIndexForProgram: (ECGLShaderProgram*) program
{
	self.index = [program locationForUniform: self.name];
}


@end
