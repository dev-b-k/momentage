

#import "BaseModel.h"
#import "MomentItem.h"
#import "User.h"

@protocol Moment <NSObject>


@end

@interface Moment : BaseModel
@property NSString *id;
@property NSString *description;
@property NSString *title;
@property NSString *privacy;
@property NSURL *url;
@property int likesCount;
@property int commentsCount;
@property long updatedAt;
@property long createdAt;
@property NSMutableArray<MomentItem> *momentItems;
@property User *user;
@property BOOL likedByMe;

-(NSInteger)getPhotoCount;
-(NSInteger)getVideoCount;
-(NSInteger)getAudioCount;

@end
