// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
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

// --------------------------------------------------------------------------
// Public Methods
// --------------------------------------------------------------------------

- (void) use;

@end
