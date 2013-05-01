//
//  ECGLMatrix4Attribute.h
//  ECGL
//
//  Created by Sam Deane on 01/05/2013.
//  Copyright (c) 2013 Elegant Chaos. All rights reserved.
//

#import "ECGLUniformAttribute.h"

@interface ECGLUniformMatrix4Attribute : ECGLUniformAttribute

@property (assign, nonatomic) GLKMatrix4 value;

@end
