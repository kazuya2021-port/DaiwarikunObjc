//
//  LayoutFuncs.h
//  DaiwarikunObjc
//
//  Created by 内山　和也 on 平成28/03/09.
//  Copyright 2016 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface LayoutFuncs : NSObject {

}
+ (NSMutableArray*)makeOriCount:(NSArray*)allLay list:(NSMutableArray*)layouts;

// 台割作成
+ (NSMutableArray*)makeDaiwari:(NSMutableArray*)daiData 
						allLay:(NSMutableArray*)allLay
						nNaosi:(NSMutableArray*)nNaosi
						wNaosi:(NSMutableArray*)wNaosi
						gNaosi:(NSMutableArray*)gNaosi
					   laylist:(NSMutableArray*)layouts
					 nNaosiSrc:(NSMutableArray**)nnSrc
					 wNaosiSrc:(NSMutableArray**)wnSrc
					 gNaosiSrc:(NSMutableArray**)gnSrc;

// 折作成
+ (NSMutableArray*)makeOri:(NSMutableArray*)daiData allLay:(NSMutableArray*)allLay laylist:(NSMutableArray*)layouts;
@end
