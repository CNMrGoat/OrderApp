//
//  NSString+AmtCalculate.m
//  CSDirectBank
//
//  Created by linkus on 2016/12/1.
//  Copyright © 2016年 tim. All rights reserved.
//

#import "NSString+AmtCalculate.h"

@implementation NSString (AmtCalculate)

- (NSComparisonResult)compareRate:(NSString *)rate
{
    NSDecimalNumber *decimalRate1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *decimalRate2 = [NSDecimalNumber decimalNumberWithString:rate];
    return [decimalRate1 compare:decimalRate2];
}

- (NSString *)addRate:(NSString *)rate
{
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:8 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *decimalRate1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *decimalRate2 = [NSDecimalNumber decimalNumberWithString:rate];
    return [[decimalRate1 decimalNumberByAdding:decimalRate2 withBehavior:roundingBehavior] stringValue];
}

- (NSString *)subtractRate:(NSString *)rate
{
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:8 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *decimalRate1 = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *decimalRate2 = [NSDecimalNumber decimalNumberWithString:rate];
    return [[decimalRate1 decimalNumberBySubtracting:decimalRate2 withBehavior:roundingBehavior] stringValue];
}

- (NSString *)multiplyByRate:(NSString *)rate
{
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *decimalAmt = [[NSDecimalNumber decimalNumberWithString:self] decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    NSDecimalNumber *decimalRate = [NSDecimalNumber decimalNumberWithString:rate];
    return [[decimalAmt decimalNumberByMultiplyingBy:decimalRate withBehavior:roundingBehavior] stringValue];
}

- (NSString *)divideByRate:(NSString *)rate
{
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *decimalAmt = [[NSDecimalNumber decimalNumberWithString:self]decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    NSDecimalNumber *decimalRate = [NSDecimalNumber decimalNumberWithString:rate];
    return [[decimalAmt decimalNumberByDividingBy:decimalRate withBehavior:roundingBehavior] stringValue];
}

- (NSComparisonResult)compareAmt:(NSString *)amt
{
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *decimalAmt1 = [[NSDecimalNumber decimalNumberWithString:self] decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    NSDecimalNumber *decimalAmt2 = [[NSDecimalNumber decimalNumberWithString:amt] decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [decimalAmt1 compare:decimalAmt2];
}

- (NSString *)addAmt:(NSString *)amt
{
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *decimalAmt1 = [[NSDecimalNumber decimalNumberWithString:self] decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    NSDecimalNumber *decimalAmt2 = [[NSDecimalNumber decimalNumberWithString:amt]decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [[decimalAmt1 decimalNumberByAdding:decimalAmt2 withBehavior:roundingBehavior] stringValue];
}

- (NSString *)subtractAmt:(NSString *)amt
{
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *decimalAmt1 = [[NSDecimalNumber decimalNumberWithString:self] decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    NSDecimalNumber *decimalAmt2 = [[NSDecimalNumber decimalNumberWithString:amt]decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [[decimalAmt1 decimalNumberBySubtracting:decimalAmt2 withBehavior:roundingBehavior] stringValue];
}

@end
