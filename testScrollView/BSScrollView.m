//
//  BSScrollView.m
//  testScrollView
//
//  Created by 一枫 on 2018/12/19.
//  Copyright © 2018 SQBJ. All rights reserved.
//

#import "BSScrollView.h"

@interface BSScrollView ()<UIGestureRecognizerDelegate>

@end

@implementation BSScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self initSubViews];
        [self masonryLayout];
    }
    return self;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
}


- (void)initSubViews{
    
}

- (void)masonryLayout{
    
}

@end
