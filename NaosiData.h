//
//  NaosiData.h
//  DaiwarikunObjc
//
//  Created by 内山　和也 on 平成28/03/08.
//  Copyright 2016 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NaosiData : NSObject {
	int naosiPage;
	NSNumber* naosiStyle;
}

@property (assign)int naosiPage;
@property (assign)NSNumber* naosiStyle;
@end
