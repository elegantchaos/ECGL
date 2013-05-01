// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
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
