//
//  LayoutListControll.m
//  DaiwarikunObjc
//
//  Created by 内山　和也 on 平成28/03/08.
//  Copyright 2016 __MyCompanyName__. All rights reserved.
//

#import "LayoutListControll.h"


@implementation LayoutListControll

#define ARRAY(first, ...) [NSArray arrayWithObjects: first, ##__VA_ARGS__ , nil]
#define APPEND_STR(first, ...) [[[NSArray arrayWithObjects: first, ##__VA_ARGS__ , nil] componentsJoinedByString:@","] stringByReplacingOccurrencesOfString:@"," withString:@""]
#define ANDP stringByAppendingPathComponent:
//----------------------------------------------------------------------------//
#pragma mark -
#pragma mark Initialization
//----------------------------------------------------------------------------//
- (id)init
{
	self = [super init];
	if (!self) 
	{
		return nil;
	}
	layouts = [[NSMutableArray alloc] init];
	return self;
}


- (void)awakeFromNib
{
}

//----------------------------------------------------------------------------//
#pragma mark -
#pragma mark Accsesser
//----------------------------------------------------------------------------//
- (NSMutableArray*)layouts
{
	return layouts;
}

//----------------------------------------------------------------------------//
#pragma mark -
#pragma mark InternalFuncs
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
#pragma mark -
#pragma mark Funcs
//----------------------------------------------------------------------------//

// ファイル一覧を取得
-(NSArray *)getFileList:(NSString *)extension
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    NSFileManager* fileManager = [[NSFileManager alloc] init];
    NSString *path = [[NSBundle mainBundle] bundlePath];
	path = [path stringByAppendingPathComponent:@"Contents/Resources"];
    for(NSString *content in [fileManager contentsOfDirectoryAtPath:path error:nil]) {
        if ([content hasSuffix:extension]) {
            [array addObject:content];
        }
    }
    return array;
}

// レイアウトファイル読み込み
- (void)readLayoutFile:(NSArray*)files
{
	NSString *path = [[NSBundle mainBundle] bundlePath];
	path = [path ANDP@"Contents/Resources"];
	for(int i = 0; i < [files count]; i++)
	{
		NSString* curFile = [path ANDP[files objectAtIndex:i]];
		NSString* layData = [[NSString alloc] initWithContentsOfFile:curFile encoding:NSUTF8StringEncoding error:nil];//[self runCommand:[NSString stringWithFormat:@"cat \"%@\"",curFile]];
		NSMutableArray *lines = [NSMutableArray array];
		[layData enumerateLinesUsingBlock:^(NSString *line, BOOL *stop) {
			[lines addObject:line];
		}];
		BOOL isName = NO;
		BOOL isPage = NO;
		BOOL isHeight = NO;
		BOOL isTitle = NO;
		BOOL isOriCount = NO;
		BOOL isFront = NO;
		BOOL isBack = NO;
		BOOL isYouso = NO;
		
		NSMutableArray* layoutFront = [NSMutableArray array];
		NSMutableArray* layoutBack = [NSMutableArray array];
		NSMutableDictionary* layInfo = [NSMutableDictionary dictionary];
		
		for(int j = 0; j < [lines count]; j++)
		{
			NSString* line = [lines objectAtIndex:j];
			if(isName)
			{
				[layInfo setObject:line forKey:@"name"];
				isName = NO;
				[layoutList addItemWithTitle:line];
				continue;
			}
			
			if(isPage)
			{
				[layInfo setObject:line forKey:@"page"];
				isPage = NO;
				continue;
			}
			
			if(isHeight)
			{
				[layInfo setObject:line forKey:@"height"];
				isHeight = NO;
				continue;
			}
			
			if(isTitle)
			{
				[layInfo setObject:line forKey:@"title"];
				isTitle = NO;
				continue;
			}
			
			if(isOriCount)
			{
				[layInfo setObject:line forKey:@"ori"];
				isOriCount = NO;
				continue;
			}
			
			if(isYouso)
			{
				[layInfo setObject:line forKey:@"youso"];
				isYouso = NO;
				continue;
			}
			
			if(isFront)
			{
				if ([line isEqualToString:@"裏"]) {
					NSMutableArray* lastLayout = [NSMutableArray array];
					for(int k = 0; k < [layoutFront count]; k++)
					{
						NSMutableArray* cur = [layoutFront objectAtIndex:k];
						for(int l = 0; l < [cur count]; l++)
						{
							[lastLayout addObject:[cur objectAtIndex:l]];
						}
					}
					[layInfo setObject:lastLayout forKey:@"F"];
					isFront = NO;
					isBack = YES;
					continue;
				}
				
				NSArray* splitted = [line componentsSeparatedByString:@","];
				NSMutableArray* layNum = [NSMutableArray array];
				for(NSString* obj in splitted)
				{
					[layNum addObject:[obj stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
				}
				[layoutFront addObject:[layNum copy]];
				
				if (j == ([lines count] - 1)) {
					NSMutableArray* lastLayout = [NSMutableArray array];
					for(int k = 0; k < [layoutFront count]; k++)
					{
						NSMutableArray* cur = [layoutFront objectAtIndex:k];
						for(int l = 0; l < [cur count]; l++)
						{
							[lastLayout addObject:[cur objectAtIndex:l]];
						}
					}
					[layInfo setObject:lastLayout forKey:@"F"];
					[layInfo setObject:[NSMutableArray array] forKey:@"B"];
					isFront = NO;
				}
				continue;
			}
			
			if (isBack) {
				NSArray* splitted = [line componentsSeparatedByString:@","];
				NSMutableArray* layNum = [NSMutableArray array];
				for(NSString* obj in splitted)
				{
					[layNum addObject:[obj stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
				}
				[layoutBack addObject:[layNum copy]];
				
				if (j == ([lines count] - 1)) {
					NSMutableArray* lastLayout = [NSMutableArray array];
					for(int k = 0; k < [layoutBack count]; k++)
					{
						NSMutableArray* cur = [layoutBack objectAtIndex:k];
						for(int l = 0; l < [cur count]; l++)
						{
							[lastLayout addObject:[cur objectAtIndex:l]];
						}
					}
					[layInfo setObject:lastLayout forKey:@"B"];
					isBack = NO;
					break;
				}
				continue;
			}
			if ([line isEqualToString:@"名前"]) {
				isName = YES;
				continue;
			}
			if ([line isEqualToString:@"総ページ数"]) {
				isPage = YES;
				continue;
			}
			if ([line isEqualToString:@"高さ"]) {
				isHeight = YES;
				continue;
			}
			if ([line isEqualToString:@"見出し"]) {
				isTitle = YES;
				continue;
			}
			if ([line isEqualToString:@"折数"]) {
				isOriCount = YES;
				continue;
			}
			if ([line isEqualToString:@"要素数"]) {
				isYouso = YES;
				continue;
			}
			if ([line isEqualToString:@"表"]) {
				isFront = YES;
				continue;
			}
			if ([line isEqualToString:@"裏"]) {
				isBack = YES;
				continue;
			}
		}
		[layouts addObject:layInfo];
	}
	return;
}
@synthesize layoutList;
@synthesize layouts;
@end
