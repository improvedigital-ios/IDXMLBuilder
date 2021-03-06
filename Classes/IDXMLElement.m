//
//  IDXMLElement.m
//  Sample
//
//  Created by Андрей on 13.07.2018.
//  Copyright © 2018 Improve Digital. All rights reserved.
//

#import "IDXMLElement.h"
#import "IDXMLValue+Protected.h"
#import "IDXMLStringGenerator.h"

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
    
    NSString *safeString = [self.value representedValue];
    NSString *representedString = [IDXMLStringGenerator representedStringWithPrefix:self.prefix
                                                                          parameter:self.parameter
                                                                              value:safeString
                                                                    attributesArray:@[self.attributes]
                                                                            initial:YES];
    return representedString;
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
