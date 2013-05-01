// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECGLArrayAttribute.h"
#import "ECGLBoundAttribute.h"

@implementation ECGLArrayAttribute

// --------------------------------------------------------------------------
//! Properties.
// --------------------------------------------------------------------------

- (void)useWithBinding:(ECGLBoundAttribute*)binding
{
	glVertexAttribPointer(binding.location, self.size, self.type, self.normalized, self.stride, [self.data bytes]);
	glEnableVertexAttribArray(binding.location);
}

@end
