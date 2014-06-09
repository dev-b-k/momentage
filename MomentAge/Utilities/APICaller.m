
#import "APICaller.h"
#import <JSONModel.h>
#import <AFNetworking.h>
#import "User.h"
#import "BaseAPIResponse.h"


@interface APICaller ()

@property (nonatomic, strong) id delegate;

@end

@implementation APICaller
//NSString* const BASE_URL = @"http://demos.smartmobe.com/plunder";

NSMutableData* _responseData;
id<APICallCompleted> _completedDelegate;
APICallStatus* _status;


-(void) getFromModuleName: (NSString *) moduleName
               methodName: (NSString *) methodName
          andWithDelegate: (id) delegate{
    [self callAPIWithModuleName:moduleName methodName:methodName httpMethod:@"GET" postData:nil andWithDelegate:delegate];
}

-(void) postToModuleName: (NSString *) moduleName
              methodName: (NSString *) methodName
                postData: (JSONModel *) data
         andWithDelegate: (id<APICallCompleted>) delegate{
    [self callAPIWithModuleName:moduleName methodName:methodName httpMethod:@"POST" postData:data andWithDelegate:delegate];
}

-(void)postToModuleName:(NSString *)moduleName methodName:(NSString *)methodName postData:(JSONModel *)data fileUrls:(NSMutableArray *)fileUrls andWithDelegate:(id)delegate{
    [self callAPIWithModuleName:moduleName methodName:methodName httpMethod:@"POST" postData:data fileUrls:fileUrls andWithDelegate:delegate];
}

-(void) putToModuleName: (NSString *) moduleName
             methodName: (NSString *) methodName
               postData: (JSONModel *) data
        andWithDelegate: (id<APICallCompleted>) delegate{
    @throw [NSException exceptionWithName:@"MethodNotImplemented" reason:@"This method is not implemented call getFromModuleName or postToModuleName instead" userInfo:nil];
    
}

-(void) deleteItemWithModuleName: (NSString *) moduleName
                      methodName: (NSString *) methodName
                        postData: (JSONModel *) data
                 andWithDelegate: (id<APICallCompleted>) delegate{
    @throw [NSException exceptionWithName:@"MethodNotImplemented" reason:@"This method is not implemented call getFromModuleName or postToModuleName instead" userInfo:nil];
    
}

-(void) callAPIWithModuleName: (NSString *) moduleName
                   methodName: (NSString *) methodName
                   httpMethod: (NSString *) httpMethod
                     postData: (JSONModel *) data
                     fileUrls: (NSMutableArray *) fileUrls
              andWithDelegate: (id<APICallCompleted>) delegate{
    
    _completedDelegate = delegate;
    _status = [[APICallStatus alloc] init];
    _status.moduleName = moduleName;
    _status.methodName = methodName;
    NSString* url = [NSString stringWithFormat:@"%@/%@/%@",API_BASE_URL,moduleName,methodName];
    //__block __weak APICaller* weakSelf = self;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", nil];
    manager.responseSerializer = [[DeserializeToJSONModel alloc] initWithExpectedResultType:[_completedDelegate expectedResponseTypeForModuleName:_status.moduleName andMethodName:_status.methodName]];
    
    //if data is nil do "GET" request else do "POST" request
    if(data){
        NSDictionary *parameters = @{@"jsonData": data.toJSONString};
        [manager POST:url
           parameters:parameters
constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    for (NSURL *fileUrl in fileUrls) {
        NSError *error = [[NSError alloc] init];
        BOOL attached = [formData appendPartWithFileURL:fileUrl name:[fileUrl lastPathComponent] error:&error];
        
        if(!attached){
            NSLog(@"Attached: %@, File: %@, Error: %@",(attached?@"1":@"0"), fileUrl, error);
        }
        else{
            NSLog(@"Attached: %@, File: %@",(attached?@"1":@"0"), fileUrl);
        }
    }
    
}
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  if([responseObject isKindOfClass:[BaseAPIResponse class]]){
                      BaseAPIResponse *respObj = (BaseAPIResponse*)responseObject;
                      if(respObj.status.errorCode==7){
                          [[[UIAlertView alloc]initWithTitle:@"Wrong Crediential" message:@"Wrong crediential sent to access data. Please try to login in again to fix this." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
                          
                          
                          [self APICallFailedWithError:[NSError errorWithDomain:@"Wrong credintial." code:1 userInfo:nil] ];
                      }
                      else{
                          [self APICallSuccededWithResponse: responseObject];
                      }
                  }
                  else{
                      [self APICallSuccededWithResponse: responseObject];
                  }
                  
                  
                  
              }
              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  [self APICallFailedWithError:error];
              }];
        
    }
    else{
        
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self APICallSuccededWithResponse: responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self APICallFailedWithError:error];
        }];
    }
    
    
}

-(void) callAPIWithModuleName: (NSString *) moduleName
                   methodName: (NSString *) methodName
                   httpMethod: (NSString *) httpMethod
                     postData: (JSONModel *) data
              andWithDelegate: (id<APICallCompleted>) delegate{
    
    [self callAPIWithModuleName:moduleName methodName:methodName httpMethod:httpMethod postData:data fileUrls:nil andWithDelegate:delegate];
}

-(void) APICallSuccededWithResponse:(id)response{
    _status.isSuccess = YES;
    [_completedDelegate APICallCompletedWithStatus:_status andResponse:response];
}

-(void)APICallFailedWithError:(NSError*) error{
    _status.isSuccess = NO;
    _status.errorMessage = [error description];
    [_completedDelegate APICallCompletedWithStatus:_status andResponse:nil];
}

@end


@implementation APICallStatus

@end


@implementation DeserializeToJSONModel

-(DeserializeToJSONModel *) initWithExpectedResultType:(Class)resultType{
    if(self=[super init]){
        self.expectedResultClass = resultType;
    }
    return self;
}

-(id)responseObjectForResponse:(NSURLResponse *)response data:(NSData *)data error:(NSError *__autoreleasing *)error{
    Class cls = [_completedDelegate expectedResponseTypeForModuleName:_status.moduleName andMethodName:_status.methodName];
    id resp = [[cls alloc] initWithData:data error:error];
    return resp;
}

@end
