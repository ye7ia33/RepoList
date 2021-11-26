//
//  ServerRequest.h
//  RepoList
//
//  Created by Yahia El-Dow on 26/11/2021.
//

#import <Foundation/Foundation.h>

@protocol RequestDelegate <NSObject>
-(void) didFinshRequest:(NSData*) data;
@optional
-(void) didFinshRequestWithError :(NSError *) errorCode ;
@end

@interface ServerRequest: NSObject
@property  (strong,nonatomic) id <RequestDelegate> requestDelegate ;
-(void)execute:(NSString *) strURL httpMethod: (NSString *) httpMethod;
@end

