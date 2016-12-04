//
//  AppDelegate.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 24/02/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "AppDelegate.h"
#import "ALPushNotificationService.h"
#import "ALAppLocalNotifications.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [self enablePushNotification];
    
    // checks wheather app version is updated/changed then makes server call setting VERSION_CODE
    [ALRegisterUserClientService isAppUpdated];
    
    // Register for Applozic notification tap actions and network change notifications
    ALAppLocalNotifications *localNotification = [ALAppLocalNotifications appLocalNotificationHandler];
    [localNotification dataConnectionNotificationHandler];
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    
    // Override point for customization after application launch.
    NSLog(@"launchOptions: %@", launchOptions);
    if (launchOptions != nil) {
        NSDictionary *dictionary = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (dictionary != nil) {
            NSLog(@"Launched from push notification: %@", dictionary);
            ALPushNotificationService *pushNotificationService = [[ALPushNotificationService alloc] init];
            BOOL applozicProcessed = [pushNotificationService processPushNotification:dictionary updateUI:[NSNumber numberWithInt:APP_STATE_INACTIVE]];
            
            //IF not a appplozic notification, process it
            if (!applozicProcessed) {
                //Note: notification for app
            }
        }
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary *)options {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
                    ];
    // Add any custom logic here.
    return handled;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    ALRegisterUserClientService *registerUserClientService = [[ALRegisterUserClientService alloc] init];
    [registerUserClientService disconnect];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"APP_ENTER_IN_BACKGROUND" object:nil];
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    ALRegisterUserClientService *registerUserClientService = [[ALRegisterUserClientService alloc] init];
    [registerUserClientService connect];
    [ALPushNotificationService applicationEntersForeground];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"APP_ENTER_IN_FOREGROUND" object:nil];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [[ALDBHandler sharedInstance] saveContext];
    
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)
deviceToken {
    
    const unsigned *tokenBytes = [deviceToken bytes];
    NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    
    NSString *apnDeviceToken = hexToken;
    NSLog(@"apnDeviceToken: %@", hexToken);
    
    [[NSUserDefaults standardUserDefaults] setValue:apnDeviceToken forKey:@"kDeviceToken"];
    
    //TO AVOID Multiple call to server check if previous apns token is same as recent one,
    //If its different then call Applozic server.
    
    if (![[ALUserDefaultsHandler getApnDeviceToken] isEqualToString:apnDeviceToken]) {
        ALRegisterUserClientService *registerUserClientService = [[ALRegisterUserClientService alloc] init];
        [registerUserClientService updateApnDeviceTokenWithCompletion
         :apnDeviceToken withCompletion:^(ALRegistrationResponse
                                          *rResponse, NSError *error) {
             
             if (error) {
                 NSLog(@"%@",error);
                 return;
             }              
             NSLog(@"Registration response from server:%@", rResponse);                         
         }]; 
    } 
}

- (void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)dictionary {
    
    NSLog(@"Received notification WithoutCompletion: %@", dictionary);
    ALPushNotificationService *pushNotificationService = [[ALPushNotificationService alloc] init];
    [pushNotificationService processPushNotification:dictionary updateUI:[NSNumber numberWithInt:APP_STATE_INACTIVE]];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSLog(@"Received notification Completion: %@", userInfo);
    ALPushNotificationService *pushNotificationService = [[ALPushNotificationService alloc] init];
    [pushNotificationService processPushNotification:userInfo updateUI:[NSNumber numberWithInt:APP_STATE_BACKGROUND]];
    completionHandler(UIBackgroundFetchResultNewData);
    
}

#pragma mark - PUSH NOTIFICATION

- (void)enablePushNotification {
    
    UIApplication * app = [UIApplication sharedApplication];
    
    if([app respondsToSelector:@selector(registerForRemoteNotifications)])
    {
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings * settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [app registerUserNotificationSettings: settings];
        [app registerForRemoteNotifications];
    }
    
}

@end
