//
//  CropLabel.m
//  testCrop
//
//  Created by 沈宁 on 6/8/18.
//  Copyright © 2018 沈宁. All rights reserved.
//

#import "CropLabel.h"

@implementation CropLabel

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        initString=self.stringValue;
        initStringLength=self.stringValue.length;
        att=@{NSFontAttributeName:[NSFont systemFontOfSize:20]};
        initStringWidth=[initString sizeWithAttributes:att].width;
        NSLog(@"%@ length=%lu width=%f",initString,initStringLength,initStringWidth);

        fixWidth=[@"..." sizeWithAttributes:att].width;
        
         NSLog(@"init=%f",self.frame.size.width);

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(boundsDidChangeNotification:)
                                                     name:NSViewBoundsDidChangeNotification
                                                   object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(frameDidChangeNotification:)
                                                     name:NSViewFrameDidChangeNotification
                                                   object:self];
    }
    return self;
}

-(void)viewWillStartLiveResize{
    [super viewWillStartLiveResize];
     NSLog(@"%@",@"will resize");
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}



-(void)cropString{
    NSLog(@"%@",@"test function called");
    //
    frameWidth=self.frame.size.width;
    noBorderWidth=frameWidth-4;
    halfWidth=(frameWidth-fixWidth-4)/2;
    s=initString;//每次计算string要复原

    //如果string的全长可以在frame内全部显示
    if (initStringWidth<=noBorderWidth) {
        oneLine=YES;
    }else{
        oneLine=NO;
    }
    
    
    if (oneLine) {
        //如果string的全长可以在1行内显示
        cropString=initString;
    }else  {
        //如果string的全长需要在2行内显示
        NSLog(@"%@",@"计算第1行");
        for (firstLineLength=1; firstLineLength<initStringLength; firstLineLength++) {
            tempString =[s substringWithRange:NSMakeRange(0,firstLineLength) ];
            tempWidth=[tempString sizeWithAttributes:att].width;
            NSLog(@"R1x=%lu\t%f\t\t%@",firstLineLength,tempWidth,tempString);
            if (tempWidth>=noBorderWidth) {
                firstLineLength=firstLineLength-1;
                break;
            }
            NSLog(@"R1y=%lu\t%f\t\t%@",firstLineLength,tempWidth,tempString);
        }
        NSLog(@"firstLineLength=%lu",firstLineLength);
        firstLine=[s substringWithRange:NSMakeRange(0, firstLineLength)];
        NSLog(@"break at:%lu firstline=%@",firstLineLength,firstLine);
        //
        NSString *check=[s substringWithRange:NSMakeRange(firstLineLength, initStringLength-firstLineLength)];
        NSLog(@"check=%@",check);
        if ([check sizeWithAttributes:att].width<=noBorderWidth) {
            cropString=[NSString stringWithFormat:@"%@\n%@",firstLine,check];
        } else {
            //head
            NSLog(@"%@",@"计算第2行head");
            for (secondLineHeadLength=1;secondLineHeadLength<initStringLength-firstLineLength ;secondLineHeadLength++) {
                tempString=[s substringWithRange:NSMakeRange(firstLineLength, secondLineHeadLength)];
                tempWidth=[tempString sizeWithAttributes:att].width;
                NSLog(@"R2x=%lu\t%f\t\t%@",secondLineHeadLength,tempWidth,tempString);
                if (tempWidth>=halfWidth) {
                    secondLineHeadLength=secondLineHeadLength-1;
                    break;
                }
                NSLog(@"R2y=%lu\t%f\t\t%@",secondLineHeadLength,tempWidth,tempString);
            }
            NSLog(@"secondLineHeadLength=%lu",secondLineHeadLength);
            secondLineHead=[s substringWithRange:NSMakeRange(firstLineLength, secondLineHeadLength)];
            NSLog(@"head=%@",secondLineHead);
            //
            //tail
            NSLog(@"%@",@"计算第2行tail");
            for (secondLineTailLength=1; secondLineTailLength<initStringLength;secondLineTailLength++) {
                tempString=[s substringWithRange:NSMakeRange(initStringLength-secondLineTailLength,secondLineTailLength)];
                tempWidth=[tempString sizeWithAttributes:att].width;
                NSLog(@"R3x=%lu\t%f\t\t%@",secondLineTailLength,tempWidth,tempString);
                if (tempWidth>=halfWidth) {
                    secondLineTailLength=secondLineTailLength-1;
                    break;
                }
                NSLog(@"R3y=%lu\t%f\t\t%@",secondLineTailLength,tempWidth,tempString);
            }
            NSLog(@"taillength=%lu",secondLineTailLength);
            secondLineTail=[s substringWithRange:NSMakeRange(initStringLength-secondLineTailLength,secondLineTailLength)];
            NSLog(@"tail=%@",secondLineTail);
            
            
            cropString=[NSString stringWithFormat:@"%@\n%@...%@",firstLine,secondLineHead,secondLineTail];
            NSLog(@"%@",cropString);
        }
        
        
    }
    NSLog(@"%@",@"test function end");
}


-(void)test{
     NSLog(@"%@",@"fasdfa");
}


- (void)boundsDidChangeNotification:(NSNotification *)notification
{
    // ...
    NSLog(@"%@",@"than way!bounds");
}

- (void)frameDidChangeNotification:(NSNotification *)notification
{
    NSLog(@"%@ %f",@"======begin frame",self.frame.size.width);
    //
    [self cropString];
    self.stringValue=cropString;

    // ...
    NSLog(@"%@ %f",@"======end frame",self.frame.size.width);
}







@end
