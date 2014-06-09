
#import "JSONModel.h"
#import "BaseModel.h"


@class APICallStatus;

@interface BaseAPIResponse : BaseModel

@property APICallStatus* status;

@end
