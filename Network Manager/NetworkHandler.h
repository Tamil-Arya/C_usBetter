//
//  NetworkHandler.h
//  CuB
//
//  Created by Vishwavijet on 23/02/17.
//  Copyright © 2017 Tamil Selvan R. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkHandler : NSObject
+(NetworkHandler *)sharedInstance;

@property(nonatomic,strong)NSString *loginUserID;
@property(nonatomic,strong)NSString *deviceToken;

-(void)loginUserwithDetails:(NSDictionary *)loginDict withURL:(NSString *)url withMethod:(NSString *)method completionHandler:(void(^)(NSDictionary *response, NSError *error))completionHandler;

-(void)registerDeviceTokenWithDetails:(NSDictionary *)details withURL:(NSString *)url withMethod:(NSString *)method completionHandler:(void(^)(NSDictionary *response, NSError *error))completion;
@end
