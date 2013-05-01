//
//  ECGLBoundAttribute.h
//  ECGL
//
//  Created by Sam Deane on 01/05/2013.
//  Copyright (c) 2013 Elegant Chaos. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ECGLAttribute;

@interface ECGLBoundAttribute : NSObject

@property (readonly, strong, nonatomic) ECGLAttribute* attribute;
@property (readonly, assign, nonatomic) GLuint location;

- (id)initWithAttribute:(ECGLAttribute*)attribute location:(GLuint)location;
- (void)use;

@end
