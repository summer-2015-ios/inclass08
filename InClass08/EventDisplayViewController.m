//
//  EventDisplayViewController.m
//  InClass08
//
//  Created by student on 7/21/15.
//  Copyright (c) 2015 student. All rights reserved.
//

#import "EventDisplayViewController.h"
#import "AppDelegate.h"

@interface EventDisplayViewController ()
@property (weak, nonatomic) IBOutlet UILabel *eNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *eLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *eDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *eDescrLabel;
@end

@implementation EventDisplayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.eNameLabel.text = self.event.name;
    self.eLocationLabel.text = self.event.location;
    self.eDateLabel.text = [self formattedDate:self.event.date] ;
    self.eDescrLabel.text = self.event.desc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)deleteBtnClicked:(UIBarButtonItem *)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Event Delete"
                                                                   message:@"Do you want to delete this event?"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
                                                         // Do delete here
                                                         AppDelegate* app = [[UIApplication sharedApplication] delegate];
                                                         NSManagedObjectContext* context  = [app managedObjectContext];
                                                         [context deleteObject: self.event];
                                                         [self.navigationController popViewControllerAnimated:YES];
                                                     }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * action) {}];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];

}

-(NSString*) formattedDate: (NSDate*) date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
    return formattedDateString;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
