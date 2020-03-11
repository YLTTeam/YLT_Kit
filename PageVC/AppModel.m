//
// AppModel.m 
//
// Created By 项普华 Version: 2.0
// Copyright (C) 2020/03/11  By AlexXiang  All rights reserved.
// email:// xiangpuhua@126.com  tel:// +86 13316987488 
//
//

#import "AppModel.h"
#import <MJExtension/MJExtension.h>
#import <YLT_BaseLib/YLT_BaseLib.h>
#import "PHRequest.h"




@implementation AppHeaderModel

- (id)init {
	self = [super init];
	if (self) {
		self.height = 0;
		self.classname = @"";
		self.cellIdentify = @"";
		self.title = @"";
		self.rightTitle = @"";
		self.clickAction = @"";
		self.top = 0;
		self.bottom = 0;
		self.left = 0;
		self.right = 0;
		self.data = nil;
	}
	return self;
}

+ (NSDictionary *)ylt_keyMapper {
	NSMutableDictionary *result = [super ylt_keyMapper].mutableCopy;
	[result addEntriesFromDictionary: @{
			@"classname":@[@"class"],
				}];
	return result;
}

+ (NSDictionary *)ylt_classInArray {
	NSMutableDictionary *result = [super ylt_classInArray].mutableCopy;
	[result addEntriesFromDictionary: @{
				}];
	return result;
}

@end


@implementation AppFooterModel

- (id)init {
	self = [super init];
	if (self) {
	}
	return self;
}

+ (NSDictionary *)ylt_keyMapper {
	NSMutableDictionary *result = [super ylt_keyMapper].mutableCopy;
	[result addEntriesFromDictionary: @{
				}];
	return result;
}

+ (NSDictionary *)ylt_classInArray {
	NSMutableDictionary *result = [super ylt_classInArray].mutableCopy;
	[result addEntriesFromDictionary: @{
				}];
	return result;
}

@end


@implementation AppSectionModel

- (id)init {
	self = [super init];
	if (self) {
		self.headerModel = nil;
		self.footerModel = nil;
		self.classname = @"";
		self.dataTag = @"";
		self.list = [[NSMutableArray alloc] init];
		self.sectionRows = 0;
		self.background = @"";
		self.cellIdentify = @"";
		self.clickAction = @"";
		self.top = 0;
		self.bottom = 0;
		self.left = 0;
		self.right = 0;
		self.width = 0;
		self.height = 0;
		self.ratio = 1.778;
		self.columCount = 1;
		self.spacing = 8;
		self.customType = 0;
		self.extraData = nil;
	}
	return self;
}

+ (NSDictionary *)ylt_keyMapper {
	NSMutableDictionary *result = [super ylt_keyMapper].mutableCopy;
	[result addEntriesFromDictionary: @{
			@"headerModel":@[@"header"],
			@"footerModel":@[@"footer"],
			@"classname":@[@"class"],
			@"dataTag":@[@"data"],
				}];
	return result;
}

+ (NSDictionary *)ylt_classInArray {
	NSMutableDictionary *result = [super ylt_classInArray].mutableCopy;
	[result addEntriesFromDictionary: @{
			@"list":@"YLT_BaseModel",
				}];
	return result;
}

@end


@implementation AppPageModel

- (id)init {
	self = [super init];
	if (self) {
		self.page = [[NSMutableArray alloc] init];
		self.title = @"";
		self.localData = nil;
	}
	return self;
}

+ (NSDictionary *)ylt_keyMapper {
	NSMutableDictionary *result = [super ylt_keyMapper].mutableCopy;
	[result addEntriesFromDictionary: @{
			@"localData":@[@"data"],
				}];
	return result;
}

+ (NSDictionary *)ylt_classInArray {
	NSMutableDictionary *result = [super ylt_classInArray].mutableCopy;
	[result addEntriesFromDictionary: @{
			@"page":@"AppSectionModel",
				}];
	return result;
}

@end
