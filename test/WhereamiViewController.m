//
//  WhereamiViewController.m
//  test
//
//  Created by Michael Wathen on 12/28/12.
//  Copyright (c) 2012 Michael Wathen. All rights reserved.
//

#import "WhereamiViewController.h"

#import "Whereami.h"

@implementation WhereamiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        question1 = [[NSMutableArray alloc] init];
              
        correctAnswer = [[NSMutableArray alloc] init];
        testQuestions = [[NSDictionary alloc] init];
        testAnswers = [[NSDictionary alloc] init];
        
        testQuestions = @{@"question1":@"What was the name of the band Janis Joplin started out with, brah?",@"question2":@"What is the name of the late 60's supergroup with Eric Clapton and Steve Winwood?",@"question3":@"Who is the drummer for Phish?",@"question4":@"What neighborhood of San Francisco did the Grateful Dead reside?",@"question5":@"What was the name of the 2003 comeback album by the Allman Brothers?",@"question6":@"What is the name of the online radio show combining the best of Phish and the Dead?",@"question7":@"What was the name of the train tour that traveled Canada with Janis, The Dead and The Band in 1970?",@"question8":@"Which Phish stunt had band members playing to a series of beach balls released to the audience?"};
        
        [question1 addObject:@"What was the name of the band Janis Joplin started out with, brah?"];

        answer1 = [NSMutableArray arrayWithObjects:@"Jefferson Airplane",@"Big Brother and the Holding Company",@"Canned Heat",@"The Mamas and the Papas",nil];
        answer2 = [NSMutableArray arrayWithObjects:@"The Travelling Wilburys",@"Them Crooked Vultures",@"Blind Faith",@"Derek and the Dominoes",nil];
        answer3 = [NSMutableArray arrayWithObjects:@"Trey Anastasio",@"Mike Gordon",@"Page McConnell",@"Jon Fishman",nil];
        answer4 = [NSMutableArray arrayWithObjects:@"Outer Sunset",@"Mission District",@"Haight-Ashbury",@"Chinatown",nil];
        answer5 = [NSMutableArray arrayWithObjects:@"Hittin' the Note",@"Space Wrangler",@"Eat a Peach",@"Here and Back Again",nil];
        answer6 = [NSMutableArray arrayWithObjects:@"Jam On",@"HeadStash",@"Live Phish Radio",@"The Grateful Dead Hour",nil];
        answer7 = [NSMutableArray arrayWithObjects:@"Steel Wheels Tour",@"Trippin across Canada",@"Ridin' That Train",@"Festival Express",nil];
        answer8 = [NSMutableArray arrayWithObjects:@"Runaway Golf Cart Marathon",@"Secret Language",@"Big Ball Jam",@"Underwater Tank", nil];
       
        testAnswers = @{@"answer1":answer1,@"answer2":answer2,@"answer3":answer3,@"answer4":answer4,@"answer5":answer5,@"answer6":answer6,@"answer7":answer7,@"answer8":answer8};
        
        [correctAnswer addObject:@"answer2"];
        [correctAnswer addObject:@"answer3"];
        [correctAnswer addObject:@"answer4"];
        [correctAnswer addObject:@"answer3"];
        [correctAnswer addObject:@"answer1"];
        [correctAnswer addObject:@"answer2"];
        [correctAnswer addObject:@"answer4"];
        [correctAnswer addObject:@"answer3"];

        numberquestions = 8;
        
    }
    
    return self;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)x
{
    return (x == UIInterfaceOrientationPortrait)
    || UIInterfaceOrientationIsLandscape(x);
}

- (void)quizComplete {
    [nextQuestion setHidden:YES];
    [correctAnswerLabel setHidden:YES];
    [startQuiz setHidden:NO];
    [startQuiz setTitle:@"Try the Quiz Again" forState:UIControlStateNormal];
    
    //show an alert with the user's score
    double score = ((double)numbercorrect/(double)numberquestions)*100;
    NSLog(@"%i",numbercorrect);
    NSLog(@"%i",numberquestions);
    NSLog(@"%f",score);
    NSString *strFromscore = [NSString stringWithFormat:@"%.0f",score];
    
    if (score==100) {
        UIAlertView *a2 = [[UIAlertView alloc] initWithTitle:@"Heady Brah" message:@"You got every question right! Good job!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [a2 show];
    } else if (score==0) {
        UIAlertView *a3 = [[UIAlertView alloc] initWithTitle:@"Sorry Brah" message:@"You got no questions right! Better luck next time noob!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [a3 show];
    } else {
        UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"Quiz Complete" message:[NSString stringWithFormat:@"Your Score was %@%%", strFromscore] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [a show];
    }
    
    numbercorrect = 0;
}

- (void)checkAnswer:(NSString*)id
{
    self.wrongAnswer = NO;
        
    if (id == correctAnswer[currentQuestionIndex]) {
        [correctAnswerLabel setText:@"Correct"];
        [nextQuestion setHidden:NO];
        [answer1button setEnabled:NO];
        [answer2button setEnabled:NO];
        [answer3button setEnabled:NO];
        [answer4button setEnabled:NO];
        currentQuestionIndex++;
        numbercorrect++;
        //check if we're at the end of the quiz
        if (currentQuestionIndex == numberquestions) {
            [self quizComplete];
        }
    } else {
        self.wrongAnswer = YES;
    }
        
    if (self.wrongAnswer) {
        [correctAnswerLabel setText:@"Wrong answer"];
        currentQuestionIndex++;
        [nextQuestion setHidden:NO];
        //check if we're at the end of the quiz
        if (currentQuestionIndex == numberquestions) {
            [self quizComplete];
        }
    }
}

- (IBAction)startQuiz:(id)sender{
    [imgView setHidden:YES];
    [introLabel setText:@""];
    [startQuiz setHidden:YES];
    [answer1button setHidden:NO];
    [answer2button setHidden:NO];
    [answer3button setHidden:NO];
    [answer4button setHidden:NO];
    [answer1button setEnabled:YES];
    [answer2button setEnabled:YES];
    [answer3button setEnabled:YES];
    [answer4button setEnabled:YES];
    [correctAnswerLabel setHidden:NO];
    [correctAnswerLabel setText:@""];

    currentQuestionIndex = 0;
    NSString *question = [question1 objectAtIndex:(0)];
    [questionLabel setText:question];
    [answer1Label setText:[answer1 objectAtIndex:(0)]];
    [answer2Label setText:[answer1 objectAtIndex:(1)]];
    [answer3Label setText:[answer1 objectAtIndex:(2)]];
    [answer4Label setText:[answer1 objectAtIndex:(3)]];
}

- (IBAction)nextQuestion:(id)sender{
    [correctAnswerLabel setText:@""];
    [nextQuestion setHidden:YES];

    //define our concatenated label
    #define AS(A,B)    [(A) stringByAppendingString:(B)]
    NSString *strFromInt = [NSString stringWithFormat:@"%d",currentQuestionIndex+1];
    NSString *questionref = AS(@"question",strFromInt);
    NSString *answerref = AS(@"answer",strFromInt);
    
    NSString *question = [testQuestions objectForKey:(questionref)];

    [answer1button setEnabled:YES];
    [answer2button setEnabled:YES];
    [answer3button setEnabled:YES];
    [answer4button setEnabled:YES];
    [questionLabel setText:question];

    NSArray *answers = [testAnswers objectForKey:(answerref)];
    [answer1Label setText:[answers objectAtIndex:(0)]];
    [answer2Label setText:[answers objectAtIndex:(1)]];
    [answer3Label setText:[answers objectAtIndex:(2)]];
    [answer4Label setText:[answers objectAtIndex:(3)]];
}

//- (void)loadView
//{
//    CGRect frame = [[UIScreen mainScreen] bounds];
//    Whereami *w = [[Whereami alloc] initWithFrame:frame];

//    [self setView:self.view];
//}

- (void)viewDidLoad{
    //play the attached audio
    [super viewDidLoad];
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/caseyjones_short.mp3", [[NSBundle mainBundle] resourcePath]]];

    NSError *error;
	audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
	audioPlayer.numberOfLoops = 0;
	
	if (audioPlayer == nil)
		NSLog(@"%@",[error localizedDescription]);
	else
		[audioPlayer play];
}


- (IBAction)answer1:(id)sender{
    NSString *identifier = @"answer1";
    [self checkAnswer:identifier];
}

- (IBAction)answer2:(id)sender{
    NSString *identifier = @"answer2";
    [self checkAnswer:identifier];
}

- (IBAction)answer3:(id)sender{
    NSString *identifier = @"answer3";
    [self checkAnswer:identifier];
}

- (IBAction)answer4:(id)sender{
    NSString *identifier = @"answer4";
    [self checkAnswer:identifier];
}

@end
