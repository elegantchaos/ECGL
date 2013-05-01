// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
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
