// --------------------------------------------------------------------------
//! @author Sam Deane
//! @date 11/08/2010
//
//  Copyright 2010 Sam Deane, Elegant Chaos. All rights reserved.
// --------------------------------------------------------------------------

#import "ECGLGeometry.h"
#import "ECGLCommon.h"
#import "ECGLAttribute.h"
#import "ECGLShaderProgram.h"
#import "ECGLTexture.h"
#import "ECGLTextureLink.h"

@interface ECGLGeometry()
- (void) use;
@end

@implementation ECGLGeometry

ECPropertySynthesize(attributes);
ECPropertySynthesize(shaders);
ECPropertySynthesize(count);
ECPropertySynthesize(textures);
ECPropertySynthesize(cullFace);

- (id) init
{
	if ((self = [super init]) != nil)
	{
		NSMutableArray* atts = [[NSMutableArray alloc] init];
		self.attributes = atts;
		[atts release];
		
		NSMutableArray* tex = [[NSMutableArray alloc] init];
		self.textures = tex;
		[tex release];
		
		self.cullFace = YES;
	}
	
	return self;
}

- (void) dealloc
{
	[mGeometry release];
	ECPropertyDealloc(attributes);
	ECPropertyDealloc(shaders);
	ECPropertyDealloc(textures);
	
	[super dealloc];
}

- (void) addTexture:(ECGLTexture *)texture
{
	ECGLTextureLink* link = [[ECGLTextureLink alloc] init];
	link.texture = texture;
	[self.textures addObject: link];
	[link release];
}

- (void) updateTransformForPosition: (Vector3D) position orientation: (Vector3D) orientation
{
    static const Vector3D rotateX = {1.f, 0.f, 0.f};
    static const Vector3D rotateY = {0.f, 1.f, 0.f};
    static const Vector3D rotateZ = {0.f, 0.f, 1.f};
	
	Matrix3D rotationXMatrix;
    Matrix3DSetRotationByDegrees(rotationXMatrix, orientation.x, rotateX);
	
	Matrix3D rotationYMatrix;
    Matrix3DSetRotationByDegrees(rotationYMatrix, orientation.y, rotateY);
	
	Matrix3D rotationZMatrix;
    Matrix3DSetRotationByDegrees(rotationZMatrix, orientation.z, rotateZ);
	
	Matrix3D translationMatrix;
	Matrix3DSetTranslation(translationMatrix, -position.x, -position.y, -position.z);
	
	Matrix3D temp;
	Matrix3DMultiply(rotationXMatrix, rotationYMatrix, mTransform);
	Matrix3DMultiply(rotationZMatrix, mTransform, temp);
	Matrix3DMultiply(translationMatrix, temp, mTransform);
}

- (GLfloat*) transform
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
	mMVP = [self.shaders locationForUniform: @"matrix"];
	
	for (ECGLAttribute* attribute in self.attributes)
	{
		[attribute resolveIndexForProgram: self.shaders];
	}
	
	NSUInteger textureNumber = 0;
	for (ECGLTextureLink* texture in self.textures)
	{
		texture.index = [self.shaders locationForUniform: [NSString stringWithFormat: @"texture%d", textureNumber++]];
	}

	for (ECGLGeometry* sub in mGeometry)
	{
		[sub resolveIndexes];
	}
}

- (void) use
{
	[self.shaders use];
	
	for (ECGLAttribute* attribute in self.attributes)
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
			glActiveTexture(GL_TEXTURE0 + textureIndex++);
			[texture.texture use];
			glUniform1f(texture.index, 0);		
		}
		for (; textureIndex < 4; ++textureIndex)
		{
			glActiveTexture(GL_TEXTURE0 + textureIndex);
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

- (void) drawWithCamera: (GLfloat*) camera projection: (GLfloat*) projection;
{
	[self use];

	Matrix3D modelView;
	Matrix3DMultiply(camera, mTransform, modelView);
	
	Matrix3D modelViewProjection;
	Matrix3DMultiply(projection, modelView, modelViewProjection);		

	glUniformMatrix4fv(mMVP, 1, GL_FALSE, modelViewProjection);
	glDrawArrays(GL_TRIANGLES, 0, self.count);
	
	for (ECGLGeometry* sub in mGeometry)
	{
		[sub drawWithCamera: camera projection:projection];
	}
}

- (void) drawWireframeWithCamera: (GLfloat*) camera projection: (GLfloat*) projection;
{
	[self use];

	Matrix3D modelView;
	Matrix3DMultiply(camera, mTransform, modelView);
	
	Matrix3D modelViewProjection;
	Matrix3DMultiply(projection, modelView, modelViewProjection);		

	glUniformMatrix4fv(mMVP, 1, GL_FALSE, modelViewProjection);
	
	for(NSUInteger i = 0; i < self.count; i += 3)
		glDrawArrays(GL_LINE_LOOP, i, 3);
	
	for (ECGLGeometry* sub in mGeometry)
	{
		[sub drawWireframeWithCamera: camera projection:projection];
	}
}

@end
