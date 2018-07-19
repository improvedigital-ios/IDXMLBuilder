//
//  IDXMLValue+Protected.m
//  Sample
//
//  Created by Андрей on 13.07.2018.
//  Copyright © 2018 Improve Digital. All rights reserved.
//

#import "IDXMLValue+Protected.h"
#import "IDXMLElement.h"
#import "NSString+IDXMLAdditions.h"

@implementation IDXMLValue (Protected)

- (NSString *)representedValue {
    
    if (self.stringValue.length) {
        return self.stringValue;
    }
    else {
        NSMutableString *mutableString = @"\n".mutableCopy;
        
        [self.elements enumerateObjectsUsingBlock:^(IDXMLElement * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString *representedString = [obj representedString];
            NSString *representedAndTabulatedString = [representedString tabulated];
            
            [mutableString appendString:representedAndTabulatedString];
        }];
        
        return mutableString.copy;
    }
}

@end
