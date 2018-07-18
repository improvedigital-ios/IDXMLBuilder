//
//  BookXMLModel.h
//  Sample
//
//  Created by Андрей on 18.07.2018.
//  Copyright © 2018 Improve Digital. All rights reserved.
//

#import "IDXMLModel.h"

@interface BookXMLModel : IDXMLModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) double price;

@end
