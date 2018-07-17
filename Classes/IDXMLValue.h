//
//  IDXMLValue.h
//  Sample
//
//  Created by Андрей on 13.07.2018.
//  Copyright © 2018 Improve Digital. All rights reserved.
//

#import <Foundation/Foundation.h>
@class IDXMLElement;

@interface IDXMLValue : NSObject

+ (instancetype)valueWithString: (NSString *)string;
+ (instancetype)valueWithElementBlock: (IDXMLElement *(^)(void))block;
+ (instancetype)valueWithElementsBlock: (NSArray <IDXMLElement *> *(^)(void))block;

@property (nonatomic, strong, readonly) NSString *stringValue;
@property (nonatomic, strong, readonly) NSArray <IDXMLElement *> *elements;

@end
