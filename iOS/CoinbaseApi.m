#import "CoinbaseApi.h"
#import "CoinbaseOAuth.h"

@implementation CoinbaseApi

static CoinbaseApi *sharedObject;

+ (CoinbaseApi *)sharedInstance
{
  static id sharedObject = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedObject = [[self alloc] init];
  });

  return sharedObject;
}

+ (NSString *)getClientId
{
  CoinbaseApi *shared = [CoinbaseApi sharedInstance];
  return shared.clientId;
}


+ (NSString *)getClientSecret
{
  CoinbaseApi *shared = [CoinbaseApi sharedInstance];
  return shared.clientSecret;

}
+ (void)setClientId:(NSString *)clientId
{
  CoinbaseApi *shared = [CoinbaseApi sharedInstance];
  [shared setClientId:clientId];
}

+ (void)setClientSecret:(NSString *)clientSecret
{
  CoinbaseApi *shared = [CoinbaseApi sharedInstance];
  [shared setClientSecret:clientSecret];
}

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(startAuthentication:(NSString *)clientId clientSecret:(NSString *)clientSecret) {
  [CoinbaseApi setClientId:clientId];
  [CoinbaseApi setClientSecret:clientSecret];
  [CoinbaseOAuth startOAuthAuthenticationWithClientId:clientId
         scope:@"user balance transfer"
   redirectUri:@"org.reactjs.native.example.coinbase-oauth://coinbase-oauth"
          meta:nil];
};

@end
