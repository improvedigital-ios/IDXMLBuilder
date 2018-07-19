//
//  IDXMLModel.m
//  Sample
//
//  Created by Андрей on 17.07.2018.
//  Copyright © 2018 Improve Digital. All rights reserved.
//

#import "IDXMLModel.h"
#import "IDXMLStringGenerator.h"
#import "NSString+IDXMLAdditions.h"
#import <objc/runtime.h>
#import "IDXMLModelPrivateProtocol.h"

@interface IDXMLModel () <IDXMLModelPrivateProtocol>

@property (nonatomic, strong) NSMutableDictionary <NSString *, NSDictionary <NSString *, NSString *> *> *attributesForKeys;

@end

@implementation IDXMLModel

- (NSString *)toXMLString {
    
    return [self toXMLStringFirstly:YES];
}

- (void)addAttributes: (NSDictionary <NSString *, NSString *> *)attributes forKey: (NSString *)key {
    self.attributesForKeys[key] = attributes;
}

- (NSDictionary <NSString *, NSString *> *)prefixesForPropertyKeys {
    return nil;
}


#pragma mark - IDXMLModelPrivateProtocol
- (NSString *)toXMLStringFirstly: (BOOL)firstly {
    
    Class objType = [self class];
    
    unsigned int count;
    
    objc_property_t* props = class_copyPropertyList(objType, &count);
    
    NSString *initialString = firstly ? @"\n" : @"";
    NSMutableString *totalMutableFormattedString = initialString.mutableCopy;
    
    for (int i = 0; i < count; i++) {
        
        objc_property_t property = props[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        
        id value = [self valueForKey:propertyName];
        NSString *finalPrefix = [self handledPrefixForPropertyName:propertyName];
        NSArray *attributesArray = [self attributesWithValue:value propertyName:propertyName];
        
        NSString *formattedStringForCurrentProperty = [IDXMLStringGenerator representedStringWithPrefix:finalPrefix
                                                                                              parameter:propertyName
                                                                                                  value:value
                                                                                        attributesArray:attributesArray
                                                                                                initial:firstly];
        
        [totalMutableFormattedString appendString:formattedStringForCurrentProperty];
    }
    
    free(props);
    return totalMutableFormattedString.copy;
}


#pragma mark - Private
- (NSMutableDictionary *)attributesForKeys {
    
    if (_attributesForKeys == nil) {
        _attributesForKeys = [NSMutableDictionary new];
    }
    return _attributesForKeys;
}

- (NSArray *)attributesWithValue: (id)value propertyName: (NSString *)propertyName {
    
    NSMutableArray *attributesArray = @[[NSMutableDictionary new]].mutableCopy;
    
    if ([value isKindOfClass: IDXMLModel.class]) {
        IDXMLModel *model = (IDXMLModel *)value;
        [attributesArray.firstObject addEntriesFromDictionary:model.attributes];
    }
    else if ([value isKindOfClass: NSArray.class]) {
        NSArray *array = (NSArray *)value;
        attributesArray = [NSMutableArray arrayWithCapacity:array.count];
        
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            attributesArray[idx] = [NSMutableDictionary new];
            if ([obj isKindOfClass: IDXMLModel.class]) {
                IDXMLModel *model = (IDXMLModel *)obj;
                [attributesArray[idx] addEntriesFromDictionary:model.attributes];
            }
        }];
    }
    
    if ([self.attributesForKeys.allKeys containsObject:propertyName]) {
        [attributesArray.firstObject addEntriesFromDictionary:self.attributesForKeys[propertyName]];
    }
    
    return attributesArray.copy;
}

- (NSString *)handledPrefixForPropertyName: (NSString *)propertyName {
    
    NSDictionary <NSString *, NSString *> *prefixes = [self prefixesForPropertyKeys];
    
    NSString *prefix = [self defaultPrefix];
    if ([prefixes.allKeys containsObject:propertyName]) {
        prefix = prefixes[propertyName];
    }
    
    return prefix;
}

@end
