// --------------------------------------------------------------------------
//  Copyright 2013 Sam Deane, Elegant Chaos. All rights reserved.
//  This source code is distributed under the terms of Elegant Chaos's
//  liberal license: http://www.elegantchaos.com/license/liberal
// --------------------------------------------------------------------------

@class ECGLMesh;
@class ECGLShaderProgram;

@interface ECGLLoader : NSObject<NSXMLParserDelegate>
{
	NSXMLParser*			mParser;
	NSMutableString*		mContent;
	NSData*                 mIndexes;
	NSData*                 mFloats;
	NSString*				mSourceID;
	NSString*				mPositionsID;
	NSString*				mNormalsID;
	NSMutableDictionary*	mSources;
	ECGLMesh*				mResult;
}

@property (strong, nonatomic) ECGLShaderProgram* defaultProgram;

- (ECGLMesh*) loadMeshFromPath: (NSString*) path;
- (ECGLMesh*) loadMeshFromURL: (NSURL*) url;
- (ECGLMesh*) loadMeshFromResourceNamed: (NSString*) name;

@end
