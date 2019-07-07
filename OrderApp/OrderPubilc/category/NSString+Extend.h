//
//  NSString+Extend.h
//  CSDirectBank
//
//  Created by 彭小坚 on 15/8/16.
//  Copyright (c) 2015年 彭小坚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Extend)
/*!
 *  @author 彭小坚, 15-08-07 09:08:32
 *
 *  @brief  兼容ios7以上版本该方法，消除警告
 *
 *  @param font          字体样式
 *  @param size          原本大小
 *  @param lineBreakMode 文字排放样式
 *
 *  @return 得到字体大小
 *
 *  @since 2.8.0
 */
- (CGSize)sizeWithFont:(UIFont *)font
     constrainedToSize:(CGSize)size
         lineBreakMode:(NSLineBreakMode)lineBreakMode;

/*!
 *  @author 彭小坚, 15-08-07 09:08:39
 *
 *  @brief  利用系统自带base64编码
 *
 *  @return 编码后的字符串
 *
 *  @since 2.8.0
 */
- (NSString *)stringWithBase64;

/*!
 *  @author 彭小坚, 15-09-17 17:09:41
 *
 *  @brief  将编码的base64字符串解码
 *
 *  @return 解码后的字符串
 *
 *  @since 2.8.0
 */
- (NSString *)decodeBase64StringToString;

/*!
 *  @author 彭小坚, 15-08-24 00:08:33
 *
 *  @brief  通过字体属性来计算文字高度
 *
 *  @param attrs 字体属性设置
 *  @param size  需要加载字体的控件大小
 *
 *  @return 字体所占区域大小
 *
 *  @since 3.0.1
 */
- (CGSize)sizeWithAttributes:(NSDictionary *)attrs constrainedToSize:(CGSize)size;

/*!
 *  @author 郑新民, 15-08-25 18:08:22
 *
 *  @brief  去除所有空格
 *
 *  @param input 需要去除空格的字符串
 *
 *  @return 已去除空格的字符串
 *
 *  @since 3.0.1
 */
- (NSString *)trim;

/*!
 *  @author 郑新民, 15-08-25 18:08:22
 *
 *  @brief  去除首尾空格
 *
 *  @param input 需要去除空格的字符串
 *
 *  @return 已去除空格的字符串
 *
 *  @since 3.0.1
 */
- (NSString *)eliminateSpace;

/*!
 *  @author 彭小坚, 15-08-26 21:08:54
 *
 *  @brief  判断字符串里面是否包含某个字符
 *
 *  @param string 查找匹配的字符串
 *
 *  @return 是否包含
 *
 *  @since 3.0.1
 */
- (BOOL)isContainString:(NSString *)string;

/*!
 *  @author 彭小坚, 15-12-25 17:12:19
 *
 *  @brief 判断字体是否为空
 *
 *  @return 布尔值
 *
 *  @since 3.2
 */
+ (BOOL)isNilOrEmpty:(NSString *)str;

/*!
 *  @author 朱介伟, 16-01-21 18:01:54
 *
 *  @brief  将金额转为千分制显示
 *
 *  @return 结果
 *
 *  @since 3.3
 */
- (NSString *)permilString;

/*!
 *  @author jojo, 16-01-21 22:01:04
 *
 *  @brief 计算字符串字符个数（非ascii字符算2个字符）
 *
 *  @return 字符个数
 *
 *  @since 3.3
 */
- (NSUInteger)characterLength;

/*!
 *  @author jojo, 16-01-22 13:01:18
 *
 *  @brief 截取前to个字符
 *
 *  @param to 要截取的字符个数（非ascii字符算2个字符）
 *
 *  @return 截取后的字符串
 *
 *  @since 3.3
 */
- (NSString *)substringToCharacterIndex:(NSUInteger)to;

/*!
 *  @author 郑新民, 18-02-29 18:45:22
 *
 *  @brief  去除表情符号
 *
 *  @return 已去除表情的字符串
 *
 *  @since 3.4
 *
 */
- (NSString *)disable_emoji;

/**
 *  去掉非数字字符
 *
 *  @return 数字字符串
 */
-(NSString *)stringGetNumberString;


/*！
 *  @author 谭海涛, 17-04-13 11:58:22
 *
 *  每charNumbers个字符添加一个splitStr字符串
 *
 *  @param charNumbers 分割字符的数目
 *
 *  @param splitStr 分割字符串
 *
 *  @return 分割后的字符串
 */
-(NSString *)splitStringBetweenCharNumbers:(NSUInteger)charNumbers WithSplitStr:(NSString *)splitStr;

/*！
 *  @author 谭世豪
 *  金额千分位格式化
 *  @return 千分位格式化以后的金额
 */
-(NSString *)amountFormat;

//数字金额转大写
-(NSString *)changetochinese;
/*！
 *  @author 谭世豪
 *  密码错误提示
 *  @return 密码错误提示
 */
-(NSString *)pwdWarm;

//手机号格式验证
- (BOOL)checkPhoneNumInput;

//掩盖手机号码
+(NSString *)maskMobile:(NSString *)mobile;

//是否包含对应字符
- (BOOL)containStr:(NSString *)subString;
@end
