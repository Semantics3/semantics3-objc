//
//  Offers.m
//  semantics3-objc
//
//  Created by Siddharthan Asokan on 23/8/13.
//  Copyright (c) 2013 Semantics3. All rights reserved.
//

#import "Offers.h"

@implementation Offers
-(id) initOffers:(NSString *)apiSecret andKey:(NSString *)apiKey
{
    self = [super init];
    if(self)
    {
        self = [super initSemantic3Request:apiKey withapiSecret:apiSecret andEndpoints:@"offers"];
        
    }
    return self;
}


-(void )getOffers{
    
    [super runQuery];
}

-(void)offersField:(id)offerFields{
    
    [super field:offerFields];
}



@end
