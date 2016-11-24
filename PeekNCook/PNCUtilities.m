//
//  PNCUtilities.m
//  PeekNCook
//
//  Created by AnirbanMaiti on 12/10/14.
//  Copyright (c) 2014 PeekNCook. All rights reserved.
//

#import "PNCUtilities.h"

@implementation PNCUtilities
//	==============================================================
//	resizedImage
//	==============================================================
// Return a scaled down copy of the image.

+ (UIImage*) resizedImage:(UIImage *)inImage withRect: (CGRect) thumbRect
{
    CGImageRef			imageRef = [inImage CGImage];
    // Build a bitmap context that's the size of the thumbRect
    //CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = [self normalizeBitmapInfo:CGImageGetBitmapInfo(imageRef)];
    
    CGContextRef bitmap = CGBitmapContextCreate(
                                                NULL,
                                                thumbRect.size.width,		// width
                                                thumbRect.size.height,		// height
                                                CGImageGetBitsPerComponent(imageRef),	// really needs to always be 8
                                                4 * thumbRect.size.width,	// rowbytes
                                                CGImageGetColorSpace(imageRef),
                                                bitmapInfo
                                                );
    //CGColorSpaceRelease(rgbColorSpace);
    
    // Draw into the context, this scales the image
    CGContextDrawImage(bitmap, thumbRect, imageRef);
    
    // Get an image from the context and a UIImage
    CGImageRef	ref = CGBitmapContextCreateImage(bitmap);
    UIImage*	result = [UIImage imageWithCGImage:ref];
    
    CGContextRelease(bitmap);	// ok if NULL
    CGImageRelease(ref);
    
    return result;
}

+ (CGBitmapInfo)normalizeBitmapInfo:(CGBitmapInfo)oldBitmapInfo {
    //extract the alpha info by resetting everything else
    CGImageAlphaInfo alphaInfo = oldBitmapInfo & kCGBitmapAlphaInfoMask;
    
    //Since iOS8 it's not allowed anymore to create contexts with unmultiplied Alpha info
    if (alphaInfo == kCGImageAlphaLast) {
        alphaInfo = kCGImageAlphaPremultipliedLast;
    }
    if (alphaInfo == kCGImageAlphaFirst) {
        alphaInfo = kCGImageAlphaPremultipliedFirst;
    }
    
    //reset the bits
    CGBitmapInfo newBitmapInfo = oldBitmapInfo & ~kCGBitmapAlphaInfoMask;
    
    //set the bits to the new alphaInfo
    newBitmapInfo |= alphaInfo;
    
    return newBitmapInfo;
}

+ (UIImage*) resizedImage:(UIImage *)originalImage withSize: (CGSize) destinationSize{
    
    UIGraphicsBeginImageContext(destinationSize);
    [originalImage drawInRect:CGRectMake(0,0,destinationSize.width,destinationSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
@end
