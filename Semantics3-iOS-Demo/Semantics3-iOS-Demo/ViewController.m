//
//  ViewController.m
//  Semantics3-iOS-Demo
//
//  Created by Siddharthan Asokan on 10/11/13.
//  Copyright (c) 2013 Semantics3. All rights reserved.
//

#import "ViewController.h"
#define OAUTH_KEY @""
#define OAUTH_SECRET @""

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
      semantics3_objc *sem = [[semantics3_objc alloc] initSemantic3Request:OAUTH_KEY withapiSecret:OAUTH_SECRET andEndpoints:@"products"];
    
    NSMutableDictionary *tempDict = [[NSMutableDictionary alloc] init];
    
    [tempDict setObject:@"4znupRCkN6w2Q4Ke4s6sUC" forKey:@"sem3_id"];
    [tempDict setObject:@"Satellite" forKey:@"mod"];
    
    sem.delegate = self;
    [sem field:tempDict];
    [sem runQuery];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)queryData:(NSString *)content{
    NSLog(@"content output: %@",content);
}

@end
