//
//  AboutAuthorCell.h
//  ImitateJianShuDemo
//
//  Created by 劉光軍 on 16/5/26.
//

#import <UIKit/UIKit.h>

typedef void(^CellBlock)();

@interface AboutAuthorCell : UITableViewCell

@property (nonatomic, copy) CellBlock selfBlock;

@end
