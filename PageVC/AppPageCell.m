//
//  AppPageCell.m
//  App
//
//  Created by 項普華 on 2019/10/31.
//  Copyright © 2019 Alex. All rights reserved.
//

#import "AppPageCell.h"

@interface AppPageCell ()
/** swipeButtons */
@property (nonatomic, strong) NSArray<UIButton *> *swipeButtons;
/** 是否处于左滑状态 */
@property (nonatomic, assign) BOOL isLeftStatus;

/** coverImageView */
@property (nonatomic, strong) UIImageView *leftStatusCoverImageView;

/** <#注释#> */
@property (nonatomic, copy) void(^pageLeftButtonAction)(UIButton *sender, AppPageCell *cell);

@end

@implementation AppPageCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.mainView = [[self.mainViewClass alloc] initWithFrame:frame];
        [self addSubview:self.mainView];
        self.mainView.prepareForReuseSignal = self.rac_prepareForReuseSignal;
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        @weakify(self);
        self.leftStatusCoverImageView = UIImageView.ylt_createLayout(self.mainView, ^(MASConstraintMaker *make) {
            make.edges.equalTo(self.mainView);
        }).ylt_backgroundColor(UIColor.clearColor)
        .ylt_convertToImageView()
        .ylt_contentMode(UIViewContentModeScaleAspectFill);
        self.leftStatusCoverImageView.ylt_tap(self, @selector(swipeDismiss));
        [RACObserve(self, isLeftStatus) subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            self.leftStatusCoverImageView.hidden = !self.isLeftStatus;
        }];
    }
    return self;
}

- (void)setData:(YLT_BaseModel *)data {
    _data = data;
    self.mainView.prepareForReuseSignal = self.rac_prepareForReuseSignal;
    self.mainView.data = data;
    
    if (self.swipeButtons.count > 0) {
        self.isLeftStatus = NO;//恢复左滑状态
    }
}

- (Class)mainViewClass {
    return AppPageView.class;
}

- (BOOL)selectedIndexPath:(NSIndexPath *)indexPath sourceList:(NSMutableArray<AppSectionModel *> *)sourceList {
    return NO;
}

#define PAGE_SWIPE_BUTTON_WIDTH 120.
/// 左滑配置
/// @param swipeButtons 左滑按钮
/// @param clickBlock 回调
- (void)swipeButtons:(NSArray<UIButton *> *)swipeButtons clickBlock:(void(^)(UIButton *sender, AppPageCell *cell))clickBlock {
    self.swipeButtons = swipeButtons;
    if (swipeButtons.count > 0) {
        @weakify(self);
        self.pageLeftButtonAction = clickBlock;
        [swipeButtons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self insertSubview:obj belowSubview:self.mainView];
            CGFloat offset = -(idx*PAGE_SWIPE_BUTTON_WIDTH);
            [obj mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mainView).offset(offset);
                make.top.bottom.equalTo(self.mainView);
                make.width.mas_equalTo(PAGE_SWIPE_BUTTON_WIDTH);
            }];
            [[obj rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIButton * _Nullable x) {
                @strongify(self);
                if (self.pageLeftButtonAction) {
                    self.pageLeftButtonAction(x, self);
                }
            }];
        }];
        
        UISwipeGestureRecognizer *gesture = self.ylt_swipe(self, @selector(swipeAction:));
        gesture.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.mainView addGestureRecognizer:gesture];
        
        gesture = self.ylt_swipe(self, @selector(swipeAction:));
        gesture.direction = UISwipeGestureRecognizerDirectionRight;
        [self.mainView addGestureRecognizer:gesture];
        
        [[NSNotificationCenter.defaultCenter rac_addObserverForName:@"PAGE_SWIPE_ACTION_NOTIFICATION" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
            @strongify(self);
            [self swipeDismiss];
        }];
    }
}

- (void)swipeAction:(UISwipeGestureRecognizer *)sender {
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        [NSNotificationCenter.defaultCenter postNotificationName:@"PAGE_SWIPE_ACTION_NOTIFICATION" object:nil];
        self.isLeftStatus = YES;
        [UIView animateWithDuration:APP_ANIMATED_DURATION delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            CGRect frame = self.mainView.frame;
            frame.origin.x -= self.swipeButtons.count*PAGE_SWIPE_BUTTON_WIDTH;
            self.mainView.frame = frame;
        } completion:^(BOOL finished) {
        }];
    } else if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        [self swipeDismiss];
    }
}

- (void)swipeDismiss {
    if (self.isLeftStatus) {
        [UIView animateWithDuration:APP_ANIMATED_DURATION delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            CGRect frame = self.mainView.frame;
            frame.origin.x += self.swipeButtons.count*PAGE_SWIPE_BUTTON_WIDTH;
            self.mainView.frame = frame;
        } completion:^(BOOL finished) {
            [self layoutIfNeeded];
        }];
    }
    self.isLeftStatus = NO;
}

@end
