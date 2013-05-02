// --------------------------------------------------------------------------
//  Copyright 2013 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's
//  liberal license: http://www.elegantchaos.com/license/liberal
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
