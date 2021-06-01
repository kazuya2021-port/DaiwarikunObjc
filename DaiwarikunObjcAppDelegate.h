//
//  DaiwarikunObjcAppDelegate.h
//  DaiwarikunObjc
//
//  Created by 内山　和也 on 平成28/03/04.
//  Copyright 2016 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NumTableControll.h"
#import "DaiwariFuncs.h"
#import "LayoutListControll.h"
#import "DaiwariTableControll.h"
#import "LayoutTableControll.h"

@interface DaiwarikunObjcAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	IBOutlet NSTabView* tabview;
	IBOutlet NSSegmentedControl* seg;
	IBOutlet NumTableControll* naosiTable;
	IBOutlet NSTextField* TotalPage;
	IBOutlet NSTextField* OffsetPage;
	IBOutlet NSTextField* daiwariTitle;
	IBOutlet NSPopUpButton* bookType;
	IBOutlet NSTextField* setumeiWaku;
	IBOutlet NSTextField* setumeiGousei;
	
	IBOutlet NSTableView* LayoutTable;
	IBOutlet NSTableView* LayoutDaiTable;
	IBOutlet NSPopUpButton* LayoutSelect;
	IBOutlet NSTextField* LayoutCount;
	IBOutlet NSTextField* OriCount;
	IBOutlet NSTextField* PageCount;
	IBOutlet NSButton* Hanei;
	IBOutlet NSButton* Sakujyo;
	IBOutlet NSButton* SakujyoDai;
	IBOutlet NSButton* Tuika;
	IBOutlet NSButton* PageKousin;
	IBOutlet NSButton* OriKousin;
	IBOutlet NSTextField* widthCount;
	

	IBOutlet DaiwariFuncs* daiFunc;
	IBOutlet LayoutListControll* layCon;
	IBOutlet DaiwariTableControll* daiTable;
	IBOutlet LayoutTableControll* layTable;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTabView* tabview;
@property (assign) IBOutlet NSSegmentedControl* seg;
@property (assign) IBOutlet NumTableControll* naosiTable;
@property (assign) IBOutlet DaiwariFuncs* daiFunc;
@property (assign) IBOutlet LayoutListControll* layCon;
@property (assign) IBOutlet DaiwariTableControll* daiTable;
@property (assign) IBOutlet LayoutTableControll* layTable;

-(IBAction)makeEPS:(id)sender;
-(IBAction)apperMain:(id)sender;
-(IBAction)apperCustum:(id)sender;
-(IBAction)selectSyubetsu:(id)sender;
-(IBAction)clearNumTable:(id)sender;
-(IBAction)deleteSelectRow:(id)sender;
@property (retain) NSTableView* LayoutTable;
@property (retain) NSTableView* LayoutDaiTable;
@property (retain) NSPopUpButton* LayoutSelect;
@property (retain) NSTextField* LayoutCount;
@property (retain) NSTextField* OriCount;
@property (retain) NSTextField* PageCount;
@property (retain) NSButton* Hanei;
@property (retain) NSButton* Tuika;
@property (retain) NSButton* PageKousin;
@property (retain) NSButton* OriKousin;
@property (retain) NSTextField* TotalPage;
@property (retain) NSTextField* OffsetPage;
@end
