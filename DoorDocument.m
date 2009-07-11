//
//  MyDocument.m
//  Door
//
//  Created by Mando Escamilla on 7/10/09.
//  Copyright __MyCompanyName__ 2009 . All rights reserved.
//

#import "DoorDocument.h"

@implementation DoorDocument

- (id)init
{
    self = [super init];
    if (self) {
        if (mString == nil) {
            mString = [[NSAttributedString alloc] initWithString:@""];
        }
    }
    return self;
}

// TODO:  check on these get/setters and see if there's another/better way to do this
- (NSAttributedString *) string { return [[mString retain] autorelease]; }

- (void) setString: (NSAttributedString *) newValue 
{
    if (mString != newValue) {
        if (mString) [mString release];
        mString = [newValue copy];
    }
}

- (void) textDidChange: (NSNotification *) notification
{
    [self setString: [textView textStorage]];
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
    
    if ([self string] != nil) {
        [[textView textStorage] setAttributedString: [self string]];
    }
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to write your document to data of the specified type. If the given outError != NULL, ensure that you set *outError when returning nil.

    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.

    // For applications targeted for Panther or earlier systems, you should use the deprecated API -dataRepresentationOfType:. In this case you can also choose to override -fileWrapperRepresentationOfType: or -writeToFile:ofType: instead.

    NSData *data;
    [self setString:[textView textStorage]];
    data = [NSArchiver archivedDataWithRootObject:[self string]];
    
    if ( outError != NULL ) {
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
	}
	
    return data;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type.  If the given outError != NULL, ensure that you set *outError when returning NO.

    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead. 
    
    // For applications targeted for Panther or earlier systems, you should use the deprecated API -loadDataRepresentation:ofType. In this case you can also choose to override -readFromFile:ofType: or -loadFileWrapperRepresentation:ofType: instead.
    
    NSAttributedString *tempString = [NSUnarchiver unarchiveObjectWithData: data];
    [self setString:tempString];
    
    if ( outError != NULL ) {
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
	}
    return YES;
}

@end
