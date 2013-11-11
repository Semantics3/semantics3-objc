//
//  semantics3_objc.h
//  semantics3-objc
//
//  Created by Siddharthan Asokan on 5/11/13.
//  Copyright (c) 2013 Semantics3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OAuthConsumer.h"
#import "JSONKit.h"
#import "NSString+URLEncoding.h"
#include <sys/types.h>

@protocol Sem3ObjCDelegate;

@interface semantics3_objc : NSObject{
    BOOL isNested;
    int indexFinder;
    
}
@property (strong,nonatomic) NSString *apiKey;
@property (strong,nonatomic) NSString *apiSecret;
@property (strong,nonatomic) NSString *endPoint;
@property (strong,nonatomic) NSString *endpointURL;
@property (strong,nonatomic) NSMutableString *urlBuilder;
@property (strong,nonatomic) OAConsumer *consumer;
@property (strong,nonatomic) OAMutableURLRequest *request;
@property (strong,nonatomic) OARequestParameter * qParam;
@property (strong,nonatomic) OADataFetcher *fetcher;
@property (strong,nonatomic) NSString *query;
@property (strong,nonatomic) NSMutableDictionary *querybuild;
@property (strong,nonatomic) NSString *queryResult;
@property (nonatomic, strong) id<Sem3ObjCDelegate> delegate;
@property(strong,nonatomic) NSMutableArray *keyArray;
@property(strong,nonatomic) NSMutableDictionary *queryBuild;
@property(strong,nonatomic) id dictHanger;

-(id)initSemantic3Request:(NSString *)api_Key withapiSecret:(NSString *)api_Secret andEndpoints:(NSString *)end_Point;
-(void)buildQuery:(id)object andKeys:(NSString *)keys;
-(void)field:(id)fields;
-(void)runQuery;
-(void)runQuery:(NSString *)end_Point;

@end


// 3. Definition of the delegate's interface
@protocol Sem3ObjCDelegate <NSObject>

- (void)queryData:(NSString *)content;

@end

