//
//  FMDB+Telen.m
//  TimeTools
//
//  Created by telen on 15/4/27.
//  Copyright (c) 2015年 Telen. All rights reserved.
//

#import "FMDB+Telen.h"

@implementation FMDatabase (Telen)

// 返回格式：insert into table_name (c1,c2,c3) values (:a,:b,:c);
+(NSString*) Sql_InsertDict:(NSDictionary*) record forTable:(NSString*)table
{
    NSArray *columns = [record allKeys];
    NSString *prefix = [NSString stringWithFormat:@"insert into %@ (", table];
    
    NSMutableString *middle = [NSMutableString new];
    for(int i=0;i<[columns count];i++){
        NSString *columnName = [columns objectAtIndex:i];// 列
        if(i>0)[middle appendString:@","];
        [middle appendString:columnName];
    }
    NSString* cuttedMiddle = middle;
    
    NSMutableString *suffix = [NSMutableString new];
    [suffix appendString:@") values ("];
    for(int i=0;i<[columns count];i++){
        NSString *columnName = [columns objectAtIndex:i];// 列名
        if(i>0)[suffix appendString:@","];
        [suffix appendString:@":"];
        [suffix appendString:columnName];
    }
    NSString *cuttedSuffix = suffix;
    
    NSMutableString *sql = [NSMutableString new];
    [sql appendString:prefix];
    [sql appendString:cuttedMiddle];
    [sql appendString:cuttedSuffix];
    [sql appendString:@");"];
    return sql;
}

+ (BOOL)FMDB_Clone_Opened_DB:(FMDatabase*) db1 toOpened_DB:(FMDatabase*) db2
{
    FMResultSet *rs =[db1 executeQuery:@"SELECT name FROM sqlite_master WHERE type='table' order by name"];//select name from sqlite_master where type='table' order by namex
    if (rs) {
        while ([rs next]){
            NSString* name = [rs stringForColumn:@"name"];
            //NSLog(@"%@",name);
            FMResultSet *rs_tbInfo = [db1 executeQuery:[NSString stringWithFormat:@"pragma table_info ('%@')",name]];
            if (rs_tbInfo) {
                NSMutableString* sql = [NSMutableString new];
                [sql appendFormat:@"CREATE TABLE IF NOT EXISTS %@ (",name];
                while ([rs_tbInfo next]) {
                    NSLog(@"%@",rs_tbInfo.resultDictionary);
                    NSString* columnKey = [rs_tbInfo stringForColumn:@"name"];
                    NSString* columnType = [rs_tbInfo stringForColumn:@"type"];
                    [sql appendFormat:@"%@ %@,",columnKey,columnType];
                }
                [sql replaceCharactersInRange:NSMakeRange(sql.length-1, 1) withString:@")"];
                [db2 executeUpdate:sql];
            }else{
                return NO;
            }
            FMResultSet *rs_tb =[db1 executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@",name]];
            if(rs_tb){
                while ([rs_tb next]){
                    //NSLog(@"%@",rs_tb.resultDictionary);
                    NSString* sql = [self Sql_InsertDict:rs_tb.resultDictionary forTable:name];
                    [db2 executeUpdate:sql withParameterDictionary:rs_tb.resultDictionary];
                }
            }else{
                return NO;
            }
        }
    }else{
        return NO;
    }
    return YES;
}


@end
