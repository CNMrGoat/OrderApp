//
//  NSString+AmtCalculate.h
//  CSDirectBank
//
//  Created by linkus on 2016/12/1.
//  Copyright © 2016年 tim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AmtCalculate)

- (NSComparisonResult)compareRate:(NSString *)rate;/**<利率大小比较*/

- (NSString *)addRate:(NSString *)rate;/**<利率相加*/

- (NSString *)subtractRate:(NSString *)rate;/**<利率相减*/

- (NSString *)multiplyByRate:(NSString *)rate;/**<利率相乘*/

- (NSString *)divideByRate:(NSString *)rate;/**<利率相除*/

- (NSComparisonResult)compareAmt:(NSString *)amt;/**<金钱比较大小*/

- (NSString *)addAmt:(NSString *)amt;/**<金钱相加*/

- (NSString *)subtractAmt:(NSString *)amt;/**<金钱相减*/

@end
