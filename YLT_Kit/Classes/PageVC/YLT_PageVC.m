//
//  YLT_PageVC.m
//  App
//
//  Created by 項普華 on 2019/11/4.
//  Copyright © 2019 Alex. All rights reserved.
//

#import "YLT_PageVC.h"
#import "NSArray+AppPage.h"

@interface YLT_PageVC ()

@end

@implementation YLT_PageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.bgColor;
}

- (void)reloadData {
    if (self.pageModel.title.ylt_isValid) {
        self.title = self.pageModel.title;
        self.bcBar.title = self.pageModel.title;
    }
    if (self.pageModel.page.count == 0) {
        return;
    }
    for (YLT_SectionModel *model in self.pageModel.page) {
        if (model.classname.ylt_isValid && NSClassFromString(model.classname) != NULL) {
            Class cls = NSClassFromString(model.classname);
            [model.list removeAllObjects];
            if ([model.dataTag hasPrefix:@"$"]) {
                //取的数据在本地能直接取出
                NSArray *dataList = [self.pageModel.localData objectForKey:[model.dataTag substringFromIndex:1]];
                if ([dataList isKindOfClass:[NSDictionary class]]) {
                    dataList = @[dataList];
                }
                if ([dataList isKindOfClass:[NSArray class]]) {
                    [dataList enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [model.list addObject:[cls mj_objectWithKeyValues:obj]];
                    }];
                }
            } else if ([model.dataTag hasPrefix:@"&"]) {
                //取的数据是本地的变量
                id obj = YLT_RouterQuick([model.dataTag substringFromIndex:1], nil);
                if ([obj isKindOfClass:[NSArray class]]) {
                    [model.list addObjectsFromArray:obj];
                } else if (obj) {
                    [model.list addObject:obj];
                }
            } else {
                //本地数据
                YLT_Log(@"待适配");
            }
            
            //进行表头、表尾的配置
            if (model.list.count != 0) {
                model.list.firstObject.ylt_isFirst = YES;
                model.list.lastObject.ylt_isLast = YES;
            }
            //表头、表尾配置结束
        }
    }
    self.mainView.pageModel = self.pageModel;
    

    
    
//    NSArray *layouts = [self.pageObject objectForKey:@"page"];
//    NSDictionary *datas = [self.pageObject objectForKey:@"data"];
//    
//    NSMutableArray<NSMutableArray<YLT_BaseModel *> *> *list = [[NSMutableArray alloc] init];
//    for (NSDictionary *layout in layouts) {
//        NSString *class = layout[@"class"];
//        NSString *dataTag = layout[@"data"];
//        
//        if (class.ylt_isValid && NSClassFromString(class) != NULL) {
//            Class cls = NSClassFromString(class);
//            NSMutableArray<YLT_BaseModel *> *models = [[NSMutableArray alloc] init];
//            
//            if ([dataTag hasPrefix:@"$"]) {
//                //取的数据在本地能直接取出
//                NSArray *dataList = [datas objectForKey:[dataTag substringFromIndex:1]];
//                if ([dataList isKindOfClass:[NSDictionary class]]) {
//                    dataList = @[dataList];
//                }
//                if ([dataList isKindOfClass:[NSArray class]]) {
//                    [dataList enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                        [models addObject:[cls mj_objectWithKeyValues:obj]];
//                    }];
//                }
//            } else if ([dataTag hasPrefix:@"&"]) {
//                //取的数据是本地的变量
//                id obj = YLT_RouterQuick([dataTag substringFromIndex:1], nil);
//                if ([obj isKindOfClass:[NSArray class]]) {
//                    [models addObjectsFromArray:obj];
//                } else if (obj) {
//                    [models addObject:obj];
//                }
//            } else {
//                //本地数据
//                YLT_Log(@"待适配");
//            }
//            
//            //进行表头、表尾的配置
//            if (models.count != 0) {
//                [list addObject:models];
//                models.firstObject.ylt_isFirst = YES;
//                models.lastObject.ylt_isLast = YES;
//                models.headerSource = layout;
//            }
//            //表头、表尾配置结束
//        }
//    }
//    
//    self.pageList = [self resetList:list];
}

- (UIEdgeInsets)resetInsets:(UIEdgeInsets)edgeInsets section:(NSInteger)section {
    return edgeInsets;
}

- (CGFloat)resetMinimumLineSpacing:(CGFloat)spacing section:(NSInteger)section {
    return spacing;
}

- (CGFloat)resetMinimumInteritemSpacing:(CGFloat)spacing section:(NSInteger)section {
    return spacing;
}

- (CGSize)resetHeaderSize:(CGSize)headerSize section:(NSInteger)section {
    return headerSize;
}

- (CGSize)resetFooterSize:(CGSize)footerSize section:(NSInteger)section {
    return footerSize;
}

- (CGSize)resetCellSize:(CGSize)cellSize indexPath:(NSIndexPath *)indexPath {
    return cellSize;
}

- (NSInteger)resetSectionCount:(NSInteger)sectionCount {
    return sectionCount;
}

- (NSInteger)resetRowCount:(NSInteger)rowCount section:(NSInteger)section {
    return rowCount;
}

- (JJCollectionViewRoundConfigModel *)resetRoundConfigModel:(JJCollectionViewRoundConfigModel *)model configModelForSectionAtIndex:(NSInteger)section {
    return model;
}

- (YLT_PageReusableView *)resetReusable:(YLT_PageReusableView *)reusable indexPath:(NSIndexPath *)indexPath {
    return reusable;
}

- (YLT_PageCell *)resetCell:(YLT_PageCell *)cell indexPath:(NSIndexPath *)indexPath {
    return cell;
}

- (BOOL)selectedCell:(YLT_PageCell *)cell indexPath:(NSIndexPath *)indexPath {
    return NO;
}

/// 对组装好的数据做修改，慎用
/// @param list 数据
- (NSMutableArray<NSMutableArray<YLT_BaseModel *> *> *)resetList:(NSMutableArray<NSMutableArray<YLT_BaseModel *> *> *)list {
    return list;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (YLT_PageBaseView *)mainView {
    if (!_mainView) {
        _mainView = [[YLT_PageBaseView alloc] init];
        [self.view addSubview:_mainView];
        CGFloat top = 0;
        CGFloat bottom = 0;
        if (self.navigationController.viewControllers.count > 1) {
            top = NAVIGATION_BAR_HEIGHT;
            bottom = HOME_INDICATOR_HEIGHT;
        }
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(top, 0, bottom, 0));
        }];
        
        [self reloadData];
    }
    return _mainView;
}

- (NSDictionary *)pageObject {
    if (!_pageObject) {
        NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass(self.class) ofType:@"geojson"];
        _pageObject = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingAllowFragments error:nil];
    }
    return _pageObject;
}

- (YLT_PageModel *)pageModel {
    if (!_pageModel) {
        NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass(self.class) ofType:@"geojson"];
        NSDictionary *allPages = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingAllowFragments error:nil];
        _pageModel = [YLT_PageModel mj_objectWithKeyValues:allPages];
        NSArray<NSDictionary *> *pages = allPages[@"page"];
        [_pageModel.page enumerateObjectsUsingBlock:^(YLT_SectionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *sectionDic = pages[idx];
            if (obj.headerModel.classname.ylt_isValid && NSClassFromString(obj.headerModel.classname) != NULL) {
                obj.headerModel.data = [NSClassFromString(obj.headerModel.classname) mj_objectWithKeyValues:sectionDic[@"header"]];
            }
            if (obj.footerModel.classname.ylt_isValid && NSClassFromString(obj.footerModel.classname) != NULL) {
                obj.footerModel.data = [NSClassFromString(obj.footerModel.classname) mj_objectWithKeyValues:sectionDic[@"footer"]];
            }
        }];
    }
    return _pageModel;
}

@end
