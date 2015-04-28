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

#import "Event.h"

@implementation Event
@synthesize event_id,time,acc,activity,label,version;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self =[super init]) {
        self.event_id = [aDecoder decodeObjectForKey:@"event_id"];
        self.label = [aDecoder decodeObjectForKey:@"label"];
        self.time = [aDecoder decodeObjectForKey:@"time"];
        self.activity = [aDecoder decodeObjectForKey:@"activity"];
        self.acc = [aDecoder decodeInt32ForKey:@"acc"];
        self.version = [aDecoder decodeObjectForKey:@"version"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:event_id forKey:@"event_id"];
    [aCoder encodeObject:label forKey:@"label"];
    [aCoder encodeObject:time forKey:@"time"];
    [aCoder encodeObject:activity forKey:@"activity"];
    [aCoder encodeObject:version forKey:@"version"];
    [aCoder encodeInt:acc forKey:@"acc"];
}


+ (NSString *)sqlite_createTable
{
    return [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (event_id text,time text,activity text,label text,acc integer,version text)",NSStringFromClass(self)];
}

- (NSString*)sqlite_insertPerInfo
{
    return [NSString stringWithFormat:@"INSERT INTO %@ VALUES('%@','%@','%@','%@',%d,'%@')",NSStringFromClass(self.class),event_id,time,activity,label,acc,version];
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
