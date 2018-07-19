# IDXMLBuilder

## Some description
IDXMLBuilder is a library for XML format text generation with ObjC (hello 2018 year) by 2 ways:
- via IDXMLBuilder
- via IDXMLModel (based on idea of [JSONModel](https://github.com/jsonmodel/jsonmodel))

## Example as XMLModel
```objective-c
BookXMLModel *book1 = [BookXMLModel new];
book1.defaultPrefix = @"xml";
book1.title = @"Everyday Italian";
book1.author = @"Giada De Laurentiis";
book1.year = 2005;
book1.price = 30.00;
book1.attributes = @{@"category" : @"cooking"};
[book1 addAttributes: @{@"lang" : @"en"} forKey: @"title"];

BookXMLModel *book2 = [BookXMLModel new];
book2.defaultPrefix = @"xml";
book2.title = @"Harry Potter";
book2.author = @"J K. Rowling";
book2.year = 2005;
book2.price = 29.99;
book2.attributes = @{@"category" : @"children"};
[book2 addAttributes: @{@"lang" : @"en"} forKey: @"title"];

BookXMLModel *book3 = [BookXMLModel new];
book3.defaultPrefix = @"xml";
book3.title = @"Learning XML";
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
```

## Example as XMLBuilder

```objective-c
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
```

## OUTPUT is

```XML
<?xml version="1.0" encoding="UTF-8"?>
<xml:bookstore xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:mob="http://www.bacup-it.com/Integration/MobileAppService">
<xml:book category="cooking">
<xml:title lang="en">Everyday Italian</xml:title lang="en">
<xml:author>Giada De Laurentiis</xml:author>
<xml:year>2005</xml:year>
<xml:price>30</xml:price>
</xml:book category="cooking">
<xml:book category="children">
<xml:title lang="en">Harry Potter</xml:title lang="en">
<xml:author>J K. Rowling</xml:author>
<xml:year>2005</xml:year>
<xml:price>29.99</xml:price>
</xml:book category="children">
<xml:book category="web">
<xml:title lang="en">Learning XML</xml:title lang="en">
<xml:author>Erik T. Ray</xml:author>
<xml:year>2003</xml:year>
<xml:price>39.95</xml:price>
</xml:book category="web">
</xml:bookstore xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:mob="http://www.bacup-it.com/Integration/MobileAppService">

```
