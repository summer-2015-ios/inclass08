//
//  AddEventViewController.m
//  InClass08
//
//  Created by student on 7/21/15.
//  Copyright (c) 2015 student. All rights reserved.
//

#import "AddEventViewController.h"
#import "AppDelegate.h"
#import "Event.h"

@interface AddEventViewController ()
@property (weak, nonatomic) IBOutlet UITextField *eNameTV;
@property (weak, nonatomic) IBOutlet UITextField *eLocationTV;
@property (weak, nonatomic) IBOutlet UITextField *eDateTV;
@property (weak, nonatomic) IBOutlet UITextView *eDescTV;

@end

@implementation AddEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitBtnClicked:(UIButton *)sender {
    NSString* eName = self.eNameTV.text;
    NSString* eLocation = self.eLocationTV.text;
    NSString* eDate = self.eDateTV.text;
    NSString* eDescr = self.eDescTV.text;
    if([eName length] ==0 || [eLocation length] ==0|| [eDate length] ==0  || [eDescr length]==0){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Missing Field"
                                                                       message:@"All field are mandatory!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    // Save the object
    AppDelegate* app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context  = [app managedObjectContext];
    Event* event = [NSEntityDescription insertNewObjectForEntityForName:@"Event"
                                                 inManagedObjectContext:context];
    event.name = eName;
    event.desc = eDescr;
    //Change
    event.date = [NSDate date];
    event.location = eLocation;
    NSError *error = nil;
    if(![[app managedObjectContext] save:&error]){
        //Handle error
        NSLog(@"Error saving event : %@", error);
    }
    [self performSegueWithIdentifier:@"backFromEventCreateBySubmit" sender:self];
}



@end
