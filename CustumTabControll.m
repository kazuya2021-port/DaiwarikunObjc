//
//  CustumTabControll.m
//  DaiwarikunObjc
//
//  Created by 内山　和也 on 平成28/03/10.
//  Copyright 2016 __MyCompanyName__. All rights reserved.
//

#import "CustumTabControll.h"


@implementation CustumTabControll

-(IBAction)addLayout:(id)sender
{
	NSString* selLay = [[layoutList selectedItem] title];
	int lCount = [layoutCount intValue];
	[layCtrl addLayout:selLay layoutCount:lCount];
	[clearLayoutTable setEnabled:YES];
	[appendLayoutTable setEnabled:YES];
	[layoutCount setStringValue:@""];
}
-(IBAction)appendLayout:(id)sender
{
	[appendLayoutTable setEnabled:NO];
	[clearDaiwariTable setEnabled:YES];
	// 総ページ計算
	NSMutableArray* lays = [layCtrl layData];
	NSMutableArray* layInfos = [layCtrl getLayoutInfo];
	int pageCount = 0;
	for (NSString* lay in lays)
	{
		for(NSMutableDictionary* info in layInfos)
		{
			if([lay isEqualToString:[info objectForKey:@"name"]])
			{
				pageCount += [[info objectForKey:@"page"] intValue];
			}
		}
	}
	NSLog(@"計%dページ",pageCount);
	[totalPage setStringValue:[NSString stringWithFormat:@"%d",pageCount]];
	[daiCtrl setDaiwari];
	[layCtrl setLayout:[lays copy]];
}
-(IBAction)clearLayout:(id)sender
{
	[layCtrl clearTableData];
	[clearLayoutTable setEnabled:NO];
}
-(IBAction)updateOri:(id)sender
{
	NSMutableArray* oriData = [NSMutableArray array];
	NSIndexSet* selectedRows = [daitbl selectedRowIndexes];
	NSMutableArray* daiData = [daiCtrl daiData];
	NSUInteger idx = [selectedRows firstIndex];
	NSString* setNum = [oriNum stringValue];

	if ([[setNum substringToIndex:1] isEqualToString:@"+"]) {
		while (idx != NSNotFound)
		{	
			int cur = [[[daiData objectAtIndex:idx] objectAtIndex:0] intValue];
			int padd = [[setNum substringFromIndex:1] intValue];
			[oriData addObject:[NSString stringWithFormat:@"%d",(cur + padd)]];
			
			idx = [selectedRows indexGreaterThanIndex:idx];
		}
	}
	else if ([[setNum substringToIndex:1] isEqualToString:@"-"]) {
		while (idx != NSNotFound)
		{	
			int cur = [[[daiData objectAtIndex:idx] objectAtIndex:0] intValue];
			int padd = [[setNum substringFromIndex:1] intValue];
			[oriData addObject:[NSString stringWithFormat:@"%d",(cur - padd)]];
			
			idx = [selectedRows indexGreaterThanIndex:idx];
		}
	}
	else {
		while (idx != NSNotFound)
		{	
			[oriData addObject:[oriNum stringValue]];
			idx = [selectedRows indexGreaterThanIndex:idx];
		}
	}
	[daiCtrl setOri:oriData withIndex:selectedRows];
}
-(IBAction)updatePage:(id)sender
{
	NSMutableArray* pageData = [NSMutableArray array];
	NSIndexSet* selectedRows = [daitbl selectedRowIndexes];
	NSMutableArray* daiData = [daiCtrl daiData];
	NSUInteger idx = [selectedRows firstIndex];
	NSString* setNum = [pageNum stringValue];
	
	if ([[setNum substringToIndex:1] isEqualToString:@"+"]) {
		while (idx != NSNotFound)
		{	
			int cur = [[[daiData objectAtIndex:idx] objectAtIndex:1] intValue];
			int padd = [[setNum substringFromIndex:1] intValue];
			[pageData addObject:[NSString stringWithFormat:@"%d",(cur + padd)]];
			
			idx = [selectedRows indexGreaterThanIndex:idx];
		}
	}
	else if ([[setNum substringToIndex:1] isEqualToString:@"-"]) {
		while (idx != NSNotFound)
		{	
			int cur = [[[daiData objectAtIndex:idx] objectAtIndex:1] intValue];
			int padd = [[setNum substringFromIndex:1] intValue];
			[pageData addObject:[NSString stringWithFormat:@"%d",(cur - padd)]];
			
			idx = [selectedRows indexGreaterThanIndex:idx];
		}
	}
	else {
		while (idx != NSNotFound)
		{	
			[pageData addObject:[NSString stringWithFormat:@"%d",(idx + [pageNum intValue])]];
			idx = [selectedRows indexGreaterThanIndex:idx];
		}
	}
	[daiCtrl setPage:pageData withIndex:selectedRows];
}
-(IBAction)clearDaiwari:(id)sender
{
	[daiCtrl clearTableData];
	[appendLayoutTable setEnabled:YES];
	[clearDaiwariTable setEnabled:NO];
}
@end
