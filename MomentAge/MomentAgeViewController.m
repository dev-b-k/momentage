//
//  MomentAgeViewController.m
//  MomentAge
//
//  Created by Dev Khadka on 5/21/14.
//  Copyright (c) 2014 LeapFrog. All rights reserved.
//

#import "MomentAgeViewController.h"
#import "ApiResponseMoments.h"
#import "UIImageView+AFNetworking.h"


@interface MomentAgeViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewMoments;
@property (weak) ApiResponseMoments *CurrMoments;

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
    self.CurrMoments = response;
}

-(Class)expectedResponseTypeForModuleName:(NSString *)moduleName andMethodName:(NSString *)methodName{
    Class returnType = [BaseAPIResponse class];
    if([MODULE_MOMENTS isEqualToString:moduleName] && [METHOD_FEATURED isEqualToString:methodName]){
        returnType = [ApiResponseMoments class] ;
    }
    return returnType;
}
#pragma end

#pragma mark - UICollectionView methods
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.CurrMoments.moments.counawet;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellCollectionIdentifier=@"CVCellMoments";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellCollectionIdentifier forIndexPath:indexPath];
    
    Moment *currMoment = [self.CurrMoments.moments objectAtIndex:indexPath.row];
    MomentItem *currMomentItem = [currMoment.sellingItems objectAtIndex:0];
    
    __block __weak UIImageView *momentImageView = (UIImageView *)[cell viewWithTag:100];
    
    // Create the request.
    NSURL *imageURL = [NSURL URLWithString:[currMomentItem.mediumUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
    
    [momentImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        //NSLog(@"request: %@\nresponse: %@, image: %@", request, response, image);
        [momentImageView setImage:image];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"error occurred!");
    }];
    
    return cell;
}
#pragma end

@end
