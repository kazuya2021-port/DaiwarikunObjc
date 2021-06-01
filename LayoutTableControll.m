//
//  LayoutTableControll.m
//  DaiwarikunObjc
//
//  Created by 内山　和也 on 平成28/03/09.
//  Copyright 2016 __MyCompanyName__. All rights reserved.
//

#import "LayoutTableControll.h"
#import "LayoutFuncs.h"

@implementation LayoutTableControll
@synthesize tableLayout;
@synthesize layData;

#define ARRAY(first, ...) [NSArray arrayWithObjects: first, ##__VA_ARGS__ , nil]

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
	layData = [[NSMutableArray alloc] init];
	return self;
}


- (void)awakeFromNib
{
	[tableLayout setDataSource:self];
}

//----------------------------------------------------------------------------//
#pragma mark -
#pragma mark Funcs
//----------------------------------------------------------------------------//
- (void)addLayout:(NSString*)layName layoutCount:(int)laycount
{
	for(int i = 0; i < laycount; i++)
	{
		[layData addObject:layName];
	}
	[tableLayout noteNumberOfRowsChanged];
	[tableLayout reloadData];
}

- (void)setLayout:(NSArray*)ar
{
	[layData removeAllObjects];
	layData = [ar mutableCopy];
	
	[tableLayout noteNumberOfRowsChanged];
	[tableLayout reloadData];
	// 折の作成
	NSMutableArray* ori = [LayoutFuncs makeOriCount:[layData copy] list:[layoutList layouts]];
	[daiCtrl setOri:ori];
	return;
}

- (NSMutableArray*)getLayoutInfo
{
	return [layoutList layouts];
}

- (void)clearTableData
{
	[layData removeAllObjects];
	[tableLayout noteNumberOfRowsChanged];
	[tableLayout reloadData];	
}

- (void)deleteSelectRow
{
	int selRow = [tableLayout selectedRow];
	[layData removeObjectAtIndex:selRow];
	[tableLayout noteNumberOfRowsChanged];
	[tableLayout reloadData];
}

//----------------------------------------------------------------------------//
#pragma mark -
#pragma mark NSTableView DataSource
//----------------------------------------------------------------------------//
- (int)numberOfRowsInTableView:(NSTableView *)aTableView
{
	if (aTableView == tableLayout)
	{
		return [layData count];
	}
	return 0;
}

- (id)tableView:(NSTableView *)aTableView
objectValueForTableColumn:(NSTableColumn *)aTableColumn
			row:(int)rowIndex
{
	if (aTableView == tableLayout) 
	{
		// レイアウト列
		if([[aTableColumn identifier] isEqualToString:@"layout"]) 
		{
			return [layData objectAtIndex:rowIndex];
		}
	}
	
	// ここには来ないはず
	return nil;
}

- (void)tableView:(NSTableView *)aTableView 
   setObjectValue:(id)anObject
   forTableColumn:(NSTableColumn *)aTableColumn 
			  row:(int)rowIndex 
{
    if (aTableView == tableLayout) 
	{
		if ([[aTableColumn identifier] isEqualToString:@"layout"])
		{
			NSString* setData = (NSString*)anObject;
	        [layData replaceObjectAtIndex:rowIndex withObject:setData];
		}
	}
	
}
@end
