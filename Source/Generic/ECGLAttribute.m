// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECGLAttribute.h"
#import "ECGLShaderProgram.h"

@implementation ECGLAttribute

// --------------------------------------------------------------------------
//! Properties.
// --------------------------------------------------------------------------

- (void) resolveIndexForProgram: (ECGLShaderProgram*) program
{
	self.index = [program locationForAttribute: self.name];
}

- (void) use
{
	ECAssertShouldntBeHere();
}

@end
