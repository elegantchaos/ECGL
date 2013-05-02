// --------------------------------------------------------------------------
//  Copyright 2013 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECGLBoundAttribute.h"
#import "ECGLAttribute.h"

@interface ECGLBoundAttribute()
@property (readwrite, strong, nonatomic) ECGLAttribute* attribute;
@property (readwrite, assign, nonatomic) GLuint location;
@end

@implementation ECGLBoundAttribute

- (id)initWithAttribute:(ECGLAttribute*)attribute location:(GLuint)location
{
	if ((self = [super init]) != nil)
	{
		self.attribute = attribute;
		self.location = location;
	}

	return self;
}

- (void)use
{
	[self.attribute useWithBinding:self];
}

@end
