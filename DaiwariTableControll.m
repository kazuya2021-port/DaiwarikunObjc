//
//  DaiwariTableControll.m
//  DaiwarikunObjc
//
//  Created by 内山　和也 on 平成28/03/09.
//  Copyright 2016 __MyCompanyName__. All rights reserved.
//

#import "DaiwariTableControll.h"


@implementation DaiwariTableControll
@synthesize tableDaiwari;
@synthesize daiData;

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
	daiData = [[NSMutableArray alloc] init];
	return self;
}


- (void)awakeFromNib
{
	[tableDaiwari setDataSource:self];
}

//----------------------------------------------------------------------------//
#pragma mark -
#pragma mark Funcs
//----------------------------------------------------------------------------//
- (void)setDaiwari
{
	[daiData removeAllObjects];
	int tp = [totalPage intValue];
	int sp = [startPage intValue];

	for(int i = sp; i < (tp + sp); i++)
	{
		[daiData addObject:ARRAY(@"0",[NSNumber numberWithInt:i])];
	}
	[tableDaiwari noteNumberOfRowsChanged];
	[tableDaiwari reloadData];
	return;
}

- (void)setPage:(NSMutableArray*)page withIndex:(NSIndexSet*)selectedRows
{
	NSUInteger idx = [selectedRows firstIndex];
	int pageIdx = 0;
	while (idx != NSNotFound)
	{
		NSArray* repObj = ARRAY([[daiData objectAtIndex:idx] objectAtIndex:0], [page objectAtIndex:pageIdx]);
		[daiData replaceObjectAtIndex:idx withObject:repObj];
		idx = [selectedRows indexGreaterThanIndex:idx];
		pageIdx++;
	}
	
	[tableDaiwari noteNumberOfRowsChanged];
	[tableDaiwari reloadData];
	return;	
}
- (void)setOri:(NSMutableArray*)ori
{
	for(int i = 0; i < [daiData count]; i++)
	{
		NSArray* repObj = ARRAY([ori objectAtIndex:i], [[daiData objectAtIndex:i] objectAtIndex:1]);
		[daiData replaceObjectAtIndex:i withObject:repObj];
	}
	[tableDaiwari noteNumberOfRowsChanged];
	[tableDaiwari reloadData];
	return;
}

- (void)setOri:(NSMutableArray*)ori withIndex:(NSIndexSet*)selectedRows
{
	NSUInteger idx = [selectedRows firstIndex];
	int oriIdx = 0;
	while (idx != NSNotFound)
	{
		NSArray* repObj = ARRAY([ori objectAtIndex:oriIdx], [[daiData objectAtIndex:idx] objectAtIndex:1]);
		[daiData replaceObjectAtIndex:idx withObject:repObj];
		idx = [selectedRows indexGreaterThanIndex:idx];
		oriIdx++;
	}

	[tableDaiwari noteNumberOfRowsChanged];
	[tableDaiwari reloadData];
	return;	
}
- (void)clearTableData
{
	[daiData removeAllObjects];
	[tableDaiwari noteNumberOfRowsChanged];
	[tableDaiwari reloadData];	
}

- (void)deleteSelectRow
{
	int selRow = [tableDaiwari selectedRow];
	[daiData removeObjectAtIndex:selRow];
	[tableDaiwari noteNumberOfRowsChanged];
	[tableDaiwari reloadData];
}

//----------------------------------------------------------------------------//
#pragma mark -
#pragma mark NSTableView DataSource
//----------------------------------------------------------------------------//
- (int)numberOfRowsInTableView:(NSTableView *)aTableView
{
	if (aTableView == tableDaiwari)
	{
		return [daiData count];
	}
	return 0;
}

- (id)tableView:(NSTableView *)aTableView
objectValueForTableColumn:(NSTableColumn *)aTableColumn
			row:(int)rowIndex
{
	if (aTableView == tableDaiwari) 
	{
		// 番号の列
		if([[aTableColumn identifier] isEqualToString:@"Number"]) 
		{
			return [NSNumber numberWithInt:rowIndex + 1];
		}
		// 折の列
		else if([[aTableColumn identifier] isEqualToString:@"Ori"]) 
		{
			return [[daiData objectAtIndex:rowIndex] objectAtIndex:0];
		}
		// ページの列
		else if([[aTableColumn identifier] isEqualToString:@"Page"]) 
		{
			return [[daiData objectAtIndex:rowIndex] objectAtIndex:1];
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
    if (aTableView == tableDaiwari) 
	{
		NSMutableArray* setData = [NSMutableArray array];
		NSMutableArray* curData = [daiData objectAtIndex:rowIndex];
		
		if ([[aTableColumn identifier] isEqualToString:@"Ori"])
		{
			[setData addObject:anObject];
			[setData addObject:[curData objectAtIndex:1]];
		}
		else if ([[aTableColumn identifier] isEqualToString:@"Page"])
		{
			[setData addObject:[curData objectAtIndex:0]];
			[setData addObject:anObject];
		}
        [daiData replaceObjectAtIndex:rowIndex withObject:setData];
	}
	
}

@end
