//
//  UITableViewCell+YLT_Create.m
//  Pods
//
//  Created by YLT_Alex on 2017/10/31.
//

#import "UITableViewCell+YLT_Create.h"
#import <YLT_BaseLib/YLT_BaseLib.h>
#import <objc/message.h>
#import "UIImage+YLT_Utils.h"
#import "UIImageView+YLT_Create.h"
#import "UILabel+YLT_Create.h"

@implementation UITableViewCell (YLT_Create)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject YLT_SwizzleSelectorInClass:[UITableView class] originalSel:@selector(initWithStyle:reuseIdentifier:) replaceSel:@selector(initWithStyle:YLT_ReuseIdentifier:)];
    });
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style YLT_ReuseIdentifier:(NSString *)reuseIdentifier {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if ([self respondsToSelector:@selector(YLT_cellStyle)]) {
        style = (UITableViewCellStyle)[self performSelector:@selector(YLT_CellStyle) withObject:nil];
    }
#pragma clang diagnostic pop
    self = [self initWithStyle:style YLT_ReuseIdentifier:reuseIdentifier];
    self.YLT_CellConfigUI();
    return self;
}


- (void)setCellData:(id)cellData {
    objc_setAssociatedObject(self, @selector(cellData), cellData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)cellData {
    return objc_getAssociatedObject(self, @selector(cellData));
}


/**
 绑定数据
 */
- (UITableViewCell *(^)(NSIndexPath *indexPath, id bindData))YLT_CellBindData {
    return ^id(NSIndexPath *indexPath, id bindData) {
        self.cellData = bindData;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if ([self respondsToSelector:@selector(YLT_IndexPath:bindData:)]) {
            [self performSelector:@selector(YLT_IndexPath:bindData:) withObject:indexPath withObject:bindData];
        }
#pragma clang diagnostic pop
        return self;
    };
}
/**
 处理UI
 */
- (UITableViewCell *(^)(void))YLT_CellConfigUI {
    return ^id() {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if ([self respondsToSelector:@selector(YLT_configUI)]) {
            [self performSelector:@selector(YLT_configUI) withObject:nil];
        }
#pragma clang diagnostic pop
        return self;
    };
}

/**
 accessory type
 */
- (UITableViewCell *(^)(UITableViewCellAccessoryType accessoryType))YLT_AccessoryType {
    return ^id(UITableViewCellAccessoryType accessoryType) {
        self.accessoryType = accessoryType;
        return self;
    };
}
/**
 左边image
 */
- (UITableViewCell *(^)(id leftImg))YLT_LeftImage {
    return ^id(id leftImg) {
        self.imageView.YLT_Image(leftImg);
        return self;
    };
}
/**
 左边标题
 */
- (UITableViewCell *(^)(NSString *title))YLT_Title {
    return ^id(NSString *title) {
        self.textLabel.YLT_Text(title);
        return self;
    };
}
/**
 详细标题
 */
- (UITableViewCell *(^)(NSString *subTitle))YLT_SubTitle {
    return ^id(NSString *subTitle) {
        self.detailTextLabel.YLT_Text(subTitle);
        return self;
    };
}

@end
