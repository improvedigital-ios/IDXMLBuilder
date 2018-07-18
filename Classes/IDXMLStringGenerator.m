//
//  IDXMLStringGenerator.m
//  Sample
//
//  Created by Андрей on 17.07.2018.
//  Copyright © 2018 Improve Digital. All rights reserved.
//

#import "IDXMLStringGenerator.h"
#import "IDXMLModel.h"
#import "NSString+IDXMLAdditions.h"

@implementation IDXMLStringGenerator

//+ (NSString *)representedStringWithPrefix: (NSString *)prefix
//                                parameter: (NSString *)parameter
//                                    value: (NSString *)value
//                               attributes: (NSDictionary *)attributes {
//
//
//    // Tags
//    NSMutableString *tag = @"".mutableCopy;
//
//    if (prefix.length) {
//        [tag appendString:prefix];
//        [tag appendString:@":"];
//    }
//
//    [tag appendString:parameter];
//    [tag insertString:@"<" atIndex:0];
//    [tag insertString:@">" atIndex:tag.length];
//
//    NSMutableString *initialTag = tag.mutableCopy;
//    NSMutableString *endTag = tag.mutableCopy;
//    [endTag insertString:@"/" atIndex:1];
//
//    // Attributes
//    NSMutableString *attributesString = @"".mutableCopy;
//    [attributes enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
//        [attributesString appendString:@" "];
//        [attributesString appendString:key];
//        [attributesString appendString:@"="];
//        [attributesString appendString:@"\""];
//
//        if (obj.length) {
//            [attributesString appendString:obj];
//        }
//
//        [attributesString appendString:@"\""];
//    }];
//
//    // Total string
//    NSMutableString *totalString = initialTag.mutableCopy;
//
//    if (attributesString.length) {
//        [totalString insertString:attributes.copy atIndex:totalString.length - 1];
//    }
//
//    if (value.length) {
//        [totalString appendString:value];
//    }
//
//    [totalString appendString:endTag.copy];
//    return totalString.copy;
//}

+ (NSString *)representedStringWithPrefix: (NSString *)prefix
                                parameter: (NSString *)parameter
                                    value: (id)value
                               attributes: (NSDictionary *)attributes {
    
    NSString *formattedPrefix = prefix.length ? [NSString stringWithFormat:@"%@:", prefix] : @"";
    NSString *formattedAttributes = [self formattedAttributes: attributes];

    NSString *initialTagFormat = [NSString stringWithFormat:@"<%@%@%@>",
                                  formattedPrefix,
                                  parameter,
                                  formattedAttributes];
    
    NSMutableString *mutableTotalValue = @"".mutableCopy;
    
    if ([value isKindOfClass:NSArray.class]) {
        
            NSMutableString *mutableString = @"".mutableCopy;
            NSArray *a = (NSArray *)value;
            for (NSObject *object in a) {
                
                [mutableString appendString:@"\n"];
                
                NSString *temporaryString = [self safeStringValue:object];
                NSString *formattedValue = [self formattedValue:temporaryString
                                              betweenInitialTag:initialTagFormat
                                                    andFinalTag:initialTagFormat];
                
                [mutableString appendString:formattedValue];
                
            }
            [mutableTotalValue appendString:mutableString.copy];
    }
    else {
        
        NSString *temporaryString = [self safeStringValue:value];
        NSString *formattedValue = [self formattedValue:temporaryString
                                      betweenInitialTag:initialTagFormat
                                            andFinalTag:initialTagFormat];
        
        mutableTotalValue = formattedValue.mutableCopy;
    }

    return mutableTotalValue.copy;
    
    // ----
    
//    // Tags
//    NSMutableString *tag = @"".mutableCopy;
//
//    if (prefix.length) {
//        [tag appendString:prefix];
//        [tag appendString:@":"];
//    }
//
//    [tag appendString:parameter];
//    [tag insertString:@"<" atIndex:0];
//    [tag insertString:@">" atIndex:tag.length];
//
//    NSMutableString *initialTag = tag.mutableCopy;
//    NSMutableString *endTag = tag.mutableCopy;
//    [endTag insertString:@"/" atIndex:1];
//
//    // Attributes
//    NSMutableString *attributesString = @"".mutableCopy;
//    [attributes enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
//        [attributesString appendString:@" "];
//        [attributesString appendString:key];
//        [attributesString appendString:@"="];
//        [attributesString appendString:@"\""];
//
//        if (obj.length) {
//            [attributesString appendString:obj];
//        }
//
//        [attributesString appendString:@"\""];
//    }];
//
//    // Total string
//    NSMutableString *totalString = initialTag.mutableCopy;
//
//    if (attributesString.length) {
//        [totalString insertString:attributes.copy atIndex:totalString.length - 1];
//    }
//
//    if (value.length) {
//        [totalString appendString:value];
//    }
//
//    [totalString appendString:endTag.copy];
//    return totalString.copy;
}

+ (NSString *)formattedValue: (NSString *)value
           betweenInitialTag: (NSString *)initialTag
                 andFinalTag: (NSString *)finalTag {
    
    NSString *totalValue = [NSString stringWithFormat:@"%@%@%@",
                            initialTag,
                            value,
                            finalTag];
    
    return totalValue;
}

+ (NSString *)formattedAttributes: (NSDictionary *)attributes {
    
    NSMutableString *attributesString = @"".mutableCopy;
    [attributes enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        
        [attributesString appendString:@" "];
        [attributesString appendString:key];
        [attributesString appendString:@"="];
        [attributesString appendString:@"\""];
        
        if (obj.length) {
            [attributesString appendString:obj];
        }
        
        [attributesString appendString:@"\""];
    }];
    
    return attributesString.copy;
}

+ (NSString *)safeStringValue: (id)value {
    
    NSString *safeString = nil;
    
    if ([value isKindOfClass:NSString.class]) {
        safeString = (NSString *)value;
    }
    else if ([value isKindOfClass:NSNumber.class]) {
        NSNumber *n = (NSNumber *)value;
        safeString = [n stringValue];
    }
    else if ([value isKindOfClass:IDXMLModel.class]) {
        IDXMLModel *m = (IDXMLModel *)value;
        safeString = [m toXMLString];
    }
    
    return safeString;
}

@end
