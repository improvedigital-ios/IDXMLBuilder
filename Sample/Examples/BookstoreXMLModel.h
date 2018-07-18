//
//  BookstoreXMLModel.h
//  Sample
//
//  Created by Андрей on 18.07.2018.
//  Copyright © 2018 Improve Digital. All rights reserved.
//

#import "IDXMLModel.h"
#import "BookXMLModel.h"

@interface BookstoreXMLModel : IDXMLModel

@property (nonatomic, strong) NSArray <BookXMLModel *> *book;

@end
