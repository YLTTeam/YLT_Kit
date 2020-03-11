//
//  AppView+DataSource.h
//  App
//
//  Created by 項普華 on 2019/10/31.
//  Copyright © 2019 Alex. All rights reserved.
//

#import "AppView.h"
#import <JJCollectionViewRoundFlowLayout/JJCollectionViewRoundFlowLayout.h>

@interface AppView (DataSource)<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, JJCollectionViewDelegateRoundFlowLayout>

- (void)registerMainCollection:(UICollectionView *)mainCollection;

@end


