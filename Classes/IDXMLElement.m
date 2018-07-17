//
//  IDXMLElement.m
//  Sample
//
//  Created by Андрей on 13.07.2018.
//  Copyright © 2018 Improve Digital. All rights reserved.
//

#import "IDXMLElement.h"
#import "IDXMLValue+Protected.h"

@interface IDXMLElement ()

@property (nonatomic, strong, readwrite) NSString *parameter;
@property (nonatomic, strong, readwrite) IDXMLValue *value;
@property (nonatomic, strong, readwrite) NSString *prefix;
@property (nonatomic, strong, readwrite) NSMutableDictionary *mutableNamespaces;
@property (nonatomic, strong, readwrite) NSMutableDictionary *mutableAttributes;

@end

@implementation IDXMLElement

+ (instancetype)elementWithParameter: (NSString *)parameter
                               value: (NSObject *)value {
    
    return [self elementWithParameter:parameter attributes:nil value:value];
}

+ (instancetype)elementWithParameter: (NSString *)parameter
                         valuesBlock: (NSArray <IDXMLElement *> *(^)(void))block {
    
    IDXMLElement *element = [[IDXMLElement elementWithWithParameter:parameter]
                             withValue:[IDXMLValue valueWithElementsBlock:block]];
    return element;
}

+ (instancetype)elementWithParameter: (NSString *)parameter
                          valueBlock: (IDXMLElement *(^)(void))block {
    
    IDXMLElement *element = [[IDXMLElement elementWithWithParameter:parameter]
                             withValue:[IDXMLValue valueWithElementBlock:block]];
    return element;
}

+ (instancetype)elementWithParameter: (NSString *)parameter
                          attributes: (NSDictionary <NSString *, NSString *> *)attributes
                               value: (NSObject *)value {
    
    NSString *safeString = [self safeStringValue:value];
    
    __block IDXMLElement *element = [[IDXMLElement elementWithWithParameter:parameter]
                             withValue:[IDXMLValue valueWithString:safeString]];
    
    [attributes enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        element = [element withAttribute:key value:obj];
    }];
    
    return element;
}

+ (instancetype)elementWithParameter: (NSString *)parameter
                          attributes: (NSDictionary <NSString *, NSString *> *)attributes
                         valuesBlock: (NSArray <IDXMLElement *> *(^)(void))block {

    __block IDXMLElement *element = [[IDXMLElement elementWithWithParameter:parameter]
                                     withValue:[IDXMLValue valueWithElementsBlock:block]];
    
    [attributes enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        element = [element withAttribute:key value:obj];
    }];
    
    return element;
}

+ (instancetype)elementWithParameter: (NSString *)parameter
                          attributes: (NSDictionary <NSString *, NSString *> *)attributes
                          valueBlock: (IDXMLElement *(^)(void))block {
    
    __block IDXMLElement *element = [[IDXMLElement elementWithWithParameter:parameter]
                                     withValue:[IDXMLValue valueWithElementBlock:block]];
    
    [attributes enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        element = [element withAttribute:key value:obj];
    }];
    
    return element;
}


// -----

+ (instancetype)elementWithWithParameter: (NSString *)parameter {
    
    IDXMLElement *element = [[[self class] alloc] init];
    element.parameter = parameter;
    return element;
}

- (instancetype)withValue: (IDXMLValue *)value {
    
    self.value = value;
    return self;
}

- (instancetype)withPrefix: (NSString *)prefix forNamespace: (NSString *)aNamespace {
    
    self.mutableNamespaces[prefix] = aNamespace;
    return self;
}

- (instancetype)withAttribute: (NSString *)attribute value: (NSString *)value {
    
    self.mutableAttributes[attribute] = value;
    return self;
}

- (instancetype)withPrefix: (NSString *)prefix {
    
    self.prefix = prefix;
    return self;
}

- (NSString *)representedString {
    
    // Tags
    NSMutableString *tag = @"".mutableCopy;
    
    if (self.prefix.length) {
        [tag appendString:self.prefix];
        [tag appendString:@":"];
    }
    
    [tag appendString:self.parameter];
    [tag insertString:@"<" atIndex:0];
    [tag insertString:@">" atIndex:tag.length];
    
    NSMutableString *initialTag = tag.mutableCopy;
    NSMutableString *endTag = tag.mutableCopy;
    [endTag insertString:@"/" atIndex:1];
    
    // Attributes
    NSMutableString *attributes = @"".mutableCopy;
    [self.attributes enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        [attributes appendString:@" "];
        [attributes appendString:key];
        [attributes appendString:@"="];
        [attributes appendString:@"\""];
        
        if (obj.length) {
            [attributes appendString:obj];
        }

        [attributes appendString:@"\""];
    }];
    
    // Total string
    NSMutableString *totalString = initialTag.mutableCopy;
    
    if (attributes.length) {
        [totalString insertString:attributes.copy atIndex:totalString.length - 1];
    }
    
    NSString *safeString = [self.value representedValue];
    if (safeString.length) {
        [totalString appendString:safeString];
    }
    
    [totalString appendString:endTag.copy];
    return totalString.copy;
}

- (NSDictionary *)namespaces {
    return self.mutableNamespaces.copy;
}

- (NSDictionary *)attributes {
    return self.mutableAttributes.copy;
}


#pragma mark - Private

- (NSMutableDictionary *)mutableNamespaces {
    
    if (_mutableNamespaces == nil) {
        _mutableNamespaces = [NSMutableDictionary dictionary];
    }
    return _mutableNamespaces;
}

- (NSMutableDictionary *)mutableAttributes {
    
    if (_mutableAttributes == nil) {
        _mutableAttributes = [NSMutableDictionary dictionary];
    }
    return _mutableAttributes;
}


//TODO: Move to utility
+ (NSString *)safeStringValue: (NSObject *)value {
    
    NSString *safeString = nil;
    if ([value isKindOfClass:[NSString class]]) {
        safeString = (NSString *)value;
    }
    else if ([value isKindOfClass:[NSNumber class]]) {
        safeString = [(NSNumber *)value stringValue];
    }
    else {
        NSAssert(NO, @"Still not supported class: %@", NSStringFromClass(value.class));
    }
    
    return safeString;
}

@end
