//
//  EPSFuncs.m
//  DaiwarikunObjc
//
//  Created by 内山　和也 on 平成28/03/10.
//  Copyright 2016 __MyCompanyName__. All rights reserved.
//

#import "EPSFuncs.h"
#import "NaosiData.h"
#import "LayoutFuncs.h"

@implementation EPSFuncs
#define INT2STR(in) [NSString stringWithFormat:@"%d",in]

+ (NSString*)convertSJIS:(NSString*)str
{
//	NSData* tmpData = [str dataUsingEncoding:NSShiftJISStringEncoding allowLossyConversion:YES];
	NSString* tmp = [NSString stringWithFormat:@"%@",[str dataUsingEncoding:NSShiftJISStringEncoding allowLossyConversion:YES]];
	tmp = [tmp stringByReplacingOccurrencesOfString:@"<" withString:@""];
	tmp = [tmp stringByReplacingOccurrencesOfString:@">" withString:@""];
	tmp = [tmp stringByReplacingOccurrencesOfString:@" " withString:@""];
	int ofst = 0;
	NSMutableString* ret = [NSMutableString string];
	for(int i = 0; i < ([tmp length]/2); i++)
	{
		NSString* t = [tmp substringWithRange:NSMakeRange(ofst, 2)];
		[ret appendFormat:@"%@ ",t];
		ofst +=2;
	}
	return [ret copy];
}
+ (NSString*)makeLastEPS:(NSString*)gou waku:(NSString*)waku daiNum:(int)daiNum height:(int)height title:(NSString*)title
{
	NSMutableString* ret = [NSMutableString string];
	if (![[waku stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""] &&
		![[gou stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]) {
		[ret appendFormat:@"%d <%@> (W) setumei\r\n",daiNum, [self convertSJIS:waku]];
		[ret appendString:@"/curPosY curPosY 23 add def\r\n"];
		[ret appendFormat:@"%d <%@> (G) setumei\r\n",daiNum, [self convertSJIS:gou]];
	}
	else if (![[waku stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]) {
		[ret appendFormat:@"%d <%@> (W) setumei\r\n",daiNum, [self convertSJIS:waku]];
	}
	else if (![[gou stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]) {
		[ret appendFormat:@"%d <%@> (G) setumei\r\n",daiNum, [self convertSJIS:gou]];
	}
	[ret appendString:@"0 0 0 setrgbcolor\r\n"];
	[ret appendString:@"/Osaka findfont 20 scalefont setfont\r\n"];
	[ret appendFormat:@"cellWidth -%d moveto\r\n",(height - 5)];
	[ret appendFormat:@"<%@> show\r\n",[self convertSJIS:title]];
	return [ret copy];
}

+ (NSString*)date2String
{
    // 現在日時（世界標準時）を取得
    NSDate* dt = [NSDate date];
    
    // 時刻書式指定子を設定
	NSDateFormatter* form = [[NSDateFormatter alloc] init];
	[form setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
	
	return [form stringFromDate:dt];
}

+ (NSString*)makeInitialEps:(NSString*)title height:(int)height width:(int)width
{
	NSMutableString* ret = [NSMutableString string];
	int BX = ([title length] * 20);
	if(BX < 714){
		BX = 714;
	}
	[ret appendString:@"%!PS-Adobe-3.0 EPSF-3.0\r\n"];
	[ret appendFormat:@"%%%%Title: %@\r\n",title];
	[ret appendString:@"%%Creator: DaiwariKun Objc ver.1.0\r\n"];
	[ret appendFormat:@"%%%%CreationDate: %@\r\n",[self date2String]];
	[ret appendString:@"%%Pages: 1\r\n"];
	[ret appendString:@"%%DocumentFonts: Osaka\r\n"];
	[ret appendFormat:@"%%%%BoundingBox: 0 0 %d %d\r\n",BX, height];
	[ret appendString:@"%%EndComments\r\n"];
	[ret appendString:@"%%Page: 1\r\n"];
	if (width == 2) {
		[ret appendString:@"/cellWidth 714 20 div def\r\n"];
		[ret appendString:@"/graphWidth cellWidth 8 mul def\r\n"];
	}
	else if (width == 4) {
		[ret appendString:@"/cellWidth 714 24 div def\r\n"];
		[ret appendString:@"/graphWidth cellWidth 4 mul def\r\n"];
	}
	[ret appendString:@"/fontHeight 15 def\r\n"];
	[ret appendString:@"/fontScale 10 def\r\n"];
	[ret appendString:@"/colHeight 3 fontHeight add def\r\n"];
	[ret appendString:@"/graphHeight colHeight 5 mul def\r\n"];
	[ret appendFormat:@"0 %d translate\r\n",height];
	[ret appendString:@"0 0 0 setrgbcolor\r\n"];
	return [ret copy];
}

+ (NSString*)makeMainEPS:(NSMutableArray*)daiSrc 
				  oriSrc:(NSMutableArray*)oriSrc 
				  nNaosi:(NSMutableArray*)nNaosi 
				  wNaosi:(NSMutableArray*)wNaosi
				  gNaosi:(NSMutableArray*)gNaosi
				 laylist:(NSMutableArray*)laylist
				 layData:(NSMutableArray*)layData
				   width:(int)width
{
	NSMutableString* ret = [NSMutableString string];
	for(int i = 0; i < [layData count]; i++)
	{
		NSString* layName = [layData objectAtIndex:i];
		int layHeight = 0;
		for(NSMutableDictionary* info in laylist)
		{
			if ([layName isEqualToString:[info objectForKey:@"name"]]) {
				layHeight = [[info objectForKey:@"height"] intValue];
				break;
			}
		}
		if (i == 0) {
			[ret appendString:@"/curPosY fontHeight def\r\n"];
		}
		NSMutableArray* curNsrc = [NSMutableArray array];
		NSMutableArray* curWsrc = [NSMutableArray array];
		NSMutableArray* curGsrc = [NSMutableArray array];
		for(NSMutableDictionary* theNN in nNaosi)
		{
			if([[theNN objectForKey:@"daiNo"] intValue] == i){
				[curNsrc addObject:theNN];
			}			
		}
		for(NSMutableDictionary* theWN in wNaosi)
		{
			if([[theWN objectForKey:@"daiNo"] intValue] == i){
				[curWsrc addObject:theWN];
			}	
		}
		for(NSMutableDictionary* theGN in gNaosi)
		{
			if([[theGN objectForKey:@"daiNo"] intValue] == i){
				[curGsrc addObject:theGN];
			}
		}
		
		if([curNsrc count] != 0)
		{
			for(NSMutableDictionary* nnn in curNsrc)
			{
				if (width == 2) {
					[ret appendFormat:@"%@ %@ %d (%@) 1 (B) (N) markN\r\n",
					 [nnn objectForKey:@"x"], 
					 [nnn objectForKey:@"y"],
					 [[nnn objectForKey:@"daiNo"] intValue] + 1,
					 [nnn objectForKey:@"FB"]];
				}
				else {
					int cc = ([[nnn objectForKey:@"daiNo"] intValue] + 1) % 2;
					if (cc == 0) {
						cc = 2;
					}
					
					[ret appendFormat:@"%@ %@ %d (%@) %@ (T) (N) markN\r\n",
					 [nnn objectForKey:@"x"], 
					 [nnn objectForKey:@"y"],
					 [[nnn objectForKey:@"daiNo"] intValue] + 1,
					 [nnn objectForKey:@"FB"],
					 INT2STR(cc)];
				}
			}
		}
		if([curWsrc count] != 0)
		{
			for(NSMutableDictionary* nnn in curWsrc)
			{
				if (width == 2) {
					[ret appendFormat:@"%@ %@ %d (%@) 1 (B) (W) markN\r\n",
					 [nnn objectForKey:@"x"], 
					 [nnn objectForKey:@"y"],
					 [[nnn objectForKey:@"daiNo"] intValue] + 1,
					 [nnn objectForKey:@"FB"]];
				}
				else {
					int cc = ([[nnn objectForKey:@"daiNo"] intValue] + 1) % 2;
					if (cc == 0) {
						cc = 2;
					}
					
					[ret appendFormat:@"%@ %@ %d (%@) %@ (T) (W) markN\r\n",
					 [nnn objectForKey:@"x"], 
					 [nnn objectForKey:@"y"],
					 [[nnn objectForKey:@"daiNo"] intValue] + 1,
					 [nnn objectForKey:@"FB"],
					 INT2STR(cc)];
				}
			}
		}
		if([curGsrc count] != 0)
		{
			for(NSMutableDictionary* nnn in curGsrc)
			{
				if (width == 2) {
					[ret appendFormat:@"%@ %@ %d (%@) 1 (B) (G) markN\r\n",
					 [nnn objectForKey:@"x"], 
					 [nnn objectForKey:@"y"],
					 [[nnn objectForKey:@"daiNo"] intValue] + 1,
					 [nnn objectForKey:@"FB"]];
				}
				else {
					int cc = ([[nnn objectForKey:@"daiNo"] intValue] + 1) % 2;
					if (cc == 0) {
						cc = 2;
					}
					
					[ret appendFormat:@"%@ %@ %d (%@) %@ (T) (G) markN\r\n",
					 [nnn objectForKey:@"x"], 
					 [nnn objectForKey:@"y"],
					 [[nnn objectForKey:@"daiNo"] intValue] + 1,
					 [nnn objectForKey:@"FB"],
					 INT2STR(cc)];
				}
			}
		}
		NSMutableArray* curDaiSrc = [NSMutableArray array];
		for(NSMutableDictionary* thePage in daiSrc)
		{
			if ([[thePage objectForKey:@"daiNo"] intValue] == i) {
				[curDaiSrc addObject:thePage];
			}
		}
		if([curDaiSrc count] != 0)
		{
			for(int j = 0; j < [curDaiSrc count]; j++)
			{
				NSMutableDictionary* mmm = [curDaiSrc objectAtIndex:j];
				if (width == 2) {
					if((j+1) % 8 == 0)
					{
						[ret appendFormat:@"%@ %@ %d (%@) (%@) 1 (B) setNum \r\n",
						 [mmm objectForKey:@"x"], 
						 [mmm objectForKey:@"y"],
						 [[mmm objectForKey:@"daiNo"] intValue] + 1,
						 [mmm objectForKey:@"FB"],
						 [mmm objectForKey:@"Page"]];
					}else {
						[ret appendFormat:@"%@ %@ %d (%@) (%@) 1 (B) setNum ",
						 [mmm objectForKey:@"x"], 
						 [mmm objectForKey:@"y"],
						 [[mmm objectForKey:@"daiNo"] intValue] + 1,
						 [mmm objectForKey:@"FB"],
						 [mmm objectForKey:@"Page"]];
					}
				}
				else {
					int cc = ([[mmm objectForKey:@"daiNo"] intValue] + 1) % 2;
					if (cc == 0) {
						cc = 2;
					}
					if((j+1) % 8 == 0)
					{
						[ret appendFormat:@"%@ %@ %d (%@) (%@) %@ (T) setNum \r\n",
						 [mmm objectForKey:@"x"], 
						 [mmm objectForKey:@"y"],
						 [[mmm objectForKey:@"daiNo"] intValue] + 1,
						 [mmm objectForKey:@"FB"],
						 [mmm objectForKey:@"Page"],
						 INT2STR(cc)];
					}else {
						[ret appendFormat:@"%@ %@ %d (%@) (%@) %@ (T) setNum ",
						 [mmm objectForKey:@"x"], 
						 [mmm objectForKey:@"y"],
						 [[mmm objectForKey:@"daiNo"] intValue] + 1,
						 [mmm objectForKey:@"FB"],
						 [mmm objectForKey:@"Page"],
						 INT2STR(cc)];
					}
				}
			}
		}
		
		NSArray* theOri = [oriSrc objectAtIndex:i];
		if([theOri count] == 2) {
			if (width == 2) {
				[ret appendFormat:@"%d (F) <%@> 1 (B) setTitle\r\n",
				 i+1,
				 [self convertSJIS:[theOri objectAtIndex:0]]];
				[ret appendFormat:@"%d (B) <%@> 1 (B) setTitle\r\n",
				 i+1,
				 [self convertSJIS:[theOri objectAtIndex:1]]];
			}
			else {
				int cc = (i+1) % 2;
				if (cc == 0) {
					cc = 2;
				}
				[ret appendFormat:@"%d (F) <%@> %d (T) setTitle\r\n",
				 i+1,
				 [self convertSJIS:[theOri objectAtIndex:0]],
				 cc];
				[ret appendFormat:@"%d (B) <%@> %d (T) setTitle\r\n",
				 i+1,
				 [self convertSJIS:[theOri objectAtIndex:1]],
				 cc];
			}
		}
		else {
			if (width == 2) {
				[ret appendFormat:@"%d (F) <%@> 1 (B) setTitle\r\n",
				 i+1,
				 [self convertSJIS:[theOri objectAtIndex:0]]];
			}
			else {
				int cc = (i+1) % 2;
				if (cc == 0) {
					cc = 2;
				}
				[ret appendFormat:@"%d (F) <%@> %d (T) setTitle\r\n",
				 i+1,
				 [self convertSJIS:[theOri objectAtIndex:0]],
				 cc];
			}

			
		}
		if((i == 10))
			NSLog(@"dou?");
		if(width == 2){
			[ret appendFormat:@"/curPosY curPosY %d add def\r\n", layHeight];
		}
		else {
			if( (((i+1) % 2) == 0) || i == ([layData count]-1) ) {
				[ret appendFormat:@"/curPosY curPosY %d add def\r\n", layHeight];
			}
		}
	}
	return [ret copy];
}

+(int)calcPageHeight:(NSMutableArray*)layData waku:(NSString*)waku gou:(NSString*)gou layInfo:(NSMutableArray*)layInfo width:(int)width
{
	int ret = 60;
	for(int i = 0; i < [layData count]; i++)
	{
		NSString* lay = [layData objectAtIndex:i];
		int h = 0;
		for(NSMutableDictionary* info in layInfo)
		{
			if([lay isEqualToString:[info objectForKey:@"name"]])
			{
				h = [[info objectForKey:@"height"] intValue];
				int w = width;
				w = w / 2;
				if(((i+1) % w) == 0)
				{
					ret += h;
					break;
				}
			}	
		}
	}
	int lastDai = [layData count];
	if((lastDai % 2) == 1)
	{
		NSString* lay = [layData lastObject];
		for(NSMutableDictionary* info in layInfo)
		{
			if([lay isEqualToString:[info objectForKey:@"name"]])
			{
				ret += [[info objectForKey:@"height"] intValue];
				break;
			}
		}
	}
	if (![waku isEqualToString:@""])
		ret += 18;

	if (![gou isEqualToString:@""])
		ret += 18;
	
	return ret;
}

+(void)startMakeEPS:(NSMutableArray*)layData daiwari:(NSMutableArray*)daiData naosi:(NSMutableArray*)numData layInfo:(NSMutableArray*)layInfo uiInfo:(NSMutableDictionary*)uiInfo width:(int)width
{
	NSString* title = [uiInfo objectForKey:@"title"];
	NSString* wakuSetumei = [uiInfo objectForKey:@"wakuSetumei"];
	NSString* gouSetumei = [uiInfo objectForKey:@"gouSetumei"];
	
	if (![wakuSetumei isEqualToString:@""])
		wakuSetumei = [@"：" stringByAppendingString:wakuSetumei];
	
	if (![gouSetumei isEqualToString:@""])
		gouSetumei = [@"：" stringByAppendingString:gouSetumei];
	NSLog(@"wakuSetumei:%@",wakuSetumei);
	NSLog(@"gouSetumei:%@",gouSetumei);
	// EPSの高さ計算
	int epsHeight = [self calcPageHeight:layData waku:wakuSetumei gou:gouSetumei layInfo:layInfo width:width];
	
	// レイアウトの横の個数を求める
	
	NSMutableArray* allNaosi = [NSMutableArray array];
	NSMutableArray* nuriNaosi = [NSMutableArray array];
	NSMutableArray* wakuNaosi = [NSMutableArray array];
	NSMutableArray* gouNaosi = [NSMutableArray array];
	
	// 直しデータ収集
	for(NaosiData* n in numData)
	{
		int nPage = n.naosiPage;
		int nStyle = [n.naosiStyle intValue];
		if (nStyle == 0) {
			[nuriNaosi addObject:[NSNumber numberWithInt:nPage]];
			[allNaosi addObject:[NSNumber numberWithInt:nPage]];
		}
		else if (nStyle == 1) {
			[gouNaosi addObject:[NSNumber numberWithInt:nPage]];
			[allNaosi addObject:[NSNumber numberWithInt:nPage]];
		}
		else if (nStyle == 2) {
			[wakuNaosi addObject:[NSNumber numberWithInt:nPage]];
			[allNaosi addObject:[NSNumber numberWithInt:nPage]];
		}
	}
	NSMutableArray* nuriSrc = [NSMutableArray array];
	NSMutableArray* wakuSrc = [NSMutableArray array];
	NSMutableArray* gouSrc = [NSMutableArray array];
	NSMutableArray* daiSrc = [NSMutableArray array];
	NSMutableArray* oriSrc = [NSMutableArray array];
	daiSrc = [LayoutFuncs makeDaiwari:daiData allLay:layData nNaosi:nuriNaosi wNaosi:wakuNaosi gNaosi:gouNaosi laylist:layInfo nNaosiSrc:&nuriSrc wNaosiSrc:&wakuSrc gNaosiSrc:&gouSrc];

	oriSrc = [LayoutFuncs makeOri:daiData allLay:layData laylist:layInfo];
	
	NSString* epsData = [self makeMainEPS:daiSrc oriSrc:oriSrc nNaosi:nuriSrc wNaosi:wakuSrc gNaosi:gouSrc laylist:layInfo layData:layData width:width];
	NSString* resPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Contents/Resources/FuncsEPS"];
	NSString* funcEPS = [[NSString alloc] initWithContentsOfFile:resPath encoding:NSUTF8StringEncoding error:nil];
	NSString* initialEPS = [self makeInitialEps:title height:epsHeight width:width];
	NSString* lastEPS = [self makeLastEPS:gouSetumei waku:wakuSetumei daiNum:[layData count] height:epsHeight title:title];
	NSString* epsfile = [NSString stringWithFormat:@"%@%@%@%@",initialEPS, funcEPS, epsData, lastEPS];
	NSString* savePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"/Desktop/%@.eps",title]];
	[epsfile writeToFile:savePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}
@end
