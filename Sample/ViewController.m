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
    
    [self buildXMLViaModels];
    [self buildXMLViaBuilder];
}

- (void)buildXMLViaModels {

    BookXMLModel *book1 = [BookXMLModel new];
    book1.defaultPrefix = @"xml";
    book1.somethingWhatNeedToRename = @"Everyday Italian";
    book1.author = @"Giada De Laurentiis";
    book1.year = 2005;
    book1.price = 30.00;
    book1.attributes = @{@"category" : @"cooking"};
    [book1 addAttributes: @{@"lang" : @"en"} forKey: @"title"];
    
    BookXMLModel *book2 = [BookXMLModel new];
    book2.defaultPrefix = @"xml";
    book2.somethingWhatNeedToRename = @"Harry Potter";
    book2.author = @"J K. Rowling";
    book2.year = 2005;
    book2.price = 29.99;
    book2.attributes = @{@"category" : @"children"};
    [book2 addAttributes: @{@"lang" : @"en"} forKey: @"title"];
    
    BookXMLModel *book3 = [BookXMLModel new];
    book3.defaultPrefix = @"xml";
    book3.somethingWhatNeedToRename = @"Learning XML";
    book3.author = @"Erik T. Ray";
    book3.year = 2003;
    book3.price = 39.95;
    book3.attributes = @{@"category" : @"web"};
    [book3 addAttributes: @{@"lang" : @"en"} forKey: @"title"];
    
    BookstoreXMLModel *bookstore = [BookstoreXMLModel new];
    bookstore.defaultPrefix = @"xml";
    bookstore.book = @[book1, book2, book3];
    
    RootXMLModel *root = [RootXMLModel new];
    root.defaultPrefix = @"xml";
    NSDictionary *attributes = [self namespaces];
    [root addAttributes:attributes forKey:@"bookstore"];
    root.bookstore = bookstore;
    
    NSLog(@"\n%@\n", root.toXMLString);
}

- (void)buildXMLViaBuilder {
    
    IDXMLBuilder *builder = [IDXMLBuilder builderWithElementBlock:^IDXMLElement *{
        
        return [[IDXMLElement elementWithParameter:@"bookstore" attributes:[self namespaces] valuesBlock:^NSArray<IDXMLElement *> *{
            
            return @[
                     
                     [[IDXMLElement elementWithParameter:@"book" attributes:@{@"category" : @"cooking"} valuesBlock:^NSArray<IDXMLElement *> *{
                         
                         return @[[[IDXMLElement elementWithParameter: @"title" attributes: @{@"lang" : @"en"} value: @"Everyday Italian" ] withPrefix:@"xml"],
                                  [[IDXMLElement elementWithParameter: @"author" value: @"Giada De Laurentiis" ] withPrefix:@"xml"],
                                  [[IDXMLElement elementWithParameter: @"year" value: @(2005) ] withPrefix:@"xml"],
                                  [[IDXMLElement elementWithParameter: @"price" value: @(30.00) ] withPrefix:@"xml"]];
                     }] withPrefix:@"xml"],
                     
                     [[IDXMLElement elementWithParameter:@"book" attributes:@{@"category" : @"children"} valuesBlock:^NSArray<IDXMLElement *> *{
                         
                         return @[[[IDXMLElement elementWithParameter: @"title" attributes: @{@"lang" : @"en"} value: @"Harry Potter" ] withPrefix:@"xml"],
                                  [[IDXMLElement elementWithParameter: @"author" value: @"J K. Rowling" ] withPrefix:@"xml"],
                                  [[IDXMLElement elementWithParameter: @"year" value: @(2005) ] withPrefix:@"xml"],
                                  [[IDXMLElement elementWithParameter: @"price" value: @(29.99) ] withPrefix:@"xml"]];
                     }] withPrefix:@"xml"],
                     
                     [[IDXMLElement elementWithParameter:@"book" attributes:@{@"category" : @"web"} valuesBlock:^NSArray<IDXMLElement *> *{
                         
                         return @[[[IDXMLElement elementWithParameter: @"title" attributes: @{@"lang" : @"en"} value: @"Learning XML" ] withPrefix:@"xml"],
                                  [[IDXMLElement elementWithParameter: @"author" value: @"Erik T. Ray" ] withPrefix:@"xml"],
                                  [[IDXMLElement elementWithParameter: @"year" value: @(2003) ] withPrefix:@"xml"],
                                  [[IDXMLElement elementWithParameter: @"price" value: @(39.95) ] withPrefix:@"xml"]];
                     }] withPrefix:@"xml"]
                     
                     ];
        }] withPrefix:@"xml"];
    }];
    
    NSLog(@"%@", builder.result);
}

- (NSDictionary *)namespaces {
    
    return @{ @"xmlns:soapenv" : @"http://schemas.xmlsoap.org/soap/envelope/",
              @"xmlns:mob" : @"http://www.bacup-it.com/Integration/MobileAppService" };
}


@end
