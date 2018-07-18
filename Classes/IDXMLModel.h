//
//  IDXMLModel.h
//  Sample
//
//  Created by Андрей on 17.07.2018.
//  Copyright © 2018 Improve Digital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDXMLModel : NSObject

- (NSString *)toXMLString;

- (void)addAttributes: (NSDictionary <NSString *, NSString *> *)attributes forKey: (NSString *)key;
- (NSDictionary <NSString *, NSString *> *)prefixesForPropertyKeys;

@end
