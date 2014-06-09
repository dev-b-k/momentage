
#import "BaseAPIResponse.h"
#import "Moment.h"

@interface ApiResponseMoments : BaseAPIResponse

@property NSMutableArray<Moment>  *moments;
@property int nextPage;

@end
