//
//  DaiwariTableControll.h
//  DaiwarikunObjc
//
//  Created by 内山　和也 on 平成28/03/09.
//  Copyright 2016 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DaiwariTableControll : NSObject <NSTableViewDataSource> {
	NSMutableArray*		  daiData;
	IBOutlet NSTableView* tableDaiwari;
	IBOutlet NSTextField* totalPage;
	IBOutlet NSTextField* startPage;
}
@property (retain) 	NSMutableArray* daiData;
@property (assign)	NSTableView* tableDaiwari;

- (void)setDaiwari;
- (void)setPage:(NSMutableArray*)page withIndex:(NSIndexSet*)selectedRows;
- (void)setOri:(NSMutableArray*)ori;
- (void)setOri:(NSMutableArray*)ori withIndex:(NSIndexSet*)selectedRows;
- (void)clearTableData;
- (void)deleteSelectRow;

@end
