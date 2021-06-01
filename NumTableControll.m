//
//  NumListControll.m
//  DaiwarikunObjc
//
//  Created by 内山　和也 on 平成28/03/04.
//  Copyright 2016 __MyCompanyName__. All rights reserved.
//

#import "NumTableControll.h"
#import "NaosiData.h"

@implementation NumTableControll
@synthesize tableNumList;
@synthesize numData;


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
	numData = [[NSMutableArray alloc] init];
	return self;
}


- (void)awakeFromNib
{
	[tableNumList setDelegate:self];
	[tableNumList setDataSource:self];
}

//----------------------------------------------------------------------------//
#pragma mark -
#pragma mark InternalFuncs
//----------------------------------------------------------------------------//
- (int)getSlashPos:(NSString*)str
{
	NSRange rng = [str rangeOfString:@"/"];
	if(rng.location == NSNotFound) return -1;
	return rng.location;
}
- (int)getHaifunPos:(NSString*)str
{
	NSRange rng = [str rangeOfString:@"-"];
	if(rng.location == NSNotFound) return -1;
	return rng.location;
}
- (BOOL)checkDuplicate:(int)np
{
	BOOL ret = NO;
	for(int i = 0; i < [numData count]; i++)
	{
		int n = [[numData objectAtIndex:i] naosiPage];
		if(n == np) 
		{
			ret = YES; 
			break;
		}
	}
	return ret;
}

//----------------------------------------------------------------------------//
#pragma mark -
#pragma mark Funcs
//----------------------------------------------------------------------------//
- (void)setNumDataFromTextBox:(NSString*)val segment:(NSNumber*)seg
{	
	int sPos = [self getSlashPos:val];
	int hPos = [self getHaifunPos:val];
	if(sPos != -1)
	{
		NSString* startNum = [val substringToIndex:sPos];
		NSString* endNum = [val substringFromIndex:sPos+1];

		for(int i = [startNum intValue]; i<=[endNum intValue]; i++)
		{
			if(i % 2 == 1)
			{
				if ([self checkDuplicate:i] == NO) {
					NaosiData* dData = [[[NaosiData alloc] init] autorelease];
					dData.naosiPage = i;
					dData.naosiStyle = seg;
					[numData addObject:dData];
				}
			}
		}
	}
	else if (hPos != -1)
	{
		NSString* startNum = [val substringToIndex:hPos];
		NSString* endNum = [val substringFromIndex:hPos+1];

		for(int i = [startNum intValue]; i<=[endNum intValue]; i++)
		{
			if ([self checkDuplicate:i] == NO) {
				NaosiData* dData = [[[NaosiData alloc] init] autorelease];
				dData.naosiPage = i;
				dData.naosiStyle = seg;
				[numData addObject:dData];
			}
		}
	}
	else {
		if ([self checkDuplicate:[val intValue]] == NO) {
			NaosiData* dData = [[[NaosiData alloc] init] autorelease];
			dData.naosiPage = [val intValue];
			dData.naosiStyle = seg;
			[numData addObject:dData];
		}
	}
	
	NSSortDescriptor *sortDispNo = [[NSSortDescriptor alloc] initWithKey:@"naosiPage" ascending:YES];  
	NSArray *sortDescArray = [NSArray arrayWithObjects:sortDispNo, nil];  
	
	NSArray* sortedArray = [numData sortedArrayUsingDescriptors:sortDescArray];  
	
	numData = [sortedArray mutableCopy];
	
	[tableNumList noteNumberOfRowsChanged];
	[tableNumList reloadData];
}

- (void)clearTableData
{
	[numData removeAllObjects];
	[tableNumList noteNumberOfRowsChanged];
	[tableNumList reloadData];	
}

- (void)deleteSelectRow
{
	int selRow = [tableNumList selectedRow];
	[numData removeObjectAtIndex:selRow];
	[tableNumList noteNumberOfRowsChanged];
	[tableNumList reloadData];
}

//----------------------------------------------------------------------------//
#pragma mark -
#pragma mark NSTableView DataSource
//----------------------------------------------------------------------------//
- (int)numberOfRowsInTableView:(NSTableView *)aTableView
{
	if (aTableView == tableNumList)
	{
		return [numData count];
	}
	return 0;
}

- (id)tableView:(NSTableView *)aTableView
objectValueForTableColumn:(NSTableColumn *)aTableColumn
			row:(int)rowIndex
{
	if (aTableView == tableNumList) 
	{
		// ページの列
		if([[aTableColumn identifier] isEqualToString:@"Page"]) 
		{
			return [NSString stringWithFormat:@"%d",[[numData objectAtIndex:rowIndex] naosiPage]];
		}
		// ファイル名の列
		else if([[aTableColumn identifier] isEqualToString:@"Style"]) 
		{
			return [[numData objectAtIndex:rowIndex] naosiStyle];
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
    if (aTableView == tableNumList) 
	{
		NaosiData* setData = [[[NaosiData alloc] init] autorelease];
		NaosiData* curData = [numData objectAtIndex:rowIndex];
		if ([[aTableColumn identifier] isEqualToString:@"Page"])
		{
			[setData setNaosiPage:[anObject intValue]];
			[setData setNaosiStyle:[curData naosiStyle]];
		}
		else if ([[aTableColumn identifier] isEqualToString:@"Style"])
		{
			[setData setNaosiPage:[curData naosiPage]];
			[setData setNaosiStyle:anObject];
		}
        [numData replaceObjectAtIndex:rowIndex withObject:setData];
	}
		
}

//----------------------------------------------------------------------------//
#pragma mark -
#pragma mark NSTableView Delegate
//----------------------------------------------------------------------------//
- (NSCell *)tableView:(NSTableView *)tableView 
dataCellForTableColumn:(NSTableColumn *)tableColumn 
				  row:(NSInteger)row
{
	if([[tableColumn identifier] isEqualToString:@"Style"])
	{
		NSSegmentedCell *mcell = [[[NSSegmentedCell alloc] init]autorelease];
		[mcell setControlSize:NSMiniControlSize];
		[mcell setSegmentCount:3];
		[mcell segmentStyle];
		[mcell setSegmentStyle:NSSegmentStyleTexturedSquare];
		[mcell setWidth:25.0 forSegment:0];
		[mcell setWidth:25.0 forSegment:1];
		[mcell setWidth:25.0 forSegment:2];
		[mcell setLabel:@"塗" forSegment:0];
		[mcell setLabel:@"合" forSegment:1];
		[mcell setLabel:@"枠" forSegment:2];
		return mcell;
	}
	return nil;
}
@end
