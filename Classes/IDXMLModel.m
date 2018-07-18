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

@interface IDXMLModel ()

@property (nonatomic, strong) NSMutableDictionary <NSString *, NSDictionary <NSString *, NSString *> *> *attributes;

@end

@implementation IDXMLModel

- (NSString *)toXMLString {
    
    Class objType = [self class];
    
    unsigned int count;
    
    objc_property_t* props = class_copyPropertyList(objType, &count);
    
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < count; i++) {
        
        objc_property_t property = props[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        
        id value = [self valueForKey:propertyName];
        
        //NSString *stringValue = [self safeStringValue:value propertyName: propertyName];
        
        NSDictionary <NSString *, NSString *> *prefixes = [self prefixesForPropertyKeys];
        
        NSString *prefix = [self defaultPrefix];
        if ([prefixes.allKeys containsObject:propertyName]) {
            prefix = prefixes[propertyName];
        }

        //[mutableString appendString:@"\n"];
        
        NSString *string = [IDXMLStringGenerator representedStringWithPrefix:prefix
                                                                   parameter:propertyName
                                                                       value:value
                                                                  attributes:nil];
        
//        if (i != 0) {
//            string = string.tabulated;
//            
            [mutableString appendString:string];
//            [mutableString appendString:@"\n"];
//        }

    }
    
    free(props);
    return mutableString.copy;
}

- (void)addAttributes: (NSDictionary <NSString *, NSString *> *)attributes forKey: (NSString *)key {
    self.attributes[key] = attributes;
}

- (NSString *)defaultPrefix {
    return nil;
}

- (NSDictionary <NSString *, NSString *> *)prefixesForPropertyKeys {
    return nil;
}

#pragma mark - Private
- (NSMutableDictionary *)attributes {
    
    if (_attributes == nil) {
        _attributes = [NSMutableDictionary new];
    }
    return _attributes;
}

//- (void)appendToString: (NSMutableString *)mutableString
//             withValue: (id)value
//          propertyName: (NSString *)propertyName {
//    
//    NSString *stringValue = [self safeStringValue:value];
//    
//    NSDictionary <NSString *, NSString *> *prefixes = [self prefixesForPropertyKeys];
//    
//    NSString *prefix = [self defaultPrefix];
//    if ([prefixes.allKeys containsObject:propertyName]) {
//        prefix = prefixes[propertyName];
//    }
//    
//    NSString *string = [IDXMLStringGenerator representedStringWithPrefix:prefix
//                                                               parameter:propertyName
//                                                                   value:stringValue
//                                                              attributes:nil];
//    
//    //string = [string tabulated];
//    
//    [mutableString appendString:string];
//    [mutableString appendString:@"\n"];
//}

//- (NSString *)safeStringValue: (id)value propertyName: (NSString *)propertyName {
//
//    NSString *safeString = nil;
//    if ([value isKindOfClass:IDXMLModel.class]) {
//        IDXMLModel *m = (IDXMLModel *)value;
//        safeString = [m toXMLString];
//    }
//    else if ([value isKindOfClass:NSNumber.class]) {
//        NSNumber *n = (NSNumber *)value;
//        safeString = [n stringValue];
//    }
//    else if ([value isKindOfClass:NSArray.class]) {
//
//        NSMutableString *mutableString = @"".mutableCopy;
//        NSArray *a = (NSArray *)value;
//        for (NSObject *object in a) {
//
//            //NSString *temporaryString = [self safeStringValue:object propertyName:propertyName];
//            //[mutableString appendString:temporaryString];
//            [self appendToString:mutableString withValue:object propertyName:propertyName];
//        }
//        safeString = mutableString.copy;
//    }
//
//    return safeString;
//}

@end
