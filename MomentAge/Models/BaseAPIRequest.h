//
//  BaseAPIRequest.h
//  Plunder
//
//  Created by Dev Khadka on 3/25/14.
//  Copyright (c) 2014 Leapfrog Technology. All rights reserved.
//

#import "BaseModel.h"

@interface BaseAPIRequest : BaseModel
@property int userId;
-(BaseAPIRequest*)init;
@end
