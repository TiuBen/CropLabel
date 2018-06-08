//
//  CropLabel.h
//  testCrop
//
//  Created by 沈宁 on 6/8/18.
//  Copyright © 2018 沈宁. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CropLabel : NSTextField{
    NSString*   initString;
    NSUInteger  initStringLength;
    NSString*   cropString;
    //
    NSString*   firstLine;
    NSUInteger  firstLineLength;
    NSString*   secondLineHead;
    NSUInteger  secondLineHeadLength;
    NSString*   secondLineTail;
    NSUInteger  secondLineTailLength;
    
    //
    BOOL oneLine;
    NSDictionary *att;
    CGFloat initStringWidth;
    CGFloat fixWidth;
    
    //always change
    CGFloat frameWidth;
    CGFloat noBorderWidth;
    NSString *s;
    CGFloat halfWidth;
    NSString *tempString;
    CGFloat  tempWidth;

}


@end
