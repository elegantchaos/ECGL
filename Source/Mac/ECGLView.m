// --------------------------------------------------------------------------
//  Copyright 2013 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECGLView.h"

#import <CoreVideo/CoreVideo.h>

@interface ECGLView()

@property (assign, nonatomic) CVDisplayLinkRef displayLink;
@property (assign, nonatomic) NSTimeInterval lastUpdate;

@end

@implementation ECGLView

ECDefineDebugChannel(ECGLViewChannel);

- (void)drawRect:(NSRect)dirtyRect
{
	NSOpenGLContext* context = self.openGLContext;
	[context makeCurrentContext];

    glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);

    [self drawContent:dirtyRect];

    glFlush();
	CGLFlushDrawable([context CGLContextObj]);
}

- (void)checkError
{
	GLuint error = glGetError();
	if (error != GL_NO_ERROR)
	{
		ECDebug(ECGLViewChannel, @"gl error %ld", error);
	}
}

- (void)prepareOpenGL
{
	ECDebug(ECGLViewChannel, @"setting up view");

    [super prepareOpenGL];

	NSOpenGLContext* context = self.openGLContext;

    // Make this openGL context current to the thread
	// (i.e. all openGL on this thread calls will go to this context)
	[context makeCurrentContext];

	// Synchronize buffer swaps with vertical refresh rate
	GLint swapInt = 1;
	[context setValues:&swapInt forParameter:NSOpenGLCPSwapInterval];

	CVReturn result = [self setupDisplayLink];
    if (result != kCVReturnSuccess)
	{
		ECDebug(ECGLViewChannel, @"display link failed with result %ld", result);
	}

	[self setupResources];
	
    glEnable(GL_CULL_FACE);
    glEnable(GL_DEPTH_TEST);

    // Set the background color stored in the current context
	CGFloat red, green, blue, alpha;
	[self.background getRed:&red green:&green blue:&blue alpha:&alpha];
    glClearColor((GLclampf)red, (GLclampf)green, (GLclampf)blue, (GLclampf)alpha);

	[self checkError];
}

- (void)drawContent:(NSRect)dirtyRect
{

}

- (void)update:(NSTimeInterval)deltaTime
{

}

- (void)setupViewport
{

}

- (void)setupResources
{
	
}

- (void)doUpdate
{
	NSTimeInterval timeNow = [NSDate timeIntervalSinceReferenceDate];
	NSTimeInterval deltaTime = (self.lastUpdate) ? (timeNow - self.lastUpdate) : 0;
	self.lastUpdate = timeNow;

	[self update:deltaTime];
}

/////////////////////////////////////////////////////////////////
//
- (void)reshape
{
	ECDebug(ECGLViewChannel, @"reshaped");

    NSOpenGLContext* context = self.openGLContext;
	[context makeCurrentContext];
    [self doUpdate];
    [self setupViewport];
}

#pragma mark - Display Link

- (CVReturn)setupDisplayLink
{
	ECDebug(ECGLViewChannel, @"setup display link");
	
    // Create a display link capable of being used with all active displays
    CVDisplayLinkRef displayLink;
    CVReturn result = CVDisplayLinkCreateWithActiveCGDisplays(&displayLink);
	if (result == kCVReturnSuccess)
	{
		// Set the renderer output callback function
		result = CVDisplayLinkSetOutputCallback(displayLink, &DisplayLinkCallback, (__bridge void*) self);
	}

	if (result == kCVReturnSuccess)
	{
		// Set the display link for the current renderer
		NSOpenGLContext* context = self.openGLContext;
		CGLContextObj cglContext = [context CGLContextObj];
		CGLPixelFormatObj cglPixelFormat = [[self pixelFormat] CGLPixelFormatObj];
		result = CVDisplayLinkSetCurrentCGDisplayFromOpenGLContext(displayLink, cglContext, cglPixelFormat);
	}

	if (result == kCVReturnSuccess)
	{
		// Activate the display link
		result = CVDisplayLinkStart(displayLink);
	}

	if (result == kCVReturnSuccess)
	{
		self.displayLink = displayLink;
	}

	return result;
}

- (CVReturn)firedDisplayLink:(const CVTimeStamp*)outputTime
{
    [self doUpdate];
    [self display];

    return kCVReturnSuccess;
}


static CVReturn DisplayLinkCallback(CVDisplayLinkRef displayLink, const CVTimeStamp* now, const CVTimeStamp* outputTime, CVOptionFlags flagsIn, CVOptionFlags* flagsOut, void* displayLinkContext)
{
    CVReturn result = [(__bridge ECGLView*)displayLinkContext firedDisplayLink:outputTime];
    return result;
}

@end
