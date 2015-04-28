/**
 * Cobub Razor
 *
 * An open source analytics iphone sdk for mobile applications
 *
 * @package		Cobub Razor
 * @author		WBTECH Dev Team
 * @copyright	Copyright (c) 2011 - 2012, NanJing Western Bridge Co.,Ltd.
 * @license		http://www.cobub.com/products/cobub-razor/license
 * @link		http://www.cobub.com/products/cobub-razor/
 * @since		Version 0.1
 * @filesource
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define __UMSAgent_CacheTo_DB  //定义开启，sqlite记录信息
#define __UMSAgent_Key_DB @"cccsee.cn"  //需要sqlite 版本支持
#define __UMSAgent_Limit_num 100

typedef enum {
    REALTIME = 0,       //RealTime Send Policy
    BATCH = 1,          //Send Data When Start
} ReportPolicy;

@interface UMSAgent : NSObject<UIAlertViewDelegate>
{

}

+(void)checkUpdate;

+(void)startWithAppKey:(NSString*)appKey serverURL:(NSString *)serverURL;

+(void)startWithAppKey:(NSString*)appKey ReportPolicy:(ReportPolicy)policy ServerURL:(NSString*)serverURL
;
+(void)postEvent:(NSString *)event_id;

+(void)postEvent:(NSString *)event_id label:(NSString *)label;

+(void)postEvent:(NSString *)event_id acc:(NSInteger)acc;

+(void)postEvent:(NSString *)event_id label:(NSString *)label acc:(NSInteger)acc;

+(void)postTag:(NSString *)tag;

+(void)bindUserIdentifier:(NSString *)userid;

+(void)startTracPage:(NSString*)page_name;

+(void)endTracPage:(NSString*)page_name;

// Check if the device jail broken
+ (BOOL)isJailbroken;
+ (void)setOnLineConfig:(BOOL)isOnlineConfig;
+ (void)setIsLogEnabled:(BOOL)isLogEnabled;
+ (NSString*)getUMSUDID;

+ (void)tryFlashData; //telen 尝试发送一次数据

@end
