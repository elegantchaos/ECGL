// --------------------------------------------------------------------------
//  Copyright 2013 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECGLAttribute.h"
#import "ECGLShaderProgram.h"

@interface ECGLAttribute()

@property (strong, readwrite, nonatomic) NSString* name;

@end

@implementation ECGLAttribute

// --------------------------------------------------------------------------
//! Properties.
// --------------------------------------------------------------------------

- (id)initWithName:(NSString*)name
{
	if ((self = [super init]) != nil)
	{
		self.name = name;
	}

	return self;
}

- (void)useWithBinding:(ECGLBoundAttribute*)binding
{
	ECAssertShouldntBeHere();
}

@end
