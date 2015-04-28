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

#import "ClientData.h"

@implementation ClientData
@synthesize deviceid;
@synthesize devicename;
@synthesize isjailbroken;
@synthesize language;
@synthesize mccmnc;
@synthesize modulename;
@synthesize network;
@synthesize os_version;
@synthesize platform;
@synthesize resolution;
@synthesize time;
@synthesize version;
@synthesize userid;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self =[super init]) {
        self.deviceid = [aDecoder decodeObjectForKey:@"deviceid"];
        self.devicename = [aDecoder decodeObjectForKey:@"devicename"];
        self.isjailbroken = [aDecoder decodeObjectForKey:@"isjailbroken"];
        self.language = [aDecoder decodeObjectForKey:@"language"];
        self.mccmnc = [aDecoder decodeObjectForKey:@"mccmnc"];
        self.modulename = [aDecoder decodeObjectForKey:@"modulename"];
        self.network = [aDecoder decodeObjectForKey:@"network"];
        self.os_version = [aDecoder decodeObjectForKey:@"os_version"];
        self.platform = [aDecoder decodeObjectForKey:@"platform"];
        self.resolution = [aDecoder decodeObjectForKey:@"resolution"];
        self.time = [aDecoder decodeObjectForKey:@"time"];
        self.version = [aDecoder decodeObjectForKey:@"version"];
        self.userid = [aDecoder decodeObjectForKey:@"userid"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:deviceid forKey:@"deviceid"];
    [aCoder encodeObject:devicename forKey:@"devicename"];
    [aCoder encodeObject:isjailbroken forKey:@"isjailbroken"];
    [aCoder encodeObject:language forKey:@"language"];
    [aCoder encodeObject:mccmnc forKey:@"mccmnc"];
    [aCoder encodeObject:modulename forKey:@"modulename"];
    [aCoder encodeObject:network forKey:@"network"];
    [aCoder encodeObject:os_version forKey:@"os_version"];
    [aCoder encodeObject:platform forKey:@"platform"];
    [aCoder encodeObject:resolution forKey:@"resolution"];
    [aCoder encodeObject:time forKey:@"time"];
    [aCoder encodeObject:version forKey:@"version"];
    [aCoder encodeObject:userid forKey:@"userid"];
}

+ (NSString *)sqlite_createTable
{
    return [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (platform text,os_version text,language text,resolution text,deviceid text,mccmnc text,version text,network text,devicename text,modulename text,time text,isjailbroken text,userid text)",NSStringFromClass(self)];
}

- (NSString*)sqlite_insertPerInfo
{
    return [NSString stringWithFormat:@"INSERT INTO %@ VALUES('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",NSStringFromClass(self.class),platform,os_version,language,resolution,deviceid,mccmnc,version,network,devicename,modulename,time,isjailbroken,userid];
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
