// --------------------------------------------------------------------------
//  Copyright 2013 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

@interface ECGLShader : NSObject 
{
	GLenum	mType;
}

@property (readonly, nonatomic) GLuint	shader;
@property (readonly, nonatomic) BOOL		isCompiled;

- (id)			initWithType: (GLuint) type;
- (int)			compileFromResourceNamed: (NSString*) source;
- (int)			compileFromSource: (NSString*) source;
- (int)			compileFromPath: (NSString*) path;
- (int)			compileFromURL: (NSURL*) url;
- (NSString*)	fileType;

@end
