//
//  Offers.h
//  semantics3-objc
//
//  Created by Siddharthan Asokan on 23/8/13.
//  Copyright (c) 2013 Semantics3. All rights reserved.
//

#import "semantics3_objc.h"

@interface Offers : semantics3_objc

-(id) initOffers:(NSString *)apiSecret andKey:(NSString *)apiKey;
-(void)getOffers;
-(void)offersField:(id)offerFields;

@end
