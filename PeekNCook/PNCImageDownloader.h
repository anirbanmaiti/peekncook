//
//  PNCImageDownloader.h
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/9/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PNCImageDownloader : NSObject

-(NSData*) downloadImageWithUID:(NSString*)fileID withCompletionBlock:(void (^)(NSData*))completeBlock;

+ (instancetype)sharedInstance;
@end
