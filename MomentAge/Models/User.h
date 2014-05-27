//
//  User.h
//  MomentAge
//
//  Created by Dev Khadka on 5/21/14.
//  Copyright (c) 2014 LeapFrog. All rights reserved.
//

#import "BaseModel.h"

@interface User : BaseModel
@property NSString *id;
@property NSString *name;
@property NSString *username;
@property NSString *avatar;
@property NSString *background;
@property NSString *oneLiner;
@property int momentsCount;
@property int followersCount;
@property int followingCount;
@property BOOL flollowedByMe;
@end
