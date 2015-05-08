/**
 * Copyright (c) 2015-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 */

#import "AppDelegate.h"
#import "CoinbaseOAuth.h"
#import "CoinbaseApi.h"
#import "RCTRootView.h"
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"

@implementation AppDelegate {
  RCTEventDispatcher *_eventDispatcher;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  NSURL *jsCodeLocation;
  jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle"];
  /* jsCodeLocation = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"]; */

  /* RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation */
  /*                                                     moduleName:@"CoinbaseExample" */
  /*                                                  launchOptions:launchOptions]; */


  RCTBridge *bridge = [[RCTBridge alloc] initWithBundleURL:jsCodeLocation
                                            moduleProvider: nil
                                                   launchOptions:launchOptions];

  _eventDispatcher = [[RCTEventDispatcher alloc] initWithBridge:bridge];

  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge
                                               moduleName:@"CoinbaseExample"];
  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [[UIViewController alloc] init];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];
  return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    if ([[url scheme] isEqualToString:@"org.reactjs.native.example.coinbase-oauth"]) {
      [CoinbaseOAuth finishOAuthAuthenticationForUrl:url
                                              clientId:[CoinbaseApi getClientId]
                                          clientSecret:[CoinbaseApi getClientSecret]
                                            completion:^(id result, NSError *error) {
          if (error) {
            [[[UIAlertView alloc] initWithTitle:@"OAuth Error" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
          } else {
            /* Send an app event with the API key */
            /* { */
            /*     "access_token" = xxxxxxxxxxxxxxxxxxxxxxxxxx; */
            /*     "expires_in" = 7200; */
            /*     "refresh_token" = yyyyyyyyyyyyyyyyyyyyyyyyyy; */
            /*     "scope" = "user balance transfer"; */
            /*     "token_type" = bearer; */
            /* } */
            [_eventDispatcher sendDeviceEventWithName:@"CoinbaseOAuthComplete" body:result];
          }
      }];
    return YES;
    }

  return NO;
}

@end
