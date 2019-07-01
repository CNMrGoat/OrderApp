//
//  CSColor.h
//  CSDirectBank
//
//  Created by tim on 15/8/14.
//  Copyright (c) 2015年 彭小坚. All rights reserved.
//

/*!
 *  @author 彭小坚, 15-09-17 20:09:23
 *
 *  @brief  颜色定义
 *
 *  @since 2.8
 */

#ifndef CSDirectBank_CSColor_h
#define CSDirectBank_CSColor_h

#define UIColorFromRGB(rgbValue) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0])

//主题色
#define CS_Color_BackZhuti       UIColorFromHex(0xfa6f65)

//背景灰
#define CS_Color_BackGroundGray  UIColorFromHex(0xEFEFEF)

//背景浅白
#define CS_Color_BackGroundLightWhite  UIColorFromHex(0xfafafa)

//超浅灰
#define CS_Color_LightLightGray       UIColorFromHex(0xF8F9FA)

//浅灰
#define CS_Color_LightGray       UIColorFromHex(0xE5E5E5)

//边线浅灰
#define CS_Color_LineLightGray   UIColorFromHex(0xD1D1D1)

//中灰
#define CS_Color_MidGray         UIColorFromHex(0x999999)

//深灰
#define CS_Color_DeepGray        UIColorFromHex(0x666666)

//浅黑
#define CS_Color_LightBlack        UIColorFromHex(0x333333)

//深黑
#define CS_Color_DeepBlack       UIColorFromHex(0x2E2E2E)

//标准红
#define CS_Color_StandRed        UIColorFromHex(0xFB4747)

//深红
#define CS_Color_DeepRed         UIColorFromHex(0xD03D3D)

//我的账户查看详情背景红
#define CS_Color_ButtonRed         UIColorFromHex(0xE54347)

//我的账户查看详情背景蓝
#define CS_Color_ButtonBlue       UIColorFromHex(0x3669B5)
//标准蓝
#define CS_Color_StandBlue       UIColorFromHex(0x404A58)
//物业缴费蓝
#define CS_Color_PropertyBlue    UIColorFromHex(0x2938F8)

//标准绿
#define CS_Color_StandGreen      UIColorFromHex(0x8ECD4B)

//标准青
#define CS_Color_StandGreen2     UIColorFromHex(0x77D0DE)

//标配青
#define CS_Color_GenerallyGreen  UIColorFromHex(0x7FC6C8)

//标配红
#define CS_Color_GenerallyRed    UIColorFromHex(0xF89594)

//标配蓝
#define CS_Color_GenerallyBlue   UIColorFromHex(0x95ADCD)

/**<芙蓉宝专用（申请进度）*/
#define CS_Color_Red             UIColorFromHex(0xA33640)

#define CS_Color_Black           UIColorFromHex(0x7994B3)

#define CS_Color_Green           UIColorFromHex(0x7DCC3B)

#define CS_Color_Origen          UIColorFromHex(0xE4BD5A)

//背景浅灰，section
#define CS_Color_SectionBackgroundGray  UIColorFromHex(0xf8f8f8)
//e家金额 蓝
#define CS_Color_EFamilyBlue   UIColorFromHex(0x2eb3fe)
//砖红色
#define CS_Color_BrickRed      UIColorFromHex(0xfff5f5)
//绿色，跌
#define CS_Color_DropGreen     UIColorFromHex(0x28d587)


#endif
