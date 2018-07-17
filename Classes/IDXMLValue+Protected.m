//
//  IDXMLValue+Protected.m
//  Sample
//
//  Created by Андрей on 13.07.2018.
//  Copyright © 2018 Improve Digital. All rights reserved.
//

#import "IDXMLValue+Protected.h"
#import "IDXMLElement.h"

@implementation IDXMLValue (Protected)

- (NSString *)representedValue {
    
    if (self.stringValue.length) {
        return self.stringValue;
    }
    else {
        NSMutableString *mutableString = @"\n".mutableCopy;
        
        [self.elements enumerateObjectsUsingBlock:^(IDXMLElement * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSMutableString *representedString = [obj representedString].mutableCopy;
            NSArray *array = [representedString componentsSeparatedByString:@"\n"];
            
            for (int i = 0; i < array.count; i++) {
                NSRange range = [representedString rangeOfString:array[i]];
                [representedString insertString:@"\t" atIndex:range.location];
            }
            
            [mutableString appendString:representedString.copy];
            [mutableString appendString:@"\n"];
        }];
        
        return mutableString.copy;
    }
}

@end
