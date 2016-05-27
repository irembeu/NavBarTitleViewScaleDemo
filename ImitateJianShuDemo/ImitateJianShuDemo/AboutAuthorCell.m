//
//  AboutAuthorCell.m
//  ImitateJianShuDemo
//
//  Created by 劉光軍 on 16/5/26.
//

#import "AboutAuthorCell.h"

@implementation AboutAuthorCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)editInformationClick:(id)sender {
    
    if (self.selfBlock) {
        _selfBlock();
    }
}


@end
