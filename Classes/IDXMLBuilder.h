//
//  IDXMLBuilder.h
//  Sample
//
//  Created by Андрей on 13.07.2018.
//  Copyright © 2018 Improve Digital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IDXMLElement.h"

@interface IDXMLBuilder : NSObject

+ (instancetype)builderWithElementsBlock: (NSArray <IDXMLElement *> *(^)(void))block;
+ (instancetype)builderWithElementBlock: (IDXMLElement *(^)(void))block;

@property (nonatomic, strong) NSString *defaultPrefix;

- (NSString *)result;

@end
