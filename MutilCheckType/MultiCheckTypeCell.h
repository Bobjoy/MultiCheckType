//
//  PassengerTypeCell.h
//  CEAJS
//
//  Created by Vetech on 15/11/12.
//  Copyright © 2015年 胜意科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MultiCheckTypeCell : UITableViewCell

@property (nonatomic, strong) void(^checkTypeBlock)(NSInteger typeIndex);

- (id)initWithData:(NSDictionary *)data;

@end
