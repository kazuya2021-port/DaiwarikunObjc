//
//  CustumTabControll.h
//  DaiwarikunObjc
//
//  Created by 内山　和也 on 平成28/03/10.
//  Copyright 2016 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LayoutTableControll.h"
#import "DaiwariTableControll.h"

@interface CustumTabControll : NSObject {
	IBOutlet NSPopUpButton* layoutList;
	
	IBOutlet NSTextField* layoutCount;
	IBOutlet NSTextField* oriNum;
	IBOutlet NSTextField* pageNum;
	
	IBOutlet NSTextField* totalPage;
	IBOutlet NSTableView* laytbl;
	IBOutlet NSTableView* daitbl;
	
	IBOutlet NSButton*	clearLayoutTable;
	IBOutlet NSButton*	appendLayoutTable;
	IBOutlet NSButton*	clearDaiwariTable;
	IBOutlet LayoutTableControll* layCtrl;
	IBOutlet DaiwariTableControll* daiCtrl;
}

-(IBAction)addLayout:(id)sender;
-(IBAction)appendLayout:(id)sender;
-(IBAction)clearLayout:(id)sender;
-(IBAction)clearDaiwari:(id)sender;
-(IBAction)updateOri:(id)sender;
-(IBAction)updatePage:(id)sender;
@end
