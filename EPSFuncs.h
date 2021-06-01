//
//  EPSFuncs.h
//  DaiwarikunObjc
//
//  Created by 内山　和也 on 平成28/03/10.
//  Copyright 2016 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface EPSFuncs : NSObject {

}
+(int)calcPageHeight:(NSMutableArray*)layData waku:(NSString*)waku gou:(NSString*)gou layInfo:(NSMutableArray*)layInfo width:(int)width;
+(void)startMakeEPS:(NSMutableArray*)layData daiwari:(NSMutableArray*)daiData naosi:(NSMutableArray*)numData layInfo:(NSMutableArray*)layInfo uiInfo:(NSMutableDictionary*)uiInfo width:(int)width;
@end
