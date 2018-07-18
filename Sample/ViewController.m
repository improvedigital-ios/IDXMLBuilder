//
//  ViewController.m
//  Sample
//
//  Created by Андрей on 13.07.2018.
//  Copyright © 2018 Improve Digital. All rights reserved.
//

#import "ViewController.h"
#import "IDXMLBuilder.h"

#import "RootXMLModel.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BookXMLModel *book1 = [BookXMLModel new];
    book1.title = @"Everyday Italian";
    book1.author = @"Giada De Laurentiis";
    book1.year = 2005;
    book1.price = 30.00;
    [book1 addAttributes: @{@"category" : @"cooking"} forKey: @"self"];
    [book1 addAttributes: @{@"lang" : @"en"} forKey: @"title"];
    
    BookXMLModel *book2 = [BookXMLModel new];
    book2.title = @"Harry Potter";
    book2.author = @"J K. Rowling";
    book2.year = 2005;
    book2.price = 29.99;
    [book2 addAttributes: @{@"category" : @"children"} forKey: @"self"];
    [book2 addAttributes: @{@"lang" : @"en"} forKey: @"title"];
    
    BookXMLModel *book3 = [BookXMLModel new];
    book3.title = @"Learning XML";
    book3.author = @"Erik T. Ray";
    book3.year = 2003;
    book3.price = 39.95;
    [book3 addAttributes: @{@"category" : @"web"} forKey: @"self"];
    [book3 addAttributes: @{@"lang" : @"en"} forKey: @"title"];
    
    BookstoreXMLModel *bookstore = [BookstoreXMLModel new];
    bookstore.book = @[book1, book2, book3];
    
    RootXMLModel *root = [RootXMLModel new];
    root.bookstore = bookstore;

    NSLog(@"%@", root.toXMLString);
    
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
