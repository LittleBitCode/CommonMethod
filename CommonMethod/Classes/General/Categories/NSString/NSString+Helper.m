//
//  NSString-Helper.m
//  CommonMethod
//
//  Created by littleBit on 2016/12/13.
//  Copyright © 2016年 littleBit. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)
+ (NSString *)formatAccountFromAccountStr:(NSString *)accountStr{
    int size =(int) (accountStr.length/4);
    NSMutableArray *tmpStrArr = [[NSMutableArray alloc] init];
    for (int n = 0;n < size; n++) {
        [tmpStrArr addObject:[accountStr substringWithRange:NSMakeRange(n*4, 4)]];
    }
    [tmpStrArr addObject:[accountStr substringWithRange:NSMakeRange(size*4, (accountStr.length % 4))]];
    accountStr = [tmpStrArr componentsJoinedByString:@" "];
    return accountStr;
}

//屏蔽账号:只显示前4位和后4位
+ (NSString *) screenIDWithIdStr:(NSString *)idStr{
    NSUInteger lenth = [idStr length];
    NSString *newStr = [NSString string];
    if (lenth >=10) {
        NSString *xSt=@"*";
        for (int i=1; i<lenth-8; i++) {
            xSt = [NSString stringWithFormat:@"%@%@",xSt,@"*"];
        }
        
        newStr = [NSString stringWithFormat:@"%@%@%@",[idStr substringToIndex:4],xSt,[idStr substringFromIndex:lenth-4]];
    }
    //    else if(lenth==11){
    ////        newStr = idStr;
    //        NSString *xSt=@"*";
    //        for (int i=1; i<lenth-8; i++) {
    //            xSt = [NSString stringWithFormat:@"%@%@",xSt,@"*"];
    //        }
    //
    //        newStr = [NSString stringWithFormat:@"%@%@%@",[idStr substringToIndex:4],xSt,[idStr substringFromIndex:lenth-4]];
    //    }
    
    return newStr;
}
//缴费编码判断
+ (BOOL)payNumCheck:(NSString *)nickName {
    /**
     ASCll码表:
     0-9: 48-57
     a-z: 97-122
     A-Z; 65-90
     Unicode: char 值处于区间[19968, 19968+20902]里的，都是汉字
     */
    BOOL _isNotword = YES;
    for(int i=0;i<[nickName length];i++) {
        unichar char_password = [nickName characterAtIndex:i];
        if((char_password>=19968 && char_password<= 19968+20902)) {
            _isNotword = NO;
            return _isNotword;
        } else {
            // 是数字或者小写字母或者大写字母或者特殊字符
        }
    }
    return _isNotword;
}

//TODO: 判断是否简单密码   modified by sunruilian
+ (NSInteger) checkSimplePassword: (NSString *)password{
    //密码只能有数字和字母组成
    //密码不能有6位连续的数字或字母
    //密码不能有6位连续的相同数字或字母
    //返回：0，不是简单密码；1，含有数字和字母外的特殊字符；
    //	   2，含有6位连续的数字或字母;3，含有6位连续的相同数字或字母
    NSInteger resultValue=0;
    if (![NSString isPassword: password]) {
        resultValue = 1;
        return resultValue;
    }else {
        /**
         ASCll码表:
         0-9: 48-57
         a-z: 97-122
         A-Z; 65-90
         */
        
        int incrementTag=1; //ASCll值递增标识
        int descendingTa=1; //ASCll值递减标识
        int sameTag=1;      //ASCll 值相同标识
        
        unichar char_1;
        char_1 = [password characterAtIndex:0];
        for(int i=1;i<[password length];i++)
        {
            unichar char_next = [password characterAtIndex:i];
            if (char_next == char_1) {
                sameTag++;
                incrementTag=1;
                descendingTa=1;
            }else if (char_next == char_1+1) {
                incrementTag++;
                sameTag=1;
                descendingTa=1;
            }else if (char_next == char_1-1) {
                descendingTa++;
                incrementTag=1;
                sameTag=1;
            }else {
                sameTag = 1;
                descendingTa = 1;
                incrementTag = 1;
            }
            char_1 = char_next;
            
            if (sameTag >= 6) {
                resultValue = 3;
                return resultValue;
            }else if (incrementTag >=6 || descendingTa>=6) {
                resultValue = 2;
                return resultValue;
            }
        }
    }
    
    return resultValue;
}
//算出字符串和汉字的个数
+ (int)convertToInt:(NSString*)strtemp {
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
        
    }
    return strlength;
}
//新增：不屏蔽特殊字符（收款人户名专用！！！）
+ (BOOL)isRecName:(NSString *)nameStr{
    int aa=0;
    int bb=0;
    BOOL _isName = YES;
    for(int i=0;i<[nameStr length];i++)
    {
        unichar char_nick = [nameStr characterAtIndex:i];
        if (char_nick == '|') {
            return NO;
        }
        if ((char_nick>=19968 && char_nick<= 19968+20902)) {
            bb++;
            if (bb>60) {
                return NO; //汉字不能大于60位
            }
        }else {
            if (aa>120) {
                return  NO; //字母不能大于120位
            }
        }
    }
    
    return _isName;
}

//TODO: 判断字符串是否只还有数字，大小字母和汉字
+ (BOOL)isNickName:(NSString *)nickName
{
    /**
     ASCll码表:
     0-9: 48-57
     a-z: 97-122
     A-Z; 65-90
     
     Unicode: char 值处于区间[19968, 19968+20902]里的，都是汉字
     */
    
    int aa=0;
    int bb=0;
    BOOL _isNickName = YES;
    for(int i=0;i<[nickName length];i++)
    {
        unichar char_nick = [nickName characterAtIndex:i];
        if ((char_nick>=48 && char_nick<=57) ||
            (char_nick>=97 && char_nick<= 122) ||
            (char_nick>=65 && char_nick<= 90)||char_nick==32) {
            aa++;
            if (aa>20) {
                return  NO; //数字和字母不能大于20位
            }
        }else if ((char_nick>=19968 && char_nick<= 19968+20902)) {
            bb++;
            if (bb>10) {
                return NO; //汉字不能大于10位
            }
        }else {
            _isNickName = NO;
            return _isNickName;
        }
    }
    
    return _isNickName;
}
//TODO: 判断是否姓名
+ (BOOL)isName:(NSString *)nameStr{
    int aa=0;
    int bb=0;
    BOOL _isName = YES;
    for(int i=0;i<[nameStr length];i++)
    {
        unichar char_nick = [nameStr characterAtIndex:i];
        if ((char_nick>=97 && char_nick<= 122) ||
            (char_nick>=65 && char_nick<= 90)||char_nick==32) {
            aa++;
            if (aa>120) {
                return  NO; //字母不能大于20位
            }
        }else if ((char_nick>=19968 && char_nick<= 19968+20902)) {
            bb++;
            if (bb>60) {
                return NO; //汉字不能大于10位
            }
        }else {
            _isName = NO;
            return _isName;
        }
    }
    
    return _isName;
}

//TODO: 过滤掉'<'、"<"、‘&’字符的 60汉字和20字符
+ (BOOL)isRemMsg: (NSString *)aString{
    int aa=0;
    int bb=0;
    BOOL _isRemMsg = YES;
    for(int i=0;i<[aString length];i++)
    {
        unichar char_nick = [aString characterAtIndex:i];
        NSLog(@"%d",char_nick);
        if (char_nick == '<'||char_nick=='>'||char_nick=='&') {
            return NO;
        }else if ((char_nick>=19968 && char_nick<= 19968+20902)) {
            bb++;
            if (bb>30) {
                return NO; //汉字不能大于30位
            }
        }else {
            aa++;
            if (aa>60) {
                return  NO; //数字和字母不能大于60位
            }
        }
    }
    
    return _isRemMsg;
}


//TODO: 判断字符串是否只还有数字，大小字母
+ (BOOL)isPassword:(NSString *)password
{
    /**
     ASCll码表:
     0-9: 48-57
     a-z: 97-122
     A-Z; 65-90
     */
    
    BOOL _isPassword = YES;
    for(int i=0;i<[password length];i++)
    {
        unichar char_password = [password characterAtIndex:i];
        if((char_password>=48 && char_password<=57) ||
           (char_password>=97 && char_password<= 122) ||
           (char_password>=65 && char_password<= 90))
        {
            // 是数字或者小写字母或者大写字母
        }
        else
        {
            _isPassword = NO;
            return _isPassword;
        }
    }
    
    return _isPassword;
}


// 修改登陆密码纯数字与纯字母不能过
+ (BOOL)isLoginPassword:(NSString *)password
{
    /**
     ASCll码表:
     0-9: 48-57
     a-z: 97-122
     A-Z; 65-90
     */
    
    BOOL _isPassword = YES;
    for(int i=0;i<[password length];i++)
    {
        unichar char_password = [password characterAtIndex:i];
        if((char_password>=48 && char_password<=57) ||
           (char_password>=97 && char_password<= 122) ||
           (char_password>=65 && char_password<= 90))
        {
            // 是数字或者小写字母或者大写字母
        }
        else
        {
            _isPassword = NO;
            return _isPassword;
        }
    }
    
    return _isPassword;
}



//TODO: 判断输入是否数字 0-9 和 小数点.
+ (BOOL) isDigital:(NSString *)aString
{
    if([aString length] == 0)
        return NO;
    
    for(int i=0;i<[aString length];i++)
    {
        char aa = [aString characterAtIndex:i];
        if(!(aa>= '0' && aa<= '9') && aa!='.')
        {
            ///有非数字
            return NO;
        }
    }
    
    return YES;
}
//TODO: 纯数字 0-9
- (BOOL) isNumber{
    if([self length] == 0)
        return NO;
    for(int i=0;i<[self length];i++) {
        char aa = [self characterAtIndex:i];
        if(!(aa>= '0' && aa<= '9')) {
            ///有非数字
            return NO;
        }
    }
    return YES;
}

//TODO: 判断是否身份号
+(BOOL) isIDNumber:(NSString *)aString {
    //旧身份证15位，新身份证（二代）18位
    if([aString length] != 15 && [aString length]!=18) {
        return NO;
    } else { //15 位时
        if([aString length] == 15) {
            for(int i=0;i<15;i++) {
                char aa = [aString characterAtIndex:i];
                if(!(aa>= '0' && aa<= '9')) {
                    return NO;///有非数字
                }
            }
            return YES;
        } else if([aString length] == 18) {// 18位时
                for(int i=0;i<17;i++) { // 前17位数字，后一位可能是字母
                char aa = [aString characterAtIndex:i];
                if(!(aa>= '0' && aa<= '9')) {
                    return NO;///有非数字
                }
            }
            char aa = [aString characterAtIndex:17];// 第18位
            if(!((aa>=48 && aa<=57)||(aa>=97 && aa<= 122)||(aa>=65 && aa<= 90))) {
                return NO; //非字母或数字，则 NO
            }
            return YES;
        }
    }
    return YES;
}

//TODO: 判断字符串是否6位数字
+ (BOOL) isSixDigitalPassword:(NSString *)password{
    if ([password length]!=6) {
        return NO;
    }
    for(int i=0;i<[password length];i++) {
        char aa = [password characterAtIndex:i];
        if(!(aa>= '0' && aa<= '9')) {
            return NO; ///有非数字
        }
    }
    return YES;	
}
//TODO: 判断字符串是否6－12位字符（大小写字符和数字）
+ (BOOL) isSixToThTwelvePassword:(NSString *)password{
    if ([password length]<6 || [password length] >18) {
        return NO;
    }
    // ASCll码表: 0-9: 48-57  a-z: 97-122  A-Z; 65-90
    BOOL _isPassword = YES; 
    for(int i=0;i<[password length];i++) {
        unichar char_password = [password characterAtIndex:i]; 		
        if((char_password>=48 && char_password<=57) ||
           (char_password>=97 && char_password<= 122) ||
           (char_password>=65 && char_password<= 90)) {
            // 是数字或者小写字母或者大写字母
        } else  {
            _isPassword = NO;
            return _isPassword;
        }
    }
    return _isPassword;	
}

//TODO: 是否正常银行卡号（10－32位）
+ (BOOL) isCardNumber:(NSString *)aString{
    if ([aString length]<10 || [aString length] >32) {
        return NO;
    }
    
    for(int i=0;i<[aString length];i++)
    {
        char aa = [aString characterAtIndex:i];
        if(!(aa>= '0' && aa<= '9'))
        {
            ///有非数字
            return NO;
        }
    }
    
    return YES;			
}

//TODO: md5 加密方法
+ (NSString *)md5Digest:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
            ];
}

+ (NSString *)NumberStringTurnToAccountNumberWith:(NSString *)number
{
    if (number!=nil&& ![number isEqualToString:@""])
    {
        NSMutableString * newString = [NSMutableString stringWithString:number];
        [newString insertString:@" " atIndex:4];
        [newString insertString:@" " atIndex:9];
        NSRange rang = {10,6};
        [newString replaceCharactersInRange:rang withString:@"****"];
        [newString insertString:@" " atIndex:newString.length-4];
        return newString;
    }
    else
        return nil;
}
//账户格式化 加空格
+ (NSString*)accountStringWithAccount:(NSString *)account{
    if (account!=nil&& ![account isEqualToString:@""]) {
        NSMutableString * newString = [NSMutableString stringWithString:account];
        if (newString.length > 4) {
            [newString insertString:@" " atIndex:4];
        }
        if (newString.length > 9) {
            [newString insertString:@" " atIndex:9];
        }
        if (newString.length > 14) {
            [newString insertString:@" " atIndex:14];
        }
//        [newString insertString:@" " atIndex:4];
//        [newString insertString:@" " atIndex:9];
//        [newString insertString:@" " atIndex:14];
        return newString;
    }
    else
        return nil;
}
+ (NSString *)numberStringTurnToPhoneNumWith:(NSString *)number {
    if (number!=nil&& ![number isEqualToString:@""]) {
        NSMutableString * newString = [NSMutableString stringWithString:number];
        [newString insertString:@"-" atIndex:3];
        [newString insertString:@"-" atIndex:8];
        return newString;
    }
    else
        return nil;
}
+ (NSDictionary *)checkMessageStringWithDesString:(NSString *)desString andDesValueString:(NSString *)desValue {
    NSMutableDictionary * dict  = [[NSMutableDictionary alloc] initWithCapacity:6];
    NSString * pointStr = @"|";
    NSRange firstRange = [desString rangeOfString:pointStr];
    NSRange firstValueRange = [desValue rangeOfString:pointStr];
    NSString *firstSting = [desString substringToIndex:firstRange.location];
    NSString * firstValue = [desValue substringToIndex:firstValueRange.location];
    [dict setObject:firstValue forKey:firstSting];
    
    NSString * otherDesString = [desString substringFromIndex:firstRange.location-1];
    NSString * otherValueString = [desValue substringFromIndex:firstValueRange.location-1];
    NSRange secRange = [otherDesString rangeOfString:pointStr];
    NSRange secVauleRange = [otherValueString rangeOfString:pointStr];
    NSString * secStr = [otherDesString substringToIndex:secRange.location];
    NSString * secValue = [otherValueString substringToIndex:secVauleRange.location];
    [dict setObject:secValue  forKey:secStr];
    
    NSString * thirdDesString = [otherDesString substringFromIndex:secRange.location-1];
    NSString * thirdValueString = [otherValueString substringFromIndex:secVauleRange.location-1];
    NSRange thirdDesRang = [thirdDesString rangeOfString:pointStr];
    NSRange thirdValueRange = [thirdValueString rangeOfString:pointStr];
    NSString * thirdStr = [thirdDesString substringToIndex:thirdDesRang.location];
    NSString * thirdValueStr = [thirdValueString substringToIndex:thirdValueRange.location];
    [dict setObject:thirdValueStr forKey:thirdStr];
    
    NSString * fouthDesString = [thirdDesString substringFromIndex:thirdDesRang.location-1];
    NSString * fouthValueString = [thirdValueString substringFromIndex:thirdValueRange.location-1];
    NSRange fouthDesRange = [fouthDesString rangeOfString:pointStr];
    NSRange fouthValueRange = [fouthValueString rangeOfString:pointStr];
    NSString * fouthStr = [fouthDesString substringToIndex:fouthDesRange.location];
    NSString * fouthValueStr = [fouthValueString substringToIndex:fouthValueRange.location];
    [dict setObject:fouthValueStr forKey:fouthStr];
    
    NSString * fifthDesString = [fouthDesString substringFromIndex:fouthDesRange.location-1];
    NSString * fifthValueString = [fouthValueString substringFromIndex:fouthValueRange.location-1];
    NSRange fifthDesRange = [fifthDesString rangeOfString:pointStr];
    NSRange fifthValueRange = [fifthValueString rangeOfString:pointStr];
    NSString * fifStr = [fifthDesString substringToIndex:fifthDesRange.location];
    NSString * fifValue = [fifthValueString substringToIndex:fifthValueRange.location];
    [dict setObject:fifValue forKey:fifStr];
    
    NSString * sixDesString = [fifthDesString substringFromIndex:fifthDesRange.location-1];
    NSString * sixValueString = [fifthValueString substringFromIndex:fifthValueRange.location-1];
    [dict setObject:sixValueString forKey:sixDesString];
    
    return dict;
}

+(NSString *) compareCurrentTime:(NSTimeInterval) compareDate
{
    
    NSDate *confromTimesp        = [NSDate dateWithTimeIntervalSince1970:compareDate/1000];
    
    NSTimeInterval  timeInterval = [confromTimesp timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    
    NSCalendar *calendar     = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags      = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents*referenceComponents=[calendar components:unitFlags fromDate:confromTimesp];
    //    NSInteger referenceYear  =referenceComponents.year;
    //    NSInteger referenceMonth =referenceComponents.month;
    //    NSInteger referenceDay   =referenceComponents.day;
    NSInteger referenceHour  =referenceComponents.hour;
    //    NSInteger referemceMinute=referenceComponents.minute;
    
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp= timeInterval/60) < 60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = timeInterval/3600) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if ((temp = timeInterval/3600/24)==1)
    {
        result = [NSString stringWithFormat:@"昨天%ld时",(long)referenceHour];
    }
    else if ((temp = timeInterval/3600/24)==2)
    {
        result = [NSString stringWithFormat:@"前天%ld时",(long)referenceHour];
    }
    
    else if((temp = timeInterval/3600/24) <31){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = timeInterval/3600/24/30) <12){
        result = [NSString stringWithFormat:@"%ld个月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}
+ (NSString*) getDateStringWithTimestamp:(NSTimeInterval)timestamp
{
    NSDate *confromTimesp    = [NSDate dateWithTimeIntervalSince1970:timestamp/1000];
    NSCalendar *calendar     = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags      = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents*referenceComponents=[calendar components:unitFlags fromDate:confromTimesp];
    NSInteger referenceYear  =referenceComponents.year;
    NSInteger referenceMonth =referenceComponents.month;
    NSInteger referenceDay   =referenceComponents.day;
    
    return [NSString stringWithFormat:@"%ld年%ld月%ld日",referenceYear,(long)referenceMonth,(long)referenceDay];
}



+ (NSString*) getStringWithTimestamp:(NSTimeInterval)timestamp formatter:(NSString*)formatter
{
    if ([NSString stringWithFormat:@"%@", @(timestamp)].length == 13) {
        timestamp /= 1000.0f;
    }
    NSDate*timestampDate=[NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSString *strDate = [dateFormatter stringFromDate:timestampDate];
    
    return strDate;
}
@end
