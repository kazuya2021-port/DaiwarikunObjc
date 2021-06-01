//
//  LayoutTableControll.h
//  DaiwarikunObjc
//
//  Created by 内山　和也 on 平成28/03/09.
//  Copyright 2016 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LayoutListControll.h"
#import "DaiwariTableControll.h"

@interface LayoutTableControll : NSObject <NSTableViewDataSource> {
	NSMutableArray*		  layData;
	IBOutlet NSTableView* tableLayout;
	IBOutlet LayoutListControll* layoutList;
	IBOutlet DaiwariTableControll* daiCtrl;
}
@property (retain) 	NSMutableArray* layData;
@property (assign)	NSTableView* tableLayout;

- (void)addLayout:(NSString*)layName layoutCount:(int)laycount;
- (void)setLayout:(NSArray*)ar;
- (NSMutableArray*)getLayoutInfo;
- (void)clearTableData;
- (void)deleteSelectRow;
@end
