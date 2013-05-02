// --------------------------------------------------------------------------
//  Copyright 2013 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

/*
This class wraps the CAEAGLLayer from CoreAnimation into a convenient UIView subclass.
The view content is basically an EAGL surface you render your OpenGL scene into.
Note that setting the view non-opaque will only work if the EAGL surface has an alpha channel.
*/

@class EAGLContext;

@interface ECGLView : UIView 
{
@protected
	GLKMatrix4	mProjection;
    
@private
    /* The pixel dimensions of the backbuffer */
    GLint backingWidth;
    GLint backingHeight;
    
    EAGLContext *context;   

    GLuint viewRenderbuffer, viewFramebuffer;
    GLuint depthRenderbuffer;
    
    NSTimer *animationTimer;
    NSTimeInterval animationInterval;
}


@property NSTimeInterval animationInterval;

- (void)	startAnimation;
- (void)	stopAnimation;
- (void)	drawView;
- (void)	drawContent;

- (void)	setPerspectiveProjectionWithFieldOfView: (GLfloat) fieldOfVision nearPlane: (GLfloat) near farPlane: (GLfloat) far aspectRatio: (GLfloat) aspect;

@end
