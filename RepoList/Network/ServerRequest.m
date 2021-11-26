//
//  ServerRequest.m
//  RepoList
//
//  Created by Yahia El-Dow on 26/11/2021.
//
#import "ServerRequest.h"

@implementation ServerRequest

-(void)execute:(NSString *) strURL httpMethod: (NSString *) httpMethod {
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:strURL]];
    [urlRequest setHTTPMethod:httpMethod];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
      if(httpResponse.statusCode == 200) {
        [[self requestDelegate] didFinshRequest:data] ;
      }
      else {
        [self.requestDelegate didFinshRequestWithError:error];
      }
    }];
    [dataTask resume];
}

@end
