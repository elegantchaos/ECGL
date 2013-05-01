//
//  ECGLMatrix4Attribute.m
//  ECGL
//
//  Created by Sam Deane on 01/05/2013.
//  Copyright (c) 2013 Elegant Chaos. All rights reserved.
//

#import "ECGLUniformMatrix4Attribute.h"
#import "ECGLBoundAttribute.h"

@implementation ECGLUniformMatrix4Attribute

- (void)useWithBinding:(ECGLBoundAttribute *)binding
{
	glUniformMatrix4fv(binding.location, 1, 0, self.value.m);
}

@end
