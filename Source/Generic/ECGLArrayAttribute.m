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

+ (instancetype)arrayOfVector3WithName:(NSString*)name capacity:(NSUInteger)capacity
{
	ECGLArrayAttribute* array = [[ECGLArrayAttribute alloc] initWithName:name];
	array.data = [NSMutableData dataWithCapacity:capacity * sizeof(GLKVector3)];
	array.type = GL_FLOAT;
	array.normalized = NO;
	array.stride = sizeof(GLKVector3);
	array.size = 3;
	array.count = capacity;

	return array;
}

+ (instancetype)arrayOfVector4WithName:(NSString*)name capacity:(NSUInteger)capacity
{
	ECGLArrayAttribute* array = [[ECGLArrayAttribute alloc] initWithName:name];
	array.data = [NSMutableData dataWithCapacity:capacity * sizeof(GLKVector4)];
	array.type = GL_FLOAT;
	array.normalized = NO;
	array.stride = sizeof(GLKVector4);
	array.size = 4;
	array.count = capacity;

	return array;
}

- (void)useWithBinding:(ECGLBoundAttribute*)binding
{
	glVertexAttribPointer(binding.location, self.size, self.type, self.normalized, self.stride, [self.data bytes]);
	glEnableVertexAttribArray(binding.location);
}

- (void*)mutableBytes
{
	void* result = nil;
	if ([self.data isKindOfClass:[NSMutableData class]])
	{
		result = [(NSMutableData*)self.data mutableBytes];
	}

	return result;
}

@end
