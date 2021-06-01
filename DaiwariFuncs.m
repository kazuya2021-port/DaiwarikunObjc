//
//  DaiwariFuncs.m
//  DaiwarikunObjc
//
//  Created by 内山　和也 on 平成28/03/09.
//  Copyright 2016 __MyCompanyName__. All rights reserved.
//

#import "DaiwariFuncs.h"
#import "ErrorAlert.h"

@implementation DaiwariFuncs
@synthesize window;

//----------------------------------------------------------------------------//
#pragma mark -
#pragma mark AlertReturn
//----------------------------------------------------------------------------//
- (void)alertDidEnd:(NSAlert *)alert 
		 returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
	if(returnCode == NSAlertDefaultReturn) 
	{
		
	}
}

//----------------------------------------------------------------------------//
#pragma mark -
#pragma mark Funcs
//----------------------------------------------------------------------------//

// 台割の順番を作成
-(NSArray*)arrangeDai:(NSDictionary*)dai
{
	NSMutableArray* ret = [NSMutableArray array];
	NSString* selectedType = [[bookType selectedItem] title];
	NSString* d64Key = @"64P";
	NSString* d32Key = @"32P";
	NSString* d16Key = @"16P";
	NSString* d8Key = @"8P";
	NSString* d4Key = @"4P";
	NSString* d2Key = @"2P";
	int dNum = [[dai objectForKey:@"台数"]intValue];
	int Dai64 = 0;
	int Dai32 = 0;
	int Dai16 = 0;
	int Dai8 = 0;
	int Dai4 = 0;
	int Dai2 = 0;
	
	if([dai objectForKey:d64Key] == nil || [dai objectForKey:d64Key] == NULL || [[dai objectForKey:d64Key] isKindOfClass:[NSNull class]])
		Dai64 = 0;
	else
		Dai64 = [[dai objectForKey:d64Key] intValue];
	
	if([dai objectForKey:d32Key] == nil || [dai objectForKey:d32Key] == NULL || [[dai objectForKey:d32Key] isKindOfClass:[NSNull class]])
		Dai32 = 0;
	else
		Dai32 = [[dai objectForKey:d32Key] intValue];
	
	if([dai objectForKey:d16Key] == nil || [dai objectForKey:d16Key] == NULL || [[dai objectForKey:d16Key] isKindOfClass:[NSNull class]])
		Dai16 = 0;
	else
		Dai16 = [[dai objectForKey:d16Key] intValue];
	
	if([dai objectForKey:d8Key] == nil || [dai objectForKey:d8Key] == NULL || [[dai objectForKey:d8Key] isKindOfClass:[NSNull class]])
		Dai8 = 0;
	else
		Dai8 = [[dai objectForKey:d8Key] intValue];
	
	if([dai objectForKey:d4Key] == nil || [dai objectForKey:d4Key] == NULL || [[dai objectForKey:d4Key] isKindOfClass:[NSNull class]])
		Dai4 = 0;
	else
		Dai4 = [[dai objectForKey:d4Key] intValue];
	
	if([dai objectForKey:d2Key] == nil || [dai objectForKey:d2Key] == NULL || [[dai objectForKey:d2Key] isKindOfClass:[NSNull class]])
		Dai2 = 0;
	else
		Dai2 = [[dai objectForKey:d2Key] intValue];
	
	NSMutableArray* tmp = [NSMutableArray array];
	if ([selectedType isEqualToString:@"単行本"]) {
		for(int i = dNum; i > 0 ; i--)
		{
			if (i == dNum) {
				[tmp addObject:@"8P表裏"];
				Dai16 -= 1;
			}
			else if (i == (dNum - 1)){
				if (Dai2 != 0) {
					[tmp addObject:@"2P単独"];
					Dai2 = 0;
				}
				else if (Dai4 != 0){
					[tmp addObject:@"2P表裏"];
					Dai4 = 0;
				}
				else if (Dai8 != 0){
					[tmp addObject:@"4P表裏"];
					Dai8 = 0;
				}
				else {
					[tmp addObject:@"8P表裏"];
					Dai16 -= 1;
				}

			}
			else if (i == (dNum - 2)){
				if (Dai4 != 0){
					[tmp addObject:@"2P表裏"];
					Dai4 = 0;
				}
				else if (Dai8 != 0){
					[tmp addObject:@"4P表裏"];
					Dai8 = 0;
				}
				else {
					[tmp addObject:@"8P表裏"];
					Dai16 -= 1;
				}
				
			}
			else if (i == (dNum - 3)){
				if (Dai8 != 0){
					[tmp addObject:@"2P表裏"];
					Dai8 = 0;
				}
				else {
					[tmp addObject:@"8P表裏"];
					Dai16 -= 1;
				}
				
			}
			else {
				[tmp addObject:@"8P表裏"];
				Dai16 -= 1;
			}
		}
		for(int i = 0; i < [tmp count]; i++)
		{
			int tmpIndex = ([tmp count] - 1 ) - i;
			[ret addObject:[tmp objectAtIndex:tmpIndex]];
		}
	}
	else if ([selectedType isEqualToString:@"輪転"]) {
		for(int i = dNum; i > 0 ; i--)
		{
			if (i == dNum) {
				if(Dai16 != 0) {
					[tmp addObject:@"輪転 8P表裏"];
					Dai16 -= 1;
				}
				else {
					[tmp addObject:@"輪転 16P表裏"];
					Dai32 -= 1;
				}
			}
			else {
				[tmp addObject:@"輪転 16P表裏"];
				Dai32 -= 1;
			}
		}
		for(int i = 0; i < [tmp count]; i++)
		{
			int tmpIndex = ([tmp count] - 1 ) - i;
			[ret addObject:[tmp objectAtIndex:tmpIndex]];
		}
	}
	else if ([selectedType isEqualToString:@"文庫"]) {
		for(int i = dNum; i > 0 ; i--)
		{
			if (i == dNum) {
				[tmp addObject:@"32P表裏"];
				Dai64 -= 1;
			}
			else if (i == (dNum - 1)){
				if (Dai16 != 0) {
					[tmp addObject:@"16P単独"];
					Dai16 = 0;
				}
				else if (Dai32 != 0){
					[tmp addObject:@"32P倍掛"];
					Dai32 = 0;
				}
				else {
					[tmp addObject:@"32P表裏"];
					Dai64 -= 1;
				}
			}
			else if (i == (dNum - 2)){
				if (Dai16 != 0) {
					[tmp addObject:@"16P単独"];
					Dai16 = 0;
				}
				else if (Dai32 != 0){
					[tmp addObject:@"32P倍掛"];
					Dai32 = 0;
				}
				else {
					[tmp addObject:@"32P表裏"];
					Dai64 -= 1;
				}
			}
			else {
				[tmp addObject:@"32P表裏"];
				Dai64 -= 1;
			}
		}
		for(int i = 0; i < [tmp count]; i++)
		{
			int tmpIndex = ([tmp count] - 1 ) - i;
			[ret addObject:[tmp objectAtIndex:tmpIndex]];
		}
	}
	return [ret copy];
}

// 総ページから各種台数を計算
-(NSDictionary*)calcDaiNum
{
	NSString* selectedType = [[bookType selectedItem] title];
	int tp = [totalPage intValue];
	int Dai64 = 0;
	int Dai32 = 0;
	int Dai16 = 0;
	int Dai8 = 0;
	int Dai4 = 0;
	int Dai2 = 0;
	NSDictionary* ret = nil;
	if(tp == 0)
	{
		[ErrorAlert alert:@"総ページを確認して下さい" 
				 delegate:self
				   window:window];
	}
	if([selectedType isEqualToString:@"単行本"])
	{
		if(tp > 14) Dai16 = ((tp / 8) - ((tp / 8) % 2)) / 2;
		
		int buf = tp - (Dai16 * 16);
		if (buf != 0)
		{
			if (buf == 14)
			{
				Dai8 = 1;
				Dai4 = 1;
				Dai2 = 1;
			}
			else if (buf == 12)
			{
				Dai8 = 1;
				Dai4 = 1;
			}
			else if (buf == 10)
			{
				Dai8 = 1;
				Dai2 = 1;
			}
			else if (buf == 8)
			{
				Dai8 = 1;
			}
			else if (buf == 6)
			{
				Dai4 = 1;
				Dai2 = 1;
			}
			else if (buf == 4)
			{
				Dai4 = 1;
			}
			else if (buf == 2)
			{
				Dai2 = 1;
			}
			else {
				[ErrorAlert alert:@"総ページを確認して下さい" 
						 delegate:self
						   window:window];
			}
		}
		ret = [NSDictionary dictionaryWithObjectsAndKeys:
			   [NSNumber numberWithInt:(Dai16 + Dai8 + Dai4 + Dai2)],@"台数",
			   [NSNumber numberWithInt:Dai16],@"16P",
			   [NSNumber numberWithInt:Dai8],@"8P",
			   [NSNumber numberWithInt:Dai4],@"4P",
			   [NSNumber numberWithInt:Dai2],@"2P",nil];
		
		return ret;
		
	}
	else if ([selectedType isEqualToString:@"輪転"])
	{
		if(tp > 16) Dai32 = ((tp / 16) - ((tp / 16) % 2)) / 2;
		int buf = tp - (Dai32 * 32);
		if (buf != 0)
		{
			if (buf == 16)
			{
				Dai16 = 1;
			}
			else {
				[ErrorAlert alert:@"総ページを確認して下さい" 
						 delegate:self
						   window:window];
			}
		}
		ret = [NSDictionary dictionaryWithObjectsAndKeys:
			   [NSNumber numberWithInt:(Dai32 + Dai16)],@"台数",
			   [NSNumber numberWithInt:Dai32],@"32P",
			   [NSNumber numberWithInt:Dai16],@"16P",nil];
		
		return ret;
		
	}
	else if([selectedType isEqualToString:@"文庫"]){
		if(tp > 48) Dai64 = ((tp / 32) - ((tp / 32) % 2)) / 2;
		int buf = tp - (Dai64 * 64);
		if (buf != 0)
		{
			if(buf == 48)
			{
				Dai16 = 1;
				Dai32 = 1;
			}
			else if(buf == 32)
			{
				Dai32 = 1;
			}
			else if(buf == 16)
			{
				Dai16 = 1;
			}
			else {
				[ErrorAlert alert:@"総ページを確認して下さい" 
						 delegate:self
						   window:window];
			}
		}
		ret = [NSDictionary dictionaryWithObjectsAndKeys:
			   [NSNumber numberWithInt:(Dai64 + Dai32 + Dai16)],@"台数",
			   [NSNumber numberWithInt:Dai64],@"64P",
			   [NSNumber numberWithInt:Dai32],@"32P",
			   [NSNumber numberWithInt:Dai16],@"16P",nil];
		return ret;
	}

	return ret;
}
@synthesize totalPage;
@synthesize bookType;
@end
