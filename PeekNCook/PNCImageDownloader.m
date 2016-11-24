//
//  PNCImageDownloader.m
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/9/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import "PNCImageDownloader.h"
#import <Quickblox/Quickblox.h>

@implementation PNCImageDownloader{
    NSMutableDictionary* _imagePool;
}

+ (instancetype)sharedInstance
{
    static id instance_ = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance_ = [[self alloc] init];
    });
    return instance_;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _imagePool = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)dealloc
{
}

-(NSData*) downloadImageWithUID:(NSString*)fileID withCompletionBlock:(void (^)(NSData*))completeBlock{
    
    NSData* data = [_imagePool objectForKey:fileID];
    if (data) {
        return data;
    }
    
    [QBRequest downloadFileWithUID:fileID successBlock:^(QBResponse *response, NSData *fileData) {
        if ( fileData ) {
            completeBlock(fileData);
            [_imagePool setObject:fileData forKey:fileID];
        }
    } statusBlock:^(QBRequest *request, QBRequestStatus *status) {
        NSLog(@"progress: %f", status.percentOfCompletion);
    }  errorBlock:^(QBResponse *response) {
        NSLog(@"%@", response.error.error);
    }];
    return nil;
}
@end
