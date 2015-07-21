//
//  Event.h
//  InClass08
//
//  Created by student on 7/21/15.
//  Copyright (c) 2015 student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Event : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSDate * date;

@end
