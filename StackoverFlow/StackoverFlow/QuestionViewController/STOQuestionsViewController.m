//
//  STOQuestionsViewController.m
//  StackoverFlow
//
//  Created by Randhir Kumar on 7/27/13.
//  Copyright (c) 2013 @Randhir Kumar. All rights reserved.
//

#import "STOQuestionsViewController.h"
#import "STOQuestionDataController.h"
#import "STOQuestionsDetailsViewController.h"
#import "STOQuestionDetailsController.h"

#define TAG_OFFSET                          50    // From array enum
#define QUESTION_DETAILS_SEGUE_ID          @"ShowQuestionDetails" 

@interface STOQuestionsViewController ()<STOQuestionDataControllerDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) STOQuestionDataController *questionsDataController;

@property (strong, nonatomic) IBOutlet  UITableView     *myTableView;
@property (strong, nonatomic)  NSArray                  *itemsArray;
@property (nonatomic,strong)   UIActivityIndicatorView  *activity;
@property (strong, nonatomic)  NSNumber                 *selectedQuestionID;
@property (strong, nonatomic)  NSMutableArray           *itemNewArray;


@end

@implementation STOQuestionsViewController
@synthesize questionsDataController;
@synthesize myTableView;
@synthesize itemsArray;
@synthesize selectedQuestionID;
@synthesize questionId;
@synthesize itemNewArray;
@synthesize activity;




#pragma mark - UIViewController Lifecycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.itemNewArray =[[NSMutableArray alloc] initWithCapacity:1];
    
    self.questionsDataController =[[STOQuestionDataController alloc] init];
    self.questionsDataController.delegate =self;
    
    self.activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activity.center = CGPointMake(self.view.bounds.size.width / 2.0f, self.view.bounds.size.height / 2.0f);
    self.activity.autoresizingMask = (UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin |UIViewAutoresizingFlexibleTopMargin);
    [self.activity setHidesWhenStopped:YES];
    [self.view addSubview:self.activity];

    
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear:NO];
    [self.activity startAnimating];
    [self.questionsDataController checkForUpdates];

    
}

-(void) questionDataController: (STOQuestionDataController *) questionDataController HasNewData: (BOOL)hasData
{
//    [self.itemNewArray removeAllObjects];
    if (hasData) {

        self.itemsArray = [self.questionsDataController titlesForQuestions];
        
        for (int i =0;i<[[self.questionsDataController titlesForQuestions]count ] ; i++) {
            [self.itemNewArray  addObject:[[self.questionsDataController titlesForQuestions]objectAtIndex:i]];

        }
        
        if (self.itemNewArray.count > 0) {
            [self.activity stopAnimating];

            [self.myTableView reloadData];
        }
    }

}
- (IBAction)tapToLoadMore:(id)sender forEvent:(UIEvent *)event
{
    [self.activity startAnimating];

    [self.questionsDataController getNextPage];

    
}

#pragma mark - UITableView Data Source Methods

- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView
{
    return 1;
}

- (NSInteger)             tableView: (UITableView *) tableView
              numberOfRowsInSection: (NSInteger) section
{
    return [self.itemNewArray count];
}

- (UITableViewCell *)             tableView: (UITableView *) tableView
                      cellForRowAtIndexPath: (NSIndexPath *) indexPath
{
    static NSString *CellIdentifier  = @"titleCellID";
    UITableViewCell *cell            = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    NSArray *textFieldsArray = nil;

    textFieldsArray = self.itemNewArray;
    
    NSLog(@"textFieldArray is %@",textFieldsArray);
    
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


- (void)               tableView: (UITableView *) tableView
         didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
    
 self.selectedQuestionID = [[self.questionsDataController getQuestionIDForRow: indexPath.row]objectAtIndex:0];
    
[self performSegueWithIdentifier: QUESTION_DETAILS_SEGUE_ID sender: self];
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
    [(STOQuestionsDetailsViewController *)[segue destinationViewController]  setQuestionID:self.selectedQuestionID];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
