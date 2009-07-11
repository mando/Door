//
//  MyDocument.h
//  Door
//
//  Created by Mando Escamilla on 7/10/09.
//  Copyright __MyCompanyName__ 2009 . All rights reserved.
//


#import <Cocoa/Cocoa.h>

@interface DoorDocument : NSDocument
{
    IBOutlet NSTextView *textView;
    NSAttributedString *mString;
}

- (NSAttributedString *) string;
- (void) setString: (NSAttributedString *) value;

@end
