//
//  ViewControllerAnlyze.m
//  test
//
//  Created by qingyun on 15/12/5.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "ViewControllerAnlyze.h"

@interface ViewControllerAnlyze ()

@property (weak, nonatomic) IBOutlet UILabel *colorfulCharacters;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharacters;

@end

@implementation ViewControllerAnlyze

- (void)setStringToAnalyze:(NSAttributedString *)stringToAnalyze
{
    _stringToAnalyze = stringToAnalyze;
    if (self.view.window) {
        [self updateUI];
    }
}

- (void)updateUI
{
    _colorfulCharacters.text = [NSString stringWithFormat:@"Colorful characters:%ld",[[self charactersWithAttrite:NSForegroundColorAttributeName] length]];
    _outlinedCharacters.text = [NSString stringWithFormat:@"Outlined characters:%ld",[[self charactersWithAttrite:NSStrokeWidthAttributeName] length]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

- (NSAttributedString *)charactersWithAttrite:(NSString *)attributeName
{
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    int index = 0;
    
    while (index < self.stringToAnalyze.length) {
        NSRange range;
        id value = [self.stringToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if (value) {
            [characters appendAttributedString:[self.stringToAnalyze  attributedSubstringFromRange:range]];
            index = (int)range.location + (int)range.length;
        }else{
            index++;
        }
    }
    return characters;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
