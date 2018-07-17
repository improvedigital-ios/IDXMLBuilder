//
//  ViewController.m
//  Sample
//
//  Created by Андрей on 13.07.2018.
//  Copyright © 2018 Improve Digital. All rights reserved.
//

#import "ViewController.h"
#import "IDXMLBuilder.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    IDXMLBuilder *builder = [IDXMLBuilder builderWithElementBlock:^IDXMLElement *{
        
        return [IDXMLElement elementWithParameter:@"bookstore" valuesBlock:^NSArray<IDXMLElement *> *{
            
            return @[
                     
                     [IDXMLElement elementWithParameter:@"book" attributes:@{@"category" : @"cooking"} valuesBlock:^NSArray<IDXMLElement *> *{
                         
                         return @[[IDXMLElement elementWithParameter: @"title" attributes: @{@"lang" : @"en"} value: @"Everyday Italian"  ],
                                  [IDXMLElement elementWithParameter: @"author" value: @"Giada De Laurentiis" ],
                                  [IDXMLElement elementWithParameter: @"year" value: @(2005) ],
                                  [IDXMLElement elementWithParameter: @"price" value: @(30.00) ]];
                     }],
                     
                     [IDXMLElement elementWithParameter:@"book" attributes:@{@"category" : @"children"} valuesBlock:^NSArray<IDXMLElement *> *{
                         
                         return @[[IDXMLElement elementWithParameter: @"title" attributes: @{@"lang" : @"en"} value: @"Harry Potter"  ],
                                  [IDXMLElement elementWithParameter: @"author" value: @"J K. Rowling" ],
                                  [IDXMLElement elementWithParameter: @"year" value: @(2005) ],
                                  [IDXMLElement elementWithParameter: @"price" value: @(29.99) ]];
                     }],
                     
                     [IDXMLElement elementWithParameter:@"book" attributes:@{@"category" : @"web"} valuesBlock:^NSArray<IDXMLElement *> *{
                         
                         return @[[IDXMLElement elementWithParameter: @"title" attributes: @{@"lang" : @"en"} value: @"Learning XML"  ],
                                  [IDXMLElement elementWithParameter: @"author" value: @"Erik T. Ray" ],
                                  [IDXMLElement elementWithParameter: @"year" value: @(2003) ],
                                  [IDXMLElement elementWithParameter: @"price" value: @(39.95) ]];
                     }]
                     
                     ];
        }];
    }];
    
    
    NSLog(@"%@", builder.result);
}



@end
