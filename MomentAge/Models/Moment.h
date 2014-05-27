//
//  Moment.h
//  MomentAge
//
//  Created by Dev Khadka on 5/21/14.
//  Copyright (c) 2014 LeapFrog. All rights reserved.
//

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
@property int likesCount;
@property int commentsCount;
@property long updatedAt;
@property long createdAt;
@property NSMutableArray<MomentItem> *sellingItems;
@property User *user;
@property BOOL likedByMe;

@end
