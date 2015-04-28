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

#import "ErrorLog.h"

@implementation ErrorLog
@synthesize activity;
@synthesize time;
@synthesize stackTrace;
@synthesize appkey;
@synthesize version;
@synthesize osVersion;
@synthesize deviceID;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self =[super init]) {
        self.activity = [aDecoder decodeObjectForKey:@"activity"];
        self.time = [aDecoder decodeObjectForKey:@"time"];
        self.stackTrace = [aDecoder decodeObjectForKey:@"stackTrace"];
        self.appkey = [aDecoder decodeObjectForKey:@"appkey"];
        self.version = [aDecoder decodeObjectForKey:@"version"];
        self.osVersion = [aDecoder decodeObjectForKey:@"osVersion"];
        self.deviceID = [aDecoder decodeObjectForKey:@"deviceID"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:activity forKey:@"activity"];
    [aCoder encodeObject:time forKey:@"time"];
    [aCoder encodeObject:stackTrace forKey:@"stackTrace"];
    [aCoder encodeObject:appkey forKey:@"appkey"];
    [aCoder encodeObject:version forKey:@"version"];
    [aCoder encodeObject:osVersion forKey:@"osVersion"];
    [aCoder encodeObject:deviceID forKey:@"deviceID"];
}

+ (NSString *)sqlite_createTable
{
    return [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (stackTrace text,time text,activity text,appkey text,osVersion text,deviceID text,version text)",NSStringFromClass(self)];
}

- (NSString*)sqlite_insertPerInfo
{
    return [NSString stringWithFormat:@"INSERT INTO %@ VALUES('%@','%@','%@','%@','%@','%@','%@')",NSStringFromClass(self.class),stackTrace,time,activity,appkey,osVersion,deviceID,version];
}

+(NSString*)sqlite_selectListCount:(NSUInteger)count
{
    return [NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY time LIMIT 0,%d",NSStringFromClass(self),count];
}

+(NSString*)sqlite_countTable
{
    return [NSString stringWithFormat:@"SELECT COUNT(*) FROM %@",NSStringFromClass(self)];
}

+(NSString*)sqlite_deleteListCount:(NSUInteger)count
{
    return [NSString stringWithFormat:@"DELETE FROM %@ WHERE time IN(SELECT time FROM %@ ORDER BY time LIMIT 0,%d)",NSStringFromClass(self),NSStringFromClass(self),count];
}

@end
