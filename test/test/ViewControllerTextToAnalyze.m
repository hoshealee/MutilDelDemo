//
//  ViewControllerTextToAnalyze.m
//  test
//
//  Created by qingyun on 15/12/5.
//  Copyright (c) 2015年 qingyun. All rights reserved.
//

#import "ViewControllerTextToAnalyze.h"
#import "ViewControllerAnlyze.h"

@interface ViewControllerTextToAnalyze ()

@property (weak, nonatomic) IBOutlet UITextView *textview;
@property (weak, nonatomic) IBOutlet UIButton *outlineText;

@end

@implementation ViewControllerTextToAnalyze

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"goanalyze"]) {
        if ([segue.destinationViewController isKindOfClass:[ViewControllerAnlyze class]]) {
            ViewControllerAnlyze *vca = (ViewControllerAnlyze *)segue.destinationViewController;
            vca.stringToAnalyze = self.textview.textStorage;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:self.outlineText.currentTitle];
    [title setAttributes:@{
                           NSStrokeWidthAttributeName:@3,
                           NSStrokeColorAttributeName:self.outlineText.tintColor
                           } range:NSMakeRange(0, [title length])];
    [self.outlineText setAttributedTitle:title forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardDidHideNotification object:nil];
    
}

- (void)keyboardNotification:(NSNotification *)notification
{
//    CGRect showRect = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
//    CGRect hideRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGRect selfRect = self.textview.frame;
//    selfRect.size.height += (hideRect.origin.y - showRect.origin.y);
//    self.textview.frame = selfRect;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textview resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self usePreferredFonts];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredFontSChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil];
    //在在此改变时接受消息
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIContentSizeCategoryDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
}

- (void)preferredFontSChanged:(NSNotification *)notification
{
    [self usePreferredFonts];
}

- (void)usePreferredFonts
{
    self.textview.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

- (IBAction)ColorfulBtnClick:(UIButton *)sender {
    [self.textview.textStorage addAttribute:NSForegroundColorAttributeName value:sender.backgroundColor range:self.textview.selectedRange];
}

- (IBAction)outlineBtnClick:(UIButton *)sender {
    [self.textview.textStorage addAttributes:@{
                                               NSStrokeColorAttributeName:[UIColor blackColor],
                                               NSStrokeWidthAttributeName:@3
                                               } range:self.textview.selectedRange ];
}

- (IBAction)unOutlineBtnClick:(id)sender {
    [self.textview.textStorage removeAttribute:NSStrokeWidthAttributeName range:self.textview.selectedRange];
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
