//
//  PNCSplashViewController.m
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/6/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import "PNCSplashViewController.h"
#import <Quickblox/Quickblox.h>

@interface PNCSplashViewController ()

@end

@implementation PNCSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[PNCContentManager sharedInstance] performInitialSyncWithDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initialSyncCompleted{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView setAnimationsEnabled:NO];
        
        //self.view.hidden = YES;
        [self performSegueWithIdentifier:@"splashSegue" sender:self];
    });
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [UIView setAnimationsEnabled:YES];
//        //self.view.hidden = NO;
//    });
}
//- (void(^)(QBResponse *, QBASession *))sessionSuccessBlock
//{
//    return ^(QBResponse *response, QBASession *session) {
//        
//        
//        NSString *fileID = @"58294eddbe4c443ea2058ea7d92035d700";
//        // Download file from QuickBlox server
//        [QBRequest downloadFileWithUID:fileID successBlock:^(QBResponse *response, NSData *fileData) {
//            if ( fileData ) {
//                NSError *error;
//                NSPropertyListFormat format;
//                NSDictionary *plist = [NSPropertyListSerialization propertyListWithData:fileData options:NSPropertyListImmutable format:&format error:&error];
//                if (!plist) {
//                    NSLog(@"Error reading plist from file error = '%@'", error);
//                }
//                else{
//                    [[PNCContentManager sharedInstance] addData:plist];
//                }
//            }
//            [self performSegueWithIdentifier:@"splashSegue" sender:self];
//        } statusBlock:^(QBRequest *request, QBRequestStatus *status) {
//            NSLog(@"progress: %f", status.percentOfCompletion);
//        }  errorBlock:^(QBResponse *response) {
//            NSLog(@"%@", response.error.error);
//        }];
//        

//        QBGeneralResponsePage *page = [QBGeneralResponsePage responsePageWithCurrentPage:1 perPage:20];
//        [QBRequest blobsForPage:page successBlock:^(QBResponse *response, QBGeneralResponsePage *page, NSArray *blobs) {
//            
//            //[[SSCContentManager instance] saveFileList:blobs];
//            
//            NSLog(@"%@", blobs);
//            // hide splash screen
//            //[self performSelector:@selector(hideSplashScreen) withObject:self afterDelay:1];
//            [self performSegueWithIdentifier:@"splashSegue" sender:self];
//
//        } errorBlock:^(QBResponse *response) {
//            NSLog(@"error: %@", response.error);
//        }];
//    };
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
