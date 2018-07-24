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
    
    NSMutableString *total = @"".mutableCopy;
    
    NSArray *partsOfSelfString = [self componentsSeparatedByString:@"\n"];
    
    [partsOfSelfString enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [total appendString:@"\t"];
        [total appendString:obj];
        if (idx != partsOfSelfString.count - 1) {
            [total appendString:@"\n"];
        }
    }];

    return total.copy;
    
}

@end
