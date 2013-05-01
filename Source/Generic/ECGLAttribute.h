// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

@class ECGLShaderProgram;

/**
 A high level abstraction of some 3d attributes - for example
 an array of vertices or texture coordinates.
 */

@class ECGLBoundAttribute;
@interface ECGLAttribute : NSObject 

@property (readonly, strong, nonatomic) NSString* name;

- (id)initWithName:(NSString*)name;
- (void)useWithBinding:(ECGLBoundAttribute*)binding;

@end
