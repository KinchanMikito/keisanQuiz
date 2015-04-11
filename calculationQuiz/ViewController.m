//
//  ViewController.m
//  calculationQuiz
//
//  Created by 金森幹斗 on 2014/10/29.
//  Copyright (c) 2014年 Mikito Kanamori. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *numField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self question];
    
    NSString *pathCorrect=[[NSBundle mainBundle]pathForResource:@"correct1" ofType:@"mp3"];
    
    NSURL *urlCorrect=[NSURL fileURLWithPath:pathCorrect];
    
    self.correct=[[AVAudioPlayer alloc]initWithContentsOfURL:urlCorrect error:NULL];
    
    NSString *pathIncorrect=[[NSBundle mainBundle]pathForResource:@"incorrect1" ofType:@"mp3"];
    
    NSURL *urlIncorrect=[NSURL fileURLWithPath:pathIncorrect];
    
    self.incorrect=[[AVAudioPlayer alloc]initWithContentsOfURL:urlIncorrect error:NULL];
    
    count=30;
    
    countLabel.text = [NSString stringWithFormat:@"残り%d秒",count];

}

-(void)viewDidAppear:(BOOL)animated{
    while (count> 0) {
        count-=1;
        countLabel.text = [NSString stringWithFormat:@"残り%d秒",count];
        [[NSRunLoop currentRunLoop]
         runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]
         ];
    }
    
    
    if (count==0) {
        ViewControllerResult *vc2=[self.storyboard instantiateViewControllerWithIdentifier:@"vc2"];
        [self presentViewController:vc2 animated:YES completion:nil];

    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)question{
    firstNum=arc4random() % 9;
    firstNum++;
    first.text=[NSString stringWithFormat:@"%d",firstNum];
    secondNum=arc4random() % 9;
    secondNum++;
    second.text=[NSString stringWithFormat:@"%d",secondNum];
    kakuninWaru=firstNum%secondNum;
    if (firstNum< secondNum) {
        keisanNum=arc4random() % 1;
    }else if (kakuninWaru==0){
        keisanNum=arc4random() % 1;
        keisanNum+=2;
    }else{
        keisanNum=arc4random() % 2;
    }
    if (keisanNum==0) {
        keisan.text=@"+";
    }
    if (keisanNum==1) {
        keisan.text=@"×";
    }
    if (keisanNum==2) {
        keisan.text=@"-";
    }
    if (keisanNum==3) {
        keisan.text=@"÷";
    }
}
-(void)answer{
    if (keisanNum==0) {
        answerNum = firstNum + secondNum;
    }
    if (keisanNum==1) {
        answerNum = firstNum * secondNum;
    }
    if (keisanNum==2) {
        answerNum = firstNum - secondNum;
    }
    if (keisanNum==3) {
        answerNum = firstNum / secondNum;
    }
    if (textNum==answerNum) {
        seikaisu++;
        seikai.text=[NSString stringWithFormat:@"正解数:%d",seikaisu];
        [self.correct play];
    }else{
        [self.incorrect play];
    }
}
-(IBAction)tapNext:(id)sender{
    textNum=[_numField.text intValue];
    NSLog(@"text=%d",textNum);
    [self answer];
    [self question];
    _numField.text=@"";
}
@end
