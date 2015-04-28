//
//  Tag.m
//  UMSAgent
//
//  Created by admin on 13-4-27.
//
//

#import "Tag.h"

@implementation Tag
@synthesize deviceid;
@synthesize productkey;
@synthesize tags;
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self =[super init]) {
        self.deviceid = [aDecoder decodeObjectForKey:@"deviceid"];
        self.productkey = [aDecoder decodeObjectForKey:@"productkey"];
        self.tags = [aDecoder decodeObjectForKey:@"tags"];    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:deviceid forKey:@"deviceid"];    
    [aCoder encodeObject:productkey forKey:@"productkey"];
    [aCoder encodeObject:tags forKey:@"tags"];
}

+ (NSString *)sqlite_createTable
{
    return [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (tags text,deviceid text,productkey text)",NSStringFromClass(self)];
}

- (NSString*)sqlite_insertPerInfo
{
    return [NSString stringWithFormat:@"INSERT INTO %@ VALUES('%@','%@','%@')",NSStringFromClass(self.class),tags,deviceid,productkey];
}

+(NSString*)sqlite_selectListCount:(NSUInteger)count
{
    return [NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY tags LIMIT 0,%d",NSStringFromClass(self),count];
}

+(NSString*)sqlite_countTable
{
    return [NSString stringWithFormat:@"SELECT COUNT(*) FROM %@",NSStringFromClass(self)];
}

+(NSString*)sqlite_deleteListCount:(NSUInteger)count
{
    return [NSString stringWithFormat:@"DELETE FROM %@ WHERE tags IN(SELECT tags FROM %@ ORDER BY tags LIMIT 0,%d)",NSStringFromClass(self),NSStringFromClass(self),count];
}


@end
