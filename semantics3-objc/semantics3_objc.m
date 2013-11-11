//
//  semantics3_objc.m
//  semantics3-objc
//
//  Created by Siddharthan Asokan on 5/11/13.
//  Copyright (c) 2013 Semantics3. All rights reserved.
//


#import "semantics3_objc.h"
#import <UIKit/UIKit.h>
@implementation semantics3_objc
@synthesize apiKey,apiSecret,endPoint,endpointURL,urlBuilder,consumer,query,queryResult,querybuild;
@synthesize fetcher,qParam,request,keyArray,dictHanger,queryBuild;


-(id)initSemantic3Request:(NSString *)api_Key withapiSecret:(NSString *)api_Secret andEndpoints:(NSString *)end_Point{
    
    
    
    if ( self = [super init] ) {
        
        
        
        
        if(api_Key == nil){
            UIAlertView *noAPIKeyAlert = [[UIAlertView alloc] initWithTitle:@"API Credentials Missing" message:@"You did not supply an apiKey. Please sign up  to obtain your api_key." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [noAPIKeyAlert show];
            
        }
        if (api_Secret == nil) {
            UIAlertView *noAPISecretInfo = [[UIAlertView alloc] initWithTitle:@"API Credentials Missing" message:@"You did not provide an apiSecret. Please sign up at https://semantics3.com/ to obtain your api_key." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [noAPISecretInfo show];
            
        }
        
        apiKey = api_Key;
        apiSecret =api_Secret;
        endPoint = end_Point;
        consumer = [[OAConsumer alloc] initWithKey:apiKey secret:apiSecret];
        querybuild = [[NSMutableDictionary alloc] init];
        query = [[NSString alloc] init];
        keyArray = [[NSMutableArray alloc] init];
        
        queryBuild = [[NSMutableDictionary alloc] init];
        isNested = false;
        
        
    }
    return self;
    
}






-(void)field:(id)fields{
    
    
    if([fields isKindOfClass:[NSMutableDictionary class]]){
        
        
        
        
        query = [fields JSONString];
    }else if ([fields isKindOfClass:[NSString class]]){
        query = fields;
    }
    
}










-(void)runQuery{
    
    [self runQuery:endPoint];
    
    
}




-(void)runQuery:(NSString *)end_Point{
    
    
    [self fetch:end_Point andParameter:query];
    
    
    
}

-(void)fetch:(NSString *)end_Point andParameter:(NSString *)params{
    
    
    NSURL *url = [NSURL URLWithString:[@"https://api.semantics3.com/v1/" stringByAppendingString:end_Point]];
    
    request = [[OAMutableURLRequest alloc] initWithURL:url
                                              consumer:consumer
                                                 token:nil
                                                 realm:nil
                                     signatureProvider:nil]; // use the default method, HMAC-SHA1
    
    [request setHTTPMethod:@"GET"];
    
    
    
    
    qParam = [[OARequestParameter alloc] initWithName:@"q" value:params ];
    
    //qParam = [[OARequestParameter alloc] initWithName:@"q" value:@"{\"cat_id\":13658,\"model\":\"Satellite\"}"];
    
    NSArray *paramArray = [NSArray arrayWithObjects:qParam, nil];
    
    
    [request setParameters:paramArray];
    
    fetcher = [[OADataFetcher alloc] init];
    
    
    [fetcher fetchDataWithRequest:request
                         delegate:self
                didFinishSelector:@selector(requestDidFinishWithData:)
                  didFailSelector:@selector(requestDidFailWithError:)];
    
    
    
    
}

- (void)requestDidFinishWithData:(OAServiceTicket *)ticket {
    
    queryResult= [[NSString alloc] initWithData:ticket.data
                                       encoding:NSUTF8StringEncoding];
    
    
    
    
    [self.delegate queryData:queryResult];
    
    
}


- (void)requestDidFailWithError:(NSError *)error {
    
    NSLog(@"Request did fail with error: %@", [error localizedDescription]);
}

-(void)buildQuery:(id)object andKeys:(NSString *)keys{
    [self indexIdentifier:keys];
    NSArray *temp_keyHolder = [keys componentsSeparatedByString:@","];
    
    
    //setting object with keys as assigned by the user **initial**
    
    if(temp_keyHolder.count -1){
        
        if(isNested){
            
            //NESTED CASE
            NSMutableDictionary *temp_queryBuilder = [[NSMutableDictionary alloc] init];
            [temp_queryBuilder setDictionary:queryBuild];
            
            for (int i = 0; i <indexFinder ; i++) {
                NSMutableDictionary *temp_DictSplitter = [[NSMutableDictionary alloc] init];
                
                if( [[temp_queryBuilder objectForKey:[temp_keyHolder objectAtIndex:i]] isKindOfClass:[NSMutableDictionary class]]){
                    temp_DictSplitter = [temp_queryBuilder objectForKey:[temp_keyHolder objectAtIndex:i]];
                    temp_queryBuilder = [[NSMutableDictionary alloc] init];
                    [temp_queryBuilder setDictionary:temp_DictSplitter];
                    
                    if(i == indexFinder -1){
                        dictHanger = temp_queryBuilder;
                    }
                }else{
                    NSString *temp_stringObjSaver = [temp_queryBuilder objectForKey:[temp_keyHolder objectAtIndex:i]];
                    
                    if(i == indexFinder -1){
                        dictHanger = temp_stringObjSaver;
                    }
                }
                
            }
            
            NSMutableDictionary *temp_Dict = [[NSMutableDictionary alloc] init];
            [temp_Dict setObject:object  forKey:[temp_keyHolder objectAtIndex:temp_keyHolder.count - 1]];
            
            
            for (int j = (int)temp_keyHolder.count -2 ; j >= indexFinder ; --j) {
                NSMutableDictionary *subDict = [[NSMutableDictionary alloc] init];
                [subDict setDictionary:temp_Dict];
                temp_Dict = [[NSMutableDictionary alloc] init];
                [temp_Dict setObject:subDict forKey:[temp_keyHolder objectAtIndex:j]];
                
            }
            
            if ([dictHanger isKindOfClass:[NSMutableDictionary class]]) {
                NSMutableDictionary *dict1 = dictHanger;
                NSMutableDictionary *dict2 = temp_Dict;
                [dict1 addEntriesFromDictionary:dict2];
                //[dict setDictionary:dict1];
                temp_queryBuilder = [[NSMutableDictionary alloc] init];
                for (int k = indexFinder -1; k >=1 ; --k) {
                    NSMutableDictionary *subDict = [[NSMutableDictionary alloc] init];
                    [subDict setObject:dict1 forKey:[temp_keyHolder objectAtIndex:k]];
                    dict1 = [[NSMutableDictionary alloc] init];
                    [dict1 setDictionary:subDict];
                    
                    
                }
                
                [queryBuild setObject:dict1 forKey:[temp_keyHolder objectAtIndex:0]];
                
            }else if([dictHanger isKindOfClass:[NSString class]]){
                
                //Error catching to be added
                
            }
            
            
            
        }else{
            NSMutableDictionary *temp_Dict = [[NSMutableDictionary alloc] init];
            [temp_Dict setObject:object  forKey:[temp_keyHolder objectAtIndex:temp_keyHolder.count - 1]];
            
            //NEW KEYS AND OBJECTS
            for (int i = (int)temp_keyHolder.count - 2; i>0; --i) {
                
                NSMutableDictionary *subDict = [[NSMutableDictionary alloc] init];
                [subDict setDictionary:temp_Dict];
                temp_Dict = [[NSMutableDictionary alloc] init];
                [temp_Dict setObject:subDict forKey:[temp_keyHolder objectAtIndex:i]];
            }
            [queryBuild setObject:temp_Dict forKey:[temp_keyHolder objectAtIndex:0]];
            
        }
    }else{
        [queryBuild setObject:object forKey:keys];
    }
    
    NSLog(@"query builder output: %@",[queryBuild JSONString]);
    query = [queryBuild JSONString];
    
}


-(void)indexIdentifier:(NSString *)key_String{
    
    
    
    NSArray *keyHolder = [key_String componentsSeparatedByString:@","];
    
    [keyArray addObject:keyHolder];
    
    indexFinder = 0;
    
    if (keyArray.count -1 > 0) {
        
        
        int tempCount = 0;
        
        for (int i = 0 ; i < keyArray.count - 1; i++) {
            NSArray *keyRetreiver = [keyArray objectAtIndex:i];
            
            int counter = 0;
            
            for (int j = 0; j < keyHolder.count - 1; j ++) {
                if(j < keyRetreiver.count){
                    if ([[keyHolder objectAtIndex:j]isEqualToString: [keyRetreiver objectAtIndex:j]]) {
                        counter  = counter + 1;
                        
                    }else{
                        //  break;
                    }
                }
            }
            if (counter > tempCount) {
                tempCount = counter;
            }
            
            
        }
        indexFinder = tempCount ;
        if(indexFinder){
            isNested = TRUE;
        }else{
            isNested = FALSE;
        }
        
    }
    
    
}




@end


