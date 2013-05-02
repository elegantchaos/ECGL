//
//  ECGLView.m
//  ECGL
//
//  Created by Sam Deane on 02/05/2013.
//  Copyright (c) 2013 Elegant Chaos. All rights reserved.
//

#import "ECGLView.h"

#import <CoreVideo/CoreVideo.h>

@interface ECGLView()

@property (assign, nonatomic) CVDisplayLinkRef displayLink;
@property (assign, nonatomic) NSTimeInterval lastUpdate;

@end

@implementation ECGLView


- (void)drawRect:(NSRect)dirtyRect
{
	NSOpenGLContext* context = self.openGLContext;
	[context makeCurrentContext];

    glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);

    [self drawContent:dirtyRect];

    glFlush();
	CGLFlushDrawable([context CGLContextObj]);
}

- (void)prepareOpenGL
{
    [super prepareOpenGL];

	NSOpenGLContext* context = self.openGLContext;

    // Make this openGL context current to the thread
	// (i.e. all openGL on this thread calls will go to this context)
	[context makeCurrentContext];

	// Synchronize buffer swaps with vertical refresh rate
	GLint swapInt = 1;
	[context setValues:&swapInt forParameter:NSOpenGLCPSwapInterval];

    [self setupDisplayLink];

	[self setupResources];
	
    glEnable(GL_CULL_FACE);
    glEnable(GL_DEPTH_TEST);

    // Set the background color stored in the current context
	CGFloat red, green, blue, alpha;
	[self.background getRed:&red green:&green blue:&blue alpha:&alpha];
    glClearColor((GLclampf)red, (GLclampf)green, (GLclampf)blue, (GLclampf)alpha);
	
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
    NSOpenGLContext* context = self.openGLContext;
	[context makeCurrentContext];
    [self doUpdate];
    [self setupViewport];
}

#pragma mark - Display Link

- (void)setupDisplayLink
{
    // Create a display link capable of being used with all active displays
    CVDisplayLinkRef displayLink;
    CVDisplayLinkCreateWithActiveCGDisplays(&displayLink);

    // Set the renderer output callback function
    CVDisplayLinkSetOutputCallback(displayLink, &DisplayLinkCallback, (__bridge void*) self);

    // Set the display link for the current renderer
	NSOpenGLContext* context = self.openGLContext;
    CGLContextObj cglContext = [context CGLContextObj];
    CGLPixelFormatObj cglPixelFormat = [[self pixelFormat] CGLPixelFormatObj];
    CVDisplayLinkSetCurrentCGDisplayFromOpenGLContext(displayLink, cglContext, cglPixelFormat);

    // Activate the display link
    CVDisplayLinkStart(displayLink);
    self.displayLink = displayLink;
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
