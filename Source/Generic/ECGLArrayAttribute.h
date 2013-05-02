// --------------------------------------------------------------------------
//  Copyright 2013 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECGLAttribute.h"

// --------------------------------------------------------------------------
//! A high level abstraction of some 3d attributes - for example
//! an array of vertices or texture coordinates.
// --------------------------------------------------------------------------

@interface ECGLArrayAttribute : ECGLAttribute 

// --------------------------------------------------------------------------
// Public Properties.
// --------------------------------------------------------------------------

@property (assign, nonatomic) NSUInteger offset;
@property (assign, nonatomic) NSUInteger count;
@property (strong, nonatomic) NSData* data;
@property (assign, nonatomic) GLint size;
@property (assign, nonatomic) GLenum type;
@property (assign, nonatomic) GLboolean normalized;
@property (assign, nonatomic) GLsizei stride;

+ (instancetype)arrayOfVector3WithName:(NSString*)name capacity:(NSUInteger)capacity;
+ (instancetype)arrayOfVector4WithName:(NSString*)name capacity:(NSUInteger)capacity;

- (void*)mutableBytes;

@end
