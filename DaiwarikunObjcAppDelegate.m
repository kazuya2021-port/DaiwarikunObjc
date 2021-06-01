//
//  DaiwarikunObjcAppDelegate.m
//  DaiwarikunObjc
//
//  Created by 内山　和也 on 平成28/03/04.
//  Copyright 2016 __MyCompanyName__. All rights reserved.
//

#import "DaiwarikunObjcAppDelegate.h"
#import "ErrorAlert.h"
#import "EPSFuncs.h"

@implementation DaiwarikunObjcAppDelegate

@synthesize window;
@synthesize tabview;
@synthesize seg;
@synthesize naosiTable;
@synthesize daiFunc;
@synthesize layCon;
@synthesize daiTable;
@synthesize layTable;

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


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	NSArray* lays = [layCon getFileList:@".lay"];
	[layCon readLayoutFile:lays];
}

-(BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender{
	return YES;
}
-(IBAction)makeEPS:(id)sender
{
	NSDictionary* d = [daiFunc calcDaiNum];
	NSArray* ar = [daiFunc arrangeDai:d];
	
	NSLog(@"台数:%@",d);
	for(NSString* a in ar)
	{
		NSLog(@"arrangeDai:%@",a);		
	}
		

	if(![[[bookType selectedItem] title] isEqualToString:@"カスタム"])
	{
		[daiTable setDaiwari];
		[layTable setLayout:ar];
		if ([[[bookType selectedItem] title] isEqualToString:@"単行本"] || [[[bookType selectedItem] title] isEqualToString:@"輪転"]) {
			[widthCount setStringValue:@"4"];
		}
		else {
			[widthCount setStringValue:@"2"];
		}
	}
	
	NSMutableDictionary* ui = [NSMutableDictionary dictionary];
	[ui setObject:[daiwariTitle stringValue] forKey:@"title"];
	[ui setObject:[OffsetPage stringValue] forKey:@"startPage"];
	[ui setObject:[TotalPage stringValue] forKey:@"totalPage"];
	[ui setObject:[setumeiWaku stringValue] forKey:@"wakuSetumei"];
	[ui setObject:[setumeiGousei stringValue] forKey:@"gouSetumei"];

	[EPSFuncs startMakeEPS:[layTable layData] daiwari:[daiTable daiData] naosi:[naosiTable numData] layInfo:[layCon layouts] uiInfo:ui width:[widthCount intValue]];
}

-(IBAction)apperMain:(id)sender
{
	NSToolbarItem* item = (NSToolbarItem*)sender;
	[tabview selectTabViewItemWithIdentifier:[item itemIdentifier]];
}

-(IBAction)apperCustum:(id)sender
{
	NSToolbarItem* item = (NSToolbarItem*)sender;
	[tabview selectTabViewItemWithIdentifier:[item itemIdentifier]];	
}

-(IBAction)selectSyubetsu:(id)sender
{
	if([[sender titleOfSelectedItem] isEqualToString:@"カスタム"])
	{
		[LayoutTable setEnabled:YES];
		[LayoutDaiTable setEnabled:YES];
		[LayoutDaiTable setEnabled:YES];
		[LayoutSelect setEnabled:YES];
		[LayoutCount setEnabled:YES];
		[OriCount setEnabled:YES];
		[PageCount setEnabled:YES];
		[Tuika setEnabled:YES];
		[PageKousin setEnabled:YES];
		[OriKousin setEnabled:YES];
		[widthCount setEnabled:YES];
	}
	else {
		[LayoutTable setEnabled:NO];
		[LayoutDaiTable setEnabled:NO];
		[LayoutDaiTable setEnabled:NO];
		[LayoutSelect setEnabled:NO];
		[LayoutCount setEnabled:NO];
		[OriCount setEnabled:NO];
		[PageCount setEnabled:NO];
		[Hanei setEnabled:NO];
		[Sakujyo setEnabled:NO];
		[SakujyoDai setEnabled:NO];
		[Tuika setEnabled:NO];
		[PageKousin setEnabled:NO];
		[OriKousin setEnabled:NO];
		[widthCount setEnabled:NO];
	}

}

-(IBAction)clearNumTable:(id)sender
{
	[naosiTable clearTableData];
}

-(IBAction)deleteSelectRow:(id)sender
{
	[naosiTable deleteSelectRow];
}
//----------------------------------------------------------------------------//
#pragma mark -
#pragma mark NSTextField Delegate
//----------------------------------------------------------------------------//
- (void)controlTextDidEndEditing:(NSNotification *)obj
{
	NSString* place = [[[obj object] cell] placeholderString];
	NSString* vals = [[obj object] stringValue];
	
	if([place isEqualToString:@"総ページ"]) 
	{
		if(![[[bookType selectedItem] title] isEqualToString:@"カスタム"])
		{
			if ([[vals stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]) {
				[ErrorAlert alert:@"総ページが未記入です" 
						 delegate:self
						   window:window];
				return;
			}
			if ([vals intValue] == 0) {
				[ErrorAlert alert:@"総ページが不正です" 
						 delegate:self
						   window:window];
				return;
				
			}
		}
	}
	else if ([place isEqualToString:@"開始ページ"]) 
	{
		if ([[vals stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]) {
			[ErrorAlert alert:@"開始ページが未記入です" 
					 delegate:self
					   window:window];
			return;
		}
		if([[[bookType selectedItem] title] isEqualToString:@"カスタム"])
			[Hanei setEnabled:YES];
	}
	else if ([place isEqualToString:@"直しページ"]) 
	{
		if ([[vals stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]) {
			return;
		}
		
		int maxPage = [TotalPage intValue] + ([OffsetPage intValue] - 1);
		int minPage = [OffsetPage intValue];
		
		if([vals intValue] > maxPage || minPage > [vals intValue])
		{
			[ErrorAlert alert:@"直しページが範囲外です" 
					 delegate:self
					   window:window];
			return;
		}
		NSNumber* selectSeg = [NSNumber numberWithInt:[seg selectedSegment]];
		[naosiTable setNumDataFromTextBox:vals segment:selectSeg];
		[[obj object] setStringValue:@""];
	}
	else if ([place isEqualToString:@"タイトル"]) 
	{
		if ([[vals stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]) {
			[ErrorAlert alert:@"タイトルが未記入です" 
					 delegate:self
					   window:window];
			return;
		}
	}
	
}

@synthesize LayoutTable;
@synthesize LayoutDaiTable;
@synthesize LayoutSelect;
@synthesize LayoutCount;
@synthesize OriCount;
@synthesize PageCount;
@synthesize Hanei;
@synthesize Tuika;
@synthesize PageKousin;
@synthesize OriKousin;
@synthesize TotalPage;
@synthesize OffsetPage;
@end
