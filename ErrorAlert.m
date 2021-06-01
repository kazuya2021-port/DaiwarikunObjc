//
//  ErrorAlert.m
//  DaiwarikunObjc
//
//  Created by 内山　和也 on 平成28/03/08.
//  Copyright 2016 __MyCompanyName__. All rights reserved.
//

#import "ErrorAlert.h"

// ログ

@implementation ErrorAlert

+ (void)alert:(NSString *)message delegate:(id )delegate window:(NSWindow *)window {
	NSAlert *alert = [NSAlert alertWithMessageText:@""
									 defaultButton:@"OK"
								   alternateButton:@""
									   otherButton:@""
						 informativeTextWithFormat:message];
	[alert beginSheetModalForWindow:window 
					  modalDelegate:delegate
					 didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:)
						contextInfo:nil];
}

@end
