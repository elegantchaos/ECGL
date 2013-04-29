//
//  ECGLLoader.m
//  ECFoundation
//
//  Created by Sam Deane on 11/08/2010.
//  Copyright (c) 2010 Elegant Chaos. All rights reserved.
//

#import "ECGLLoader.h"
#import "ECGLMesh.h"
#import "ECGLGeometry.h"
#import "ECGLArrayAttribute.h"
#import "ECGLShaderProgram.h"

#import <ECFoundation/NSString+ECUtilities.h>

ECDefineDebugChannel(LoaderChannel);

@interface ECGLLoader()
- (void) makeMesh;
@end;

@implementation ECGLLoader

ECPropertySynthesize(defaultProgram);

- (void) dealloc
{
	ECPropertyDealloc(defaultProgram);

	[super dealloc];
}

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
	[url release];

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
	
	[mParser release];
	mParser = nil;

	ECGLMesh* mesh = mResult;
	mResult = nil;
	
	return [mesh autorelease];
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
		mFloats = [[string splitWordsIntoFloats] retain];
		[string release];
	}
	
	else if ([elementName isEqualToString:@"p"]) 
	{
		ECAssertNil(mIndexes);
		mIndexes = [[[NSString stringWithString: mContent] splitWordsIntoInts] retain];
	}

	else if ([elementName isEqualToString: @"source"])
	{
		if (mSourceID && mFloats && mSources)
		{
			[mSources setObject: mFloats forKey:mSourceID];
			[mFloats release];
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
		[mContent release];
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
		NSUInteger positionCount = [data length] / sizeof(Vertex3D); ECUnusedInRelease(positionCount);
		const GLKVector3* positionData = [data bytes];
		
		NSMutableData* vertexData = [NSMutableData dataWithCapacity: indexCount * sizeof(GLKVector3)];
		GLKVector3* vertices = [vertexData mutableBytes];
		for (NSUInteger n = 0; n < indexCount; ++n)
		{
			NSUInteger index = indexData[n];
			ECAssert(index < positionCount);
			vertices[n] = positionData[index];
		}
		
		ECGLArrayAttribute* attribute = [[ECGLArrayAttribute alloc] init];
		attribute.data = vertexData;
		attribute.count = indexCount;
		attribute.name = @"position";
		attribute.size = 3;
		attribute.type = GL_FLOAT;
		attribute.normalized = NO;
		attribute.stride = 0;

		ECGLGeometry* geometry = [[ECGLGeometry alloc] init];
		geometry.count = indexCount;
		geometry.shaders = self.defaultProgram;
		[geometry.attributes addObject: attribute];

		mResult = [[ECGLMesh alloc] init];
		[mResult addGeometry: geometry];
		
		[attribute release];
		[geometry release];
	}
	
	[mIndexes release];
	mIndexes = nil;
	[mSources release];
	mSources = nil;
	mPositionsID = nil;
	mNormalsID = nil;
	
}

@end
