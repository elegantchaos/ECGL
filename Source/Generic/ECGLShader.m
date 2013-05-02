// --------------------------------------------------------------------------
//  Copyright 2013 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECGLShader.h"

@interface ECGLShader()
- (void) makeShader;
- (void) disposeShader;
- (void) logError;
@end

@implementation ECGLShader

- (id) initWithType: (GLuint) type
{
	if ((self = [super init]) != nil)
	{
		mType = type;
		[self makeShader];
	}
	
	return self;
}

- (void) makeShader
{
	if (!_shader)
	{
		_shader = glCreateShader(mType);
	}
}

- (void) disposeShader
{
	if (_shader)
	{
		glDeleteShader(_shader);
		_shader = 0;
	}
}

- (void) dealloc
{
	[self disposeShader];
}

- (int) compileFromResourceNamed: (NSString*) name
{
	int success = 0;
	NSString* path = [[NSBundle mainBundle] pathForResource: name ofType: [self fileType]];
	if (path)
	{
		success = [self compileFromPath: path];
	}
	else
	{
		NSLog(@"Shader resource '%@' missing.", name);
	}
	
	return success;
}

- (int) compileFromURL: (NSURL*) url
{
	return [self compileFromPath: [url path]];
}

- (int) compileFromPath: (NSString*) path
{
	NSError* error = nil;
	NSString* source = [NSString stringWithContentsOfFile: path encoding: NSUTF8StringEncoding error: &error];
	
	int success = 0;
	if (source)
	{
		success = [self compileFromSource: source];
	}
	else if (error)
	{
		NSLog(@"Error loading shader from '%@':\n", error);
	}
		
	return success;
}

- (int) compileFromSource: (NSString*) source
{
	int success = 0;
	if (_shader)
	{
		NSUInteger size;
		NSRange range = NSMakeRange(0, [source length]);
		[source getBytes: nil maxLength: 0 usedLength: &size encoding: NSUTF8StringEncoding options: 0 range: range remainingRange: nil];
		GLchar* buffer = malloc(size + 1);
		[source getBytes: buffer maxLength: size usedLength: &size encoding: NSUTF8StringEncoding options: 0 range: range remainingRange: nil];
		buffer[size] = 0;
		
		glShaderSource(_shader, 1, (const GLchar**) &buffer, NULL);
		glCompileShader(_shader);
		
		free(buffer);
		
		glGetShaderiv(_shader, GL_COMPILE_STATUS, &success);
		if (success == 0)
		{
			[self logError];
			[self disposeShader];
		}
	}
	
	return success;
}

- (void) logError
{
	if (_shader)
	{
		char errorMsg[2048];
		glGetShaderInfoLog(_shader, sizeof(errorMsg), NULL, errorMsg);
		NSLog(@"Shader error: %s", errorMsg); 
	}
}

- (BOOL) isCompiled
{
	BOOL result = NO;
	if (_shader)
	{
		int success = 0;
		glGetShaderiv(_shader, GL_COMPILE_STATUS, &success);
		result = (success != 0);
	}
	
	return result;
}

- (NSString*) fileType
{
	return @"txt";
}

@end
