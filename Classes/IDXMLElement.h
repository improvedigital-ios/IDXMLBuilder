//
//  IDXMLElement.h
//  Sample
//
//  Created by Андрей on 13.07.2018.
//  Copyright © 2018 Improve Digital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDXMLValue.h"

@interface IDXMLElement : NSObject

// Simplified
+ (instancetype)elementWithParameter: (NSString *)parameter
                               value: (NSObject *)value;

+ (instancetype)elementWithParameter: (NSString *)parameter
                         valuesBlock: (NSArray <IDXMLElement *> *(^)(void))block;

+ (instancetype)elementWithParameter: (NSString *)parameter
                          valueBlock: (IDXMLElement *(^)(void))block;

+ (instancetype)elementWithParameter: (NSString *)parameter
                          attributes: (NSDictionary <NSString *, NSString *> *)attributes
                               value: (NSObject *)value;

+ (instancetype)elementWithParameter: (NSString *)parameter
                          attributes: (NSDictionary <NSString *, NSString *> *)attributes
                         valuesBlock: (NSArray <IDXMLElement *> *(^)(void))block;

+ (instancetype)elementWithParameter: (NSString *)parameter
                          attributes: (NSDictionary <NSString *, NSString *> *)attributes
                          valueBlock: (IDXMLElement *(^)(void))block;


// Common
+ (instancetype)elementWithWithParameter: (NSString *)parameter;
- (instancetype)withValue: (IDXMLValue *)value;
- (instancetype)withPrefix: (NSString *)prefix forNamespace: (NSString *)aNamespace;
- (instancetype)withAttribute: (NSString *)attribute value: (NSString *)value;
- (instancetype)withPrefix: (NSString *)prefix;

@property (nonatomic, strong, readonly) NSString *parameter;
@property (nonatomic, strong, readonly) IDXMLValue *value;
@property (nonatomic, strong, readonly) NSString *prefix;
@property (nonatomic, strong, readonly) NSDictionary *namespaces;
@property (nonatomic, strong, readonly) NSDictionary *attributes;

- (NSString *)representedString;

@end
