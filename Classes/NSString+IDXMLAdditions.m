//
//  NSString+IDXMLAdditions.m
//  Sample
//
//  Created by Андрей on 18.07.2018.
//  Copyright © 2018 Improve Digital. All rights reserved.
//

#import "NSString+IDXMLAdditions.h"

@implementation NSString (IDXMLAdditions)

- (NSString *)tabulated {
    
    NSMutableString *representedString = self.mutableCopy;
    NSArray *array = [representedString componentsSeparatedByString:@""];
    
    for (int i = 0; i < array.count; i++) {
        NSRange range = [representedString rangeOfString:array[i]];
        [representedString insertString:@"\t" atIndex:range.location];
    }
    
    return representedString.copy;
}

@end
