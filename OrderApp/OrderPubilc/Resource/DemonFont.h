//
//  DemonFont.h
//  CSDirectBank
//
//  Created by JoJo on 15/12/4.
//  Copyright © 2015年 lyx. All rights reserved.
//

#ifndef DemonFont_h
#define DemonFont_h

//判断手机版本号是否大于9.0,因为PingFangSC字体只会出现在iOS 9.0以上
#define Demon_MediumFont_(i) (([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) ? [UIFont fontWithName:@"PingFangSC-Medium" size:i] : [UIFont fontWithName:@"STHeitiSC-Medium" size:i])

#define Demon_RegularFont_(i) (([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) ? [UIFont fontWithName:@"PingFangSC-Regular" size:i] : [UIFont fontWithName:@"STHeitiSC-Light" size:i])

#define Demon_10_Font [UIFont fontWithName:@"STHeitiSC-Light" size:10]
#define Demon_11_Font [UIFont fontWithName:@"STHeitiSC-Light" size:11]
#define Demon_13_Font [UIFont fontWithName:@"STHeitiSC-Light" size:13]
#define Demon_14_Font [UIFont fontWithName:@"STHeitiSC-Light" size:14]
#define Demon_12_Font [UIFont fontWithName:@"STHeitiSC-Light" size:12]
#define Demon_18_Font [UIFont fontWithName:@"STHeitiSC-Light" size:18]
#define Demon_15_Font [UIFont fontWithName:@"STHeitiSC-Light" size:15]
#define Demon_16_Font [UIFont fontWithName:@"STHeitiSC-Light" size:16]
#define Demon_17_Font [UIFont fontWithName:@"STHeitiSC-Light" size:17]
#define Demon_19_Font [UIFont fontWithName:@"STHeitiSC-Light" size:19]
#define Demon_20_Font [UIFont fontWithName:@"STHeitiSC-Light" size:20]
#define Demon_21_Font [UIFont fontWithName:@"STHeitiSC-Light" size:21]
#define Demon_22_Font [UIFont fontWithName:@"STHeitiSC-Light" size:22]
#define Demon_23_Font [UIFont fontWithName:@"STHeitiSC-Light" size:23]
#define Demon_24_Font [UIFont fontWithName:@"STHeitiSC-Light" size:24]
#define Demon_26_Font [UIFont fontWithName:@"STHeitiSC-Light" size:26]
#define Demon_30_Font [UIFont fontWithName:@"STHeitiSC-Light" size:30]
#define Demon_32_Font [UIFont fontWithName:@"STHeitiSC-Light" size:32]


#define Demon_10_MediumFont [UIFont fontWithName:@"STHeitiSC-Medium" size:10]
#define Demon_13_MediumFont [UIFont fontWithName:@"STHeitiSC-Medium" size:13]
#define Demon_14_MediumFont [UIFont fontWithName:@"STHeitiSC-Medium" size:14]
#define Demon_12_MediumFont [UIFont fontWithName:@"STHeitiSC-Medium" size:12]
#define Demon_18_MediumFont [UIFont fontWithName:@"STHeitiSC-Medium" size:18]
#define Demon_15_MediumFont [UIFont fontWithName:@"STHeitiSC-Medium" size:15]
#define Demon_16_MediumFont [UIFont fontWithName:@"STHeitiSC-Medium" size:16]
#define Demon_17_MediumFont [UIFont fontWithName:@"STHeitiSC-Medium" size:17]
#define Demon_19_MediumFont [UIFont fontWithName:@"STHeitiSC-Medium" size:19]
#define Demon_20_MediumFont [UIFont fontWithName:@"STHeitiSC-Medium" size:20]
#define Demon_22_MediumFont [UIFont fontWithName:@"STHeitiSC-Medium" size:22]
#define Demon_24_MediumFont [UIFont fontWithName:@"STHeitiSC-Medium" size:24]
#define Demon_26_MediumFont [UIFont fontWithName:@"STHeitiSC-Medium" size:26]
#define Demon_28_MediumFont [UIFont fontWithName:@"STHeitiSC-Medium" size:28]
#define Demon_30_MediumFont [UIFont fontWithName:@"STHeitiSC-Medium" size:30]
#define Demon_40_MediumFont [UIFont fontWithName:@"STHeitiSC-Medium" size:40]
#define Demon_45_MediumFont [UIFont fontWithName:@"STHeitiSC-Medium" size:45]
#define Demon_50_MediumFont [UIFont fontWithName:@"STHeitiSC-Medium" size:50]
#define Demon_60_MediumFont [UIFont fontWithName:@"STHeitiSC-Medium" size:60]
#endif
