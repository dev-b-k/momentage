
#import "MomentAgeViewController.h"
#import "ApiResponseMoments.h"
#import "UIImageView+AFNetworking.h"


@interface MomentAgeViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewMoments;
@property (strong, nonatomic) ApiResponseMoments *CurrMoments;

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
}


#pragma mark -APICallCompleted Implementation
-(void)APICallCompletedWithStatus:(APICallStatus *)status andResponse:(BaseAPIResponse *)response{
    self.CurrMoments = ((ApiResponseMoments*)response);
    [self.collectionViewMoments reloadData];
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
    return self.CurrMoments.moments.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellCollectionIdentifier=@"CVCellMoments";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellCollectionIdentifier forIndexPath:indexPath];
    
    Moment *currMoment = [self.CurrMoments.moments objectAtIndex:indexPath.row];
    
    MomentItem *currMomentItem = [currMoment.momentItems objectAtIndex:0];
    User *currUser = currMoment.user;
    
    __block __weak UIImageView *momentImageView = (UIImageView *)[cell viewWithTag:100];
    UILabel *lblMomentTitle = (UILabel *)[cell viewWithTag:101];
    UILabel *lblPhotoCount = (UILabel *)[cell viewWithTag:102];
    UIButton *btnPhotoCount = (UIButton *)[cell viewWithTag:103];
    UILabel *lblVideoCount = (UILabel *)[cell viewWithTag:104];
    UIButton *btnVideoCount = (UIButton *)[cell viewWithTag:105];
    UILabel *lblAudioCount = (UILabel *)[cell viewWithTag:106];
    UIButton *btnAudioCount = (UIButton *)[cell viewWithTag:107];
    __block __weak UIImageView *userImageView = (UIImageView *)[cell viewWithTag:108];
    UILabel *lblUserName = (UILabel *)[cell viewWithTag:109];
    
    [userImageView.layer setCornerRadius:24.0f];
    [userImageView.layer setMasksToBounds:YES];
    
    lblMomentTitle.text = currMoment.title;
    
    NSInteger photoCount = [currMoment getPhotoCount];
    lblPhotoCount.text =  [NSString stringWithFormat:@"%d", photoCount];
    if(photoCount == 0){
        [lblPhotoCount setEnabled:FALSE];
        [btnPhotoCount setEnabled:FALSE];
    }
    
    NSInteger videoCount = [currMoment getVideoCount];
    lblVideoCount.text =  [NSString stringWithFormat:@"%d", videoCount];
    if(videoCount == 0){
        [lblVideoCount setEnabled:FALSE];
        [btnVideoCount setEnabled:FALSE];
    }
    
    NSInteger audioCount = [currMoment getAudioCount];
    lblAudioCount.text =  [NSString stringWithFormat:@"%d", audioCount];
    if(audioCount == 0){
        [lblAudioCount setEnabled:FALSE];
        [btnAudioCount setEnabled:FALSE];
    }
    
    lblUserName.text =  [NSString stringWithFormat:@"%@", currUser.name];
    
    NSURL *momentImageURL = [NSURL URLWithString:[currMomentItem.mediumUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:momentImageURL];
    
    [momentImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [momentImageView setImage:image];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"error occurred!");
    }];
    
    
    NSURL *userImageURL = [NSURL URLWithString:[currUser.avatar stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    request = [NSURLRequest requestWithURL:userImageURL];
    
    [userImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [userImageView setImage:image];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"error occurred!");
    }];
    
    return cell;
}
#pragma end

@end
