//
//  ApiResponseMoments.h
//  MomentAge
//
//  Created by Dev Khadka on 5/21/14.
//  Copyright (c) 2014 LeapFrog. All rights reserved.
//

#import "BaseAPIResponse.h"
#import "Moment.h"

@interface ApiResponseMoments : BaseAPIResponse
@property NSMutableArray<Moment>  *moments;
@property int nextPage;
@end
