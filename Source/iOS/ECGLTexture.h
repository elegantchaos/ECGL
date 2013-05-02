// --------------------------------------------------------------------------
//  Copyright 2013 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

@interface ECGLTexture : NSObject 
{
	GLuint	texture;
	NSString	*filename;
}
@property (nonatomic, retain) NSString *filename;
- (id)initWithResourceNamed:(NSString*) name;
- (id)initWithPath:(NSString*) path;
- (id)initWithURL:(NSURL*) url;
- (void)use;
+ (void)useDefaultTexture;
@end
