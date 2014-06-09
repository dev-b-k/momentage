
#import "BaseModel.h"

@protocol MomentItem <NSObject>

@end

@interface MomentItem : BaseModel

@property NSString *id;
@property NSString *itemType;
@property int order;
@property NSString *audioPath;
@property NSString *originalUrl;
@property NSString *preveiwUrl;
@property NSString *largeUrl;
@property NSString *mediumUrl;
@property NSString *smallUrl;

@end
