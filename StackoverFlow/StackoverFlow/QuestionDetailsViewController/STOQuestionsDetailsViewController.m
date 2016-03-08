//
//  STOQuestionsDetailsViewController.m
//  StackoverFlow
//
//  Created by Randhir Kumar on 7/27/13.
//  Copyright (c) 2013 @Randhir Kumar. All rights reserved.
//

#import "STOQuestionsDetailsViewController.h"
#import "STOQuestionDetailsController.h"
#import "STOAnswerDetailViewController.h"

#define  ANSWER_DETAILS_SEGUE_ID @"answerDetailID"


@interface STOQuestionsDetailsViewController ()<STOQuestionDetailsControllerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) STOQuestionDetailsController *questionsDetailsDataController;
@property (strong, nonatomic) IBOutlet  UITableView                 *myTableView;
@property (nonatomic,strong)   UIActivityIndicatorView  *activity;


@property (nonatomic,strong) NSString *questionDetailsText;
@property (nonatomic,strong) NSString *answerDetailsText;

@property (nonatomic,strong) NSArray *answerOwnerArray;



@end

@implementation STOQuestionsDetailsViewController

@synthesize questionID;
@synthesize questionsDetailsDataController;
@synthesize textWebView;
@synthesize questionDetailsText;
@synthesize myTableView;
@synthesize answerOwnerArray;
@synthesize answerBodyStr;
@synthesize answerDetailsText;
@synthesize activity;



#pragma mark - UIViewController Lifecycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.questionsDetailsDataController =[[STOQuestionDetailsController  alloc] init];
    self.questionsDetailsDataController.delegate =self;
    
    [self.questionsDetailsDataController setQuestionID:[self questionID]];
    
    self.activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activity.center = CGPointMake(self.view.bounds.size.width / 2.0f, self.view.bounds.size.height / 2.0f);
    self.activity.autoresizingMask = (UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin |UIViewAutoresizingFlexibleTopMargin);
    [self.activity setHidesWhenStopped:YES];
    [self.view addSubview:self.activity];


	// Do any additional setup after loading the view.
}


- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear:NO];
    [self.activity startAnimating];
    [self.questionsDetailsDataController checkForUpdates];
    
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSString *text =   self.questionDetailsText;
    text = [text stringByReplacingOccurrencesOfString:@"\n" withString:@"<p>"];
    NSLog(@"New String : %@", text);
    NSString *cssString = [NSString stringWithFormat:@".title {font-family: HelveticaNeue; text-decoration: bold; font-size: %fpt; color:red;} .news {font-family: Arial; font-size: %fpt; color:black;}",10.0, 20.0];
	NSString *htmlString = [NSString stringWithFormat:@"<html> <head> <style type=\"text/css\"> %@ </style> </head> <body> <p> <span class=\"news\">%@</span> </p> </body> </html>", cssString, text];
    [self.textWebView loadHTMLString:htmlString baseURL:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - STOQuestionDetailsController Delegate Method


-(void) questionDetailController:(STOQuestionDetailsController *) questionDetailController HasNewData:(BOOL) hasData
{

    NSLog(@"string is %@",[self.questionsDetailsDataController getQuestionDetails]);
   
    [self.activity stopAnimating];

    self.questionDetailsText =[self.questionsDetailsDataController getQuestionDetails];
    self.answerOwnerArray  =[self.questionsDetailsDataController ownerForAnswers];

    [myTableView  reloadData];
}


#pragma mark - UITableView Data Source Methods

- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView
{
    return 1;
}

- (NSInteger)             tableView: (UITableView *) tableView
              numberOfRowsInSection: (NSInteger) section
{
    return [self.self.answerOwnerArray count];
}

- (UITableViewCell *)             tableView: (UITableView *) tableView
                      cellForRowAtIndexPath: (NSIndexPath *) indexPath
{
    static NSString *CellIdentifier  = @"answerCellID";
    UITableViewCell *cell            = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    NSArray         *textFieldsArray = self.answerOwnerArray;
    
    //    NSLog(@"textFieldArray is %@",textFieldsArray);
    
    if ( cell == nil )
    {
        cell = [ [UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                       reuseIdentifier: CellIdentifier];
    }
    
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.font          = [UIFont fontWithName: @"Arial"
                                                   size: 11.0f ];;
    [cell.textLabel sizeToFit];
    cell.textLabel.textColor = [UIColor colorWithRed: 0.600
                                               green: 0.122
                                                blue: 0.255
                                               alpha: 1.00];
    
    cell.textLabel.text = [textFieldsArray objectAtIndex: indexPath.row];
    
    
    
    return cell;
}


#pragma mark - UITableViewDelegate Methods


- (void)                                tableView: (UITableView *) tableView
         accessoryButtonTappedForRowWithIndexPath: (NSIndexPath *) indexPath
{
    // TODO: Segue to our child
    // NSLog( @"%s", __PRETTY_FUNCTION__ );
}

- (void)               tableView: (UITableView *) tableView
         didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
    
    self.answerDetailsText = [self.questionsDetailsDataController getAnswerDetails:indexPath.row];
    
    [self performSegueWithIdentifier:ANSWER_DETAILS_SEGUE_ID  sender: self];
}

- (CGFloat)                tableView: (UITableView *) tableView
            heightForFooterInSection: (NSInteger) section
{
    return 0.0;
}

- (CGFloat)                tableView: (UITableView *) tableView
            heightForHeaderInSection: (NSInteger) section
{
    return 0.0;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [(STOAnswerDetailViewController *)[segue destinationViewController]  setAnswerBodyStr:self.answerDetailsText];
}





@end
