//
//  DataSyncManager.m
//  PampersRewards
//
//  Created by Dipen Sekhsaria on 15/11/15.
//  Copyright (c) 2015 ProcterAndGamble. All rights reserved.
//

#import "DataSyncManager.h"
#import "SignUpResponseModal.h"
#import "CustomerGetProjectsResponseModal.h"


@implementation DataSyncManager
@synthesize delegate,serviceKey;



-(void)startPOSTWebServicesWithParams:(NSMutableDictionary *)postData
{
    
    NSURL* url;
    url = [NSURL URLWithString:DomainBaseURL];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    

    [manager POST:self.serviceKey parameters:postData constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        
        
    } progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        //if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            if ([[responseObject valueForKey:@"status"] intValue] == 1 || [[responseObject valueForKey:@"result"] intValue] == 1 || [[responseObject valueForKey:@"status"] intValue] == 2) {
                
                if ([delegate respondsToSelector:@selector(didFinishServiceWithSuccess:andServiceKey:)]) {
                    [delegate didFinishServiceWithSuccess:[self prepareResponseObjectForServiceKey:self.serviceKey withData:responseObject] andServiceKey:self.serviceKey];
                }
            }
            else {
            //if ([delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
                [delegate didFinishServiceWithFailure:[responseObject valueForKey:@"msg"]];
            //}
            
            }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if ([delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
           [delegate didFinishServiceWithFailure:NSLocalizedString(@"Verify your internet connection and try again", nil)];
        }
        
        
    }];
    
    
}


-(void)startPOSTWebServicesForProfileUploadWithParams:(NSMutableDictionary *)postData
{
    
    NSURL* url;
    url = [NSURL URLWithString:DomainBaseURL];
    
    UIImage* image = [[UIImage alloc] init];
    image = [postData valueForKey:@"Profile_pi"];
    [postData removeObjectForKey:@"Profile_pi"];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    [manager POST:self.serviceKey parameters:postData constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        NSData* data = UIImageJPEGRepresentation(image,1.0);
        
        [formData appendPartWithFileData:data
                                    name:@"myFile"
                                fileName:@"myFile" mimeType:@"image/png"];
        
    } progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        //if ([responseObject isKindOfClass:[NSDictionary class]]) {
        
        if ([[responseObject valueForKey:@"status"] intValue] == 1 || [[responseObject valueForKey:@"result"] intValue] == 1) {
            
            if ([delegate respondsToSelector:@selector(didFinishServiceWithSuccess:andServiceKey:)]) {
                [delegate didFinishServiceWithSuccess:[self prepareResponseObjectForServiceKey:self.serviceKey withData:responseObject] andServiceKey:self.serviceKey];
            }
        }
        else {
            //if ([delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
            [delegate didFinishServiceWithFailure:[responseObject valueForKey:@"msg"]];
            //}
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if ([delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
            [delegate didFinishServiceWithFailure:NSLocalizedString(@"Verify your internet connection and try again", nil)];
        }
        
        
    }];
    
    
}



-(void)startGETWebServices
{
    
    NSURL* url;
    url = [NSURL URLWithString:DomainBaseURL];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    manager.requestSerializer = [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [manager GET:self.serviceKey parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[responseObject valueForKey:@"status"] intValue] == 1 || [[responseObject valueForKey:@"result"] intValue] == 1 ) {
            
            if ([delegate respondsToSelector:@selector(didFinishServiceWithSuccess:andServiceKey:)]) {
                [delegate didFinishServiceWithSuccess:[self prepareResponseObjectForServiceKey:self.serviceKey withData:responseObject] andServiceKey:self.serviceKey];
            }
        }
        else {
            
            if ([self.serviceKey containsString:kCheckIfEmailExists]) {
                if ([delegate respondsToSelector:@selector(didFinishServiceWithSuccess:andServiceKey:)]) {
                    [delegate didFinishServiceWithSuccess:[self prepareResponseObjectForServiceKey:self.serviceKey withData:responseObject] andServiceKey:self.serviceKey];
                }
            }
            else {
                [delegate didFinishServiceWithFailure:[responseObject valueForKey:@"msg"]];
            }
            
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if ([delegate respondsToSelector:@selector(didFinishServiceWithFailure:)]) {
            [delegate didFinishServiceWithFailure:NSLocalizedString(@"Verify your internet connection and try again", nil)];
        }
        
        
    }];
    
    
}

- (id) prepareResponseObjectForServiceKey:(NSString *) responseServiceKey withData:(id)responseObj {
    
    if ([responseServiceKey isEqualToString:kSignUpService] || [responseServiceKey isEqualToString:kLoginService] || [responseServiceKey isEqualToString:kLoginWithFB]) {
        
        NSError* error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObj options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        [[SharedClass sharedInstance] saveData:jsonString ForService:kLoginService];
        
        SignUpResponseModal* response;
        
        if ([[responseObj valueForKey:@"status"] intValue] == 2) {
            response = [[SignUpResponseModal alloc] initWithDictionary:[[responseObj valueForKey:@"updated_records"] objectAtIndex:0]];
        }
        else {
            response = [[SignUpResponseModal alloc] initWithDictionary:[[responseObj valueForKey:@"info"] objectAtIndex:0]];
        }
        
        return response;
        
    }
    else if ([responseServiceKey containsString:kCustomerGetPostedProjectsService] || [responseServiceKey containsString:kCustomerGetActiveProjectsService] || [responseServiceKey containsString:kCustomerGetCompletedProjectsService]) {
        
        CustomerGetProjectsResponseModal* response = [[CustomerGetProjectsResponseModal alloc] initWithDictionary:responseObj];
        return response;
        
    }
    
    return responseObj;
    
}





- (NSString *) errorStringForService:(NSString *) responseServiceKey withData:(id)responseObj {
    
//    if ([responseServiceKey isEqualToString:kLoginService]) {
//        
//        if ([[responseObj valueForKey:@"code"] isEqualToString:USERNAME_EMPTYKey]) {
//            
//            return NSLocalizedString(@"Please enter your email", nil);
//            
//        }
//        else if ([[responseObj valueForKey:@"code"] isEqualToString:PASSWORD_EMPTYKey]) {
//            
//            return NSLocalizedString(@"Please enter a password", nil);
//            
//        }
//        else if ([[responseObj valueForKey:@"code"] isEqualToString:USER_NOT_FOUND_LEGKey] || [[responseObj valueForKey:@"code"] isEqualToString:USER_NOT_FOUND_PCKey]) {
//            
//            return NSLocalizedString(@"The email and password combination you entered is incorrect. Please try again.", nil);
//            
//        }
//        
//    }
//    
//    if ([responseServiceKey isEqualToString:kImageUploadService]) {
//        
//        if ([[responseObj valueForKey:@"message"] isEqualToString:cappingLimitReachedKey]) {
//            
//            return NSLocalizedString(@"Sorry! Your receipt processing limit has been reached. Please send again tomorrow.", nil);
//            
//        }
//        
//    }
//    
//    if ([responseServiceKey isEqualToString:kRegisterService]) {
//    
//        NSString *correctString = [NSString stringWithCString:[[responseObj valueForKey:@"message"] cStringUsingEncoding:NSUTF8StringEncoding]
//                                                     encoding:NSNonLossyASCIIStringEncoding];
//        
//        correctString = [[correctString componentsSeparatedByString:@": "] lastObject];
//        correctString = [correctString stringByReplacingOccurrencesOfString:@"\"]" withString:@""];
//        
//       return correctString;
//            
//    }
    
    
    return NSLocalizedString(@"An issue occured while processing your request. Please try again later.", nil);
    
}




@end
