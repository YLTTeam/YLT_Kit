//
//  YLT_PageModel+Extension.h
//  App
//
//  Created by 項普華 on 2020/3/10.
//  Copyright © 2020 Alex. All rights reserved.
//

#import "YLT_PageModel.h"

@interface YLT_SectionModel (Extension)

/** insets */
@property (nonatomic, assign, readonly) UIEdgeInsets appInsets;

/** spacing */
@property (nonatomic, assign) CGFloat appSpacing;

/** size */
@property (nonatomic, assign, readonly) CGSize rowSize;

/** header size */
@property (nonatomic, assign, readonly) CGSize headerSize;
/** footer size */
@property (nonatomic, assign, readonly) CGSize footerSize;

@end
