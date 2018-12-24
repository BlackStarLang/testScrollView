//
//  BSTableView.m
//  testScrollView
//
//  Created by 一枫 on 2018/12/19.
//  Copyright © 2018 SQBJ. All rights reserved.
//

#import "BSTableView.h"

@implementation BSTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
}



@end
