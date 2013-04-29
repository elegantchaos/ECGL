// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECGLArrayAttribute.h"


@implementation ECGLArrayAttribute

// --------------------------------------------------------------------------
//! Properties.
// --------------------------------------------------------------------------

- (void) use
{
	glVertexAttribPointer(self.index, self.size, self.type, self.normalized, self.stride, [self.data bytes]);
	glEnableVertexAttribArray(self.index);
}

@end
