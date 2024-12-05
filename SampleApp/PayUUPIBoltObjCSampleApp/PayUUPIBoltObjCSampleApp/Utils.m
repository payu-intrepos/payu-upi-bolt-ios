//
//  Utils.m
//  PayUUPIBoltObjCSampleApp
//
//  Created by Amit Salaria on 22/10/24.
//

#import "Utils.h"
#include <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@interface Utils ()

@end

@implementation Utils


+ (NSString *) getTransactionID {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyMMddHHmmss";
    NSString *txnID = [NSString stringWithFormat:@"iOS%@",[formatter stringFromDate:[NSDate date]]];
    return  txnID;
}

@end
