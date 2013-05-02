// --------------------------------------------------------------------------
//  Copyright 2013 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

@class ECGLBoundAttribute;
@class ECGLVertexShader;
@class ECGLFragmentShader;
@class ECGLAttribute;
@class ECGLUniformAttribute;

@interface ECGLShaderProgram : NSObject 


- (id)initWithShaderResourcesNamed:(NSString*)name;
- (id)initWithVertexShader:(ECGLVertexShader*)vertexShader fragmentShader:(ECGLFragmentShader*)fragmentShader;
- (int)compileAndLink;
- (void)use;

- (ECGLBoundAttribute*)bindingForAttribute:(ECGLAttribute*)attribute;
- (ECGLBoundAttribute*)bindingForUniform:(ECGLUniformAttribute*)uniform;

@end
