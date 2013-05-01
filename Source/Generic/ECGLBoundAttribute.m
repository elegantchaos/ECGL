//
//  ECGLBoundAttribute.m
//  ECGL
//
//  Created by Sam Deane on 01/05/2013.
//  Copyright (c) 2013 Elegant Chaos. All rights reserved.
//

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
