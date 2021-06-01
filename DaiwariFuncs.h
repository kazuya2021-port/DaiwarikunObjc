//
//  DaiwariFuncs.h
//  DaiwarikunObjc
//
//  Created by 内山　和也 on 平成28/03/09.
//  Copyright 2016 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface DaiwariFuncs : NSObject {
	IBOutlet NSTextField* totalPage;
	IBOutlet NSPopUpButton* bookType;
	IBOutlet NSWindow* window;
}

@property (assign) NSWindow* window;
@property (retain) NSTextField* totalPage;
@property (retain) NSPopUpButton* bookType;

-(NSDictionary*)calcDaiNum;
-(NSArray*)arrangeDai:(NSDictionary*)dai;

@end
