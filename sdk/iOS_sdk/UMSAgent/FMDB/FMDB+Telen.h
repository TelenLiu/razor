//
//  FMDB+Telen.h
//  TimeTools
//
//  Created by telen on 15/4/27.
//  Copyright (c) 2015年 Telen. All rights reserved.
//

#import "FMDatabase.h"

@interface FMDatabase (Telen)

//把字典，转为Insert 语句
+(NSString*) Sql_InsertDict:(NSDictionary*) record forTable:(NSString*)table;

//克隆，sqlite db，需要先open及setkey
+ (BOOL)FMDB_Clone_Opened_DB:(FMDatabase*) db1 toOpened_DB:(FMDatabase*) db2;

@end
