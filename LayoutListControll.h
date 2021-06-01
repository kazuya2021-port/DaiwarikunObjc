//
//  LayoutListControll.h
//  DaiwarikunObjc
//
//  Created by 内山　和也 on 平成28/03/08.
//  Copyright 2016 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface LayoutListControll : NSObject {
	IBOutlet NSPopUpButton* layoutList;
	NSMutableArray* layouts;
}
-(NSArray *)getFileList:(NSString *)extension;
- (NSMutableArray*)layouts;
- (void)readLayoutFile:(NSArray*)files;
@property (retain) NSPopUpButton* layoutList;
@property (retain,getter=layouts) NSMutableArray* layouts;
@end
