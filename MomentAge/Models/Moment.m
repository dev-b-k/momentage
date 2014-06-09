
#import "Moment.h"

@implementation Moment

-(NSInteger)getPhotoCount{
    NSInteger photoCount = 0;
    
    for(MomentItem *momentItem in self.momentItems){
        if([momentItem.itemType caseInsensitiveCompare:@"photo"] == NSOrderedSame)
            photoCount++;
    }
    
    return photoCount;
}

-(NSInteger)getVideoCount{
    NSInteger photoCount = 0;
    
    for(MomentItem *momentItem in self.momentItems){
        if([momentItem.itemType caseInsensitiveCompare:@"video"] == NSOrderedSame)
            photoCount++;
    }
    
    return photoCount;
}

-(NSInteger)getAudioCount{
    NSInteger photoCount = 0;
    
    for(MomentItem *momentItem in self.momentItems){
        if([momentItem.itemType caseInsensitiveCompare:@"audio"] == NSOrderedSame)
            photoCount++;
    }
    
    return photoCount;
}

@end
