//
//  ApiCaller.h
//  Plunder
//
//  Created by Dev Khadka on 3/6/14.
//  Copyright (c) 2014 Leapfrog Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>
#import "BaseAPIResponse.h"
#import <AFNetworking.h>
#import "Constants.h"


@interface APICaller : NSObject<UIAlertViewDelegate>
    -(void) getFromModuleName: (NSString *) moduleName
                  methodName: (NSString *) methodName
             andWithDelegate: (id) delegate;
    
    -(void) postToModuleName: (NSString *) moduleName
                  methodName: (NSString *) methodName
                   postData: (JSONModel *) data
             andWithDelegate: (id) delegate;

    -(void) postToModuleName: (NSString *) moduleName
              methodName: (NSString *) methodName
                postData: (JSONModel *) data
                    fileUrls: (NSMutableArray *) fileUrls
         andWithDelegate: (id) delegate;

    -(void) putToModuleName: (NSString *) moduleName
                 methodName: (NSString *) methodName
                   postData: (JSONModel *) data
            andWithDelegate: (id) delegate;

    -(void) deleteItemWithModuleName: (NSString *) moduleName
                 methodName: (NSString *) methodName
                   postData: (JSONModel *) data
            andWithDelegate: (id) delegate;
@end

@interface APICallStatus : JSONModel
    @property BOOL isSuccess;
    @property int errorCode;
    @property NSString * errorMessage;
    @property NSString<Optional>* moduleName;
    @property NSString<Optional>* methodName;
@end

@interface DeserializeToJSONModel : AFHTTPResponseSerializer<AFURLResponseSerialization>
@property (strong, nonatomic) Class expectedResultClass;

-(DeserializeToJSONModel *) initWithExpectedResultType:(Class)resultType;
-(id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error;
@end

@protocol APICallCompleted <NSObject>
    - (void)APICallCompletedWithStatus:(APICallStatus *)status andResponse:(BaseAPIResponse*)response;
    - (Class)expectedResponseTypeForModuleName: (NSString*) moduleName andMethodName: (NSString*) methodName;

@end
