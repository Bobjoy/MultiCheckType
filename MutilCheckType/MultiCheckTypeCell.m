//
//  PassengerTypeCell.m
//  CEAJS
//
//  Created by Vetech on 15/11/12.
//  Copyright © 2015年 胜意科技. All rights reserved.
//

#import "MultiCheckTypeCell.h"

@interface MultiCheckTypeCell(){
    CGFloat _fontSize;
    CGFloat _typesWidth;
    int index;
    
    UIView * typesView;
}

@end

@implementation MultiCheckTypeCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (id)initWithData:(NSDictionary *)data {
    self = [super init];
    if (self) {
        _fontSize = 14;
        //标签名
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 70, 30)];
        titleLabel.text = data[@"title"];
        titleLabel.font = [UIFont systemFontOfSize:_fontSize];
        [self addSubview:titleLabel];
        
        typesView = [[UIView alloc] init];
        for (NSString * text in data[@"array"]) {
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(_typesWidth, 0, [self widthOfString:text], 30)];
            button.tag = index++;
            [button setTitle:text forState:UIControlStateNormal];
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont boldSystemFontOfSize:_fontSize]];
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(checkTypeAction:) forControlEvents:UIControlEventTouchUpInside];
            button.layer.cornerRadius = 4;
            button.layer.borderWidth = 1;
            button.layer.borderColor = [UIColor lightGrayColor].CGColor;
            [typesView addSubview:button];
            
            _typesWidth += button.frame.size.width + 5;
        }
        typesView.frame = CGRectMake(self.frame.size.width-_typesWidth, 10, _typesWidth, 30);
        [self addSubview:typesView];
    }
    return self;
}

- (CGFloat)widthOfString:(NSString *)string {
    CGFloat width = [string boundingRectWithSize:CGSizeMake(self.frame.size.width, self.frame.size.height)
                         options:(NSStringDrawingUsesLineFragmentOrigin)
                      attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:_fontSize]}
                         context:nil].size.width;
    return (width + 20);
}

- (void)checkTypeAction:(UIButton *)button {
    if (_checkTypeBlock) {
        [self highlightButton:button];
        _checkTypeBlock(button.tag);
    }
}

- (void)highlightButton:(UIButton *)button {
    for (UIButton * button in typesView.subviews) {
        button.selected = NO;
        button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    button.selected = YES;
    button.layer.borderColor = [UIColor blueColor].CGColor;
}

@end
