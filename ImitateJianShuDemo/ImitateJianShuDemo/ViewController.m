//
//  ViewController.m
//  ImitateJianShuDemo
//
//  Created by 劉光軍 on 16/5/26.
//

#import "ViewController.h"
#import "PersonalCenterVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)goNextItemClick:(id)sender {

    PersonalCenterVC *vc = [[PersonalCenterVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
