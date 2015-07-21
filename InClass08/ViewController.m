//
//  ViewController.m
//  InClass08
//
//  Created by student on 7/21/15.
//  Copyright (c) 2015 student. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Event.h"
#import "EventDisplayViewController.h"

@interface ViewController () <UITableViewDataSource>
@property (strong, nonatomic) NSArray* results;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
-(void)viewDidAppear:(BOOL)animated{
    [self fetchEventsWithPredicate:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backFromEventCreateByCancel:(UIStoryboardSegue*)segue{
    NSLog(@"back from add event by cancel");
}

-(IBAction)backFromEventCreateBySubmit:(UIStoryboardSegue*)segue{
    NSLog(@"back from add event by submit");
    //[self fetchEvents];
}
- (IBAction)goBtnClicked:(UIButton *)sender {
    if([self.searchTextField.text length]==0){
        [self fetchEventsWithPredicate:nil];
        return;
    }
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", self.searchTextField.text];
    [self fetchEventsWithPredicate:predicate];
}
-(void) fetchEventsWithPredicate: (NSPredicate*) predicate{
    AppDelegate* app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app managedObjectContext];
    NSFetchRequest* fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Event"];
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
   // NSPredicate* predicate = [NSPredicate pred]
    fetchRequest.fetchLimit = 1000;
    fetchRequest.fetchBatchSize = 50;
    fetchRequest.sortDescriptors = @[sortDescriptor];
    if(predicate){
        fetchRequest.predicate = predicate;
    }
    NSError* error;
    NSArray* results = [[app managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    if(error){
        NSLog(@"Error while fetching events : %@", error);
        return;
    }
    self.results = results;
    [self.tableView reloadData];
}

# pragma mark - UITableViewDataSource implementation
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.results.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    UILabel* title = cell.textLabel;
    title.text = [(Event*)self.results[indexPath.row] name];
    cell.detailTextLabel.text = [self formattedDate:[(Event*)self.results[indexPath.row] date]];
    return cell;
}
-(NSString*) formattedDate: (NSDate*) date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *formattedDateString = [dateFormatter stringFromDate:date];
    return formattedDateString;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if( [[segue identifier] isEqualToString:@"eventDisplaySegue"]){
        EventDisplayViewController* vc = [segue destinationViewController];
        UITableViewCell* cell = (UITableViewCell*) sender;
        long row = [self.tableView indexPathForCell:cell].row;
        vc.event = (Event*)self.results[row];
        NSLog(@"Sending model %@", vc.event);
    }
}
@end
