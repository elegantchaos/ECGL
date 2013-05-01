// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECGLShaderProgram.h"
#import "ECGLVertexShader.h"
#import "ECGLFragmentShader.h"
#import "ECGLAttribute.h"
#import "ECGLBoundAttribute.h"
#import "ECGLUniformAttribute.h"

@interface ECGLShaderProgram()

@property (assign, nonatomic) GLuint program;
@property (strong, nonatomic) ECGLVertexShader* vertexShader;
@property (strong, nonatomic) ECGLFragmentShader* fragmentShader;

@end

@implementation ECGLShaderProgram

- (id)initWithShaderResourcesNamed:(NSString*)name
{
	ECGLVertexShader* vs = [[ECGLVertexShader alloc] init];
	[vs compileFromResourceNamed: name];
	
	ECGLFragmentShader* fs = [[ECGLFragmentShader alloc] init];
	[fs compileFromResourceNamed: name];

	self = [self initWithVertexShader: vs fragmentShader:fs];

	return self;
}

- (id)initWithVertexShader:(ECGLVertexShader*)vs fragmentShader:(ECGLFragmentShader*)fs
{
	if ((self = [super init])!= nil)
	{
		self.vertexShader = vs;
		self.fragmentShader = fs;
	}
	
	return self;
}

- (void)releaseShaders
{
	self.vertexShader = nil;
	self.fragmentShader = nil;
}


- (void)disposeProgram
{
	if (self.program)
	{
		glDeleteProgram(self.program);
		self.program = 0;
	}
}

- (void)use
{
	if (!self.program)
	{
		[self compileAndLink];
	}

	glUseProgram(self.program);
}

- (int)compileAndLink
{
	int linked = 0;
	
	if ([self.vertexShader isCompiled] && [self.fragmentShader isCompiled])
	{
		GLuint program = glCreateProgram();
		if (program)
		{
			glAttachShader(program, [self.vertexShader shader]);
			glAttachShader(program, [self.fragmentShader shader]);
			glLinkProgram(program);
			glGetProgramiv(program, GL_LINK_STATUS, &linked);
			self.program = program;
			if (linked == 0)
			{
				[self disposeProgram];
			}
		}
	}
	
	return linked;
}

- (GLint)locationForAttribute:(NSString*)name
{
	
	int location = 0;
	if (self.program)
	{
		location = glGetAttribLocation(self.program, [name UTF8String]);
	}

	return location;
}

- (int)locationForUniform:(NSString*)name
{
	int location = 0;
	if (self.program)
	{
		location = glGetUniformLocation(self.program, [name UTF8String]);
	}
	
	return location;
}

- (ECGLBoundAttribute*)bindingForAttribute:(ECGLAttribute*)attribute
{
	ECGLBoundAttribute* result = nil;
	GLint location = [self locationForAttribute:attribute.name];
	if (location)
	{
		result = [[ECGLBoundAttribute alloc] initWithAttribute:attribute location:location];
	}

	return result;
}

- (ECGLBoundAttribute*)bindingForUniform:(ECGLUniformAttribute*)uniform
{
	ECGLBoundAttribute* result = nil;
	GLint location = [self locationForUniform:uniform.name];
	if (location)
	{
		result = [[ECGLBoundAttribute alloc] initWithAttribute:uniform location:location];
	}

	return result;

}

@end
