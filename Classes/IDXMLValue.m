//
//  IDXMLValue.m
//  Sample
//
//  Created by Андрей on 13.07.2018.
//  Copyright © 2018 Improve Digital. All rights reserved.
//

#import "IDXMLValue.h"
#import "IDXMLValue+Protected.h"
#import "IDXMLElement.h"

@interface IDXMLValue ()

@property (nonatomic, strong, readwrite) NSString *stringValue;
@property (nonatomic, strong, readwrite) NSArray <IDXMLElement *> *elements;

@end

@implementation IDXMLValue

+ (instancetype)valueWithString: (NSString *)string {
    
    IDXMLValue *value = [[self alloc] init];
    value.stringValue = string;
    return value;
}

+ (instancetype)valueWithElementBlock: (IDXMLElement *(^)(void))block {
    
    return [self valueWithElementsBlock:^NSArray<IDXMLElement *> *{
        
        if (block != nil) {
            return @[block()];
        }
        return nil;
    }];
}

+ (instancetype)valueWithElementsBlock: (NSArray <IDXMLElement *> *(^)(void))block {
    
    IDXMLValue *value = [[self alloc] init];
    
    if (block != nil) {
        NSArray <IDXMLElement *> *elements = block();
        if (elements.count) {
            value.elements = elements;
        }
    }

    return value;
}

@end
