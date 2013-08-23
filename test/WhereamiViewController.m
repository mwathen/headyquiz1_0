//
//  WhereamiViewController.m
//  test
//
//  Created by Michael Wathen on 12/28/12.
//  Copyright (c) 2012 Michael Wathen. All rights reserved.
//

#import "WhereamiViewController.h"
#import "Whereami.h"

//static definitions for our JSON retrieval code
#define Queue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1
#define JSONURL [NSURL URLWithString:@"http://www.mikewath.com/heady_quiz.php"]

@implementation WhereamiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        numberquestions = 9;
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

    NSDictionary *record = [records objectAtIndex:currentQuestionIndex];
    NSString *correctAnswerString = [record objectForKey:@"correct_answer"];
    
    NSLog(@"id: %@", id);
    NSLog(@"correct_answer: %@", correctAnswerString);
    
    if ([id isEqualToString:correctAnswerString]) {
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
    NSDictionary *record = [records objectAtIndex:currentQuestionIndex];
    #define AS(A,B)    [(A) stringByAppendingString:(B)]
    int currentquestionreference = currentQuestionIndex+1;
    
    NSString *question_number = [NSString stringWithFormat:@"%d. ",currentquestionreference];
//  NSLog(@"qnumber: %@", question_number);
//  NSLog(@"qnumber2: %@", [record objectForKey:@"question"]);
//  NSLog(@"qnumber3: %@", record);
    
    NSString *question = AS(question_number,[record objectForKey:@"question"]);
    
    [questionLabel setText:question];
    [answer1Label setText:[record objectForKey:@"answer1"]];
    [answer2Label setText:[record objectForKey:@"answer2"]];
    [answer3Label setText:[record objectForKey:@"answer3"]];
    [answer4Label setText:[record objectForKey:@"answer4"]];
}

- (IBAction)nextQuestion:(id)sender{
    [correctAnswerLabel setText:@""];
    [nextQuestion setHidden:YES];

    //define our concatenated label
    #define AS(A,B)    [(A) stringByAppendingString:(B)]
 //   NSString *strFromInt = [NSString stringWithFormat:@"%d",currentQuestionIndex+1];
 //   NSString *questionref = AS(@"question",strFromInt);
 //   NSString *answerref = AS(@"answer",strFromInt);
    
    NSLog(@"records: %@", records);
    NSLog(@"question_index: %d", currentQuestionIndex);

    NSDictionary *record = [records objectAtIndex:currentQuestionIndex];
    int currentquestionreference = currentQuestionIndex+1;
    NSString *question_number = [NSString stringWithFormat:@"%d. ",currentquestionreference];
    NSString *question = AS(question_number,[record objectForKey:@"question"]);

  //  NSString *question = [record objectForKey:@"question"];

    [answer1button setEnabled:YES];
    [answer2button setEnabled:YES];
    [answer3button setEnabled:YES];
    [answer4button setEnabled:YES];
    [questionLabel setText:question];

 //   NSArray *answers = [testAnswers objectForKey:(answerref)];
    [answer1Label setText:[record objectForKey:@"answer1"]];
    [answer2Label setText:[record objectForKey:@"answer2"]];
    [answer3Label setText:[record objectForKey:@"answer3"]];
    [answer4Label setText:[record objectForKey:@"answer4"]];
}

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
    
    //json feed retrieval
    dispatch_async(Queue, ^{
        NSData *data = [NSData dataWithContentsOfURL:
                        JSONURL];
        [self performSelectorOnMainThread:@selector(fetchedData:)
                               withObject:data waitUntilDone:YES];
    });
}

- (void)viewDidAppear:(BOOL)animated
{

    startQuiz.alpha = 0.0;
    startQuiz.enabled = NO;
    
    [view addSubview:startQuiz];
    
    CGRect imgTopFrame = imgView.frame;
    imgTopFrame.origin.x = 40; //-basketTopFrame.size.width;
    
    [UIView animateWithDuration:2.5
                          delay:0.0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         imgView.frame = imgTopFrame;
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                     }];

    [UIView animateWithDuration:3.5
                          delay:0.0
                        options: UIViewAnimationCurveEaseInOut
                     animations:^{startQuiz.alpha = 1.0;}
                     completion:nil];

    startQuiz.enabled = YES;
    
}

- (void)fetchedData:(NSData *)responseData {
    //parse out the json data to a usable array
    NSError *error;
    NSDictionary *json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          options:kNilOptions
                          error:&error];
    
    records = [json objectForKey:@"records"];
 //   NSDictionary *questions = [records objectForKey:@"question"];
    
    NSLog(@"records: %@", records);
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
