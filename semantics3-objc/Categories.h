//
//  Categories.h
//  semantics3-objc
//
//  Created by Siddharthan Asokan on 23/8/13.
//  Copyright (c) 2013 Semantics3. All rights reserved.
//

#import "semantics3_objc.h"

@interface Categories : semantics3_objc

-(id) initCategories:(NSString *)apiSecret andKey:(NSString *)apiKey;
-(void )getCategories;
-(void)catergoriesField:(id)catFields;
@end
