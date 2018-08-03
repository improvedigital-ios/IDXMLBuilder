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
#import "IDXMLModelPrivateProtocol.h"

@implementation IDXMLStringGenerator

+ (NSString *)representedStringWithPrefix: (NSString *)prefix
                                parameter: (NSString *)parameter
                                    value: (id)value
                          attributesArray: (NSArray <NSDictionary *> *)attributesArray
                                  initial: (BOOL)initial {

    NSString *formattedPrefix = prefix.length ? [prefix stringByAppendingString:@":"] : @"";
    NSMutableString *mutableTotalValue = @"".mutableCopy;
    
    if ([value isKindOfClass:NSArray.class]) {

        NSMutableString *mutableString = @"".mutableCopy;
        NSArray *a = (NSArray *)value;
        
        [a enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString *safeStringValue = [self safeStringValue:obj];
            NSString *formattedAttributes = [self formattedAttributes: attributesArray[idx]];
            NSString *formattedValueBetweenTags = [self formattedValueBetweenTagsWithParameter:parameter
                                                                                         value:safeStringValue
                                                                                        prefix:formattedPrefix
                                                                           formattedAttributes:formattedAttributes];
            
            formattedValueBetweenTags = formattedValueBetweenTags.tabulated;
            
            [mutableString appendString:@"\n"];
            [mutableString appendString:formattedValueBetweenTags];
        }];
        
        [mutableTotalValue appendString:mutableString.copy];
    }
    else {
        
        NSString *temporaryString = [self safeStringValue:value];
        NSString *formattedAttributes = [self formattedAttributes: attributesArray.firstObject];
        NSString *formattedValueBetweenTags = [self formattedValueBetweenTagsWithParameter:parameter
                                                                                     value:temporaryString
                                                                                    prefix:formattedPrefix
                                                                       formattedAttributes:formattedAttributes];
        
        
        NSString *totalFormattedValue = formattedValueBetweenTags;
        
        mutableTotalValue = totalFormattedValue.mutableCopy;
    }
    
    
    if (!initial) {
        mutableTotalValue = mutableTotalValue.tabulated.mutableCopy;
    }
    
    [mutableTotalValue appendString:@"\n"];
    
    return mutableTotalValue.copy;
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
    
    if (value == nil) {
        return nil;
    }
    
    NSString *safeString = nil;
    
    if ([value isKindOfClass:NSString.class]) {
        safeString = (NSString *)value;
    }
    else if ([value isKindOfClass:NSNumber.class]) {
        NSNumber *n = (NSNumber *)value;
        safeString = [n stringValue];
    }
    else if ([value isKindOfClass:IDXMLModel.class]) {
        
        if ([value conformsToProtocol:@protocol(IDXMLModelPrivateProtocol)]) {
            IDXMLModel <IDXMLModelPrivateProtocol> *m = (IDXMLModel <IDXMLModelPrivateProtocol> *)value;
            safeString = [m toXMLStringFirstly: NO];
        }
    }
    
    return safeString;
}

+ (NSString *)formattedValueBetweenTagsWithParameter: (NSString *)parameter
                                               value: (NSString *)value
                                              prefix: (NSString *)prefix
                                 formattedAttributes: (NSString *)formattedAttributes {
    
    if (value == nil) {
        return [NSString stringWithFormat:@"<%@ %@ nil=\"true\"/>", parameter, prefix];
    }
    
    NSString *initialTagFormat = [NSString stringWithFormat:@"<%@%@%@>",
                                  prefix,
                                  parameter,
                                  formattedAttributes];
    
    NSString *finalTagFormat = [NSString stringWithFormat:@"</%@%@>",
                                prefix,
                                parameter];
    
    NSString *formattedValue = [self formattedValue:value
                                  betweenInitialTag:initialTagFormat
                                        andFinalTag:finalTagFormat];
    return formattedValue;
}

@end
