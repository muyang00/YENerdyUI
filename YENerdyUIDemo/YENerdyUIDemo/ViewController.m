//
//  ViewController.m
//  YENerdyUIDemo
//
//  Created by yongen on 17/2/16.
//  Copyright © 2017年 yongen. All rights reserved.
//

#import "ViewController.h"
#import "NerdyUI.h"
#import "AppStoreViewController.h"

@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    Segmented(@"demo1", @"demo2", @"demo3", @"demo4", @"demo5", @"demo6").onChange(^(int index, id sc){
        id methodName = @("demo").a(index + 1);
        [self clear];
        [self performSelector:NSSelectorFromString(methodName)];
        [self.view bringSubviewToFront:sc];
    }).embedIn(self.view, NERNull, 10, 20, 10,).tg(999);
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
- (void)clear{
    self.view.subviews.filter(^(id v){return [v tag] != 999;}).forEach(@"removeFromSuperview");
  self.childViewControllers.forEach(@"removeFromParentViewController");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self demo1];
}

- (void)demo1{
    UIView *view1 = View.xywh(20, 30, 50, 50).bgColor(@"red").opacity(0.7).border(3, @"#3d3d3d");
    UIView *view2 = View.xy(80, 30).wh(view1.wh).bgColor(@"blue,0.7").cornerRadius(25).shadow(0.8).onClick(^{
        Log(@"view2");
    });
    
    
    UIView *moose = ImageView.img(@"moose").x(20).y(100).shadow(0.6, 2, -3, -1);
    UILabel *quiz = Label.str(@"%d+%d=?", 1, 1).fnt(@17).color(@"66,66,66").fitSize.x(moose.maxX + 10).cy(moose.cy);
    
    
    id title = AttStr(@"TAP ME").fnt(15).underline.range(0, 3).fnt(@18).color(@"random");
    UIButton *button1 = Button.str(title).insets(5, 10).fitSize.border(1).xy(20, 150).onClick(^(UIButton *btn) {
        quiz.text = Str(@"%d+%d=%d", 1, 1, Exp(btn.tag += 1));
        [quiz sizeToFit];
    });
    
    UIButton *button2 = Button.str(@"HAT").highColor(@"brown").img(@"hat").gap(8);
    button2.xywh(button1.frame).x(button1.maxX + 10).cornerRadius(5).bgImg(@"blue,0.5").highBgImg(@"orange");
    //highBgImg with color string is a very useful trick to set highlighted background color for UIButton.
    
    id pinField = TextField.x(button1.x).y(button1.maxY + 15).wh(170, 30).onChange(^(NSString *text){
        [(id)[self.view viewWithTag:101] setText:text];
    }).numberKeyboard.maxLength(4).hint(@"pin code").fnt(15).roundStyle;
    id textView = TextView.xywh(20, 240, 170, 100).border(1).insets(8).hint(@"placeholder").fnt([pinField font]).tg(101);
    
    //Add multiply subviews at once.
    self.view.addChild(view1, view2, quiz, moose, button1, button2, pinField, textView);
}
- (void)demo2{
    id str = @"Lorem ipsum 20 dolor sit er elit lamet, consectetaur cillium #adipisicing pecu, sed do #eiusmod tempor incididunt ut labore et 3.14 dolore magna aliqua.";
    id attStr = AttStr(str).range(0, 5).match(@"lamet").match(@"[0-9.]+").matchHashTag.linkForLabel;
    Label.str(attStr).multiline.lineGap(10).xywh(self.view.bounds).onLink(^(NSString *text){
        Log(text);
    }).addTo(self.view).centerAlignment;
    
}
- (void)demo3{
    
}
- (void)demo4{
    
}
- (void)demo5{
    
}
- (void)demo6{
    
}


- (void)dealloc{
    Log(@"dealloc");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
