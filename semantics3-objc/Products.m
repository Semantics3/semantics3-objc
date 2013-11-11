//
//  Products.m
//  semantics3-objc
//
//  Created by Siddharthan Asokan on 23/8/13.
//  Copyright (c) 2013 Semantics3. All rights reserved.
//

#import "Products.h"

@implementation Products

-(id) initProducts:(NSString *)apiSecret andKey:(NSString *)apiKey
{
    self = [super init];
    
    if( (self = [super init]) ) {
        
        
        
        self = [super initSemantic3Request:apiKey withapiSecret:apiSecret andEndpoints:@"products"];
    }
    return self;
    
}



-(void)getProducts{
    [super runQuery:@"products"];
}






-(void)productsField:(id)productfields{
    [super field:productfields];
}


-(void)latestOffers:(id)latestOfferFields{
    
    
    [super field:latestOfferFields];
    
    
    
}


-(void)siteDetails:(id)siteFields{
    
    
    [super field:siteFields];
    
    
}



-(void)latestOffers:(NSString *)object andKeys:(NSString *)keys{
    NSString *offerKey = [[[[@"sitedetails" stringByAppendingString:@","] stringByAppendingString:@"latestoffers"] stringByAppendingString:@","] stringByAppendingString:keys];
    [super buildQuery:object andKeys:offerKey];
}

-(void)siteDetails:(NSString *)object andKeys:(NSString *)keys{
    
    NSString *siteDetailKey = [[@"sitedetails" stringByAppendingString:@","] stringByAppendingString:keys];
    [super buildQuery:object andKeys:siteDetailKey];
    
}

@end
