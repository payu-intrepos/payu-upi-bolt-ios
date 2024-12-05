//
//  SDKHelper.h
//  PayUUPIBoltObjCSampleApp
//
//  Created by Amit Salaria on 24/07/24.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@import PayUUPIBoltUIKit;
@import PayUUPIBoltKit;
@import PayUUPIBoltBaseKit;

@interface SDKHelper : NSObject <PayUUPIBoltUIDelegate, PayUUPIBoltHashDelegate>

@property (nonatomic, strong) NSString *salt;

- (instancetype)initWithParentVC:(UIViewController *)parentVC
                          config:(PayUUPIBoltUIConfig *)config;

- (void)registerAndPay:(PayUUPIBoltPaymentParams *)paymentParams;
- (void)manageAccountFlow:(PayUUPIBoltUIScreenType)landingScreen;
- (void)reset;

@end
