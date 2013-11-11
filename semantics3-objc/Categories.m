//
//  Categories.m
//  semantics3-objc
//
//  Created by Siddharthan Asokan on 23/8/13.
//  Copyright (c) 2013 Semantics3. All rights reserved.
//

#import "Categories.h"

@implementation Categories

-(id) initCategories:(NSString *)apiSecret andKey:(NSString *)apiKey
{
    self = [super init];
    if(self)
    {
        self = [super initSemantic3Request:apiKey withapiSecret:apiSecret andEndpoints:@"categories"];
        
    }
    return self;
}




-(void)getCategories{
    
    [super runQuery];
}

-(void)catergoriesField:(id)catFields{
    [super field:catFields];
    
}


@end
