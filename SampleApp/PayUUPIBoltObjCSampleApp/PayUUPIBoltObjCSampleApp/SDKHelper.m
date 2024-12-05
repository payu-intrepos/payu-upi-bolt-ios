//
//  SDKHelper.m
//  PayUUPIBoltObjCSampleApp
//
//  Created by Amit Salaria on 24/07/24.
//

#import "SDKHelper.h"
#import "Utils.h"

@interface SDKHelper ()

@property (nonatomic, strong) PayUUPIBoltUIInterface* boltUI;
@property (nonatomic, weak) UIViewController *parentVC;

@end

@implementation SDKHelper

- (instancetype)initWithParentVC:(UIViewController *)parentVC
                          config:(PayUUPIBoltUIConfig *)config {
    self = [super init];
    if (self) {
        self.parentVC = parentVC;
        self.boltUI = [PayUUPIBoltUI initSDKWithParentVC:parentVC config:config delegate:self];
        self.salt = @"";
    }
    return self;
}

- (void)registerAndPay:(PayUUPIBoltPaymentParams *)paymentParams {
    [self.boltUI registerAndPayWithPaymentParams:paymentParams];
}

- (void)manageAccountFlow:(PayUUPIBoltUIScreenType)landingScreen {
    [self.boltUI openUPIManagementWithScreenType:landingScreen];
}

- (void)reset {
    [PayUUPIBoltUI reset];
}

#pragma mark - PayUUPIBoltHashDelegate Methods

- (void)generateHashFor:(NSDictionary<NSString *,NSString *> * _Nonnull)param onCompletion:(void (^ _Nonnull)(NSDictionary<NSString *,NSString *> * _Nonnull))onCompletion {
    NSString *commandName = param[PayUUPIBoltHashConstants.hashName] ?: @"";
    NSString *hashStringWithoutSalt = param[PayUUPIBoltHashConstants.hashString] ?: @"";
    NSString *postSalt = param[PayUUPIBoltHashConstants.postSalt];
    
    // Fetch hash for "commandName" and "hashStringWithoutSalt" from the server if needed
    NSString *hashValue = @"";
    
    if (postSalt != nil) {
        NSString *hashString = [NSString stringWithFormat:@"%@%@%@", hashStringWithoutSalt, self.salt, postSalt];
        hashValue = @"generate hash of hashString from your server and add here";
    } else {
        NSString *hashString = [hashStringWithoutSalt stringByAppendingString:self.salt];
        hashValue = @"generate hash of hashString from your server and add here";
    }
    onCompletion(@{commandName : hashValue});
}

- (void)onPayUSuccessWithResponse:(PayUUPIBoltResponse *)response {
    NSLog(@"Success %@", response);
    [self showAlertWithTitle:@"Success" response:response];
}

- (void)onPayUFailureWithResponse:(PayUUPIBoltResponse *)response {
    NSLog(@"Failure %@", response);
    [self showAlertWithTitle:@"Failure" response:response];
}

- (void)onPayUCancelWithIsTxnInitiated:(BOOL)isTxnInitiated {
    NSLog(@"Cancel %@", @(isTxnInitiated));
    [self showAlertWithTitle:@"Cancel" response:@(isTxnInitiated)];
}

- (void)showAlertWithTitle:(NSString *)title response:(id)response {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *text = @"";
        
        if ([response isKindOfClass:[PayUUPIBoltResponse class]]) {
            PayUUPIBoltResponse *boltResponse = (PayUUPIBoltResponse *)response;
            text = [NSString stringWithFormat:@"Code - %@\nMessage - %@\nResponse - %@",
                    @(boltResponse.code),
                    boltResponse.message ?: @"NIL",
                    [self encodeToJSONString:boltResponse.result] ?: @"NIL"];
        } else {
            text = [NSString stringWithFormat:@"%@", response ?: @"NIL"];
        }
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                       message:text
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        
        [self.parentVC presentViewController:alert animated:YES completion:nil];
    });
}

- (NSString *)encodeToJSONString:(id)object {
    if (object == nil) {
        return nil;
    }
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    if (!jsonData) {
        NSLog(@"Encoding error: %@", error);
        return [NSString stringWithFormat:@"Encoding error: %@", error];
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

@end
