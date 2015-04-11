//
//  ViewController.h
//  calculationQuiz
//
//  Created by 金森幹斗 on 2014/10/29.
//  Copyright (c) 2014年 Mikito Kanamori. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ViewControllerResult.h"

#import <AVFoundation/AVFoundation.h>

int seikaisu;

@interface ViewController : UIViewController<UITextFieldDelegate>{
    int textNum;
    int firstNum;
    int secondNum;
    int keisanNum;
    int kakuninWaru;
    int answerNum;
    
    int count;
    IBOutlet UILabel *first;
    IBOutlet UILabel *second;
    IBOutlet UILabel *keisan;
    IBOutlet UILabel *seikai;
    IBOutlet UILabel *countLabel;

    
}
-(IBAction)tapNext:(id)sender;

@property AVAudioPlayer *correct;

@property AVAudioPlayer *incorrect;

@end

