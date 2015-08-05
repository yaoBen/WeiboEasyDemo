//
//  JLResourcePath.m
//  FileManagerDemo
//
//  Created by whunf on 14-7-6.
//  Copyright (c) 2014年 Jan Lion. All rights reserved.
//

#import "JLResourcePath.h"

NSString *GetDocumentPathWithFile(NSString *file)
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    if (file) {
        return [path stringByAppendingPathComponent:file];
    }
    
    return path;
}

NSString *GetCachePathWithFile(NSString *file)
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    if (file) {
        return [path stringByAppendingPathComponent:file];
    }
    
    return path;
}

NSString *GetTempPathWithFile(NSString *file)
{
    NSString *path = NSTemporaryDirectory();
    
    if (file) {
        return [path stringByAppendingPathComponent:file];
    }
    
    return path;
}
