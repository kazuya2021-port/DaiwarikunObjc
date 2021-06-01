//
//  LayoutFuncs.m
//  DaiwarikunObjc
//
//  Created by 内山　和也 on 平成28/03/09.
//  Copyright 2016 __MyCompanyName__. All rights reserved.
//

#import "LayoutFuncs.h"


@implementation LayoutFuncs
#define ARRAY(first, ...) [NSArray arrayWithObjects: first, ##__VA_ARGS__ , nil]
#define INT2STR(in) [NSString stringWithFormat:@"%d",in]

//----------------------------------------------------------------------------//
#pragma mark -
#pragma mark InternalFuncs
//----------------------------------------------------------------------------//
+ (NSArray*)searchLayPosBai:(NSMutableArray*)arrLayF Blay:(NSMutableArray*)arrLayB num:(int)j
{
	BOOL found = NO;
	NSMutableArray* ret = [NSMutableArray array];
	for(int i = 0; i < [arrLayF count]; i++)
	{
		int arrData = [[arrLayF objectAtIndex:i] intValue];
		if(arrData == j)
		{
			if(!found){
				[ret addObject:[NSString stringWithFormat:@"F%d",i]];
				found = YES;
			}
			else {
				[ret addObject:[NSString stringWithFormat:@"F%d",i]];
				break;
			}
		}
	}
	if ([ret count] == 0) {
		for(int i = 0; i < [arrLayB count]; i++)
		{
			int arrData = [[arrLayB objectAtIndex:i] intValue];
			if(arrData == j)
			{
				if(!found){
					[ret addObject:[NSString stringWithFormat:@"B%d",i]];
					found = YES;
				}
				else {
					[ret addObject:[NSString stringWithFormat:@"B%d",i]];
					break;
				}
			}
		}
	}
	return [ret copy];
}

+ (NSArray*)searchLayPos:(NSMutableArray*)arrLayF Blay:(NSMutableArray*)arrLayB num:(int)j
{
	NSMutableArray* ret = [NSMutableArray array];
	for(int i = 0; i < [arrLayF count]; i++)
	{
		int arrData = [[arrLayF objectAtIndex:i] intValue];
		if(arrData == j)
		{
			[ret addObject:[NSString stringWithFormat:@"F%d",i]];
			break;
		}
	}
	if([ret count] == 0)
	{
		for(int i = 0; i < [arrLayB count]; i++)
		{
			int arrData = [[arrLayB objectAtIndex:i] intValue];
			if(arrData == j)
			{
				[ret addObject:[NSString stringWithFormat:@"B%d",i]];
				break;
			}
		}
	}
	return [ret copy];
}


+ (NSArray*)getPageLayoutPos:(NSMutableDictionary*)selLay
{
	NSMutableArray* ret = [NSMutableArray array];
	for(int i = 1; i < ([[selLay objectForKey:@"page"] intValue] + 1); i++)
	{
		NSRange rng = [[selLay objectForKey:@"name"] rangeOfString:@"倍"];
		if (rng.location != NSNotFound) {
			[ret addObject:[[self searchLayPosBai:[selLay objectForKey:@"F"] Blay:[selLay objectForKey:@"B"] num:i] mutableCopy]];
		}
		else {
			[ret addObject:[self searchLayPos:[selLay objectForKey:@"F"] Blay:[selLay objectForKey:@"B"] num:i]];
		}
	}
	return [ret copy];
}

+ (NSMutableArray*)getLayoutPos:(NSMutableArray*)SelectedLayout
{
	NSMutableArray* ret = [NSMutableArray array];
	for(int i = 0; i < [SelectedLayout count]; i++)
	{
		[ret addObject:[self getPageLayoutPos:[SelectedLayout objectAtIndex:i]]];
	}
	return ret;
}

+ (NSMutableDictionary*)XY8:(int)daiNo num:(int)num page:(int)pn fb:(NSString*)fb
{
	int x = 0;
	int y = 0;
	int rowPos = ((num / 8) - ((num / 8) - ((num / 8) / 1)));
	rowPos += 1;
	int colPos = (num % 8);
	
	if(colPos == 0)
	{
		y = rowPos - 1;
		x = 8;
	}
	else {
		y = rowPos;
		x = colPos;
	}
	return [NSMutableDictionary dictionaryWithObjectsAndKeys:INT2STR(x) , @"x", INT2STR(y), @"y", INT2STR(daiNo), @"daiNo", fb, @"FB", INT2STR(pn), @"Page", nil];
}

+ (NSMutableDictionary*)XY4:(int)daiNo num:(int)num page:(int)pn fb:(NSString*)fb
{
	int x = 0;
	int y = 0;
	int rowPos = ((num / 4) - ((num / 4) - ((num / 4) / 1)));
	rowPos += 1;
	int colPos = (num % 4);
	
	if(colPos == 0)
	{
		y = rowPos - 1;
		x = 4;
	}
	else {
		y = rowPos;
		x = colPos;
	}
	return [NSMutableDictionary dictionaryWithObjectsAndKeys:INT2STR(x) , @"x", INT2STR(y), @"y", INT2STR(daiNo), @"daiNo", fb, @"FB", INT2STR(pn), @"Page", nil];
}

+ (NSMutableDictionary*)XY2:(int)daiNo num:(int)num page:(int)pn fb:(NSString*)fb
{
	int x = 0;
	int y = 0;
	int rowPos = ((num / 2) - ((num / 2) - ((num / 2) / 1)));
	rowPos += 1;
	int colPos = (num % 2);
	
	if(colPos == 0)
	{
		y = rowPos - 1;
		x = 2;
	}
	else {
		y = rowPos;
		x = colPos;
	}
	return [NSMutableDictionary dictionaryWithObjectsAndKeys:INT2STR(x) , @"x", INT2STR(y), @"y", INT2STR(daiNo), @"daiNo", fb, @"FB", INT2STR(pn), @"Page", nil];
}

+ (NSMutableDictionary*)XY:(int)daiNo num:(int)num page:(int)pn fb:(NSString*)fb
{
	int x = 0;
	int y = 0;
	int rowPos = 1;
	rowPos += 1;
	int colPos = (num % 2);
	
	if(colPos == 0)
	{
		y = rowPos - 1;
		x = 2;
	}
	else {
		y = rowPos;
		x = colPos;
	}
	return [NSMutableDictionary dictionaryWithObjectsAndKeys:INT2STR(x) , @"x", INT2STR(y), @"y", INT2STR(daiNo), @"daiNo", fb, @"FB", INT2STR(pn), @"Page", nil];
}

+ (NSMutableDictionary*)calcXY:(NSMutableDictionary*)selLay daiNo:(int)daiNo num:(int)num page:(int)pn fb:(NSString*)fb
{
	int youso = [[selLay objectForKey:@"youso"] intValue];
	if(youso == 64)
		return [self XY8:daiNo num:num page:pn fb:fb];
	else if((youso == 32) || (youso == 16))
		return [self XY4:daiNo num:num page:pn fb:fb];
	else if(youso == 8 || youso == 4)
		return [self XY2:daiNo num:num page:pn fb:fb];
	return [NSMutableDictionary dictionary];
}

+ (NSMutableArray*)makeDaiLay:(NSMutableArray*)layPos 
					  daiData:(NSMutableArray*)daiData 
					   curLay:(NSMutableDictionary*)curLay 
						daiOf:(int)daiOf
{
	NSMutableArray* retLay = [NSMutableArray arrayWithCapacity:2];
	NSMutableArray* fLay = [NSMutableArray array];
	for(int i = 0; i < [[curLay objectForKey:@"F"] count]; i++){
		[fLay addObject:[NSString stringWithFormat:@"%d",i]];
	}
	NSMutableArray* bLay = [NSMutableArray array];
	for(int i = 0; i < [[curLay objectForKey:@"B"] count]; i++){
		[bLay addObject:[NSString stringWithFormat:@"%d",i]];
	}
	for(int i = 0; i < [layPos count]; i++)
	{
		NSArray* p = [layPos objectAtIndex:i];
		NSString* fb = [[p objectAtIndex:0] substringToIndex:1];
		int layNum = [[[p objectAtIndex:0] substringFromIndex:1] intValue];
		int daiPagePos = i + daiOf;
		if ([p count] == 2) {
			if([fb isEqualToString:@"F"]){
				NSString* data = [[[daiData objectAtIndex:daiPagePos] objectAtIndex:1] stringValue];
				[fLay replaceObjectAtIndex:layNum withObject:data];
				layNum = [[[p objectAtIndex:1] substringFromIndex:1] intValue];
				[fLay replaceObjectAtIndex:layNum withObject:data];
			}
			else {
				NSString* data = [[[daiData objectAtIndex:daiPagePos] objectAtIndex:1] stringValue];
				[bLay replaceObjectAtIndex:layNum withObject:data];
				layNum = [[[p objectAtIndex:1] substringFromIndex:1] intValue];
				[bLay replaceObjectAtIndex:layNum withObject:data];
			}
			
		}
		else {
			if([fb isEqualToString:@"F"]){
				NSString* data = [[[daiData objectAtIndex:daiPagePos] objectAtIndex:1] stringValue];
				[fLay replaceObjectAtIndex:layNum withObject:data];
			}
			else {
				NSString* data = [[[daiData objectAtIndex:daiPagePos] objectAtIndex:1] stringValue];
				[bLay replaceObjectAtIndex:layNum withObject:data];
			}
			
		}
		
	}
	[retLay addObject:fLay];
	[retLay addObject:bLay];
	return retLay;
}
//----------------------------------------------------------------------------//
#pragma mark -
#pragma mark Funcs
//----------------------------------------------------------------------------//
+ (NSMutableArray*)makeOriCount:(NSArray*)allLay list:(NSMutableArray*)layouts
{
	NSMutableArray* daiOri = [NSMutableArray array];
	int paddnum = 0;
	for(int i = 0; i < [allLay count]; i++)
	{
		NSString* selLayout = [allLay objectAtIndex:i];
		for(NSMutableDictionary* layInfo in layouts)
		{
			if([selLayout isEqualToString:[layInfo objectForKey:@"name"]])
			{
				int p = [[layInfo objectForKey:@"page"] intValue];
				int o = [[layInfo objectForKey:@"ori"] intValue];


				for(int i = 0; i < o; i++)
				{
					for(int j = 1; j <= p /o; j++)
					{
						[daiOri addObject:[NSNumber numberWithInt:paddnum + 1]];
					}
					paddnum ++;
				}
				break;
			}
		}
	}
	return daiOri;
}


+ (NSMutableArray*)makeDaiwari:(NSMutableArray*)daiData 
						allLay:(NSMutableArray*)allLay
						nNaosi:(NSMutableArray*)nNaosi
						wNaosi:(NSMutableArray*)wNaosi
						gNaosi:(NSMutableArray*)gNaosi
					   laylist:(NSMutableArray*)layouts
					 nNaosiSrc:(NSMutableArray**)nnSrc
					 wNaosiSrc:(NSMutableArray**)wnSrc
					 gNaosiSrc:(NSMutableArray**)gnSrc
{
	int daiOf = 0;
	NSMutableArray* ret = [NSMutableArray array];
	NSMutableArray* layPos = [NSMutableArray array];
	NSMutableArray* useLays = [NSMutableArray array];

	for(int i = 0; i < [allLay count]; i++)
	{
		NSString* lay = [allLay objectAtIndex:i];
		for(NSMutableDictionary* info in layouts)
		{
			if ([lay isEqualToString:[info objectForKey:@"name"]]) {
				[useLays addObject:info];
				break;
			}
		}
	}
	
	layPos = [self getLayoutPos:useLays];

	NSMutableArray* tmp = [NSMutableArray array];
	for(int i = 0; i < [useLays count]; i++)
	{
		NSMutableArray* daiLay = [self makeDaiLay:[layPos objectAtIndex:i] daiData:daiData curLay:[useLays objectAtIndex:i] daiOf:daiOf];
		
		[tmp addObject:daiLay];
		for (int j = 0; j < [daiLay count]; j++)
		{
			NSMutableArray* curDai = [daiLay objectAtIndex:j];
			if([curDai count]==4)
			{
							NSLog(@"%@",curDai);
			}
			for(int l = 0; l < [curDai count]; l++)
			{
				for(int k = 0; k < [nNaosi count]; k++)
				{
					int layNum = [[curDai objectAtIndex:l] intValue];
					int Nnum = [[nNaosi objectAtIndex:k] intValue];
					if (layNum == Nnum) {
						//j == 0 => F
						//j == 1 => B
						if (j == 0) {
							[*nnSrc addObject:[self calcXY:[useLays objectAtIndex:i] daiNo:i num:(l+1) page:[[curDai objectAtIndex:l] intValue] fb:@"F"]];
						}
						else if (j == 1){
							[*nnSrc addObject:[self calcXY:[useLays objectAtIndex:i] daiNo:i num:(l+1) page:[[curDai objectAtIndex:l] intValue] fb:@"B"]];
						}
					}
				}
				for(int k = 0; k < [wNaosi count]; k++)
				{
					int layNum = [[curDai objectAtIndex:l] intValue];
					int Nnum = [[wNaosi objectAtIndex:k] intValue];
					if (layNum == Nnum) {
						//j == 0 => F
						//j == 1 => B
						if (j == 0) {
							[*wnSrc addObject:[self calcXY:[useLays objectAtIndex:i] daiNo:i num:(l+1) page:[[curDai objectAtIndex:l] intValue] fb:@"F"]];
						}
						else if (j == 1){
							[*wnSrc addObject:[self calcXY:[useLays objectAtIndex:i] daiNo:i num:(l+1) page:[[curDai objectAtIndex:l] intValue] fb:@"B"]];
						}
					}
				}
				for(int k = 0; k < [gNaosi count]; k++)
				{
					int layNum = [[curDai objectAtIndex:l] intValue];
					int Nnum = [[gNaosi objectAtIndex:k] intValue];
					if (layNum == Nnum) {
						//j == 0 => F
						//j == 1 => B
						if (j == 0) {
							[*gnSrc addObject:[self calcXY:[useLays objectAtIndex:i] daiNo:i num:(l+1) page:[[curDai objectAtIndex:l] intValue] fb:@"F"]];
						}
						else if (j == 1){
							[*gnSrc addObject:[self calcXY:[useLays objectAtIndex:i] daiNo:i num:(l+1) page:[[curDai objectAtIndex:l] intValue] fb:@"B"]];
						}
					}
				}
				if(j == 0)
				{
					[ret addObject:[self calcXY:[useLays objectAtIndex:i] daiNo:i num:(l+1) page:[[curDai objectAtIndex:l] intValue] fb:@"F"]];
				}
				else if (j == 1)
				{
					[ret addObject:[self calcXY:[useLays objectAtIndex:i] daiNo:i num:(l+1) page:[[curDai objectAtIndex:l] intValue] fb:@"B"]];
				}
				
			}
		}
		daiOf += [[layPos objectAtIndex:i] count];
	}

	return ret;
}

+ (NSMutableArray*)makeOri:(NSMutableArray*)daiData allLay:(NSMutableArray*)allLay laylist:(NSMutableArray*)layouts
{
	NSMutableArray* ret = [NSMutableArray array];
	int daiOf = 0;
	for(int i = 0; i < [allLay count]; i++)
	{
		NSString* lay = [allLay objectAtIndex:i];
		int maxPage = 0;
		NSString* midasi = @"";
		BOOL BA = NO; // 裏のレイアウトがあるかどうか
		int oriCount = 0;
		for(NSMutableDictionary* info in layouts)
		{
			if ([lay isEqualToString:[info objectForKey:@"name"]]) {
				oriCount = [[info objectForKey:@"ori"] intValue];
				maxPage = [[info objectForKey:@"page"] intValue];
				midasi = [info objectForKey:@"title"];
				if([[info objectForKey:@"B"] count] != 0)
					BA = YES;
				break;
			}
		}
		
		NSMutableArray* tmpDai = [NSMutableArray array];
		if (oriCount == 2) {
			int ori1 = [[[daiData objectAtIndex:daiOf] objectAtIndex:0] intValue];
			daiOf += (maxPage / 2);
			int ori2 = [[[daiData objectAtIndex:daiOf] objectAtIndex:0] intValue];
			daiOf += (maxPage / 2);
			[tmpDai addObject:[NSString stringWithFormat:@"%d台表（%d,%d折）",(i+1),ori1,ori2]];
			[tmpDai addObject:[NSString stringWithFormat:@"%d台裏",(i+1)]];
		}
		else {
			if(BA){
				int ori1 = [[[daiData objectAtIndex:daiOf] objectAtIndex:0] intValue];
				daiOf += maxPage;
				[tmpDai addObject:[NSString stringWithFormat:@"%d台表%@＜%d折＞",(i+1),midasi,ori1]];
				[tmpDai addObject:[NSString stringWithFormat:@"%d台裏",(i+1)]];
			}
			else {
				int ori1 = [[[daiData objectAtIndex:daiOf] objectAtIndex:0] intValue];
				daiOf += maxPage;
				[tmpDai addObject:[NSString stringWithFormat:@"%d台表%@＜%d折＞",(i+1),midasi,ori1]];
			}
		}
		[ret addObject:[tmpDai copy]];
	}
	return ret;
}


@end
