// --------------------------------------------------------------------------
//  Copyright 2013 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

#import "ECGLLoader.h"
#import "ECGLMesh.h"
#import "ECGLGeometry.h"
#import "ECGLArrayAttribute.h"
#import "ECGLShaderProgram.h"

ECDefineDebugChannel(LoaderChannel);

@interface ECGLLoader()
- (void) makeMesh;
@end;

@implementation ECGLLoader

- (ECGLMesh*) loadMeshFromResourceNamed:(NSString *)name
{
	ECGLMesh* mesh = nil;

	NSString* path = [[NSBundle mainBundle] pathForResource: name ofType: @"dae"];
	if (path)
	{
		mesh = [self loadMeshFromPath: path];
	}
	else
	{
		ECDebug(LoaderChannel, @"Mesh resource '%@' missing.", name);
	}
	
	return mesh;
}

- (ECGLMesh*) loadMeshFromPath: (NSString*) path
{
	NSURL* url = [[NSURL alloc] initFileURLWithPath: path];
	ECGLMesh* mesh = [self loadMeshFromURL: url];

	return mesh;
}

- (ECGLMesh*) loadMeshFromURL: (NSURL*) url
{
	mParser = [[NSXMLParser alloc] initWithContentsOfURL: url];
	mParser.delegate = self;
	
	BOOL ok = [mParser parse];
	if (ok)
	{
	}
	
	mParser = nil;

	ECGLMesh* mesh = mResult;
	mResult = nil;
	
	return mesh;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict 
{
	if(qName) 
	{
		elementName = qName;
	}

	ECAssertNil(mContent);
	BOOL makeContent = NO;
	
	if([elementName isEqualToString:@"mesh"]) 
	{
		mSources = [[NSMutableDictionary alloc] init];
	}

	else if([elementName isEqualToString:@"source"]) 
	{
		ECAssertNil(mSourceID);
		mSourceID = [NSString stringWithFormat: @"#%@", [attributeDict valueForKey:@"id"]];
	}

	else if ([elementName isEqualToString:@"float_array"]) 
	{
		makeContent = YES;
	}

	else if ([elementName isEqualToString:@"p"]) 
	{
		makeContent = YES;
	}

	else if([elementName isEqualToString:@"input"]) 
	{
		NSString* source = [attributeDict valueForKey: @"source"];
		NSString* semantic = [attributeDict valueForKey: @"semantic"];
		if ([semantic isEqualToString: @"POSITION"])
		{
			mPositionsID = source;
		}
		else if ([semantic isEqualToString: @"NORMAL"])
		{
			mNormalsID = source;
		}
	}

	if (makeContent)
	{
		mContent = [[NSMutableString alloc] init];
	}

}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	if (qName) 
	{
		elementName = qName;
	}
	
	if ([elementName isEqualToString:@"float_array"]) 
	{
		NSLog(@"bigjobs");
		NSString* string = [mContent copy];
		mFloats = [string splitWordsIntoFloats];
	}
	
	else if ([elementName isEqualToString:@"p"]) 
	{
		ECAssertNil(mIndexes);
		mIndexes = [[NSString stringWithString: mContent] splitWordsIntoInts];
	}

	else if ([elementName isEqualToString: @"source"])
	{
		if (mSourceID && mFloats && mSources)
		{
			[mSources setObject: mFloats forKey:mSourceID];
			mFloats = nil;
			mSourceID = nil;
		}
	}

	else if ([elementName isEqualToString: @"mesh"])
	{
		[self makeMesh];
	}
	
	if (mContent)
	{
		ECDebug(LoaderChannel, @"Content for element %@ was %@", elementName, mContent);
		mContent = nil;
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if (mContent) 
	{
		[mContent appendString:string];
	}
}

- (void) makeMesh
{
	NSData* data = [mSources objectForKey: mPositionsID];
	if (data && mIndexes)
	{
		NSUInteger indexCount = [mIndexes length] / sizeof(int);
		const int* indexData = [mIndexes bytes];
		NSUInteger positionCount = [data length] / sizeof(GLKMatrix3); ECUnusedInRelease(positionCount);
		const GLKVector3* positionData = [data bytes];
		
		NSMutableData* vertexData = [NSMutableData dataWithCapacity: indexCount * sizeof(GLKVector3)];
		GLKVector3* vertices = [vertexData mutableBytes];
		for (NSUInteger n = 0; n < indexCount; ++n)
		{
			NSUInteger index = indexData[n];
			ECAssert(index < positionCount);
			vertices[n] = positionData[index];
		}
		
		ECGLArrayAttribute* attribute = [[ECGLArrayAttribute alloc] initWithName:@"position"];
		attribute.data = vertexData;
		attribute.count = indexCount;
		attribute.size = 3;
		attribute.type = GL_FLOAT;
		attribute.normalized = NO;
		attribute.stride = 0;

		ECGLGeometry* geometry = [[ECGLGeometry alloc] init];
		geometry.count = indexCount;
		geometry.shaders = self.defaultProgram;
		[geometry.attributes addObject:[self.defaultProgram bindingForAttribute:attribute]];

		mResult = [[ECGLMesh alloc] init];
		[mResult addGeometry: geometry];
	}
	
	mIndexes = nil;
	mSources = nil;
	mPositionsID = nil;
	mNormalsID = nil;
	
}

@end
