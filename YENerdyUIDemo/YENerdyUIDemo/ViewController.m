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
    ImageView.img(@"macbook").embedIn(self.view).centerMode;
    id hello = Label.str(@"Hello").fnt(@20).wh(80, 80).centerAlignment;
    id mac = Label.str(@"MAC").fnt(@20).wh(80, 80).centerAlignment;
    EffectView.darkBlur.fixWH(80, 80).addTo(self.view).makeCons(^{
        make.right.equal.superview.centerX.constants(0);
        make.bottom.equal.superview.centerY.constants(0);
    }).addVibrancyChild(hello).tg(101);
    EffectView.extraLightBlur.fixWidth(80).fixHeight(80).addTo(self.view).makeCons(^{
        make.left.bottom.equal.view(self.view).center.constants(0, 0);
    });
    EffectView.lightBlur.addTo(self.view).makeCons(^{
        make.size.equal.constants(80,80).And.center.equal.constants(40, 40);
    }).addVibrancyChild(mac);
    id subImg = Img(@"macbook").subImg(95, 110, 80, 80).blur(10);
    ImageView.img(subImg).addTo(self.view).makeCons(^{
        make.centerX.top.equal.view([self.view viewWithTag:101]).centerX.bottom.constants(0);
    });
}

- (void)demo4{
    AppStoreViewController *VC = [[AppStoreViewController alloc]init];
    [self.view addSubview:VC.view.xywh(self.view.bounds)];
    [self addChildViewController:VC];
}

- (void)demo5{
    GroupTV(
        Section(
                Row.str(@"Row1").fnt(20).color(@"red"),
                Row.str(@"Row2").detailStr(@"detail"),
                Row.str(@"Row3").detailStr(@"detail").img(@"moose").subtitleStyle.separatorLeftInset(15),
                Row.str(@"Row4").detailStr(@"detail").value2Style.disclosure.onClick(@"row4Clock"),
                Row.str(@"Row5").accessory(Switch.onChange(^{
            Log(@"switch change");
        })).onClick(^{
            Log(@"Row5");
        })
      ),
        Section(
            Row.str(@"Optionals1").check(YES),
            Row.str(@"Optionals2"),
            Row.str(@"Optionals3")
            ).singleCheck,
        Section(
                Row.str(@"Optionals11").check(YES),
                Row.str(@"Optionals22"),
                Row.str(@"Optionals33")
                ).multiCheck,
        Section(
                Row.custom(^(id contentView){
            Label.str(@"Done").color(@"orange").centerAlignment.embedIn(contentView);
        }).onClick(^{
            id checkedIndex = [[self.view viewWithTag:101]checkedIndexPaths];
            Log(checkedIndex);
        })
            )
        ).embedIn(self.view).tg(101);
}

- (void)row4Clock{
    Log(@"row4Clock");
}

- (void)demo6{
    Style(@"h1").color(@"#333333").fnt(17);
    Style(@"button").fixHeight(30).insets(0, 10).cornerRadius(5);
    id actionButtonStyle = Style().styles(@"button h1").bgImg(@"red").highBgImg(@"blue").highColor(@"white");
    id text = Label.styles(@"h1").str(@"Style Example:");
    id alert = Button.styles(actionButtonStyle).str(@"Alert").onClick(^{
       id message = @"You have to call .show() in the end in order to make Alert visible.";
        Alert.title(@"Alert").message(message).action(@"OK", ^{
            Log(@"OK");
        }).cancelAction(@"Cancel").show();
    });
    
    id action = Button.styles(actionButtonStyle).bgImg(@"orange").str(@"ActionSheet").onClick(^{
        ActionSheet.title(@"ActionSheet").message(@"ActionSheet use the same syntax as Alert.").action(@"Action1", ^{
            Log(@"Action1");
            
        }).action(@"Action2", ^{
            Log(@"Action2");
        }).destructiveAction(@"Delete", ^{
            Log(@"Delete");
        }).cancelAction(@"Cancel").tint(@"cyan").show();
    });
    VerStack(text, alert, action).embedIn(self.view, 20, 20, NERNull, 20).gap(30);
    
    
}


- (void)dealloc{
    Log(@"dealloc");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
