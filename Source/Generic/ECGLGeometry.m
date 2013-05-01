// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECGLGeometry.h"
#import "ECGLCommon.h"
#import "ECGLBoundAttribute.h"
#import "ECGLShaderProgram.h"
#import "ECGLTexture.h"
#import "ECGLTextureLink.h"

@interface ECGLGeometry()
- (void) use;
@end

@implementation ECGLGeometry

- (id) init
{
	if ((self = [super init]) != nil)
	{
		NSMutableArray* atts = [[NSMutableArray alloc] init];
		self.attributes = atts;

		NSMutableArray* tex = [[NSMutableArray alloc] init];
		self.textures = tex;

		self.cullFace = YES;
	}
	
	return self;
}

- (void) addTexture:(ECGLTexture *)texture
{
	ECGLTextureLink* link = [[ECGLTextureLink alloc] init];
	link.texture = texture;
	[self.textures addObject: link];
}

- (void) updateTransformForPosition: (GLKVector3) position orientation: (GLKVector3) orientation
{
	GLKMatrix4 rotationXMatrix = GLKMatrix4Rotate(GLKMatrix4Identity, GLKMathDegreesToRadians(orientation.x), 1.0f, 0.0f, 0.0f);

	GLKMatrix4 rotationYMatrix = GLKMatrix4Rotate(GLKMatrix4Identity, GLKMathDegreesToRadians(orientation.y), 0.0f, 1.0f, 0.0f);

	GLKMatrix4 rotationZMatrix = GLKMatrix4Rotate(GLKMatrix4Identity, GLKMathDegreesToRadians(orientation.z), 0.0f, 0.0f, 1.0f);

	GLKMatrix4 translationMatrix = GLKMatrix4Translate(GLKMatrix4Identity, -position.x, -position.y, -position.z);

	GLKMatrix4 rotXY = GLKMatrix4Multiply(rotationXMatrix, rotationYMatrix);
	GLKMatrix4 rotXYZ = GLKMatrix4Multiply(rotationZMatrix, rotXY);
	mTransform = GLKMatrix4Multiply(translationMatrix, rotXYZ);
}

- (GLKMatrix4) transform
{
	return mTransform;
}

- (void) addAttribute:(ECGLAttribute *)attribute
{
	[self.attributes addObject: attribute];
}

- (void) addGeometry:(ECGLGeometry *) geometry
{
	if (!mGeometry)
	{
		mGeometry = [[NSMutableArray alloc] init];
	}
	
	[mGeometry addObject: geometry];
}

- (void) resolveIndexes
{
#if 0 // TODO: redo this
	mMVP = [self.shaders locationForUniform: @"matrix"];
	
	for (ECGLAttribute* attribute in self.attributes)
	{
		[attribute resolveIndexForProgram: self.shaders];
	}
	
	NSUInteger textureNumber = 0;
	for (ECGLTextureLink* texture in self.textures)
	{
		texture.index = [self.shaders locationForUniform: [NSString stringWithFormat: @"texture%ld", textureNumber++]];
	}

	for (ECGLGeometry* sub in mGeometry)
	{
		[sub resolveIndexes];
	}
#endif
}

- (void) use
{
	[self.shaders use];
	
	for (ECGLBoundAttribute* attribute in self.attributes)
	{
		[attribute use];
	}
	
	NSInteger textureIndex = 0;
	NSUInteger textureCount = [self.textures count];
	if (textureCount)
	{
		glEnable(GL_TEXTURE_2D);
		for (ECGLTextureLink* texture in self.textures)
		{
			glActiveTexture((GLenum) (GL_TEXTURE0 + textureIndex++));
			[texture.texture use];
			glUniform1f((GLint) texture.index, 0);
		}
		for (; textureIndex < 4; ++textureIndex)
		{
			glActiveTexture((GLenum) (GL_TEXTURE0 + textureIndex));
			glBindTexture(GL_TEXTURE_2D, 0);
		}
	}
	else
	{
		glDisable(GL_TEXTURE_2D);
	}
	
	if (self.cullFace)
	{	
		glEnable(GL_CULL_FACE);
	}
	else
	{
		glDisable(GL_CULL_FACE);
	}
}

- (void) drawWithCamera:(GLKMatrix4)camera projection:(GLKMatrix4)projection
{
	[self use];

	GLKMatrix4 modelView = GLKMatrix4Multiply(camera, mTransform);
	GLKMatrix4 modelViewProjection = GLKMatrix4Multiply(projection, modelView);

	glUniformMatrix4fv(mMVP, 1, GL_FALSE, (GLfloat*) &modelViewProjection);
	glDrawArrays(GL_TRIANGLES, 0, (GLsizei) self.count);
	
	for (ECGLGeometry* sub in mGeometry)
	{
		[sub drawWithCamera: camera projection:projection];
	}
}

- (void) drawWireframeWithCamera:(GLKMatrix4)camera projection:(GLKMatrix4)projection
{
	[self use];

	GLKMatrix4 modelView = GLKMatrix4Multiply(camera, mTransform);
	GLKMatrix4 modelViewProjection = GLKMatrix4Multiply(projection, modelView);

	glUniformMatrix4fv(mMVP, 1, GL_FALSE, (GLfloat*) &modelViewProjection);
	
	for(NSUInteger i = 0; i < self.count; i += 3)
		glDrawArrays(GL_LINE_LOOP, (GLint)i, 3);
	
	for (ECGLGeometry* sub in mGeometry)
	{
		[sub drawWireframeWithCamera: camera projection:projection];
	}
}

@end
