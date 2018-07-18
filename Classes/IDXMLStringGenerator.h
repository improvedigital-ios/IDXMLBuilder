//
//  IDXMLStringGenerator.h
//  Sample
//
//  Created by Андрей on 17.07.2018.
//  Copyright © 2018 Improve Digital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDXMLStringGenerator : NSObject

+ (NSString *)representedStringWithPrefix: (NSString *)prefix
                                parameter: (NSString *)parameter
                                    value: (id)value
                               attributes: (NSDictionary *)attributes;

+ (NSString *)safeStringValue: (id)value;

@end
