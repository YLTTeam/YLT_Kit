//
//  UITextView+YLT_Extension.m
//  Pods
//
//  Created by YLT_Alex on 2017/11/21.
//

#import "UITextView+YLT_Extension.h"

@implementation UITextView (YLT_Extension)

-(NSRange)ylt_selectedRange {
    NSInteger location = [self offsetFromPosition:self.beginningOfDocument toPosition:self.selectedTextRange.start];
    NSInteger length = [self offsetFromPosition:self.selectedTextRange.start toPosition:self.selectedTextRange.end];
    return NSMakeRange(location, length);
}

-(void)setYlt_selectedRange:(NSRange)ylt_selectedRange {
    UITextPosition *startPosition = [self positionFromPosition:self.beginningOfDocument offset:ylt_selectedRange.location];
    UITextPosition *endPosition = [self positionFromPosition:self.beginningOfDocument offset:ylt_selectedRange.location + ylt_selectedRange.length];
    UITextRange *selectedTextRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectedTextRange];
}

@end
