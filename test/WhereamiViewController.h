//
//  WhereamiViewController.h
//  test
//
//  Created by Michael Wathen on 12/28/12.
//  Copyright (c) 2012 Michael Wathen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVFoundation/AVAudioPlayer.h"

@interface WhereamiViewController : UIViewController
{
    AVAudioPlayer *audioPlayer;

int currentQuestionIndex;

    NSMutableArray *question1;
    NSMutableArray *question2;
    NSMutableArray *answer1;
    NSMutableArray *answer2;
    NSMutableArray *answer3;
    NSMutableArray *answer4;
    NSMutableArray *answer5;
    NSMutableArray *answer6;
    NSMutableArray *answer7;
    NSMutableArray *answer8;
    NSMutableArray *answer9;
    NSMutableArray *answer10;
    NSMutableArray *correctAnswer;
    NSDictionary *testQuestions;
    NSDictionary *testAnswers;
    NSMutableArray *records;
    int numberquestions;
    int numbercorrect;

    IBOutlet UILabel *introLabel;
    IBOutlet UILabel *questionLabel;
    IBOutlet UILabel *answer1Label;
    IBOutlet UILabel *answer2Label;
    IBOutlet UILabel *answer3Label;
    IBOutlet UILabel *answer4Label;
    IBOutlet UILabel *correctAnswerLabel;
    IBOutlet UIButton *startQuiz;
    IBOutlet UIButton *nextQuestion;
    IBOutlet UIButton *answer1button;
    IBOutlet UIButton *answer2button;
    IBOutlet UIButton *answer3button;
    IBOutlet UIButton *answer4button;
    IBOutlet UIImageView *imgView;
    IBOutlet UIView *view;
    
}
@property (nonatomic) BOOL wrongAnswer;

@property (nonatomic) UIImageView *imageView;

- (IBAction)startQuiz:(id)sender;
- (IBAction)answer1:(id)sender;
- (IBAction)answer2:(id)sender;
- (IBAction)answer3:(id)sender;
- (IBAction)answer4:(id)sender;

@end
