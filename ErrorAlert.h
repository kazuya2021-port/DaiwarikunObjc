//
//  ErrorAlert.h
//  DaiwarikunObjc
//
//  Created by 内山　和也 on 平成28/03/08.
//  Copyright 2016 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface ErrorAlert : NSObject {

}
+ (void)alert:(NSString *)message delegate:(id )delegate window:(NSWindow *)window;
@end
