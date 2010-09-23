//
//  ECGLLoader.h
//  ECFoundation
//
//  Created by Sam Deane on 11/08/2010.
//  Copyright (c) 2010 Elegant Chaos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECProperties.h"

@class ECGLMesh;
@class ECGLShaderProgram;

@interface ECGLLoader : NSObject
{
	NSXMLParser*			mParser;
	NSMutableString*		mContent;
	NSMutableData*			mIndexes;
	NSMutableData*			mFloats;
	NSString*				mSourceID;
	NSString*				mPositionsID;
	NSString*				mNormalsID;
	NSMutableDictionary*	mSources;
	ECGLMesh*				mResult;
}

ECPropertyDefineRN(defaultProgram, ECGLShaderProgram*);

- (ECGLMesh*) loadMeshFromPath: (NSString*) path;
- (ECGLMesh*) loadMeshFromURL: (NSURL*) url;
- (ECGLMesh*) loadMeshFromResourceNamed: (NSString*) name;

@end
