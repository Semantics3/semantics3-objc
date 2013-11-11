//
//  Products.h
//  semantics3-objc
//
//  Created by Siddharthan Asokan on 23/8/13.
//  Copyright (c) 2013 Semantics3. All rights reserved.
//

#import "semantics3_objc.h"

@interface Products : semantics3_objc


@property (nonatomic,strong) NSString *api_Key;
@property (nonatomic,strong) NSString *api_Secret;

-(id) initProducts:(NSString *)apiSecret andKey:(NSString *)apiKey;

-(void)getProducts;


-(void)productsField:(id)productFields;

-(void)siteDetails:(id)siteFields;
-(void)latestOffers:(id)latestOfferFields;
-(void)siteDetails:(NSString *)object andKeys:(NSString *)keys;
-(void)latestOffers:(NSString *)object andKeys:(NSString *)keys;

@end
