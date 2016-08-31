//
//  ViewController.m
//  week12_localization
//
//  Created by Lee Kyu-Won on 8/31/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "ViewController.h"

const NSString *kActorNameString = @"name";
const NSString *kActorProfileString = @"profile";
const NSString *kActorImageNameString = @"imageName";
const NSString *kActorBirthdayString = @"birthday";

@interface ViewController (){
    NSArray *actor;
    NSDateFormatter *dateFormatter;
}
@property (weak, nonatomic) IBOutlet UILabel *language;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIButton *birthday;
@property (weak, nonatomic) IBOutlet UITextView *profile;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _language.text = NSLocalizedStringFromTable(@"Language", @"localizable", nil);
    _birthday.titleLabel.text = NSLocalizedStringFromTable(@"Birithday", @"localizable", nil);
    [self loadActorWithBundle: [NSBundle mainBundle]];
    
    _name.text = [actor[0] objectForKey:kActorNameString];
    _profile.text = [actor[0] objectForKey:kActorProfileString];
    _image.image = [UIImage imageNamed:[actor[0] objectForKey:kActorImageNameString]];
    dateFormatter = [[NSDateFormatter alloc] init];
}

- (void)loadActorWithBundle:(NSBundle *)bundle {
    if (bundle != nil) {
        NSString *path = [bundle pathForResource:@"actor" ofType:@"plist"];
        NSArray *mountainList = (path != nil ? [NSArray arrayWithContentsOfFile:path] : nil);
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:
                                 (mountainList != nil ? [mountainList count] : 0)];
        for (NSDictionary *mountainDict in mountainList) {
            /* add the given mountain dictionary to our array */
            [array addObject:mountainDict];
        }
        /* Copy into our non-mutable array */
        actor = [[NSArray alloc] initWithArray:array];
    }

}
- (IBAction)getBirthdayAsLocal:(id)sender {
    
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:NSLocalizedStringFromTable(@"DateFormat", @"localizable", nil)];
    NSDate *hisBirthday =[actor[0] objectForKey:kActorBirthdayString];
    NSString *localedDate = [dateFormatter stringFromDate:hisBirthday];
    [_birthday setTitle:localedDate forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
