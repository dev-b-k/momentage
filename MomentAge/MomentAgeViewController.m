//
//  MomentAgeViewController.m
//  MomentAge
//
//  Created by Dev Khadka on 5/21/14.
//  Copyright (c) 2014 LeapFrog. All rights reserved.
//

#import "MomentAgeViewController.h"
#import "ApiResponseMoments.h"


@interface MomentAgeViewController ()

@end

@implementation MomentAgeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	APICaller *apiCaller = [[APICaller alloc] init];
    [apiCaller getFromModuleName: MODULE_MOMENTS methodName:METHOD_FEATURED andWithDelegate:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -APICallCompleted Implementation
-(void)APICallCompletedWithStatus:(APICallStatus *)status andResponse:(BaseAPIResponse *)response{
    NSLog(@"%@", response);
}

-(Class)expectedResponseTypeForModuleName:(NSString *)moduleName andMethodName:(NSString *)methodName{
    Class returnType = [BaseAPIResponse class];
    if([MODULE_MOMENTS isEqualToString:moduleName] && [METHOD_FEATURED isEqualToString:methodName]){
        returnType = [ApiResponseMoments class] ;
    }
    return returnType;
}
#pragma end

@end
