//
//  CalendarViewController.m
//  week2_xib&storyboard
//
//  Created by Lee Kyu-Won on 6/29/16.
//  Copyright © 2016 Lee Kyu-Won. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController (){
    int thisMonth;
    int emptyBeforeDaysCount;
    CGFloat screenWidth;
    CGFloat screenHeight;
    float dayWidth;
    float xemptyWidth;
    float rowHeight;
    float yemptyHeight;
}
@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    [self setWidthOfComponents];
    [self setHeightOfComponents];
    thisMonth = 7;
    emptyBeforeDaysCount = 5;
    [self showCalendarOfMonth: thisMonth];
}

-(void)setWidthOfComponents{
    int intWidth = floorf(screenWidth);
    for(int i = intWidth; i > 0 ; i = i - 5 ){
        for(int j = i - 1 ; j > 0 ; j = j- 5) {
            int sum = i * 7 + j * 6;
            if (sum < intWidth){
                dayWidth = i;
                xemptyWidth = j;
                return;
            }
        }
    }
}

-(void)setHeightOfComponents{
    int intHeight = floorf(screenHeight);
    for(int i = intHeight; i > 0 ; i = i - 5 ){
        for(int j = i - 1 ; j > 0 ; j = j- 5) {
            int sum = i * 7 + j * 6;
            if (sum < intHeight){
                rowHeight = i;
                yemptyHeight = j;
                return;
            }
        }
    }
}

-(void)showCalendarOfMonth:(int)month{
    self.title = [NSString stringWithFormat:@"%d월",  month];
    
    int dayCount = 0;
    // 윤년 제외
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            dayCount = 31;
            break;
        case 2:
            dayCount = 28;
            break;
        default:
            dayCount = 30;
            break;
    }
    
    NSArray *dayText = @[ @"nil", @"일", @"월", @"화", @"수", @"목", @"금", @"토" ];
    for(int i = 1 ; i <= 7 ; i++){
        UILabel *dayLabel =[[UILabel alloc]initWithFrame:CGRectMake( dayWidth*(i-1) + xemptyWidth*i , 50, dayWidth +xemptyWidth, rowHeight)];
        dayLabel.text = dayText[i];
        [self.view addSubview:dayLabel];
    }
    
    for(int i = 1; i <= dayCount ; i++ ){
        int rowCount = ( emptyBeforeDaysCount + i ) / 7 + 1;
        int widthTurnCount = ( emptyBeforeDaysCount + i) % 7 ;
        if(widthTurnCount == 0) {
            widthTurnCount = 7;
            rowCount--;
        }
        UILabel *numdayLabel = [[UILabel alloc]initWithFrame:CGRectMake(dayWidth*(widthTurnCount-1) + xemptyWidth* widthTurnCount, 50 + rowHeight*rowCount + yemptyHeight*(rowCount-1), dayWidth, rowHeight)];
        numdayLabel.text = [NSString stringWithFormat:@"%d", i];
        [self.view addSubview:numdayLabel];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
