//
//  IDXMLBuilder.m
//  Sample
//
//  Created by Андрей on 13.07.2018.
//  Copyright © 2018 Improve Digital. All rights reserved.
//

#import "IDXMLBuilder.h"

@interface IDXMLBuilder ()

@property (nonatomic, strong) NSString *xml;

@end

@implementation IDXMLBuilder

+ (instancetype)builderWithElementsBlock: (NSArray <IDXMLElement *> *(^)(void))block {
    
    IDXMLBuilder *builder = [[IDXMLBuilder alloc] init];

    if (block != nil) {
        
        NSMutableString *mutableString = @"".mutableCopy;
        NSArray <IDXMLElement *> *elements = block();
        [elements enumerateObjectsUsingBlock:^(IDXMLElement * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *representedString = [obj representedString];
            [mutableString appendString:representedString];
            if (elements.count - 1 != idx) {
                [mutableString appendString:@"\n"];
            }
        }];
        builder.xml = [builder.xml stringByAppendingString:mutableString.copy];
    }

    return builder;
}

+ (instancetype)builderWithElementBlock: (IDXMLElement *(^)(void))block {
    
    return [self builderWithElementsBlock:^NSArray<IDXMLElement *> *{
        IDXMLElement *element = block();
        return @[element];
    }];
}

- (NSString *)result {
    return self.xml;
}


#pragma mark - Private
- (instancetype)init {
    self = [super init];
    if (self) {
        self.xml = @"\n";
    }
    return self;
}

@end
