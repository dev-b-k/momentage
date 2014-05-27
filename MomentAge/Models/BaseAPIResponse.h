//
//  BaseAPIResponse.h
//  Plunder
//
//  Created by Dev Khadka on 3/6/14.
//  Copyright (c) 2014 Leapfrog Technology. All rights reserved.
//

#import "JSONModel.h"
#import "BaseModel.h"


@class APICallStatus;
@interface BaseAPIResponse : BaseModel
@property APICallStatus* status;
@end
