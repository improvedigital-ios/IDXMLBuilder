//
//  RootXMLModel.h
//  Sample
//
//  Created by Андрей on 18.07.2018.
//  Copyright © 2018 Improve Digital. All rights reserved.
//

#import "IDXMLModel.h"
#import "BookstoreXMLModel.h"

@interface RootXMLModel : IDXMLModel

@property (nonatomic, strong) BookstoreXMLModel *bookstore;

@end
