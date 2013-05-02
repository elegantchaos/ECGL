// --------------------------------------------------------------------------
//  Copyright 2013 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECGLUniformMatrix4Attribute.h"
#import "ECGLBoundAttribute.h"

@implementation ECGLUniformMatrix4Attribute

- (void)useWithBinding:(ECGLBoundAttribute *)binding
{
	glUniformMatrix4fv(binding.location, 1, 0, self.value.m);
}

@end
