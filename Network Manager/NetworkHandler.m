//
//  NetworkHandler.m
//  CuB
//
//  Created by Vishwavijet on 23/02/17.
//  Copyright © 2017 Tamil Selvan R. All rights reserved.
//

#import "NetworkHandler.h"
#define kAPIURL @"http://192.168.2.109:1709/api/"
static NetworkHandler *sharedContextManager = nil;

@implementation NetworkHandler
+ (void) initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedContextManager = [[NetworkHandler alloc] init];
    });
}


+ (NetworkHandler *)sharedInstance
{
    return sharedContextManager;
}

#pragma mark - Class useful methods
/**
 * Method to create an instance url and execute the web service
 **/
- (NSMutableURLRequest *)requestWithURL: (NSString *)servicePath
                             httpMethod: (NSString *)httpMethod
                                   body: (NSData *)requestBody
{
    NSMutableURLRequest *request = nil;
    
    
    //Creates an Service Request.
    request =  [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:servicePath] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:300];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = httpMethod;
    request.HTTPBody = requestBody;
    
    return request;
}

- (NSData *)getDataFrom:(id)value{
    return [NSJSONSerialization dataWithJSONObject:value options:NSJSONWritingPrettyPrinted error:nil];
}

-(id)getJSONfromData:(NSData *)response{
    return [NSJSONSerialization JSONObjectWithData:response options:1 error:nil];
}


#pragma mark - Service Request APIs
//Login
-(void)loginUserwithDetails:(NSDictionary *)loginDict withURL:(NSString *)url withMethod:(NSString *)method  completionHandler:(void(^)(NSDictionary *response, NSError *error))completionHandler{
    
    NSString *servicePath = [kAPIURL stringByAppendingString:url];
    NSMutableURLRequest *request = [self requestWithURL:servicePath httpMethod:method body:[self getDataFrom:loginDict]];
    
    NSURLSessionDataTask *session = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *response = [self getJSONfromData:data];
            completionHandler(response,nil);
        }
    }];
    [session resume];
    
}

//register device
-(void)registerDeviceTokenWithDetails:(NSDictionary *)details withURL:(NSString *)url withMethod:(NSString *)method completionHandler:(void(^)(NSDictionary *response, NSError *error))completion{
    NSString *servicePath = [kAPIURL stringByAppendingString:url];
    NSMutableURLRequest *request = [self requestWithURL:servicePath httpMethod:method body:[self getDataFrom:details]];
    
    NSURLSessionDataTask *session = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData  *_Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *response = [self getJSONfromData:data];
            completion(response,nil);
        }
    }];
    [session resume];
}


//Update location
-(void)updateLocationDetails:(NSDictionary *)locDetails withURL:(NSString *)url withMethod:(NSString *)method completionHandler:(void(^)(NSDictionary *response, NSError *error))completion{
    NSString *servicePath = [kAPIURL stringByAppendingString:url];
    NSMutableURLRequest *request = [self requestWithURL:servicePath httpMethod:method body:[self getDataFrom:locDetails]];
    
    NSURLSessionDataTask *session = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData  *_Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *response = [self getJSONfromData:data];
            completion(response,nil);
        }
    }];
    [session resume];
}
@end
