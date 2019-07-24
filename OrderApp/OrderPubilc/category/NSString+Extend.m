//
//  NSString+Extend.m
//  CSDirectBank
//
//  Created by 彭小坚 on 15/8/16.
//  Copyright (c) 2015年 彭小坚. All rights reserved.
//

#import "NSString+Extend.h"
#import "DemonMarco.h"
@implementation NSString (Extend)

- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    
    NSDictionary *dic = @{NSFontAttributeName:font};
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
}

- (NSString *)stringWithBase64 {
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)decodeBase64StringToString
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self
                                                      options:0];
    NSString *base64Decoded = [[NSString alloc]
                               initWithData:data
                               encoding:NSUTF8StringEncoding];
    return base64Decoded;
}

- (CGSize)sizeWithAttributes:(NSDictionary *)attrs constrainedToSize:(CGSize)size
{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}

- (NSString *)trim
{
    if (self.length > 0) {
        return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    return self;
}

- (NSString *)eliminateSpace
{
    if (self.length > 0) {
        return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString:@""];
    }
    return self;
}

- (BOOL)isContainString:(NSString *)string
{
    BOOL judge = NO;
    if (!iOS8)
    {
        if([self rangeOfString:string].location != NSNotFound)
        {
            judge = YES;
        }
    }
    else
    {
        judge = [self containsString:string];
    }
    
    return judge;
}

+ (BOOL)isNilOrEmpty:(NSString *)str
{
    if (str == nil || [str isEqual:[NSNull null]])
    {
        return YES;
    }
    else
    {
        if (str.length > 0)
        {
            return NO;
        }
        else {
            return YES;
        }
    }
}

- (NSString *)permilString
{
    if (!self||[self floatValue] == 0.00)
    {
        return @"0.00";
    }
    else if ([self floatValue]<1.00)
    {
        return self;
    }
    else
    {
        NSNumberFormatter *form =[[NSNumberFormatter alloc] init];
        [form setPositiveFormat:@",###.00;"];
        NSString *string = [form stringFromNumber:[NSNumber numberWithDouble:[self doubleValue]]];
        return string;
    }
    
    return @"";
}

- (NSUInteger)characterLength
{
    NSUInteger totalLength = 0;
    NSUInteger length = self.length;
    for (NSUInteger i = 0; i < length; i++) {
        unichar ch = [self characterAtIndex:i];
        if (isascii(ch)) {
            totalLength += 1;
        } else {
            totalLength += 2;
        }
    }
    return totalLength;
}

- (NSString *)substringToCharacterIndex:(NSUInteger)to
{
    NSUInteger totalLength = 0;
    NSUInteger length = self.length;
    for (NSUInteger i = 0; i < length; i++) {
        unichar ch = [self characterAtIndex:i];
        if (isascii(ch)) {
            if (totalLength + 1 > to) {
                return [self substringToIndex:i];
            }
            totalLength += 1;
        } else {
            if (totalLength + 2 > to) {
                return [self substringToIndex:i];
            }
            totalLength += 2;
        }
    }
    return self;
}

- (NSString *)disable_emoji
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:self
                                                               options:0
                                                                 range:NSMakeRange(0, [self length])
                                                          withTemplate:@""];
    return modifiedString;
}

-(NSString *)stringGetNumberString{
    if (!self) return @"0";
    NSCharacterSet *setToRemove = [[ NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    return [[self componentsSeparatedByCharactersInSet:setToRemove] componentsJoinedByString:@""];
}

-(NSString *)splitStringBetweenCharNumbers:(NSUInteger)charNumbers WithSplitStr:(NSString *)splitStr{
    /** 添加size个字符串和最后一个的字符串  存入tmpStrArr中
     ** self.length =10;  size=2 charNumbers =4; 
     ** (0,4),(4,8),(8,2)
     ** NSMakeRange(8,10%4) = NSMakeRange(8,2);
     ** 分割
     **/
    if (self.length<=0||self.length<=charNumbers) {//长度小于分割字符串的长度，返回原字符串
        return self;
    }
    NSUInteger size = (self.length / charNumbers);//分割字符串个数
    NSMutableArray *tmpStrArr = [[NSMutableArray alloc] init];
    for (int n = 0;n < size; n++)
    {
        
        [tmpStrArr addObject:[self substringWithRange:NSMakeRange(n*charNumbers, charNumbers)]];
    }
    //添加最后一组 分割字符串 self.length =10;  size=2 charNumbers =4; NSMakeRange(8,10%4) = NSMakeRange(8,2);
    if (self.length%charNumbers!=0) {
        [tmpStrArr addObject:[self substringWithRange:NSMakeRange(size*charNumbers, (self.length % charNumbers))]];
    }
    
    //分割数组 用分割字符串splitStr拼接
    return  [tmpStrArr componentsJoinedByString:splitStr];
}


-(NSString *)amountFormat{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[self doubleValue]]];
    return formattedNumberString;
}

//手机号格式验证
- (BOOL)checkPhoneNumInput {
    NSString *Phoneend = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([Phoneend hasPrefix:@"1"] && Phoneend.textLength == 11) {
        return YES;
    }
    return NO;
}

//计算字符串长度 1中文2字符
- (int)textLength {
    float number = 0.0;
    for (int index = 0; index < [self length]; index++) {
        NSString *character = [self substringWithRange:NSMakeRange(index, 1)];
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3) {
            number = number + 2;
        } else {
            number = number + 1;
        }
    }
    return ceil(number);
}

//掩盖手机号码
+(NSString *)maskMobile:(NSString *)mobile{
    if (mobile == nil || mobile.length<=0) {
        return @"";
    }
    NSMutableString *str = [NSMutableString new];
    if (mobile.length <= 8) {
        return [NSString stringWithString:mobile];
    }
    [str appendString:[mobile substringWithRange:NSMakeRange(0, 3)]];
    [str appendString:@"****"];
    [str appendString:[mobile substringWithRange:NSMakeRange(mobile.length-4, 4)]];
    return [str description];
}


//是否包含对应字符
- (BOOL)containStr:(NSString *)subString {
    return ([self rangeOfString:subString].location == NSNotFound) ? NO : YES;
}

/** 二维码图片 可以 再用resize>>放大一下 */
- (UIImage *)qrCode {
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //    NSLog(@"filterAttributes:%@", filter.attributes);
    
    [filter setDefaults];
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    
    CIImage *outputImage = [filter outputImage];
    
    CIContext *context1 = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context1 createCGImage:outputImage
                                        fromRect:[outputImage extent]];
    
    UIImage *image = [UIImage imageWithCGImage:cgImage
                                         scale:1
                                   orientation:UIImageOrientationUp];
    
    CGFloat width = image.size.width *5;
    CGFloat height = image.size.height *5;
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextRef context2 = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context2, kCGInterpolationNone);
    [image drawInRect:CGRectMake(0, 0, width, height)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    return image;
}

+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}


+(NSString *)timeStampToString:(NSString *)timeStamp {
    
//    NSString *timeString = [[NSString alloc]init];
    
    CGFloat i = [timeStamp floatValue];
    
    //当前时间的时间戳
//    NSTimeInterval  timeNow=[[NSDate date] timeIntervalSince1970];
    
    //将传来的时间戳转为标准时间格式
    NSTimeInterval time = i;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *tempStr= [dateFormatter stringFromDate:date];
    
//    timeString = [NSString stringWithFormat:@"%@年%@月%@日 %@",[tempStr substringWithRange:NSMakeRange(0,4)],[tempStr substringWithRange:NSMakeRange(5,2)],[tempStr substringWithRange:NSMakeRange(8,2)],[tempStr substringWithRange:NSMakeRange(11,8)]];
//
//    //当前时间
//    NSDate *nowDate = [NSDate date];
//    NSString *nowDateStr= [dateFormatter stringFromDate:nowDate];
//
//    //时间戳判断逻辑
//    if ([[timeString substringWithRange:NSMakeRange(0, 4)] isEqualToString:[nowDateStr substringWithRange:NSMakeRange(0, 4)]]) {
//
//        if ([[timeString substringWithRange:NSMakeRange(5,2)] isEqualToString:[nowDateStr substringWithRange:NSMakeRange(5,2)]]) {
//
//            float daySubtract = [[nowDateStr substringWithRange:NSMakeRange(8,2)] floatValue] - [[timeString substringWithRange:NSMakeRange(8,2)] floatValue];
//
//            if (daySubtract < 3) {
//
//                if (daySubtract == 0) {
//
//                    NSString *string = [NSString stringWithFormat:@"今天 %@",[timeString substringWithRange:NSMakeRange(11,6)]];
//                    return  string;
//
//                }else if (daySubtract == 1) {
//
//                    NSString *string = [NSString stringWithFormat:@"昨天 %@",[timeString substringWithRange:NSMakeRange(11,6)]];
//                    return  string;
//                }else {
//
//                    if ((timeNow - time) > 3600*24*2) {
//
//                        return timeString;
//                    }else {
//
//                        NSString *string = [NSString stringWithFormat:@"前天 %@",[timeString substringWithRange:NSMakeRange(11,6)]];
//                        return  string;
//                    }
//
//                }
//
//            }else{
//
//                return timeString;
//            }
//
//        }else {
//            return timeString;
//
//        }
//
//    }else {
    
        return tempStr;
//    }
    
}

@end
