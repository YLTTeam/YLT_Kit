//
//  UITableViewCell+YLT_Create.h
//  Pods
//
//  Created by YLT_Alex on 2017/10/31.
//

#import <UIKit/UIKit.h>

@protocol YLT_TableViewCellProtocol <NSObject>

@optional
/**
 类型配置
 
 @return UITableViewCellStyle
 */
- (UITableViewCellStyle)YLT_CellStyle;
/**
 UI配置
 */
- (void)YLT_ConfigUI;
/**
 数据绑定
 */
- (void)YLT_IndexPath:(NSIndexPath *)indexPath bindData:(id)data;

@end

@interface UITableViewCell (YLT_Create)<YLT_TableViewCellProtocol>

/**
 当前行上绑定的数据
 */
@property (nonatomic, strong) id cellData;

/**
 绑定数据
 */
- (UITableViewCell *(^)(NSIndexPath *indexPath, id bindData))YLT_CellBindData;
/**
 处理UI
 */
- (UITableViewCell *(^)(void))YLT_CellConfigUI;
/**
 accessory type
 */
- (UITableViewCell *(^)(UITableViewCellAccessoryType accessoryType))YLT_AccessoryType;
/**
 左边image
 */
- (UITableViewCell *(^)(id leftImg))YLT_LeftImage;
/**
 左边标题
 */
- (UITableViewCell *(^)(NSString *title))YLT_Title;
/**
 详细标题
 */
- (UITableViewCell *(^)(NSString *subTitle))YLT_SubTitle;

@end
