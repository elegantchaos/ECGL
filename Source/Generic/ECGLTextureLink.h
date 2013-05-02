// --------------------------------------------------------------------------
//  Copyright 2013 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

@class ECGLTexture;
@interface ECGLTextureLink : NSObject 

@property (retain, nonatomic) ECGLTexture*	texture;
@property (assign, nonatomic) NSInteger		index;

@end
