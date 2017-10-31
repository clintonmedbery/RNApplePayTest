#import <Foundation/Foundation.h>
#import <React/RCTBridgeModule.h>


@interface RCT_EXTERN_MODULE(ApplePayHandler, NSObject)

RCT_EXTERN_METHOD(canMakePayments:(RCTResponseSenderBlock)callback)
RCT_EXTERN_METHOD(makePayment)

@end


