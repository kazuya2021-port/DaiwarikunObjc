//
//  NumListControll.h
//  DaiwarikunObjc
//
//  Created by 内山　和也 on 平成28/03/04.
//  Copyright 2016 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NumTableControll : NSObject < NSTableViewDelegate, NSTableViewDataSource>
{
	NSMutableArray*		  numData;
	IBOutlet NSTableView* tableNumList;
}
@property (assign) 	NSMutableArray* numData;
@property (assign)	NSTableView* tableNumList;

- (void)setNumDataFromTextBox:(NSString*)val segment:(NSNumber*)seg;
- (void)clearTableData;
- (void)deleteSelectRow;
@end
